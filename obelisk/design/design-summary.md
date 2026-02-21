# Design Summary

Generated: 2026-02-21

## System Architecture
_(empty — populated after maintenance)_

## Data Model
_(empty — populated after maintenance)_

## Core Design Principles
_(empty — populated after maintenance)_

## Modules
_(empty — populated after maintenance)_

## Open Design Questions
_(empty — populated after maintenance)_

## Unprocessed

### Tech Stack

- **Frontend:** Flutter (Android-first, then iOS; no desktop/web)
- **State Management:** Riverpod 3 — no legacy APIs (no `StateProvider`, no `ChangeNotifierProvider`, etc.)
- **Navigation:** Go Router
- **Local Storage:** SQLite or ObjectBox (to be decided at task level — see OQ-03)
- **On-device Semantic Search:** EmbeddingGemma via MediaPipe (100% private, offline indexing)
- **Cloud Backend:** Firebase (Auth + Cloud Functions)
- **Cloud AI:** Gemini 1.5 Pro for synthesis (provider TBD — see OQ-01)

---

### Architectural Decisions

- **Offline-First:** The app architecture must prioritize offline availability for all capture and search flows. Cloud calls are isolated to the synthesis/report generation flow only.
- **Local-First Data:** All user data lives in local SQLite/ObjectBox. Firebase is used only for auth and as a relay for AI API calls — not as the primary data store.
- **RAG Pipeline:** Synthesis sends `perspective_text` + `transcript_snippet` + `user_directive` to the cloud AI. Raw video and high-res images are excluded unless explicitly requested by user.
- **No Legacy Riverpod:** All providers must use Riverpod 3 patterns (`@riverpod` code generation or `NotifierProvider`, `AsyncNotifierProvider`). No `StateProvider`, `StateNotifierProvider`, or `ChangeNotifierProvider`.
- **Go Router for Navigation:** All routing declarative via Go Router. Deep-link support required (for evidence links in PDF reports pointing back to in-app views).

---

### Module Definitions (Initial)

- **Capture Module:** Handles all input — Anchored (YouTube + timestamp), Orbital (image, voice, freeform text). Must work fully offline.
- **Ledger Module:** Local semantic index using EmbeddingGemma. Manages storage, retrieval, and search of all Perspectives.
- **Synthesis Module:** Directed RAG pipeline. User selects Perspectives + provides directive → sends to cloud AI → returns structured report. Gated behind explicit user action.
- **Output Module:** Generates evidence-linked PDF. Maps every synthesized claim back to its source (timestamp or image reference).
- **Auth Module:** Firebase Auth. Method TBD (see OQ-02).

---

### UX Philosophy

- **Perception over Transcription:** The user's thought is the primary artifact. Media is evidence, not the subject.
- **Immortal Perspectives:** Captured data is a cumulative, growing asset — not disposable notes.
- **Instant Capture:** Capture speed is a hard UX constraint. No loading state, no login wall, no cloud dependency should ever slow capture.
- **Executive-Grade Output:** Reports must look professional and be 100% verifiable by source links.

---

### Keyframe Logic

- Keyframe thumbnail extracted at `[capture_timestamp − 10s]` to compensate for cognitive lag between watching and tapping capture.

---

### Open Design Questions

- **OQ-01 — AI Provider:** Fixed (Gemini 1.5 Pro) or user-configurable API key / provider selection?
- **OQ-02 — Auth Method:** Email/password, Google OAuth, biometric passphrase, or choice?
- **OQ-03 — Local DB Engine:** SQLite vs ObjectBox — performance, query, and vector storage trade-offs to be evaluated at task level.
