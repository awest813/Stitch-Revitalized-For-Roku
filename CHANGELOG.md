# Changelog

All notable changes to Twaruto are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.6.0] - 2026-06-10

First public release from the [awest813/Stitch-Revitalized-For-Roku](https://github.com/awest813/Stitch-Revitalized-For-Roku) fork.

### Added
- Emote picker overlay for chat compose (All / Twitch / BTTV / FFZ / 7TV tabs)
- Chat message sending with IRC `PRIVMSG`, slow-mode error handling, and sent confirmation
- Animated emotes from 7TV, BTTV, and FrankerFaceZ global sets
- Channel point reward message highlighting
- `/me` action message styling, `USERNOTICE` alert banners, and `CLEARMSG` / `CLEARCHAT` support
- Configurable chat delay setting for VOD sync
- Followed streams sidebar setting (`FollowBarOption`)
- Deep link launch support (`supports_input_launch`)
- Loading spinners and visual separators across browse scenes

### Changed
- Rebranded the channel to **Twaruto** (package: `Twaruto.zip`)
- UI/UX overhaul: purple Twitch accent, login card redesign, page headers, scene backgrounds
- Splash screen color set to Twitch dark (`#0e0e10`)
- Chat backend enabled by default for new installs

### Fixed
- Remote control crash during video playback
- Emoji variation selector (FE0F) rendering in chat
- Defensive nil-guard fixes ported from upstream (scene navigation, content loading)
- Wrong registry key for clip playback auth headers
- Swapped OAuth access/refresh token reads from registry
- IRC `RECONNECT` command now triggers a client reconnect
- Infinite retry loop in M3U8 playlist fetching (capped at 3 attempts)
- `translation` field incorrectly assigned as string instead of array in scene construction

[2.6.0]: https://github.com/awest813/Stitch-Revitalized-For-Roku/releases/tag/v2.6.0
