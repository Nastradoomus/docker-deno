#!/bin/bash

COMPOSE="docker-compose -p deno"

handler() {
  ${COMPOSE} down -v
}

trap handler SIGINT

${COMPOSE} up -d
${COMPOSE} logs -f
