#!/usr/bin/env bash
set -e

mkdir --parents /media/sonarqube/data
mkdir --parents /media/sonarqube/logs
chown --recursive user /media/sonarqube

if [[ -n "$DATABASE_JDBC_URL" ]]; then
    SONAR_JDBC_URL="$DATABASE_JDBC_URL"
fi
if [[ -n "$FRONTEND_URL" ]]; then
    SONAR_WEB_CONTEXT="/${FRONTEND_URL#*"://"*"/"}"
fi

export SONAR_JDBC_URL SONAR_WEB_CONTEXT

exec su user --command "$*"
