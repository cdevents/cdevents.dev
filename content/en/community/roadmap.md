<!--
---
linkTitle: "Roadmap"
weight: 40
icon: "fa-solid fa-map"
hide_summary: true
toc_hide: false
type: docs
description: >
    Roadmap
---
-->

<!-- cSpell:locale en-US -->
# CDEvents Mission and Roadmap

This document describes the mission of the CDEvents and its overall roadmap for 2023/2024.

## Mission & Vision

The mission of CDEvents project is:

> Provide interoperability in the continuous delivery ecosystem through a common events protocol

The vision for the CDEvents project is to have CDEvents natively produced and consumed by as many projects and services as possible in the continuous delivery ecosystem, to provide decoupled and scalable integration with minimal or no glue code.

We envision an ecosystem of tools to generate, store, process and visualize CDEvents.

## Roadmap

The continuous delivery ecosystem is quite large as it includes tools and services that span from the design of software, through its implementation, build, test, release, deployment and operation.

In 2023/2024 we want to focus on a few [key use cases](/docs/primer#use-cases) and make sure that we can fully support them with the protocol specification. More specifically:

- Evolve the project bootstrap governance into a full governance
- On the CDEvents specification
  - Define a mechanism for linking events with each other
  - Expand the scope with Ticket and Approval events
  - Introduce supply chain aspects:
    - Add SBOM link into artifact events
    - Add mechanism to track releases
  - Expand the set of events available to artifact registries
  - Introduce support for groups of subjects. Examples:
    - A group of changes that represent a release
    - A group of artifacts that represent an application
- On the CDEvents SDK
  - Complete the work of auto-generating the Java SDK
  - Make the Python SDK auto-generated from the spec
  - Develop an SDK in Rust, JavaScript and .NET
- Release Management
  - Create [release v0.4](https://github.com/orgs/cdevents/projects/1/views/13)
  - Define the project release cadence
  - Define our requirements for a v1.0
- Publish an updated whitepaper
- Validate and demonstrate the spec through proofs-of-concept
- Continue to collaborate with various communities to promote CDEvents adoption

The implementation of proofs of concept will require having CDEvents emitted by various platforms which do not support CDEvents yet. Where possible we will work with the community; it is likely we will have to develop producers and consumers of CDEvents that can adapt existing event formats into CDEvents. We will host such reference implementations in the `cdevents` organization at least until they can find a new home in the target project. These implementations will be useful to identify the mapping between the data model of a specific platform and CDEvents; we can add these mappings to supporting documentation in `cdevents` organization.
