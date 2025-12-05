# Copilot Instructions for Wayfinder

## Project Overview
Wayfinder is a Garmin Connect IQ app for water sports, with a companion Go server. The app tracks and displays metrics (speed, duration, max speeds) and points to the starting location. The server manages device codes and waypoints for synchronization.

## Architecture
- **App (Monkey C):** Main entry is `source/WayfinderApp.mc`. Core controllers are in `source/behavior/`. UI logic is in `source/components/`, `source/views/`, and related folders.
- **Server (Go):** Main entry is `server/main.go`. Key modules: `devicerepository/`, `generator/`, `model/`, `storage/`, `scheduler/`, and `server/`.
- **Resources:** XML files in `resources/` define settings, strings, drawables, and contributions.
- **Build Artifacts:** Output binaries and test data are in `bin/`.

## Developer Workflows
- **App Build:**
  - Use GitHub Actions (`.github/workflows/garmin.yml`) for CI builds.
  - Local build: Use Monkey C tools and reference `monkey.jungle` and `manifest.xml`.
  - Developer key is encrypted (`developer_key.gpg`), decrypted via `.github/scripts/decrypt_secret.sh`.
- **Server Build & Test:**
  - Use Go modules. Build with `go build` in `server/`.
  - Run tests with `go test ./...` in `server/`.
  - CI/CD pipeline defined in `.github/workflows/server.yml`.
- **Taskfile:**
  - Use `Taskfile` for common project tasks (init, start, stop, restart, ngrok proxy for Garmin).
  - Example: `./Taskfile task:start` to start dev environment.

## Project-Specific Conventions
- **Monkey C:**
  - Controllers are initialized in `WayfinderApp.mc` and passed dependencies explicitly.
  - Use `AppTimer` for periodic updates and sampling.
  - Settings are managed via `SettingsController` and applied on change.
- **Go Server:**
  - Data models are in `model/` (e.g., `DeviceInstance`, `Waypoint`).
  - Storage is abstracted via generic interfaces in `storage/`.
  - Scheduler pattern for periodic tasks in `scheduler/`.
  - Retrieval and storage of models is done using repositories (eg. `devicerepository/`).

## Integration Points
- **App ↔ Server:**
  - Communication via `WaypointServerRetriever` and `WaypointServerClient` (see `WayfinderApp.mc`).
  - Waypoints and device codes are synchronized between app and server.
- **External:**
  - Garmin Connect IQ SDK for app development.
  - Go modules for server dependencies.
  - Docker for server deployment (see `server/Dockerfile`).

## Patterns & Examples
- **Dependency Injection:** Controllers and providers are passed as constructor arguments.
- **Resource-Driven UI:** UI and settings are defined in XML under `resources/`.
- **Type Safety:** Go generics for storage and code generation; Monkey C uses explicit type annotations.
- **Interface/Abstract Class Pattern in `source/behavior`:**
  Most services in `source/behavior` define an interface as an abstract class, which is then extended by a concrete implementation. Dependent classes accept the abstract class/interface type, allowing for flexible substitution. The actual implementation is constructed and injected in the `WayfinderApp.mc` entrypoint. In tests, stub implementations of these interfaces can be provided to isolate dependencies and control behavior.


## Test Structure & Conventions

- **Go Server Tests:**
  - Unit and integration tests are placed alongside source files, named with `_test.go` (e.g., `server/devicerepository/devicerepository_test.go`).
  - Run all tests with `go test ./...` from the `server/` directory.
  - Tests use standard Go testing patterns and may mock storage or generator interfaces.

- **Garmin (Monkey C) App Tests:**

  - Monkey C test files use the `.test.mc` suffix (e.g., `source/containers/FloatRingBuffer.test.mc`).
  - Tests are typically run using the Connect IQ SDK tools, CI workflows, or the Taskfile command:
    - `./Taskfile garmin:test` — builds and runs Monkey C unit tests for the app on the configured device.
  - Test data and debug artifacts are stored in `bin/` (e.g., `.prg.debug.xml`, test JSON files).

Refer to CI workflows in `.github/workflows/` for automated test execution and reporting.

---

**If any section is unclear or missing important project-specific details, please provide feedback or specify which workflows, conventions, or integration points need further documentation.**
