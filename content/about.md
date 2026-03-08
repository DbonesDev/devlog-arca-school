+++
title = "About"
template = "page.html"
+++

## What is this?

This is the public build log for **Arca School** — a classical education platform being built from scratch with Rust, discipline, and a deep respect for tradition.

Arca School combines the **Trivium** (Grammar, Logic, Rhetoric) and **Quadrivium** (Arithmetic, Geometry, Music, Astronomy) with modern software engineering. Think of it as what would happen if a medieval scriptorium met a Silicon Valley startup.

## Who's building it?

I'm **Diego Bonesso** — a software engineer who believes that the best technology serves timeless ideas, not the other way around. I'm building Arca School as both a product and a practice: every architectural decision is intentional, every line of code is deliberate.

## The Stack

The entire ecosystem runs on **Rust**, organized across 7 repositories:

- **arca-api** — Core REST API with the educational domain model
- **slm-engine** — Small Language Model engine for AI-assisted learning
- **scriptorium** — Content management for classical texts and curriculum
- **spec-machine** — Specification generator for structured content
- **mathscribe** — Mathematical notation engine (LaTeX → structured data)
- **arca-school-platform** — The student-facing frontend
- **deploy** — Infrastructure and CI/CD orchestration

## The Method

Every feature follows **DDI (Intent-Driven Development)**:

1. **Intent** — Define what and why before writing code
2. **Test** — Write the test that proves the intent
3. **Implementation** — Build just enough to pass the test
4. **Review** — Verify against the original intent

This isn't just a blog about building software. It's a practice of building *well*.

---

Follow the journey on [GitHub](https://github.com/DbonesDev) or subscribe to the [RSS feed](/atom.xml).
