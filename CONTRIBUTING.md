# Contributing to Mystic

## Branching

- **`main`** — stable, release-ready code.
- **`dev`** — integration branch for features and fixes. Prefer branching from `dev` for new work and merging back to `dev` before proposing a release to `main`.

## Commit messages

- Use clear, present-tense messages: e.g. `Add EN/RU toggle` or `Fix card layout on narrow viewports`.
- Optionally prefix with area: `i18n: Add missing string key`, `theme: Document design lock`.

## Design and tokens

- **Do not change design tokens without explicit approval.** All colors live in `lib/theme/app_colors.dart`; do not introduce new colors or use `Colors.*` / raw hex outside that file. See `DESIGN_RULES.md`.
- Keep the existing UI layout and design lock (white background, black text, muted gold accent).

## Secrets and config

- **No Firebase or other secrets committed.** Do not add `google-services.json`, `GoogleService-Info.plist`, or any file containing API keys or credentials. Use env vars or secure config for local and CI.

## Scope

- Do not add packages or change app UI/business logic unless the change is agreed (e.g. in an issue or PR description). Repo hygiene (docs, `.gitignore`, etc.) is welcome.
