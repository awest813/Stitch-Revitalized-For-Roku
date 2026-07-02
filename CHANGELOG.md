# Changelog

All notable changes to Twaruto are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Empty and error states across all browse pages (Discover, Following, Live Channels, Categories, Search, category pages) — pages now explain what happened instead of showing a blank screen when a request fails or returns nothing
- Loading spinners on the Search results pane and category (game) pages
- Spanish and Portuguese translations for all new status messages

### Fixed
- Loading spinners on browse pages and the video player overlay never rendered (the `BusySpinner` nodes had no poster image); they now show a centered spinning indicator
- App crash when opening a category page while offline or when the category lookup fails
- Channel pages no longer crash when the channel info request fails or returns partial data
- Categories and category pages silently dropped the last row of results when the item count wasn't a multiple of the row size
- Login screen now shows a placeholder while the activation code is being requested, and a clear message if the code can't be fetched
- Failed pagination on Live Channels/Categories no longer risks crashing the page
- "Live Stream" row title on channel pages is now localized
- Fixed corrupted characters in the Portuguese "VODs" translation

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
