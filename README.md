# Mystic

**Mystic** is a web-first, minimalist app for daily Card/Rune of the Day insights. Phase 1 is web-only and focuses on a single “Card of the Day” experience with English and Russian support. Rituals and premium purchases are planned for later phases.

## Tech stack

- **Flutter Web** — no extra backend or packages for Phase 1.

## Getting started

**Prerequisites:** Flutter SDK (stable).

**Check Flutter:**

```bash
flutter --version
```

**Install dependencies:**

```bash
flutter pub get
```

**Run in Chrome:**

```bash
flutter run -d chrome
```

Tested on Windows and macOS.

## Project structure

- **`lib/app`** — app shell, web layout, routing.
- **`lib/core`** — routing, state, i18n (locale, strings).
- **`lib/features`** — feature modules (e.g. today/card of the day).
- **`lib/shared`** — shared widgets and components.
- **`lib/theme`** — design tokens (colors, text, theme).

## Design lock

All colors are defined in **`lib/theme/app_colors.dart`**. Do not introduce new colors or use `Colors.*` / raw `Color(0x...)` elsewhere. See `DESIGN_RULES.md` in the repo for full design rules.

## Roadmap

- **Phase 1** — Web-only Card of the Day, EN/RU, login/upgrade UI (no backend).
- **Phase 2** — Backend, auth, and premium/rituals (purchase flows later).
- **Phase 3** — Archive, profile, and expanded content.

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
