# SOC SOAR Deployment Lab

## Wazuh + TheHive + Cortex + MISP

A containerized Security Operations Center (SOC) lab demonstrating the integration of SIEM, Security Orchestration, Automation and Response (SOAR), threat analysis, and threat intelligence platforms.

The environment is designed for security monitoring, alert investigation, automated case management, and threat-intelligence enrichment.

---

## Architecture

Wazuh detects security events and generates alerts.

Wazuh
  |
  v
TheHive
  |
  v
Cortex
  |
  v
MISP

### Component Roles

- Wazuh - SIEM, endpoint monitoring and security detection
- TheHive - SOAR case management and investigation
- Cortex - Observable analysis and automated response
- MISP - Threat intelligence and IOC enrichment

---

## Project Objective

The objective of this project is to build an integrated SOC environment where security alerts can be investigated and enriched using multiple security platforms.

The lab demonstrates the following workflow:

1. Wazuh detects a security event.
2. The alert is forwarded to the SOAR platform.
3. TheHive creates an investigation case.
4. Cortex performs analysis and enrichment using analyzers.
5. MISP provides threat-intelligence context.
6. The SOC analyst investigates the enriched case and performs the required response actions.

---

## Components

| Component | Purpose |
|---|---|
| Wazuh | SIEM, endpoint monitoring, log analysis and security detection |
| TheHive | SOAR case management and investigation |
| Cortex | Observable analysis and automated response |
| MISP | Threat intelligence and IOC enrichment |
| Cassandra | TheHive data storage |
| Elasticsearch | Search and indexing backend |
| MinIO | Object storage used by TheHive |
| MySQL | MISP database |
| Redis | MISP supporting service |
| MISP Modules | MISP enrichment modules |

---

## Technology Stack

- Docker
- Docker Compose
- Wazuh
- TheHive
- Cortex
- MISP
- Cassandra
- Elasticsearch
- MySQL
- Redis
- MinIO
- Cortex Analyzers
- Linux
- SOC / Blue Team workflows
- Threat Intelligence
- MITRE ATT&CK

---

## Repository Structure

    soar-deployment-lab/
    |
    +-- docker-compose.yml
    +-- .env.example
    +-- .gitignore
    +-- README.md
    |
    +-- cortex/
    |   +-- README.md
    |   +-- logs/
    |   +-- application.conf/
    |
    +-- scripts/
    |   +-- setup-cortex-analyzers.sh
    |
    +-- server-configs/
    |   +-- bootstrap.php
    |   +-- core.php
    |   +-- routes.php
    |
    +-- files/
        +-- MISP supporting data

---

## Deployment

### 1. Clone the repository

    git clone <YOUR-REPOSITORY-URL>
    cd soar-deployment-lab

### 2. Create the environment file

    cp .env.example .env

Edit the environment file:

    nano .env

Replace all placeholder values with deployment-specific credentials and secrets.

Generate a strong random secret where required:

    openssl rand -hex 32

Do not commit `.env` to GitHub.

---

## Cortex Analyzers

The Cortex analyzers are maintained separately from this repository.

Install them using:

    ./scripts/setup-cortex-analyzers.sh

The script downloads the official Cortex-Analyzers repository and places it in:

    ./Cortex-Analyzers/

The Docker Compose deployment mounts the analyzer and responder directories into the Cortex container.

---

## Start the SOAR Stack

After configuring `.env` and installing the Cortex analyzers:

    docker compose up -d

Check the containers:

    docker compose ps

View logs:

    docker compose logs -f

Individual service logs:

    docker compose logs -f thehive
    docker compose logs -f cortex.local
    docker compose logs -f misp.local

---

## Service Access

Default service ports:

| Service | Port |
|---|---:|
| TheHive | 9000 |
| Cortex | 9001 |
| MinIO Console | 9002 |
| Elasticsearch | 9200 |
| Cassandra | 9042 |
| MISP HTTP | 80 |
| MISP HTTPS | 443 |

The actual hostname or IP address depends on the deployment environment.

---

## SOC Investigation Workflow

A typical investigation can follow this workflow:

    Security Event
          |
          v
    Wazuh Detection
          |
          v
    Alert Forwarding
          |
          v
    TheHive Case
          |
          +----------------------+
          |                      |
          v                      v
    Analyst Investigation   Cortex Analysis
                                  |
                         +--------+--------+
                         |        |        |
                        IP      Domain    Hash
                         |        |        |
                         +--------+--------+
                                  |
                                  v
                       MISP Threat Intelligence
                                  |
                                  v
                           IOC Enrichment
                                  |
                                  v
                           Analyst Decision
                                  |
                    +-------------+-------------+
                    |             |             |
                    v             v             v
              False Positive   Monitor    Investigate
                                                 |
                                                 v
                                              Respond

---

## Security Considerations

This repository is intended for an isolated security laboratory environment.

### Secrets

Never commit:

- `.env`
- API keys
- passwords
- authentication tokens
- private keys
- TLS certificates
- production configuration
- real threat-intelligence credentials

The repository includes `.env.example` instead of real credentials.

### Docker Socket

Cortex is configured with access to:

    /var/run/docker.sock

This is required by the current analyzer execution architecture.

Docker socket access provides significant privileges over the Docker host. Therefore, this deployment should only be used on an isolated lab system where the security implications are understood.

Do not expose this configuration directly to an untrusted network or production environment without appropriate hardening.

### Network Exposure

The Compose configuration publishes service ports to the host.

In a production environment, these services should be protected using:

- Firewall rules
- Network segmentation
- TLS
- Authentication
- Reverse proxy
- Access control
- Monitoring

---

## Validation

Before starting the stack, validate the Compose configuration without creating containers:

    docker compose --env-file .env.example config

Check running services:

    docker compose ps

Check service logs:

    docker compose logs --tail=100

---

## Skills Demonstrated

This project demonstrates practical experience with:

- SOC architecture
- SIEM deployment
- SOAR deployment
- Security alert investigation
- Automated case management
- Threat intelligence
- IOC enrichment
- Security automation
- Docker and Docker Compose
- Linux administration
- Elasticsearch
- Cassandra
- MySQL
- Redis
- MinIO
- Cortex analyzers
- Incident response workflows
- Blue-team security operations

---

## Future Improvements

Potential improvements include:

- Automated Wazuh-to-TheHive alert integration
- Automated IOC extraction
- Automated Cortex enrichment
- MISP bidirectional enrichment
- MITRE ATT&CK mapping
- Automated response actions
- Analyst dashboards
- Case severity automation
- IOC deduplication
- Threat-intelligence correlation
- Security metrics and reporting
- TLS and reverse-proxy hardening
- Role-based access control
- Backup and recovery automation

---

## Disclaimer

This project is intended for educational, research, and authorized security-lab environments.

Do not deploy the configuration directly into a production environment without performing appropriate security hardening, credential management, access control, network segmentation, and testing.
