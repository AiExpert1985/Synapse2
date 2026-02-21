# Project Init Snapshot

> This file is a frozen snapshot of the initial project discussion.
> It is never updated, maintained, or treated as authoritative.
> Sections marked (Initial) may be outdated after early tasks.

Generated: 2026-02-21

## Vision

Synapse is "The Sovereign Strategic Intelligence Ledger." It converts fragmented media consumption (YouTube, images, voice memos) and spontaneous "fire thoughts" into verifiable executive assets. The core insight: current AI tools summarize content generically; Synapse instead archives *how the user perceives* information, building an "Immortal Memory" that synthesizes decision-ready reports in seconds. All user data stays local by default; cloud AI is invoked only on explicit user request.

## Users

High-performance professionals (executives, engineers, strategists) who consume media during commutes or multitasking and need to convert those insights into formal, citable outputs for decisions weeks or months later. Initial target market: Dubai D33 context — professionals operating in a high-velocity knowledge environment.

## Screens & Flows (Initial)

- **Capture Flow — Anchored (YouTube):** User pastes or opens a YouTube link → video plays → user taps to anchor a thought at a specific timestamp → enters perspective (text or voice) → saved locally.
- **Capture Flow — Orbital (Standalone):** Rapid entry screen — user uploads/photos an image or records a voice memo → optionally binds a perspective text → saved locally. Media without perspective is allowed; perspective without media is allowed.
- **Ledger View:** Browsable, searchable list of all Perspectives. Semantic search powered by on-device EmbeddingGemma. Fully offline.
- **Synthesis Flow:** User selects N Perspectives from the Ledger → writes a custom directive (e.g., "Draft a SWOT analysis") → triggers cloud AI call → receives structured report.
- **Output View:** Rendered report with evidence deep-links. Export to PDF. Each claim links back to source timestamp or image.

## Core Functionality (Initial)

- Anchored Capture: YouTube transcript + user perspective + timestamp binding + keyframe thumbnail (at timestamp − 10s).
- Orbital Capture: Image/voice/text with optional perspective binding.
- On-device semantic search (EmbeddingGemma via MediaPipe).
- Directed Synthesis: User-curated RAG → Gemini 1.5 Pro (cloud AI provider TBD) → structured report.
- Evidence-Linked PDF export with deep-links to source.
- Firebase Auth + Cloud Functions as relay for AI synthesis.
- AES-256 encryption of perspective text before any cloud transmission; key derived from user biometric/passphrase, never stored on server.

## UX & Design Philosophy

- **Perception over Transcription:** User thought is the primary artifact. Media is evidence.
- **Immortal Perspectives:** Data is a cumulative, growing asset — not disposable.
- **Instant Capture:** Capture must be instant and always available offline. No cloud dependency may slow it.
- **Executive-Grade Output:** Reports are professional and 100% verifiable by source.
- **No Ads:** Privacy-first; monetization via value (subscription tiers), never attention.

## UI & Screen Notes (Initial)

- App targets Android first, then iOS. No desktop or web.
- "Sovereign Ledger" branding suggests a premium, dark-UI aesthetic (not confirmed).
- Capture must feel as fast as a native notes app.
- PDF output should be boardroom-ready in appearance.

## Open Ideas

- Post-MVP: Zero-knowledge encrypted cloud backup (perspectives encrypted on-device before sync).
- Post-MVP: Cross-device continuity (mobile capture → desktop synthesis).
- Post-MVP: Shared Perspective Pools for teams (B2B Enterprise Vault tier).
- Post-MVP: Role-Based RAG with weighted contributor trust scores.
- Post-MVP: Native video OCR and scene intelligence (chart/code block detection).
- Post-MVP: Dynamic storyboarding — .pptx or .canvas export instead of static PDF.
- Post-MVP: Semantic collision detector for conflicting team perspectives on same source.

## Notes

- Tech stack confirmed: Flutter, Riverpod 3 (no legacy), Go Router.
- Building full app iteratively, task by task, starting from zero. No MVP/date constraints.
- Monetization tiers: Free (local only, zero API cost) / Strategist $29/mo (cloud synthesis credits) / Enterprise (B2B licensing).
- UAE PDPL and Dubai Universal Blueprint for AI compliance stated as a goal.
- Open questions at init: AI provider (fixed Gemini vs user-configurable), Auth method, SQLite vs ObjectBox.
