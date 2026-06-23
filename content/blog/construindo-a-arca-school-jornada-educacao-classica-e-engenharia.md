+++
title = "Building Arca School: A Journey in Classical Education and Software Engineering"
date = 2025-12-26
description = "A detailed look at the technical architecture behind Arca School — 7 Rust repositories, CI/CD, and the bridge between tradition and code."

[taxonomies]
tags = ["rust", "architecture", "engineering"]

[extra]
reading_time = 7
+++

If the first post was about the *why*, this one is about the *how*. Arca School's architecture didn't come from a template or a tutorial. It came from questions: how do you model a thousand-year-old curriculum in code? How do you ensure the platform withstands time as well as the content it carries?

<!-- more -->

## The Architecture: 7 Repositories

The Arca School ecosystem is composed of 7 repositories, each with a clear domain:

**arca-api** is the heart — the REST API that models the educational domain. Blocks, Disciplines, Phases, Curricula. All in Rust with Axum and SQLx.

**slm-engine** (Small Language Model Engine) is the AI engine. We don't use GPT or giant models. We train small, focused models aligned with classical pedagogy.

**scriptorium** manages content — classical texts, curricula, teaching materials. The name is a tribute to the medieval scriptoria where monks copied and preserved knowledge.

**spec-machine** generates structured specifications from raw content. It transforms pedagogical intent into data the platform consumes.

**mathscribe** is the mathematical engine. It converts LaTeX into structured data, renders equations, and ensures that the Arithmetic and Geometry of the Quadrivium are taught with precision.

**arca-school-platform** is the frontend — the interface students see. Clean, focused, distraction-free.

**deploy** orchestrates everything — Docker, CI/CD, Oracle Cloud, health checks, automatic rollback.

## Cross-Repo CI/CD

One of the most important architectural decisions: each application repository (api, platform) builds and publishes its own Docker images. The deploy repository *receives* those images and handles deployment. Clear separation between build and deploy.

This is implemented via `repository_dispatch` — when a push to main on arca-api passes tests and builds the image, it fires an event on the deploy repo, which pulls the image and updates the server.

## What I've Learned So Far

Building a system with 7 repositories teaches you one thing fast: **interface clarity is everything**. Each CLAUDE.md documents not just the code, but the *contract* between repositories. Which endpoints does scriptorium expect from the API? Which events does deploy listen for?

The discipline of documenting this *before* coding is what keeps the project viable as a team of one.

---

In the next post, I'll show how DDI works in practice — with a complete example of a User Story, from intent to deploy.
