+++
title = "Building Arca School: Classical Education and Intent Engineering"
date = 2025-12-26
description = "Implementing an educational platform using Rust, the Trivium, and the Essay-to-Learn methodology."

[taxonomies]
tags = ["classical-education", "architecture", "devlog", "rust"]

[extra]
reading_time = 7
+++

Arca School is an educational infrastructure designed to implement the **Trivium** (Grammar, Logic, and Rhetoric). The system uses a Rust stack and an architecture based on Small Language Models (SLM) to support intellectual production.

<!-- more -->

## Methodological Structure

Learning is organised in three fundamental stages, culminating in the **Essay-to-Learn** methodology:

1. **Grammar:** Gathering and organising fundamental data.
2. **Logic:** Analysing contradictions and constructing valid arguments.
3. **Rhetoric / Essay-to-Learn:** Synthesising knowledge through essay writing.

At Arca School, the essay is the basic unit of assessment and data generation. The process is assisted by an SLM engine that analyses the logical structure and cohesion of the text without interfering with authorial content. Essays that meet technical criteria for information density are used as the basis for training specialised models on specific topics.

## SLM Engine Specifications

Each submitted essay goes through a validation pipeline to ensure human authorship and technical quality before being integrated into the training dataset.

### Validation Metrics (Validator)

| Metric | Threshold | Technical Function |
| --- | --- | --- |
| **Shannon Entropy** | ≥ 0.7 | Measures the randomness of character distribution. |
| **Combined Keystroke** | ≥ 0.6 | Validation via keystroke telemetry (Variance + Pauses). |
| **Authenticity Score** | ≥ 0.65 | Weighted fusion: 60% Entropy + 40% Keystroke. |

### Quality and Evaluation Metrics (Distiller & Evaluation)

* **Quality Score (≥ 0.6):** Filters instruction/response pairs extracted from essays.
* **Syllogism Score (> 90%):** Validates the trained model's formal logical reasoning capability.
* **MMLU PT (> 85%):** Accuracy across logic, philosophy, and mathematics domains.
* **Perplexity (< 10% deg.):** Monitors linguistic degradation post-fine-tuning.

## Technology Stack

The ecosystem is built in **Rust** and distributed across 7 repositories:

* **arca-api:** Domain core and REST API.
* **slm-engine:** Model processing, validation, and training.
* **scriptorium:** Curriculum and base text management.
* **spec-machine:** Structured specification generator.
* **mathscribe:** LaTeX to structured data processing.
* **arca-school-platform:** User interface.
* **deploy:** Infrastructure and CI/CD pipelines.

## DDI Method (Development Driven by Intent)

Development follows the **DDI** method, a variation of **Spec-Driven Development** focused on formalising architectural intent before execution. The cycle comprises four stages:

1. **Intent:** Technical definition and objective specification.
2. **Test:** Coding the validation of the intent/specification.
3. **Implementation:** Strictly necessary code to satisfy the specification.
4. **Review:** Verifying conformity between the artefact and the original intent.

---

Follow the progress on [GitHub](https://github.com/DbonesDev) or via [RSS feed](/atom.xml).
