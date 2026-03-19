#!/bin/bash

openclaw onboard --non-interactive \
  --auth-choice custom-api-key \
  --custom-base-url "$OLLAMA_HOST" \
  --custom-model-id "$OPENCLAW_MODEL" \
  --custom-api-key "$OLLAMA_API_KEY" \
  --secret-input-mode plaintext \
  --custom-compatibility openai \
  --accept-risk \

# Clear any existing fallbacks
openclaw models fallbacks clear

# Fix the openclaw configs
bash /home/coder/doctorfix.sh
