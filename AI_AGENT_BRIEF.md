# NIU Mobility Studio — AI Agent Brief

> **One-line project description:** NIU Mobility Studio is an Android/Kotlin application for managing NIU electric vehicles, exploring BLE/GATT diagnostics, reviewing NIU Cloud data, maintaining service/ride records, and integrating Telegram automation with role-based access, a persistent foreground bot service, structured logs, and an in-app source workspace.

## Agent instructions
- Treat this repository as an Android application using Kotlin, Jetpack Compose, Gradle Kotlin DSL, and a separate `niu-sdk` module.
- Application namespace and applicationId are `com.niu.fxstudio`; preserve them unless a migration is explicitly requested.
- Read `README_RU.md`, `ARCHITECTURE_V3_RU.md`, `BUILD_STATUS_RU.md`, `protocol-docs/`, and relevant module documentation before changing behavior.
- Do not invent NIU ECU/BLE command bytes, UUID meanings, cloud endpoints, authentication steps, or model compatibility. Mark findings as confirmed, inferred, or unknown and cite evidence in code comments/docs.
- Keep vehicle operations model/firmware-specific. Unknown or unverified write commands must remain disabled; AI analysis is advisory and never overrides application-side safety checks.
- Never log passwords, OAuth tokens, bot tokens, cookies, authorization headers, private keys, or unmasked personal identifiers. Preserve centralized redaction.
- For source modifications, produce a minimal diff, add/update tests, run available Gradle checks, and report checks that could not run. Never claim an APK was built unless a real build artifact exists.
- Do not execute arbitrary imported project scripts automatically. Require explicit user confirmation for destructive actions, publishing, signing, or applying AI-generated patches.

## Main areas
- `app/`: Android UI, navigation, BLE/NFC, cloud and Telegram integrations, Foreground Service, role-based access, structured logs, workspace.
- `niu-sdk/`: model catalog, GATT profiles, packet abstractions, telemetry and command registry.
- `niu-profiles/`: model-family metadata and per-model profiles.
- `protocol-docs/`: protocol research and evidence notes.
- `.github/workflows/`: CI build workflow.

## Current limitations to preserve transparently
- BLE command coverage differs by NIU family, ECU and firmware; not every family has a verified command map.
- NIU Cloud behavior may vary by region and service implementation; reverse-engineered APIs are not official guarantees.
- Telegram AI requires a configured HTTPS backend/provider; do not claim a bundled model exists unless one is actually included.
- Local Android build capability depends on a separately provisioned toolchain or remote CI.
