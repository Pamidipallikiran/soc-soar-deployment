# SOC SOAR Deployment Lab

## Wazuh + TheHive + Cortex + MISP

A containerized Security Operations Center (SOC) laboratory demonstrating the integration of **SIEM, Security Orchestration, Automation and Response (SOAR), observable analysis, and threat intelligence** platforms.

The project provides a practical SOC environment for:

* Security alert monitoring
* Incident investigation
* Automated case management
* Observable enrichment
* Threat-intelligence correlation
* IOC investigation
* Security automation
* Blue-team incident-response workflows

The deployment is designed primarily for **educational, research, and authorized security-lab environments**.

---

## Architecture

The overall SOC workflow integrates Wazuh with the SOAR and threat-intelligence components.

```text
                         ┌─────────────────────┐
                         │      Endpoints      │
                         │   Linux / Windows   │
                         └──────────┬──────────┘
                                    │
                                    │ Security Events
                                    ▼
                         ┌─────────────────────┐
                         │       Wazuh         │
                         │        SIEM         │
                         │ Detection & Alerts  │
                         └──────────┬──────────┘
                                    │
                                    │ Alert / Incident
                                    ▼
                         ┌─────────────────────┐
                         │      TheHive        │
                         │  Case Management    │
                         │   Investigation     │
                         └──────┬────────┬─────┘
                                │        │
                         Observable      │ Threat
                         Analysis        │ Intelligence
                                │        │
                                ▼        ▼
                    ┌──────────────┐  ┌──────────────┐
                    │    Cortex    │  │     MISP     │
                    │  Analyzers   │  │     CTI      │
                    │  Enrichment  │  │ IOC Context  │
                    └──────┬───────┘  └──────┬───────┘
                           │                 │
                           └────────┬────────┘
                                    ▼
                         ┌─────────────────────┐
                         │     SOC Analyst     │
                         │ Investigation &     │
                         │ Response Decision   │
                         └─────────────────────┘
```

### Architecture Roles

### Wazuh

Acts as the **SIEM and security-monitoring layer**. It collects security events, analyzes logs, monitors endpoints, and generates security alerts.

### TheHive

Acts as the **SOC case-management and investigation platform**. Security alerts can be converted into investigation cases that can be assigned, tracked, enriched, and closed by analysts.

### Cortex

Provides **automated observable analysis and enrichment**.

Examples of observables include:

* IP addresses
* Domains
* URLs
* File hashes
* Email addresses
* Other security observables

### MISP

Provides **threat-intelligence capabilities** and contextual information for investigating Indicators of Compromise (IOCs).

---

# Project Objective

The primary objective is to build an integrated SOC environment in which security alerts can move from **detection to investigation, enrichment, and response**.

The lab demonstrates a workflow similar to a real-world SOC:

```text
Security Event
      │
      ▼
Wazuh Detection
      │
      ▼
Security Alert
      │
      ▼
TheHive Investigation Case
      │
      ├───────────────┐
      ▼               ▼
   Cortex            MISP
   Analysis          Threat Intelligence
      │               │
      └───────┬───────┘
              ▼
       IOC Enrichment
              │
              ▼
       Analyst Investigation
              │
              ▼
       Response Decision
```

---

# Key Features

* Containerized SOAR deployment
* Docker Compose-based deployment
* TheHive case management
* Cortex observable analysis
* Cortex analyzer integration
* MISP threat-intelligence platform
* MISP supporting data and objects
* Environment-based configuration
* Secret separation using `.env`
* Automated Cortex analyzer setup
* SOC incident-response workflow
* IOC enrichment
* Linux-based deployment
* Security-focused deployment documentation

---

# Components

| Component      | Role                                                           |
| -------------- | -------------------------------------------------------------- |
| Wazuh          | SIEM, endpoint monitoring, log analysis and security detection |
| TheHive        | SOC case management and investigation                          |
| Cortex         | Observable analysis and enrichment                             |
| MISP           | Threat intelligence and IOC correlation                        |
| Cassandra      | TheHive data storage                                           |
| Elasticsearch  | Search and indexing backend                                    |
| MinIO          | Object storage                                                 |
| MySQL          | MISP database                                                  |
| Redis          | MISP supporting service                                        |
| MISP Modules   | MISP enrichment functionality                                  |
| Docker         | Container runtime                                              |
| Docker Compose | Multi-container deployment                                     |

---

# Technology Stack

### Security Platforms

* Wazuh
* TheHive
* Cortex
* MISP

### Infrastructure

* Docker
* Docker Compose
* Linux
* Cassandra
* Elasticsearch
* MySQL
* Redis
* MinIO

### Security Operations

* SIEM
* SOAR
* Threat Intelligence
* IOC Investigation
* Incident Response
* Security Monitoring
* Observable Enrichment
* MITRE ATT&CK concepts
* Blue-team workflows

---

# Repository Structure

```text
soar-deployment-lab/
│
├── cortex/
│   ├── application.conf
│   ├── README.md
│   └── logs/
│
├── files/
│   ├── community-metadata/
│   ├── feed-metadata/
│   ├── misp-decaying-models/
│   ├── misp-galaxy/
│   ├── misp-objects/
│   ├── misp-workflow-blueprints/
│   ├── noticelists/
│   └── scripts/
│
├── scripts/
│   └── setup-cortex-analyzers.sh
│
├── server-configs/
│   ├── bootstrap.php
│   ├── core.php
│   └── routes.php
│
├── docker-compose.yml
├── .env.example
├── .gitignore
└── README.md
```

---

# Prerequisites

The following software is recommended before deploying the environment:

* Linux host
* Docker Engine
* Docker Compose
* Git
* Internet connectivity for downloading required images and analyzer repositories
* Sufficient CPU, RAM, and disk resources for the complete stack

Verify Docker:

```bash
docker --version
```

Verify Docker Compose:

```bash
docker compose version
```

Verify Git:

```bash
git --version
```

---

# Deployment

## 1. Clone the Repository

Clone the repository:

```bash
git clone https://github.com/Pamidipallikiran/soc-soar-deployment.git
```

Enter the project directory:

```bash
cd soc-soar-deployment
```

---

## 2. Create the Environment File

Copy the example environment configuration:

```bash
cp .env.example .env
```

Edit the environment file:

```bash
nano .env
```

Replace all placeholder values with deployment-specific credentials and secrets.

Example:

```text
THEHIVE_SECRET=<strong-random-secret>
MINIO_ROOT_PASSWORD=<strong-password>
MISP_DB_PASSWORD=<strong-password>
MISP_DB_ROOT_PASSWORD=<strong-password>
```

Generate a random secret when required:

```bash
openssl rand -hex 32
```

### Important

The `.env` file contains deployment secrets and **must not be committed to GitHub**.

Only `.env.example` should be stored in the repository.

---

# 3. Validate Docker Compose Configuration

Before starting the services, validate the Compose configuration:

```bash
docker compose --env-file .env.example config
```

For the actual deployment configuration:

```bash
docker compose --env-file .env config
```

Resolve any configuration errors before starting the stack.

---

# 4. Install Cortex Analyzers

The Cortex analyzer repository is maintained separately.

Run:

```bash
./scripts/setup-cortex-analyzers.sh
```

The script prepares the Cortex analyzer environment used by the deployment.

Verify the project directory:

```bash
ls -la
```

Review the Cortex-specific documentation:

```bash
cat cortex/README.md
```

---

# 5. Start the SOAR Stack

Start the services in detached mode:

```bash
docker compose up -d
```

Check the containers:

```bash
docker compose ps
```

View all service logs:

```bash
docker compose logs -f
```

---

# Service-Specific Logs

### TheHive

```bash
docker compose logs -f thehive
```

### Cortex

```bash
docker compose logs -f cortex.local
```

### MISP

```bash
docker compose logs -f misp.local
```

To view only the latest entries:

```bash
docker compose logs --tail=100
```

---

# Service Access

The default service ports used by the environment are:

| Service       |   Port |
| ------------- | -----: |
| TheHive       | `9000` |
| Cortex        | `9001` |
| MinIO Console | `9002` |
| Elasticsearch | `9200` |
| Cassandra     | `9042` |
| MISP HTTP     |   `80` |
| MISP HTTPS    |  `443` |

The actual hostname or IP address depends on the host and network configuration.

Example:

```text
TheHive  → http://<HOST-IP>:9000
Cortex   → http://<HOST-IP>:9001
MinIO    → http://<HOST-IP>:9002
MISP     → http://<HOST-IP>/
```

Do not expose these services directly to untrusted networks without appropriate security controls.

---

# SOC Investigation Workflow

A typical SOC investigation can follow this workflow:

```text
┌──────────────────────┐
│   Security Event     │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│   Wazuh Detection    │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│   Alert Forwarding   │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│   TheHive Case       │
│    Investigation     │
└──────────┬───────────┘
           │
           ├──────────────────┐
           │                  │
           ▼                  ▼
┌──────────────────┐  ┌──────────────────┐
│     Cortex       │  │      MISP        │
│ Observable       │  │ Threat           │
│ Analysis         │  │ Intelligence     │
└────────┬─────────┘  └────────┬─────────┘
         │                     │
         └──────────┬──────────┘
                    ▼
          ┌────────────────────┐
          │   IOC Enrichment   │
          └──────────┬─────────┘
                     │
                     ▼
          ┌────────────────────┐
          │    SOC Analyst     │
          │    Investigation   │
          └──────────┬─────────┘
                     │
                     ▼
             Response Decision
                     │
          ┌──────────┼──────────┐
          ▼          ▼          ▼
     False Positive  Monitor   Respond
```

---

# Observable Investigation

During an investigation, an analyst may encounter observables such as:

```text
IP Address
Domain
URL
File Hash
Email Address
Hostname
```

These observables can be investigated using Cortex analyzers and MISP threat intelligence.

Example investigation flow:

```text
Suspicious IP
     │
     ▼
TheHive Observable
     │
     ├──────────────► Cortex Analyzer
     │                     │
     │                     ▼
     │              Analysis Result
     │
     └──────────────► MISP
                           │
                           ▼
                    Threat Context
                           │
                           ▼
                    Analyst Decision
```

---

# Wazuh Integration

Wazuh provides the security-detection layer of the SOC architecture.

Typical events may include:

* Authentication failures
* Suspicious processes
* File-integrity changes
* Network-security events
* Malware detections
* Custom IDS alerts
* Windows security events
* Linux security events

A Wazuh alert can be forwarded into the SOAR workflow for further investigation.

Conceptually:

```text
Wazuh Alert
     │
     ▼
Alert Integration
     │
     ▼
TheHive Case
     │
     ▼
Observable Extraction
     │
     ├── IP
     ├── Domain
     ├── Hash
     └── URL
     │
     ▼
Cortex / MISP Enrichment
```

> **Note:** Wazuh is part of the overall SOC architecture. The Docker Compose deployment in this repository focuses on the SOAR, analysis, and threat-intelligence components.

---

# TheHive Case Management

TheHive provides the investigation workspace for SOC analysts.

A case can contain:

* Case title
* Description
* Severity
* TLP classification
* PAP classification
* Observables
* Tasks
* Analyst notes
* Evidence
* Investigation results
* Response actions

A typical case lifecycle is:

```text
Alert
  ↓
Case Creation
  ↓
Triage
  ↓
Observable Extraction
  ↓
Enrichment
  ↓
Investigation
  ↓
Containment / Response
  ↓
Case Closure
```

---

# Cortex Analysis

Cortex is used to automate observable analysis.

Examples include:

```text
IP Address
    ↓
IP Reputation / Threat Intelligence Analyzer

Domain
    ↓
Domain Reputation / DNS Analyzer

Hash
    ↓
Hash / Malware Intelligence Analyzer

URL
    ↓
URL Reputation Analyzer
```

Analyzer availability depends on the analyzers installed and configured in the deployment.

---

# MISP Threat Intelligence

MISP provides threat-intelligence capabilities for IOC investigation and correlation.

The environment contains supporting MISP data such as:

* MISP Galaxy information
* MISP objects
* Decaying models
* Noticelists
* Feed metadata
* Community metadata
* Workflow blueprints

MISP can be used to provide additional context around suspicious indicators.

Typical investigation:

```text
IOC
 │
 ▼
MISP Search
 │
 ├── Known Indicator
 ├── Related Event
 ├── Threat Actor
 ├── Malware
 └── Campaign
 │
 ▼
Threat Context
 │
 ▼
SOC Investigation
```

---

# Incident Response Example

A sample SOC incident can be represented as:

### Scenario

A monitored endpoint generates a suspicious network-security alert.

### Detection

Wazuh receives the event and generates an alert.

### Triage

The alert is forwarded to the investigation workflow.

### Case Creation

TheHive is used to create an investigation case.

### Observable Extraction

The analyst identifies:

```text
Source IP
Destination IP
Domain
File Hash
```

### Enrichment

Cortex analyzers are used to investigate the observables.

MISP is queried for additional threat-intelligence context.

### Investigation

The SOC analyst correlates:

```text
Wazuh Detection
       +
Cortex Analysis
       +
MISP Intelligence
       +
Endpoint Context
```

### Response

Depending on the findings, the analyst may:

* Mark the alert as a false positive
* Continue monitoring
* Block an indicator
* Isolate an endpoint
* Escalate the incident
* Collect additional evidence
* Perform further investigation

---

# Validation and Testing

## Check Running Containers

```bash
docker compose ps
```

All required services should show an appropriate running or healthy state.

---

## Check Logs

```bash
docker compose logs --tail=100
```

Look for:

* Startup errors
* Database connection failures
* Authentication errors
* Network connectivity issues
* Analyzer errors
* Container restart loops

---

## Check Individual Services

```bash
docker compose logs --tail=100 thehive
```

```bash
docker compose logs --tail=100 cortex.local
```

```bash
docker compose logs --tail=100 misp.local
```

---

## Validate Configuration

```bash
docker compose --env-file .env config
```

A successful configuration render indicates that Docker Compose can resolve the supplied environment variables and service configuration.

---

# Troubleshooting

## Containers Are Not Starting

Check:

```bash
docker compose ps
```

Then:

```bash
docker compose logs --tail=100 <service-name>
```

---

## Environment Variables Are Missing

Verify that `.env` exists:

```bash
ls -la .env
```

Check the example configuration:

```bash
cat .env.example
```

Do not expose actual secrets when sharing configuration publicly.

---

## Cortex Analyzer Problems

Check the analyzer installation:

```bash
./scripts/setup-cortex-analyzers.sh
```

Then review:

```bash
docker compose logs --tail=100 cortex.local
```

Also review:

```text
cortex/README.md
```

---

## Database Connectivity Problems

Check the relevant container status:

```bash
docker compose ps
```

Review service logs:

```bash
docker compose logs --tail=100
```

Confirm that dependent services have successfully started before troubleshooting application-level connectivity.

---

# Security Considerations

This repository is intended for an **isolated security laboratory environment**.

Do not treat the default configuration as production-ready.

## Secrets

Never commit:

* `.env`
* API keys
* Passwords
* Authentication tokens
* Private keys
* TLS private material
* Production credentials
* Real threat-intelligence credentials

The repository provides `.env.example` as a safe configuration template.

---

## Docker Socket

The Cortex deployment may require access to:

```text
/var/run/docker.sock
```

Docker socket access can provide significant privileges over the Docker host.

Therefore:

* Use this configuration only in a controlled environment.
* Avoid exposing the host to untrusted users.
* Understand the security implications before enabling analyzer execution.
* Apply appropriate isolation and hardening for production environments.

---

## Network Exposure

The Compose configuration publishes service ports to the host.

For production deployments, consider:

* Firewall rules
* Network segmentation
* TLS
* Reverse proxy
* Authentication
* Role-based access control
* Restricted management interfaces
* Monitoring
* Secure secret management

---

## Credential Management

Use strong, unique credentials for:

* TheHive
* Cortex
* MISP
* MySQL
* MinIO
* Other supporting services

Never use example credentials in a production environment.

---

# Git and Repository Security

The repository uses `.gitignore` to prevent accidental tracking of sensitive or runtime files.

Protected file types include:

```text
.env
*.key
*.pem
*.crt
*.p12
*.pfx
*.jks
*.log
*.db
*.sqlite
```

Before committing changes, verify:

```bash
git status
```

Check whether sensitive files are tracked:

```bash
git ls-files | grep -E '(^|/)\.env$'
```

Check certificate/private-key files:

```bash
git ls-files | grep -E '\.(key|pem|p12|pfx|jks)$'
```

These commands should normally return no output.

---

# Development Workflow

After modifying the project:

```bash
git status
```

Review changes:

```bash
git diff
```

Stage changes:

```bash
git add <file>
```

Create a commit:

```bash
git commit -m "Describe the change"
```

Push to GitHub:

```bash
git push
```

Check synchronization:

```bash
git status
```

Expected result:

```text
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

---

# Skills Demonstrated

This project demonstrates practical experience in:

### SOC Operations

* SOC architecture
* Security monitoring
* Alert triage
* Incident investigation
* Incident-response workflows
* IOC investigation

### SIEM

* Wazuh deployment
* Endpoint monitoring
* Log analysis
* Security detection
* Alert management

### SOAR

* TheHive deployment
* Case management
* Investigation workflows
* Security automation concepts
* Alert-to-case workflows

### Threat Intelligence

* MISP deployment
* IOC enrichment
* Threat-intelligence correlation
* MISP objects and Galaxy data

### Security Analysis

* Cortex
* Observable analysis
* Automated enrichment
* Analyzer integration

### Infrastructure

* Linux administration
* Docker
* Docker Compose
* Elasticsearch
* Cassandra
* MySQL
* Redis
* MinIO

### Security Engineering

* Environment-based configuration
* Secret management
* Network segmentation concepts
* Container security considerations
* Blue-team architecture

---

# Future Improvements

Potential enhancements for the project include:

* Automated Wazuh-to-TheHive alert integration
* Automated IOC extraction
* Automated Cortex enrichment
* MISP bidirectional enrichment
* MITRE ATT&CK mapping
* Automated response actions
* IOC deduplication
* Threat-intelligence correlation
* Case severity automation
* Analyst dashboards
* Security metrics and reporting
* Automated incident classification
* Alert correlation
* Detection-rule management
* TLS and reverse-proxy hardening
* Role-based access control
* Backup and recovery automation
* Centralized monitoring
* Health checks
* CI/CD validation
* Infrastructure-as-Code deployment

---

# Screenshots

Screenshots can be added to document the working deployment.

Recommended screenshots include:

```text
docs/
└── screenshots/
    ├── wazuh-alert.png
    ├── thehive-case.png
    ├── cortex-analyzer.png
    ├── misp-event.png
    ├── docker-services.png
    └── architecture.png
```

Suggested documentation flow:

```text
Wazuh Alert
     ↓
TheHive Case
     ↓
Observable
     ↓
Cortex Analysis
     ↓
MISP Enrichment
     ↓
Analyst Investigation
```

---

# Project Status

| Area                       | Status                  |
| -------------------------- | ----------------------- |
| Docker deployment          | Implemented             |
| Docker Compose             | Implemented             |
| TheHive                    | Implemented             |
| Cortex                     | Implemented             |
| MISP                       | Implemented             |
| Cortex analyzer setup      | Implemented             |
| Environment configuration  | Implemented             |
| Secret protection          | Implemented             |
| SOC investigation workflow | Documented              |
| Wazuh integration          | Architecture documented |
| Automated enrichment       | Extensible              |
| Automated response         | Future improvement      |

---

# Learning Outcomes

This project provides hands-on experience with the integration of multiple security technologies into a SOC environment.

The main learning outcomes include:

* Understanding SIEM and SOAR architecture
* Deploying security platforms using containers
* Managing multi-container applications
* Investigating security alerts
* Working with security observables
* Performing IOC enrichment
* Using threat-intelligence platforms
* Understanding incident-response workflows
* Managing secrets securely
* Troubleshooting distributed security applications
* Designing a practical blue-team environment

---

# Disclaimer

This project is intended for:

* Educational purposes
* Cybersecurity research
* Authorized security testing
* SOC/blue-team laboratory environments

Do not deploy this configuration directly into a production environment without performing appropriate:

* Security hardening
* Credential management
* Network segmentation
* Access control
* TLS configuration
* Monitoring
* Backup and recovery planning
* Vulnerability assessment
* Security testing

Use only against systems and networks for which you have explicit authorization.

---

# Author

**Kiran Pamidipalli**

Cybersecurity / SOC Analyst

Areas of interest:

* SOC Operations
* SIEM
* SOAR
* Network Security
* Threat Intelligence
* Incident Response
* Security Automation
* Blue Team Operations

---

## Repository

**SOC SOAR Deployment Lab**

GitHub:

https://github.com/Pamidipallikiran/soc-soar-deployment
