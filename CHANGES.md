# 1.6.2 (future)
- AUDIO: Mute now no longer disables/enables audio but instead properly mutes the audio volume.
  Mute is also independent from the audio mixer volume.
- AUDIO: Audio mixer's volume can now be independently increased/decreased, and muted.
- SDL2: Fix 'SDL2 driver does not see the hat on wired Xbox 360 controller"
- SCANNING: Fix PS1 game scanning
- VITA: Add support for external USB if mounted
- MENU: Add 'User Interface -> Views'. Ability to display/hide online updater and core updater
options.
- LINUX: Add a tinyalsa audio driver. Doesn't require asoundlib, should be self-contained and
lower-level.
- LOCALIZATION: Update French translation
- LOCALIZATION: Update Italian translation
- LOCALIZATION: Update Japanese translation
- LOCALIZATION: Update Russian translation
- WAYLAND: Fix menu mouse input
- WII: Add support for single-port 'PS1/PS2 to USB controller adapter'
- INPUT: Fix 'All Users Control Menu' setting
- INPUT: Add mouse index selection; ability now to select between different mice
- SETTINGS: Fix regression 'Custom Viewport is no longer overridable per-core or per-game'

# 1.6.0
- AUTOSAVE/SRAM - Fix bug #3829 / #4820 (https://github.com/libretro/RetroArch/issues/3829)
- ENDIANNESS: Fixed database scanning. Should fix scanning on PS3/WiiU/Wii, etc.
- NET: Fix bug #4703 (https://github.com/libretro/RetroArch/issues/4703)
- ANDROID: Runtime permission checking
- ANDROID: Improve autoconf fallback
- ANDROID: Improve shield portable/gamepad device grouping workaround
- ANDROID: Allow remotes to retain OK/Cancel position when menu_swap_ok_cancel is enabled
- LOCALIZATION: Update/finish French translation
- LOCALIZATION: Update German translation
- LOCALIZATION: Update Japanese translation
- LOCALIZATION/GUI: Korean font should display properly now with XMB/MaterialUI's default font
- LOCALIZATION: Update Russian translation
- MENU: Improved rendering for XMB ribbon; using additive blending (Vulkan/GL)
- OSX/MACOS: Fixes serious memory leak
- WINDOWS: Added WASAPI audio driver for low-latency audio. Both shared and exclusive mode.
- WINDOWS: Added RawInput input driver for low-latency, low-level input.
- WINDOWS: Core mouse input should be relative again in cores
- MISC: Various frontend optimizations.
- VIDEO: Fix threaded video regression; tickering of menu entries would no longer work.
- WII: Fix crashing issues which could occur with the dummy core
- WIIU: HID Controller support
- WIIU: XMB/MaterialUI menu driver support
- WIIU: Initial network/netplay support
- LOBBIES: Fallback to filename based matching if no CRC matches are found (for people making playlists by hand)
- LOBBIES: GUI refinement, show stop hosting when a host has been started, show disconnect when playing as client
- LOBBIES: if the game is already loaded it will try to connect directly instead of re-loading content (non-fullpath cores only)
- LOBBIES: unify both netplay menus
- THUMBNAILS: Thumbnails show up now in Load Content -> Collection, Information -> Database 
- VITA: Fix slow I/O
- VITA: Fix 30fps menu (poke into input now instead of reading the entire input buffer which apparently is slow)
- VITA: Fix frame throttle
- VULKAN: Unicode font rendering support. Should fix bad character encoding for French characters, etc.
- VULKAN: Fix some crashes on loading some thumbnails
- AUDIO: Audio mixer support. Mix up to 8 streams with the game's audio.

# 1.5.0
- MOBILE: Single-tap for menu entry selection
- MOBILE: Long-tap a setting to reset to default
- ANDROID: Autoconf fallback
- ANDROID: Mouse support / Emulated mouse support
- AUTOCONF: Fix partial matches for pad name
- CHEEVOS: Fix crashes in the cheevos description menu
- CHEEVOS: WIP leaderboards support
- COMMON: Threading fixes
- COMMON: 9-slice texture drawing support
- CORETEXT/APPLE: Ability to load menu display font drivers and loading of custom font.
- DOS: Add keyboard driver
- DOS: Improve color accuracy and scaling
- GUI: Various settings are now only visible when advanced settings is enabled
- GUI: Allow changing icon theme on the fly
- GUI: Add a symbol page in the OSK
- GUI: Better dialogs for XMB
- LOCALIZATION: Add/update Korean translation
- LOCALIZATION: Rewrite German translation
- LOCALIZATION: Update several English sublabels
- LOCALIZATION: Update several Japanese labels
- NET: Allow manual netplay content loading
- NET: Announcing network games to the public lobby is optional now
- NET: Bake in miniupnpc
- NET: Fix netplay join for contentless cores
- NET: Lan games show next to lobbies with (lan) and connect via the private IP address
- NET: Use new lobby system with MITM support
- NET: Fix netplay rooms being pushed on the wrong tab
- NUKLEAR: Update to current version
- SCANNER: Always add 7z & zip to supported extensions
- VULKAN: Find supported composite alpha in swapchain
- VULKAN: Add snow/bokeh shader pipeline effects - at parity with GL now
- WIIU: Keyboard support
- WINDOWS: Logging to file no longer spawns an empty window
- WINDOWS: Fix loading of core/content via file menu

# 1.4.1
