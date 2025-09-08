# CDEvents Concepts and Definitions

This document defines common concepts and ideas used across the SDLC (software
development lifecycle). By establishing a shared vocabulary, it ensures that
tools leveraging CDEvents use a consistent language and adhere to common
definitions for seamless interoperability across different toolsets.

## 🏗️ Build

A **build** is the automated process of transforming **source code** and
**resources** into an **executable artifact** that can be tested, deployed, or
distributed.

This artifact may be a binary, a container image, a static website bundle, or
even a deployable infrastructure definition like Kubernetes manifests.

---

### 🧩 What Are “Resources”?

Resources are any **non-executable assets** required to complete, package, or
run a system. These include:

- **Static assets**: images, fonts, CSS, markdown
- **Configuration files**: YAML, JSON, XML, `.env`
- **Templates**: HTML, Handlebars, Jinja
- **Schemas / contracts**: OpenAPI specs, GraphQL schemas
- **Localization files**: `.po`, `.mo`, `.json` for locale strings
- **Compiled non-code assets**: `.wasm` from `.wat`, `.pdf` from `.md`

Some builds may not involve source code at all — such as infrastructure-as-code
templates, documentation bundles, or configuration files that need packaging,
versioning, or transformation.

---

### 🔧 What Constitutes a Build?

A typical build process may include:

- 🔄 **Compiling code**: e.g., `.java → .class`, `.ts → .js`
- 📦 **Bundling dependencies**: e.g., NPM modules, Maven packages
- 📦 **Packaging artifacts**: e.g., JAR, Docker image, zip file
- 🏷️ **Versioning**: tagging or stamping artifacts
- 🧪 **Static analysis** *(pre-build or during build)*
- 🧬 **Configuration templating**: injecting environment-specific variables

---

### 🧪 Build Examples and Edge Cases

| **Type**                       | **Is it a Build?** | **Example**                                        | **Notes**                                                  |
|-------------------------------|--------------------|----------------------------------------------------|------------------------------------------------------------|
| Java code to JAR              | ✅ Yes             | Compile `.java` to `.jar`                          | Traditional code compilation                              |
| Markdown to HTML              | ✅ Yes             | Static site generation (e.g., Hugo)                | Transforms content into deployable form                   |
| CSS/JS minification           | ✅ Yes             | Bundle & minify assets                             | Common in front-end workflows                             |
| Copying static files          | ❌ Not typically   | File copying without transformation                | Often part of build but not a build by itself             |
| Helm template to Kubernetes   | ✅ Yes             | `helm template` to render manifests                | Generates deployable infra config                         |
| Helm chart packaging          | ✅ Yes             | `helm package` to create `.tgz` chart              | Versioned artifact used in CI/CD pipelines                |
| Helm deployment               | ❌ No              | `helm install` or `upgrade`                        | Deployment, not artifact creation                         |

---

### 🧰 Tool-Specific Considerations

| **Tool**         | **Definition of Build**                                           |
|------------------|-------------------------------------------------------------------|
| Jenkins          | A "build" typically refers to a job run (can be compile, test, etc.) |
| GitHub Actions   | No strict definition — "build" is defined by your workflow steps  |
| GitLab CI/CD     | Often treated as a named stage (e.g., `build`, `test`, `deploy`)  |
| Spinnaker        | Uses "bake" or "artifact" stages, and may trigger builds externally |

---

## 🧪 Test

A **test** is the automated process of executing code, configuration, or system
components to **verify correctness, quality, and adherence to specified
requirements**. It provides feedback on whether a system behaves as expected
under various conditions.

---

### 🔬 What Are “Test Assets”?

Test assets encompass any components, data, or environments specifically
designed or required to perform testing. These include:

-   **Test Cases**: Specific inputs, execution steps, and expected outputs or behaviors.
-   **Test Suites**: Collections of related test cases, often grouped by functionality or type.
-   **Test Data**: Data used as input for test cases (e.g., mock data, sanitized production data).
-   **Test Environments**: Specific configurations of hardware, software, and network settings where tests are executed.
-   **Test Frameworks**: Libraries or tools that facilitate writing, executing, and reporting tests (e.g., JUnit, Pytest, Selenium, Jest).
-   **Test Reports**: Summaries of test execution, including pass/fail status, errors, and performance metrics.

---

### 📊 What Constitutes a Test?

A typical automated test process may include:

-   🚀 **Execution**: Running one or more test cases against the system under test.
-   🔍 **Assertion**: Comparing actual outputs or behaviors against expected outcomes.
-   ✅ **Validation**: Determining whether the test passed or failed based on assertions.
-   📝 **Reporting**: Generating logs, metrics, and reports of test results.
-   ⚙️ **Setup/Teardown**: Preparing the test environment before execution and cleaning up resources afterward.
-   📈 **Coverage Analysis**: Measuring the extent to which the code or system has been exercised by tests.

---

### 🧪 Test Examples and Edge Cases

| **Type**                     | **Is it a Test?** | **Example**                                         | **Notes**                                                         |
|------------------------------|-------------------|-----------------------------------------------------|-------------------------------------------------------------------|
| Unit Test                    | ✅ Yes            | JUnit tests for a Java class                        | Verifies individual components in isolation                       |
| Integration Test             | ✅ Yes            | API tests verifying service interaction             | Checks communication and data flow between modules                |
| Functional/Acceptance Test   | ✅ Yes            | Selenium UI tests for a web application             | Validates end-to-end user flows against requirements              |
| Performance Test             | ✅ Yes            | JMeter load test on an API endpoint                 | Assesses system responsiveness and stability under load           |
| Security Scan (SAST/DAST)    | ✅ Yes            | SonarQube static analysis, OWASP ZAP dynamic scan   | Identifies vulnerabilities (often automated in CI/CD)             |
| Contract Test                | ✅ Yes            | Pact tests between consumer and provider APIs       | Ensures API compatibility between services                        |
| Accessibility Test           | ✅ Yes            | Automated WCAG compliance checks (e.g., Axe)        | Verifies usability for people with disabilities                   |
| Manual Exploratory Testing   | ❌ No             | Human tester exploring application functionality    | Not an automated process, thus outside CDEvents scope             |
| Code Linting/Formatting      | ❌ No             | `prettier --check`, `gofmt`                         | Focuses on code style and consistency, not functional correctness |
| Dependency Vulnerability Scan| ❌ No             | `npm audit`, Snyk scan                              | Scans for known vulnerabilities in dependencies, not functional test of *your* code |

---

### 🧰 Tool-Specific Considerations

| **Tool**         | **Definition of Test**                                         |
|------------------|----------------------------------------------------------------|
| Jenkins          | Defined by pipeline steps that execute test commands (e.g., `mvn test`) |
| GitHub Actions   | Typically a job or step that runs test commands or frameworks  |
| GitLab CI/CD     | Often a dedicated job stage (e.g., `test` stage) with test execution commands |
| Azure DevOps     | "Test Plans" or "Test Pipelines" that run automated tests and publish results |
| SonarQube        | Primarily for static analysis and code quality, but often integrated with test results for coverage |
| Jest/JUnit/Pytest| Frameworks for writing and executing tests within codebases    |
| Selenium/Cypress | Frameworks for automated browser-based functional testing      |

---

## 💾 Store

**Storing** is the automated process of persistently saving, managing, and
making accessible any **artifact, data, or metadata** generated or consumed
during the SDLC. It ensures that necessary components and information are
retrievable for future use, auditing, or deployment.

---

### 📦 What Are “Stored Assets”?

Stored assets encompass any durable output or input that is preserved across
the SDLC. These include:

-   **Build Artifacts**: Executables, container images, packages, libraries (e.g., JARs, WARs, Docker images, npm packages).
-   **Source Code**: The versioned codebase managed in a Version Control System (VCS).
-   **Configuration**: Environment-specific settings, deployment manifests, or infrastructure-as-code definitions.
-   **Test Results**: Reports, logs, and metrics from test executions.
-   **Logs**: Runtime logs from applications or infrastructure.
-   **Metrics**: Performance, usage, or health data collected over time.
-   **Documentation**: Generated or manually created documentation.
-   **Snapshots/Backups**: Point-in-time copies of databases or systems.

---

### 🗄️ What Constitutes Storing?

A typical automated storing process may include:

-   ⬆️ **Publishing/Uploading**: Transferring an asset to a designated repository or storage location.
-   🏷️ **Tagging/Versioning**: Assigning unique identifiers or metadata to stored assets for traceability.
-   📦 **Indexing**: Cataloging assets within a repository for efficient searching and retrieval.
-   🔐 **Access Control**: Applying permissions to regulate who can access or modify stored assets.
-   🧹 **Retention/Cleanup**: Managing the lifecycle of stored assets, including deletion policies.
-   🔄 **Replication**: Copying assets to multiple locations for redundancy or distribution.
-   🔗 **Linking**: Establishing relationships between stored assets and other SDLC events (e.g., linking an artifact to the build that produced it).

---

### 💾 Store Examples and Edge Cases

| **Type**                           | **Is it Storing?** | **Example**                                         | **Notes**                                                         |
|------------------------------------|--------------------|-----------------------------------------------------|-------------------------------------------------------------------|
| Push Docker Image to Registry      | ✅ Yes             | `docker push myrepo/myapp:1.0`                      | Persistently saves a container image for distribution             |
| Upload JAR to Maven Repository     | ✅ Yes             | `mvn deploy` to Artifactory                         | Stores a compiled library for dependency management               |
| Commit Code to Git Repository      | ✅ Yes             | `git push origin main`                              | Persists source code and its history                              |
| Save Test Results to Database      | ✅ Yes             | Storing JUnit XML reports in a test management system | Preserves test outcomes for analysis and auditing                 |
| Upload Build Logs to Object Storage| ✅ Yes             | Uploading CI/CD pipeline logs to S3                 | Archiving diagnostic information                                  |
| Deploying Application to Server    | ❌ No              | `kubectl apply -f deployment.yaml`                  | This is deployment/execution, not just persistent storage of an artifact |
| Caching Build Dependencies         | ❌ No              | Local Maven `.m2` repository cache                  | Temporary storage for performance, not persistent distribution    |
| Downloading a Dependency           | ❌ No              | `npm install`                                       | Retrieval from storage, not the act of storing                    |
| Writing a Log File to Local Disk   | ❌ No              | `logger.info("message")` to a local file            | Local/temporary persistence; "storing" implies a managed, accessible repository |

---

### 🧰 Tool-Specific Considerations

| **Tool**         | **Definition of Store**                                          |
|------------------|------------------------------------------------------------------|
| Artifactory/Nexus| Dedicated artifact repositories for various package types (Maven, npm, Docker, etc.) |
| Docker Registry  | Stores and manages Docker container images                       |
| Git/GitHub/GitLab| Version Control Systems that store source code and its history   |
| Amazon S3/Azure Blob Storage/GCS | Object storage services used for archiving logs, backups, or raw data |
| Kubernetes       | Can store configuration via ConfigMaps/Secrets, but not typically "artifacts" |
| Helm Chart Museum| Stores and serves Helm charts                                    |
| Test Management Systems (e.g., TestRail) | Stores test cases, test runs, and results for manual and automated tests |

