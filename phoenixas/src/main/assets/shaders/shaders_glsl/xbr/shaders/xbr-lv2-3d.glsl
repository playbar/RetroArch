// GLSL shader autogenerated by cg2glsl.py.
#if defined(VERTEX)

#if __VERSION__ >= 130
#define COMPAT_VARYING out
#define COMPAT_ATTRIBUTE in
#define COMPAT_TEXTURE texture
#else
#define COMPAT_VARYING varying
#define COMPAT_ATTRIBUTE attribute
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif
COMPAT_VARYING     vec4 _t1;
COMPAT_VARYING     vec2 _texCoord1;
COMPAT_VARYING     vec4 _color1;
COMPAT_VARYING     vec4 _position1;
struct input_dummy {
    vec2 _video_size;
    vec2 _texture_size;
    vec2 _output_dummy_size;
};
struct out_vertex {
    vec4 _position1;
    vec4 _color1;
    vec2 _texCoord1;
    vec4 _t1;
};
out_vertex _ret_0;
input_dummy _IN1;
vec4 _r0006;
COMPAT_ATTRIBUTE vec4 VertexCoord;
COMPAT_ATTRIBUTE vec4 COLOR;
COMPAT_ATTRIBUTE vec4 TexCoord;
COMPAT_VARYING vec4 COL0;
COMPAT_VARYING vec4 TEX0;
COMPAT_VARYING vec4 TEX1;
 
uniform mat4 MVPMatrix;
uniform int FrameDirection;
uniform int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;
void main()
{
    out_vertex _OUT;
    vec2 _ps;
    _r0006 = VertexCoord.x*MVPMatrix[0];
    _r0006 = _r0006 + VertexCoord.y*MVPMatrix[1];
    _r0006 = _r0006 + VertexCoord.z*MVPMatrix[2];
    _r0006 = _r0006 + VertexCoord.w*MVPMatrix[3];
    _ps = 2.00000000E+00/TextureSize;
    _OUT._t1 = vec4(_ps.x, 0.00000000E+00, 0.00000000E+00, _ps.y);
    _ret_0._position1 = _r0006;
    _ret_0._color1 = COLOR;
    _ret_0._texCoord1 = TexCoord.xy;
    _ret_0._t1 = _OUT._t1;
    gl_Position = _r0006;
    COL0 = COLOR;
    TEX0.xy = TexCoord.xy;
    TEX1 = _OUT._t1;
    return;
    COL0 = _ret_0._color1;
    TEX0.xy = _ret_0._texCoord1;
    TEX1 = _ret_0._t1;
} 
#elif defined(FRAGMENT)

#if __VERSION__ >= 130
#define COMPAT_VARYING in
#define COMPAT_TEXTURE texture
out vec4 FragColor;
#else
#define COMPAT_VARYING varying
#define FragColor gl_FragColor
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif
COMPAT_VARYING     vec4 _t1;
COMPAT_VARYING     vec2 _texCoord;
COMPAT_VARYING     vec4 _color;
struct input_dummy {
    vec2 _video_size;
    vec2 _texture_size;
    vec2 _output_dummy_size;
};
struct out_vertex {
    vec4 _color;
    vec2 _texCoord;
    vec4 _t1;
};
vec4 _ret_0;
float _TMP64;
float _TMP63;
float _TMP62;
vec3 _TMP61;
vec3 _TMP60;
vec3 _TMP59;
vec3 _TMP58;
vec4 _TMP57;
vec4 _TMP56;
vec4 _TMP71;
bvec4 _TMP49;
bvec4 _TMP48;
bvec4 _TMP47;
bvec4 _TMP46;
bvec4 _TMP45;
bvec4 _TMP44;
bvec4 _TMP43;
bvec4 _TMP42;
bvec4 _TMP41;
bvec4 _TMP40;
bvec4 _TMP39;
vec4 _TMP37;
vec4 _TMP36;
vec4 _TMP35;
vec4 _TMP34;
vec4 _TMP33;
vec4 _TMP32;
vec4 _TMP31;
vec4 _TMP30;
vec4 _TMP29;
vec4 _TMP28;
vec4 _TMP27;
vec4 _TMP26;
vec4 _TMP25;
vec4 _TMP24;
vec4 _TMP23;
vec4 _TMP22;
vec4 _TMP21;
vec4 _TMP20;
vec4 _TMP19;
vec4 _TMP18;
vec4 _TMP17;
vec4 _TMP16;
vec4 _TMP15;
vec4 _TMP14;
vec4 _TMP13;
vec4 _TMP12;
vec4 _TMP11;
vec4 _TMP10;
vec4 _TMP9;
vec4 _TMP8;
vec4 _TMP7;
vec4 _TMP6;
vec4 _TMP5;
vec4 _TMP4;
vec4 _TMP3;
vec4 _TMP2;
vec4 _TMP1;
vec2 _TMP0;
uniform sampler2D Texture;
input_dummy _IN1;
vec2 _x0087;
vec2 _x0089;
vec2 _c0091;
vec2 _c0093;
vec2 _c0095;
vec2 _c0097;
vec2 _c0101;
vec2 _c0103;
vec2 _c0105;
vec2 _c0107;
vec2 _c0109;
vec2 _c0111;
vec2 _c0113;
vec2 _c0115;
vec2 _c0117;
vec2 _c0119;
vec2 _c0121;
vec2 _c0123;
vec2 _c0125;
vec2 _c0127;
vec2 _c0129;
vec2 _c0131;
vec2 _c0133;
vec2 _c0135;
vec2 _c0137;
vec2 _c0139;
vec2 _c0141;
vec2 _c0143;
vec2 _c0145;
vec2 _c0147;
vec2 _c0149;
vec2 _c0151;
vec2 _c0153;
vec2 _c0155;
vec2 _c0157;
vec2 _c0159;
vec2 _c0161;
vec2 _c0163;
vec4 _r0165;
vec4 _r0175;
vec4 _r0185;
vec4 _r0195;
vec4 _r0205;
vec4 _r0215;
vec4 _r0225;
vec4 _r0235;
vec4 _r0245;
vec4 _r0255;
vec4 _TMP266;
vec4 _a0269;
vec4 _TMP272;
vec4 _a0275;
vec4 _TMP278;
vec4 _a0281;
vec4 _TMP284;
vec4 _a0287;
vec4 _TMP290;
vec4 _a0293;
vec4 _TMP296;
vec4 _a0299;
vec4 _TMP302;
vec4 _a0305;
vec4 _TMP308;
vec4 _a0311;
vec4 _TMP314;
vec4 _a0317;
vec4 _TMP320;
vec4 _a0323;
vec4 _TMP326;
vec4 _a0329;
vec4 _x0331;
vec4 _TMP332;
vec4 _x0339;
vec4 _TMP340;
vec4 _x0347;
vec4 _TMP348;
vec4 _x0355;
vec4 _TMP356;
vec4 _TMP364;
vec4 _a0367;
vec4 _TMP368;
vec4 _a0371;
vec4 _TMP372;
vec4 _a0375;
vec4 _TMP376;
vec4 _a0379;
vec4 _TMP380;
vec4 _a0383;
vec4 _TMP386;
vec4 _a0389;
vec4 _TMP390;
vec4 _a0393;
vec4 _TMP394;
vec4 _a0397;
vec4 _TMP398;
vec4 _a0401;
vec4 _TMP402;
vec4 _a0405;
vec4 _TMP406;
vec4 _a0409;
vec4 _TMP410;
vec4 _a0413;
vec4 _TMP414;
vec4 _a0417;
vec4 _TMP418;
vec4 _a0421;
vec4 _TMP422;
vec4 _a0425;
vec4 _TMP426;
vec4 _a0429;
float _t0437;
float _t0441;
float _t0445;
float _t0449;
vec3 _df0453;
vec3 _a0455;
vec3 _df0457;
vec3 _a0459;
COMPAT_VARYING vec4 TEX0;
COMPAT_VARYING vec4 TEX1;
 
uniform int FrameDirection;
uniform int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;
void main()
{
    bvec4 _edri;
    bvec4 _edr;
    bvec4 _edr_left;
    bvec4 _edr_up;
    bvec4 _px;
    bvec4 _interp_restriction_lv0;
    bvec4 _interp_restriction_lv1;
    bvec4 _interp_restriction_lv2_left;
    bvec4 _interp_restriction_lv2_up;
    bvec4 _block_3d;
    vec4 _fx;
    vec4 _fx_left;
    vec4 _fx_up;
    vec2 _fp;
    vec2 _tex;
    vec4 _fx45i;
    vec4 _fx45;
    vec4 _fx30;
    vec4 _fx60;
    vec4 _wd1;
    vec4 _wd2;
    vec4 _maximos;
    vec3 _res1;
    vec3 _res2;
    vec3 _res;
    _x0087 = (TEX0.xy*TextureSize)/2.00000000E+00;
    _fp = fract(_x0087);
    _x0089 = (TEX0.xy*TextureSize)/2.00000000E+00;
    _TMP0 = floor(_x0089);
    _tex = ((_TMP0 + vec2( 5.00000000E-01, 5.00000000E-01))*2.00000000E+00)/TextureSize;
    _c0091 = (TEX0.xy - TEX1.xy) - TEX1.zw;
    _TMP1 = COMPAT_TEXTURE(Texture, _c0091);
    _c0093 = TEX0.xy - TEX1.zw;
    _TMP2 = COMPAT_TEXTURE(Texture, _c0093);
    _c0095 = (TEX0.xy + TEX1.xy) - TEX1.zw;
    _TMP3 = COMPAT_TEXTURE(Texture, _c0095);
    _c0097 = TEX0.xy - TEX1.xy;
    _TMP4 = COMPAT_TEXTURE(Texture, _c0097);
    _TMP5 = COMPAT_TEXTURE(Texture, TEX0.xy);
    _c0101 = TEX0.xy + TEX1.xy;
    _TMP6 = COMPAT_TEXTURE(Texture, _c0101);
    _c0103 = (TEX0.xy - TEX1.xy) + TEX1.zw;
    _TMP7 = COMPAT_TEXTURE(Texture, _c0103);
    _c0105 = TEX0.xy + TEX1.zw;
    _TMP8 = COMPAT_TEXTURE(Texture, _c0105);
    _c0107 = TEX0.xy + TEX1.xy + TEX1.zw;
    _TMP9 = COMPAT_TEXTURE(Texture, _c0107);
    _c0109 = (TEX0.xy - TEX1.xy) - 2.00000000E+00*TEX1.zw;
    _TMP10 = COMPAT_TEXTURE(Texture, _c0109);
    _c0111 = TEX0.xy - 2.00000000E+00*TEX1.zw;
    _TMP11 = COMPAT_TEXTURE(Texture, _c0111);
    _c0113 = (TEX0.xy + TEX1.xy) - 2.00000000E+00*TEX1.zw;
    _TMP12 = COMPAT_TEXTURE(Texture, _c0113);
    _c0115 = (TEX0.xy - TEX1.xy) + 2.00000000E+00*TEX1.zw;
    _TMP13 = COMPAT_TEXTURE(Texture, _c0115);
    _c0117 = TEX0.xy + 2.00000000E+00*TEX1.zw;
    _TMP14 = COMPAT_TEXTURE(Texture, _c0117);
    _c0119 = TEX0.xy + TEX1.xy + 2.00000000E+00*TEX1.zw;
    _TMP15 = COMPAT_TEXTURE(Texture, _c0119);
    _c0121 = (TEX0.xy - 2.00000000E+00*TEX1.xy) - TEX1.zw;
    _TMP16 = COMPAT_TEXTURE(Texture, _c0121);
    _c0123 = TEX0.xy - 2.00000000E+00*TEX1.xy;
    _TMP17 = COMPAT_TEXTURE(Texture, _c0123);
    _c0125 = (TEX0.xy - 2.00000000E+00*TEX1.xy) + TEX1.zw;
    _TMP18 = COMPAT_TEXTURE(Texture, _c0125);
    _c0127 = (TEX0.xy + 2.00000000E+00*TEX1.xy) - TEX1.zw;
    _TMP19 = COMPAT_TEXTURE(Texture, _c0127);
    _c0129 = TEX0.xy + 2.00000000E+00*TEX1.xy;
    _TMP20 = COMPAT_TEXTURE(Texture, _c0129);
    _c0131 = TEX0.xy + 2.00000000E+00*TEX1.xy + TEX1.zw;
    _TMP21 = COMPAT_TEXTURE(Texture, _c0131);
    _c0133 = _tex + TEX1.xy + 2.50000000E-01*TEX1.xy + 2.50000000E-01*TEX1.zw;
    _TMP22 = COMPAT_TEXTURE(Texture, _c0133);
    _c0135 = (_tex + TEX1.xy + 2.50000000E-01*TEX1.xy) - 2.50000000E-01*TEX1.zw;
    _TMP23 = COMPAT_TEXTURE(Texture, _c0135);
    _c0137 = ((_tex + TEX1.xy) - 2.50000000E-01*TEX1.xy) - 2.50000000E-01*TEX1.zw;
    _TMP24 = COMPAT_TEXTURE(Texture, _c0137);
    _c0139 = ((_tex + TEX1.xy) - 2.50000000E-01*TEX1.xy) + 2.50000000E-01*TEX1.zw;
    _TMP25 = COMPAT_TEXTURE(Texture, _c0139);
    _c0141 = (_tex + 2.50000000E-01*TEX1.xy + 2.50000000E-01*TEX1.zw) - TEX1.zw;
    _TMP26 = COMPAT_TEXTURE(Texture, _c0141);
    _c0143 = ((_tex + 2.50000000E-01*TEX1.xy) - 2.50000000E-01*TEX1.zw) - TEX1.zw;
    _TMP27 = COMPAT_TEXTURE(Texture, _c0143);
    _c0145 = ((_tex - 2.50000000E-01*TEX1.xy) - 2.50000000E-01*TEX1.zw) - TEX1.zw;
    _TMP28 = COMPAT_TEXTURE(Texture, _c0145);
    _c0147 = ((_tex - 2.50000000E-01*TEX1.xy) + 2.50000000E-01*TEX1.zw) - TEX1.zw;
    _TMP29 = COMPAT_TEXTURE(Texture, _c0147);
    _c0149 = (_tex - TEX1.xy) + 2.50000000E-01*TEX1.xy + 2.50000000E-01*TEX1.zw;
    _TMP30 = COMPAT_TEXTURE(Texture, _c0149);
    _c0151 = ((_tex - TEX1.xy) + 2.50000000E-01*TEX1.xy) - 2.50000000E-01*TEX1.zw;
    _TMP31 = COMPAT_TEXTURE(Texture, _c0151);
    _c0153 = ((_tex - TEX1.xy) - 2.50000000E-01*TEX1.xy) - 2.50000000E-01*TEX1.zw;
    _TMP32 = COMPAT_TEXTURE(Texture, _c0153);
    _c0155 = ((_tex - TEX1.xy) - 2.50000000E-01*TEX1.xy) + 2.50000000E-01*TEX1.zw;
    _TMP33 = COMPAT_TEXTURE(Texture, _c0155);
    _c0157 = _tex + 2.50000000E-01*TEX1.xy + 2.50000000E-01*TEX1.zw + TEX1.zw;
    _TMP34 = COMPAT_TEXTURE(Texture, _c0157);
    _c0159 = ((_tex + 2.50000000E-01*TEX1.xy) - 2.50000000E-01*TEX1.zw) + TEX1.zw;
    _TMP35 = COMPAT_TEXTURE(Texture, _c0159);
    _c0161 = ((_tex - 2.50000000E-01*TEX1.xy) - 2.50000000E-01*TEX1.zw) + TEX1.zw;
    _TMP36 = COMPAT_TEXTURE(Texture, _c0161);
    _c0163 = (_tex - 2.50000000E-01*TEX1.xy) + 2.50000000E-01*TEX1.zw + TEX1.zw;
    _TMP37 = COMPAT_TEXTURE(Texture, _c0163);
    _r0165.x = dot(_TMP2.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0165.y = dot(_TMP4.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0165.z = dot(_TMP8.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0165.w = dot(_TMP6.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0175.x = dot(_TMP3.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0175.y = dot(_TMP1.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0175.z = dot(_TMP7.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0175.w = dot(_TMP9.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0185.x = dot(_TMP5.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0185.y = dot(_TMP5.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0185.z = dot(_TMP5.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0185.w = dot(_TMP5.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0195.x = dot(_TMP21.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0195.y = dot(_TMP12.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0195.z = dot(_TMP16.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0195.w = dot(_TMP13.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0205.x = dot(_TMP15.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0205.y = dot(_TMP19.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0205.z = dot(_TMP10.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0205.w = dot(_TMP18.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0215.x = dot(_TMP14.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0215.y = dot(_TMP20.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0215.z = dot(_TMP11.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0215.w = dot(_TMP17.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0225.x = dot(_TMP22.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0225.y = dot(_TMP26.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0225.z = dot(_TMP30.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0225.w = dot(_TMP34.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0235.x = dot(_TMP23.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0235.y = dot(_TMP27.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0235.z = dot(_TMP31.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0235.w = dot(_TMP35.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0245.x = dot(_TMP24.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0245.y = dot(_TMP28.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0245.z = dot(_TMP32.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0245.w = dot(_TMP36.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0255.x = dot(_TMP25.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0255.y = dot(_TMP29.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0255.z = dot(_TMP33.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _r0255.w = dot(_TMP37.xyz, vec3( 1.02047997E+01, 3.43296013E+01, 3.46560001E+00));
    _fx = vec4( 1.00000000E+00, -1.00000000E+00, -1.00000000E+00, 1.00000000E+00)*_fp.y + vec4( 1.00000000E+00, 1.00000000E+00, -1.00000000E+00, -1.00000000E+00)*_fp.x;
    _fx_left = vec4( 1.00000000E+00, -1.00000000E+00, -1.00000000E+00, 1.00000000E+00)*_fp.y + vec4( 5.00000000E-01, 2.00000000E+00, -5.00000000E-01, -2.00000000E+00)*_fp.x;
    _fx_up = vec4( 1.00000000E+00, -1.00000000E+00, -1.00000000E+00, 1.00000000E+00)*_fp.y + vec4( 2.00000000E+00, 5.00000000E-01, -2.00000000E+00, -5.00000000E-01)*_fp.x;
    _block_3d = bvec4(_r0225.x == _r0235.x && _r0235.x == _r0245.x && _r0245.x == _r0255.x && _r0225.w == _r0235.w && _r0235.w == _r0245.w && _r0245.w == _r0255.w, _r0225.y == _r0235.y && _r0235.y == _r0245.y && _r0245.y == _r0255.y && _r0225.x == _r0235.x && _r0235.x == _r0245.x && _r0245.x == _r0255.x, _r0225.z == _r0235.z && _r0235.z == _r0245.z && _r0245.z == _r0255.z && _r0225.y == _r0235.y && _r0235.y == _r0245.y && _r0245.y == _r0255.y, _r0225.w == _r0235.w && _r0235.w == _r0245.w && _r0245.w == _r0255.w && _r0225.z == _r0235.z && _r0235.z == _r0245.z && _r0245.z == _r0255.z);
    _interp_restriction_lv0 = bvec4(_r0185.x != _r0165.w && _r0185.x != _r0165.z && _block_3d.x, _r0185.y != _r0165.x && _r0185.y != _r0165.w && _block_3d.y, _r0185.z != _r0165.y && _r0185.z != _r0165.x && _block_3d.z, _r0185.w != _r0165.z && _r0185.w != _r0165.y && _block_3d.w);
    _a0269 = _r0165.wxyz - _r0165;
    _TMP266 = abs(_a0269);
    _TMP39 = bvec4(_TMP266.x < 1.50000000E+01, _TMP266.y < 1.50000000E+01, _TMP266.z < 1.50000000E+01, _TMP266.w < 1.50000000E+01);
    _a0275 = _r0165.wxyz - _r0175;
    _TMP272 = abs(_a0275);
    _TMP40 = bvec4(_TMP272.x < 1.50000000E+01, _TMP272.y < 1.50000000E+01, _TMP272.z < 1.50000000E+01, _TMP272.w < 1.50000000E+01);
    _a0281 = _r0165.zwxy - _r0165.yzwx;
    _TMP278 = abs(_a0281);
    _TMP41 = bvec4(_TMP278.x < 1.50000000E+01, _TMP278.y < 1.50000000E+01, _TMP278.z < 1.50000000E+01, _TMP278.w < 1.50000000E+01);
    _a0287 = _r0165.zwxy - _r0175.zwxy;
    _TMP284 = abs(_a0287);
    _TMP42 = bvec4(_TMP284.x < 1.50000000E+01, _TMP284.y < 1.50000000E+01, _TMP284.z < 1.50000000E+01, _TMP284.w < 1.50000000E+01);
    _a0293 = _r0185 - _r0175.wxyz;
    _TMP290 = abs(_a0293);
    _TMP43 = bvec4(_TMP290.x < 1.50000000E+01, _TMP290.y < 1.50000000E+01, _TMP290.z < 1.50000000E+01, _TMP290.w < 1.50000000E+01);
    _a0299 = _r0165.wxyz - _r0215.yzwx;
    _TMP296 = abs(_a0299);
    _TMP44 = bvec4(_TMP296.x < 1.50000000E+01, _TMP296.y < 1.50000000E+01, _TMP296.z < 1.50000000E+01, _TMP296.w < 1.50000000E+01);
    _a0305 = _r0165.wxyz - _r0195;
    _TMP302 = abs(_a0305);
    _TMP45 = bvec4(_TMP302.x < 1.50000000E+01, _TMP302.y < 1.50000000E+01, _TMP302.z < 1.50000000E+01, _TMP302.w < 1.50000000E+01);
    _a0311 = _r0165.zwxy - _r0215;
    _TMP308 = abs(_a0311);
    _TMP46 = bvec4(_TMP308.x < 1.50000000E+01, _TMP308.y < 1.50000000E+01, _TMP308.z < 1.50000000E+01, _TMP308.w < 1.50000000E+01);
    _a0317 = _r0165.zwxy - _r0205;
    _TMP314 = abs(_a0317);
    _TMP47 = bvec4(_TMP314.x < 1.50000000E+01, _TMP314.y < 1.50000000E+01, _TMP314.z < 1.50000000E+01, _TMP314.w < 1.50000000E+01);
    _a0323 = _r0185 - _r0175.zwxy;
    _TMP320 = abs(_a0323);
    _TMP48 = bvec4(_TMP320.x < 1.50000000E+01, _TMP320.y < 1.50000000E+01, _TMP320.z < 1.50000000E+01, _TMP320.w < 1.50000000E+01);
    _a0329 = _r0185 - _r0175;
    _TMP326 = abs(_a0329);
    _TMP49 = bvec4(_TMP326.x < 1.50000000E+01, _TMP326.y < 1.50000000E+01, _TMP326.z < 1.50000000E+01, _TMP326.w < 1.50000000E+01);
    _interp_restriction_lv1 = bvec4(_interp_restriction_lv0.x && (!_TMP39.x && !_TMP40.x || !_TMP41.x && !_TMP42.x || _TMP43.x && (!_TMP44.x && !_TMP45.x || !_TMP46.x && !_TMP47.x) || _TMP48.x || _TMP49.x), _interp_restriction_lv0.y && (!_TMP39.y && !_TMP40.y || !_TMP41.y && !_TMP42.y || _TMP43.y && (!_TMP44.y && !_TMP45.y || !_TMP46.y && !_TMP47.y) || _TMP48.y || _TMP49.y), _interp_restriction_lv0.z && (!_TMP39.z && !_TMP40.z || !_TMP41.z && !_TMP42.z || _TMP43.z && (!_TMP44.z && !_TMP45.z || !_TMP46.z && !_TMP47.z) || _TMP48.z || _TMP49.z), _interp_restriction_lv0.w && (!_TMP39.w && !_TMP40.w || !_TMP41.w && !_TMP42.w || _TMP43.w && (!_TMP44.w && !_TMP45.w || !_TMP46.w && !_TMP47.w) || _TMP48.w || _TMP49.w));
    _interp_restriction_lv2_left = bvec4(_r0185.x != _r0175.z && _r0165.y != _r0175.z, _r0185.y != _r0175.w && _r0165.z != _r0175.w, _r0185.z != _r0175.x && _r0165.w != _r0175.x, _r0185.w != _r0175.y && _r0165.x != _r0175.y);
    _interp_restriction_lv2_up = bvec4(_r0185.x != _r0175.x && _r0165.x != _r0175.x, _r0185.y != _r0175.y && _r0165.y != _r0175.y, _r0185.z != _r0175.z && _r0165.z != _r0175.z, _r0185.w != _r0175.w && _r0165.w != _r0175.w);
    _x0331 = (((_fx + vec4( 3.33333343E-01, 3.33333343E-01, 3.33333343E-01, 3.33333343E-01)) - vec4( 1.50000000E+00, 5.00000000E-01, -5.00000000E-01, 5.00000000E-01)) - vec4( 2.50000000E-01, 2.50000000E-01, 2.50000000E-01, 2.50000000E-01))/vec4( 6.66666687E-01, 6.66666687E-01, 6.66666687E-01, 6.66666687E-01);
    _TMP71 = min(vec4( 1.00000000E+00, 1.00000000E+00, 1.00000000E+00, 1.00000000E+00), _x0331);
    _TMP332 = max(vec4( 0.00000000E+00, 0.00000000E+00, 0.00000000E+00, 0.00000000E+00), _TMP71);
    _x0339 = ((_fx + vec4( 3.33333343E-01, 3.33333343E-01, 3.33333343E-01, 3.33333343E-01)) - vec4( 1.50000000E+00, 5.00000000E-01, -5.00000000E-01, 5.00000000E-01))/vec4( 6.66666687E-01, 6.66666687E-01, 6.66666687E-01, 6.66666687E-01);
    _TMP71 = min(vec4( 1.00000000E+00, 1.00000000E+00, 1.00000000E+00, 1.00000000E+00), _x0339);
    _TMP340 = max(vec4( 0.00000000E+00, 0.00000000E+00, 0.00000000E+00, 0.00000000E+00), _TMP71);
    _x0347 = ((_fx_left + vec4( 1.66666672E-01, 3.33333343E-01, 1.66666672E-01, 3.33333343E-01)) - vec4( 1.00000000E+00, 1.00000000E+00, -5.00000000E-01, 0.00000000E+00))/vec4( 3.33333343E-01, 6.66666687E-01, 3.33333343E-01, 6.66666687E-01);
    _TMP71 = min(vec4( 1.00000000E+00, 1.00000000E+00, 1.00000000E+00, 1.00000000E+00), _x0347);
    _TMP348 = max(vec4( 0.00000000E+00, 0.00000000E+00, 0.00000000E+00, 0.00000000E+00), _TMP71);
    _x0355 = ((_fx_up + vec4( 3.33333343E-01, 1.66666672E-01, 3.33333343E-01, 1.66666672E-01)) - vec4( 2.00000000E+00, 0.00000000E+00, -1.00000000E+00, 5.00000000E-01))/vec4( 6.66666687E-01, 3.33333343E-01, 6.66666687E-01, 3.33333343E-01);
    _TMP71 = min(vec4( 1.00000000E+00, 1.00000000E+00, 1.00000000E+00, 1.00000000E+00), _x0355);
    _TMP356 = max(vec4( 0.00000000E+00, 0.00000000E+00, 0.00000000E+00, 0.00000000E+00), _TMP71);
    _a0367 = _r0185 - _r0175;
    _TMP364 = abs(_a0367);
    _a0371 = _r0185 - _r0175.zwxy;
    _TMP368 = abs(_a0371);
    _a0375 = _r0175.wxyz - _r0215;
    _TMP372 = abs(_a0375);
    _a0379 = _r0175.wxyz - _r0215.yzwx;
    _TMP376 = abs(_a0379);
    _a0383 = _r0165.zwxy - _r0165.wxyz;
    _TMP380 = abs(_a0383);
    _wd1 = _TMP364 + _TMP368 + _TMP372 + _TMP376 + 4.00000000E+00*_TMP380;
    _a0389 = _r0165.zwxy - _r0165.yzwx;
    _TMP386 = abs(_a0389);
    _a0393 = _r0165.zwxy - _r0205;
    _TMP390 = abs(_a0393);
    _a0397 = _r0165.wxyz - _r0195;
    _TMP394 = abs(_a0397);
    _a0401 = _r0165.wxyz - _r0165;
    _TMP398 = abs(_a0401);
    _a0405 = _r0185 - _r0175.wxyz;
    _TMP402 = abs(_a0405);
    _wd2 = _TMP386 + _TMP390 + _TMP394 + _TMP398 + 4.00000000E+00*_TMP402;
    _edri = bvec4(_wd1.x <= _wd2.x && _interp_restriction_lv0.x, _wd1.y <= _wd2.y && _interp_restriction_lv0.y, _wd1.z <= _wd2.z && _interp_restriction_lv0.z, _wd1.w <= _wd2.w && _interp_restriction_lv0.w);
    _edr = bvec4(_wd1.x < _wd2.x && _interp_restriction_lv1.x, _wd1.y < _wd2.y && _interp_restriction_lv1.y, _wd1.z < _wd2.z && _interp_restriction_lv1.z, _wd1.w < _wd2.w && _interp_restriction_lv1.w);
    _a0409 = _r0165.wxyz - _r0175.zwxy;
    _TMP406 = abs(_a0409);
    _a0413 = _r0165.zwxy - _r0175;
    _TMP410 = abs(_a0413);
    _edr_left = bvec4((2.00000000E+00*_TMP406).x <= _TMP410.x && _interp_restriction_lv2_left.x && _edr.x, (2.00000000E+00*_TMP406).y <= _TMP410.y && _interp_restriction_lv2_left.y && _edr.y, (2.00000000E+00*_TMP406).z <= _TMP410.z && _interp_restriction_lv2_left.z && _edr.z, (2.00000000E+00*_TMP406).w <= _TMP410.w && _interp_restriction_lv2_left.w && _edr.w);
    _a0417 = _r0165.wxyz - _r0175.zwxy;
    _TMP414 = abs(_a0417);
    _a0421 = _r0165.zwxy - _r0175;
    _TMP418 = abs(_a0421);
    _edr_up = bvec4(_TMP414.x >= (2.00000000E+00*_TMP418).x && _interp_restriction_lv2_up.x && _edr.x, _TMP414.y >= (2.00000000E+00*_TMP418).y && _interp_restriction_lv2_up.y && _edr.y, _TMP414.z >= (2.00000000E+00*_TMP418).z && _interp_restriction_lv2_up.z && _edr.z, _TMP414.w >= (2.00000000E+00*_TMP418).w && _interp_restriction_lv2_up.w && _edr.w);
    _fx45 = vec4(float(_edr.x), float(_edr.y), float(_edr.z), float(_edr.w))*_TMP340;
    _fx30 = vec4(float(_edr_left.x), float(_edr_left.y), float(_edr_left.z), float(_edr_left.w))*_TMP348;
    _fx60 = vec4(float(_edr_up.x), float(_edr_up.y), float(_edr_up.z), float(_edr_up.w))*_TMP356;
    _fx45i = vec4(float(_edri.x), float(_edri.y), float(_edri.z), float(_edri.w))*_TMP332;
    _a0425 = _r0185 - _r0255;
    _TMP422 = abs(_a0425);
    _a0429 = _r0185 - _r0235.wxyz;
    _TMP426 = abs(_a0429);
    _px = bvec4(_TMP422.x <= _TMP426.x, _TMP422.y <= _TMP426.y, _TMP422.z <= _TMP426.z, _TMP422.w <= _TMP426.w);
    _TMP56 = max(_fx30, _fx60);
    _TMP57 = max(_fx45, _fx45i);
    _maximos = max(_TMP56, _TMP57);
    _t0437 = float(_px.x);
    _TMP58 = _TMP8.xyz + _t0437*(_TMP6.xyz - _TMP8.xyz);
    _res1 = _TMP5.xyz + _maximos.x*(_TMP58 - _TMP5.xyz);
    _t0441 = float(_px.z);
    _TMP59 = _TMP2.xyz + _t0441*(_TMP4.xyz - _TMP2.xyz);
    _res1 = _res1 + _maximos.z*(_TMP59 - _res1);
    _t0445 = float(_px.y);
    _TMP60 = _TMP6.xyz + _t0445*(_TMP2.xyz - _TMP6.xyz);
    _res2 = _TMP5.xyz + _maximos.y*(_TMP60 - _TMP5.xyz);
    _t0449 = float(_px.w);
    _TMP61 = _TMP4.xyz + _t0449*(_TMP8.xyz - _TMP4.xyz);
    _res2 = _res2 + _maximos.w*(_TMP61 - _res2);
    _a0455 = _TMP5.xyz - _res1;
    _df0453 = abs(_a0455);
    _TMP62 = _df0453.x + _df0453.y + _df0453.z;
    _a0459 = _TMP5.xyz - _res2;
    _df0457 = abs(_a0459);
    _TMP63 = _df0457.x + _df0457.y + _df0457.z;
    _TMP64 = float((_TMP63 >= _TMP62));
    _res = _res1 + _TMP64*(_res2 - _res1);
    _ret_0 = vec4(_res.x, _res.y, _res.z, 1.00000000E+00);
    FragColor = _ret_0;
    return;
} 
#endif
