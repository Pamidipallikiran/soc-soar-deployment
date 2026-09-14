# Cortex Runtime Directory

This directory contains local Cortex runtime configuration and logs.

Runtime logs and environment-specific configuration are intentionally
excluded from version control.

The Docker Compose deployment creates/uses:

- `cortex/logs/` for Cortex logs
- `cortex/application.conf/` for local Cortex configuration

Do not commit credentials, API keys, tokens, or private configuration here.
