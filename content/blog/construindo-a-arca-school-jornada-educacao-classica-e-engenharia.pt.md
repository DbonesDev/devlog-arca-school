+++
title = "Construindo a Arca School: Uma Jornada na Educação Clássica e Engenharia de Software"
date = 2025-12-26
description = "Uma visão detalhada da arquitetura técnica por trás da Arca School — 7 repositórios Rust, CI/CD, e a ponte entre tradição e código."

[taxonomies]
tags = ["rust", "arquitetura", "engenharia"]

[extra]
reading_time = 7
+++

Se o primeiro post foi sobre o *porquê*, este é sobre o *como*. A arquitetura da Arca School não surgiu de um template ou de um tutorial. Surgiu de perguntas: como modelar um currículo milenar em código? Como garantir que a plataforma resiste ao tempo tão bem quanto o conteúdo que ela carrega?

<!-- more -->

## A Arquitetura: 7 Repositórios

O ecossistema da Arca School é composto por 7 repositórios, cada um com um domínio claro:

**arca-api** é o coração — a API REST que modela o domínio educacional. Blocos, Disciplinas, Fases, Currículos. Tudo em Rust com Axum e SQLx.

**slm-engine** (Small Language Model Engine) é o motor de IA. Não usamos GPT ou modelos gigantes. Treinamos modelos pequenos e focados, alinhados com a pedagogia clássica.

**scriptorium** gerencia o conteúdo — textos clássicos, currículos, material didático. O nome é uma homenagem aos scriptoria medievais onde monges copiavam e preservavam o conhecimento.

**spec-machine** gera especificações estruturadas a partir de conteúdo bruto. Transforma intenção pedagógica em dados que a plataforma consome.

**mathscribe** é o motor matemático. Converte LaTeX em dados estruturados, renderiza equações, e garante que a Aritmética e a Geometria do Quadrivium sejam ensinadas com precisão.

**arca-school-platform** é o frontend — a interface que os alunos veem. Limpa, focada, sem distrações.

**deploy** orquestra tudo — Docker, CI/CD, Oracle Cloud, health checks, rollback automático.

## Cross-Repo CI/CD

Uma das decisões arquiteturais mais importantes: cada repositório de aplicação (api, platform) builda e publica suas imagens Docker. O repositório de deploy *recebe* essas imagens e faz o deployment. Separação clara entre build e deploy.

Isso é implementado via `repository_dispatch` — quando um push na main do arca-api passa nos testes e builda a imagem, ele dispara um evento no repo de deploy, que puxa a imagem e atualiza o servidor.

## O Que Aprendi Até Aqui

Construir um sistema com 7 repositórios ensina uma coisa rápido: **a clareza de interfaces é tudo**. Cada CLAUDE.md documenta não só o código, mas o *contrato* entre repositórios. Quais endpoints o scriptorium espera da API? Quais eventos o deploy escuta?

A disciplina de documentar isso *antes* de codificar é o que mantém o projeto viável com um time de um.

---

No próximo post, vou mostrar como o DDI funciona na prática — com um exemplo completo de uma User Story, do intent ao deploy.
