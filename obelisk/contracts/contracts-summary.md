# Contracts Summary

Generated: 2026-02-21

## System Identity
_(empty — populated after first maintenance)_

## Active Contracts
_(empty — populated after first maintenance)_

## Non-Goals
_(empty — populated after first maintenance)_

## Unprocessed

### System Identity

- **Name:** Synapse
- **What it is:** A personal strategic intelligence app for Android (then iOS) that lets users capture perspectives on media (YouTube, images, voice memos) and synthesize them into verifiable, evidence-linked AI reports.
- **What it is NOT:** A generic summarization tool; not a team/social app; not a desktop/web app; not a podcast or video hosting platform; not an advertising product.
- **Users:** High-performance professionals who consume media and need to convert insights into decision-ready outputs.

---

### Core Contracts

- **C-01 — Data Sovereignty:** All captured data stays on-device. Nothing leaves the device unless the user explicitly triggers an AI report generation (a deliberate, per-report user action). No background sync.
- **C-02 — Perspective-First AI:** AI synthesis must treat user-provided perspective text as the primary truth. AI must NOT interpret media (images, transcripts) in isolation without a user perspective attached to the synthesis.
- **C-03 — Capture Availability:** Capture (all input — text, voice, image, YouTube anchoring) must always work offline. Cloud features are additive and must never block or degrade capture.
- **C-04 — Offline Search:** On-device semantic search must function fully offline. No network call is permitted for search.
- **C-05 — No Advertising:** The product must never monetize via advertising. Monetization is through subscription tiers only.
- **C-06 — Perspective/Media Independence:** Media can exist without a perspective. A perspective can exist without media. AI synthesis requires at least one user perspective; it cannot run on media alone.

---

### Feature-Level Contracts

- **C-07 — Anchored Capture Timestamp Binding:** A YouTube perspective must be bound to a specific video timestamp. Unanchored YouTube captures are not valid Anchored Captures.
- **C-08 — Keyframe Cognitive Lag Offset:** Keyframe thumbnails must be extracted at [Timestamp − 10s] to account for cognitive lag between perception and capture.
- **C-09 — Directed Synthesis — User Control:** Users must explicitly select which perspectives are included in a report and provide a custom directive. AI must not auto-select perspectives or auto-generate reports without explicit user initiation.
- **C-10 — Evidence Traceability:** Every claim in a generated report must be traceable back to a specific source: a video timestamp or an original image. Reports without verifiable evidence links are not valid outputs.
- **C-11 — Pre-Transmission Encryption:** Perspective text must be AES-256 encrypted before any cloud transmission. The encryption key must be derived from the user's local biometric or passphrase and must never be stored in plaintext on any server.
- **C-12 — Image Transmission Control:** Raw high-resolution images must NOT be sent to cloud AI unless the user explicitly requests it for a specific synthesis.

---

### Explicit Non-Goals

- No desktop or web app (ever, by current decision)
- No ads
- No generic summaries without user perspective
- No background or automatic cloud sync
- No raw video processing (YouTube: transcripts only)
- No podcast/RSS in initial build

---

### Open Contract Questions

- **OQ-01 — AI Provider:** Gemini 1.5 Pro is the specified cloud AI. Is the provider fixed, or will users be able to supply their own API key or choose provider? This affects data sovereignty contracts (C-01, C-11).
- **OQ-02 — Auth Method:** Email/password, Google OAuth, biometric, or user's choice? Affects key derivation strategy in C-11.
- **OQ-03 — Local DB Engine:** SQLite vs ObjectBox — preference or task-level decision?
