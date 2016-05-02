/* Copyright  (C) 2010-2016 The RetroArch team
 *
 * ---------------------------------------------------------------------------------------
 * The following license statement only applies to this file (net_compat.c).
 * ---------------------------------------------------------------------------------------
 *
 * Permission is hereby granted, free of charge,
 * to any person obtaining a copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include <stdint.h>
#include <sys/types.h>
#include <stdlib.h>
#include <string.h>

#include <net/net_compat.h>
#include <net/net_socket.h>
#include <compat/strl.h>

#if defined(VITA)
static void *_net_compat_net_memory = NULL;
#define COMPAT_NET_INIT_SIZE 512*1024
#define INET_ADDRSTRLEN sizeof(struct sockaddr_in)
#define MAX_NAME 512

typedef uint32_t in_addr_t;

struct in_addr
{
   in_addr_t s_addr;
};

char *inet_ntoa(struct SceNetInAddr in)
{
	static char ip_addr[INET_ADDRSTRLEN + 1];

	if(sceNetInetNtop(AF_INET, &in, ip_addr, INET_ADDRSTRLEN) == NULL)
		strlcpy(ip_addr, "Invalid", sizeof(ip_addr));

	return ip_addr;
}

struct SceNetInAddr inet_aton(const char *ip_addr)
{
   SceNetInAddr inaddr;

   sceNetInetPton(AF_INET, ip_addr, &inaddr);	
   return inaddr;
}

unsigned int inet_addr(const char *cp)
{
   return inet_aton(cp).s_addr;
}

struct hostent *gethostbyname(const char *name)
{
   int err;
   static struct hostent ent;
   static char sname[MAX_NAME] = "";
   static struct SceNetInAddr saddr = { 0 };
   static char *addrlist[2] = { (char *) &saddr, NULL };
   int rid = sceNetResolverCreate("resolver", NULL, 0);

   if(rid < 0)
      return NULL;

   err = sceNetResolverStartNtoa(rid, name, &saddr, 0,0,0);
   sceNetResolverDestroy(rid);
   if(err < 0)
      return NULL;

   addrlist[0]     = inet_ntoa(saddr);
   ent.h_name      = sname;
   ent.h_aliases   = 0;
   ent.h_addrtype  = AF_INET;
   ent.h_length    = sizeof(struct in_addr);
   ent.h_addr_list = addrlist;
   ent.h_addr      = addrlist[0];

   return &ent;
}

int retro_epoll_fd;

#endif

int getaddrinfo_retro(const char *node, const char *service,
      const struct addrinfo *hints,
      struct addrinfo **res)
{
#ifdef HAVE_SOCKET_LEGACY
   struct sockaddr_in *in_addr = NULL;
   struct addrinfo *info = (struct addrinfo*)calloc(1, sizeof(*info));
   if (!info)
      goto error;

#if defined(_WIN32) || defined(HAVE_SOCKET_LEGACY)
   hints->ai_family    = AF_INET;
#else
   hints->ai_family    = AF_UNSPEC;
#endif

   info->ai_family     = AF_INET;
   info->ai_socktype   = hints->ai_socktype;
   in_addr             = (struct sockaddr_in*)
      calloc(1, sizeof(*in_addr));

   if (!in_addr)
      goto error;

   info->ai_addrlen    = sizeof(*in_addr);
   in_addr->sin_family = AF_INET;
   in_addr->sin_port   = htons(strtoul(service, NULL, 0));

   if (!node && (hints->ai_flags & AI_PASSIVE))
      in_addr->sin_addr.s_addr = INADDR_ANY;
   else if (node && isdigit(*node))
      in_addr->sin_addr.s_addr = inet_addr(node);
   else if (node && !isdigit(*node))
   {
      struct hostent *host = (struct hostent*)gethostbyname(node);

      if (!host || !host->h_addr_list[0])
         goto error;

      in_addr->sin_addr.s_addr = inet_addr(host->h_addr_list[0]);
   }
   else
      goto error;

   info->ai_addr = (struct sockaddr*)in_addr;
   *res          = info;

   return 0;

error:
   if (in_addr)
      free(in_addr);
   if (info)
      free(info);
   return -1;
#else
   return getaddrinfo(node, service, hints, res);
#endif
}

void freeaddrinfo_retro(struct addrinfo *res)
{
#ifdef HAVE_SOCKET_LEGACY
   free(res->ai_addr);
   free(res);
#else
   freeaddrinfo(res);
#endif
}

/**
 * network_init:
 *
 * Platform specific socket library initialization.
 *
 * Returns: true (1) if successful, otherwise false (0).
 **/
bool network_init(void)
{
#ifdef _WIN32
   WSADATA wsaData;
#endif
   static bool inited = false;
   if (inited)
      return true;

#if defined(_WIN32)
   if (WSAStartup(MAKEWORD(2, 2), &wsaData) != 0)
   {
      network_deinit();
      return false;
   }
#elif defined(__CELLOS_LV2__) && !defined(__PSL1GHT__)
   cellSysmoduleLoadModule(CELL_SYSMODULE_NET);
   sys_net_initialize_network();
#elif defined(VITA)
   SceNetInitParam initparam;

   if (sceNetShowNetstat() == PSP2_NET_ERROR_ENOTINIT)
   {
      _net_compat_net_memory = malloc(COMPAT_NET_INIT_SIZE);

      initparam.memory       = _net_compat_net_memory;
      initparam.size         = COMPAT_NET_INIT_SIZE;
      initparam.flags        = 0;

      sceNetInit(&initparam);

      sceNetCtlInit();
   }
   
   retro_epoll_fd = sceNetEpollCreate("epoll", 0);
#else
   signal(SIGPIPE, SIG_IGN); /* Do not like SIGPIPE killing our app. */
#endif

   inited = true;
   return true;
}

/**
 * network_deinit:
 *
 * Deinitialize platform specific socket libraries.
 **/
void network_deinit(void)
{
#if defined(_WIN32)
   WSACleanup();
#elif defined(__CELLOS_LV2__) && !defined(__PSL1GHT__)
   cellNetCtlTerm();
   sys_net_finalize_network();
   cellSysmoduleUnloadModule(CELL_SYSMODULE_NET);
#elif defined(VITA)
   sceNetCtlTerm();
   sceNetTerm();

   if (_net_compat_net_memory)
   {
      free(_net_compat_net_memory);
      _net_compat_net_memory = NULL;
   }
#elif defined(GEKKO) && !defined(HW_DOL)
   net_deinit();
#endif
}
