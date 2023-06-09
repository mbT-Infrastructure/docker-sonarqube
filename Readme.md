# sonarqube image

This Docker image contains a sonarqube installation.

## Environment variables

- `DATABASE_JDBC_URL`
    - The complete JDBC Url of the database. Overwrites `SONAR_JDBC_URL`.
- `FRONTEND_URL`
    - The base URL where keycloak is accessed. Overwrites `SONAR_WEB_CONTEXT`.
- `SONAR_WEB_PORT`
    - Port for incoming HTTP connections, default: `80`.

There are more sonarqube specific environment variables available.
Refer to [docs.sonarqube.org](https://docs.sonarqube.org/latest/setup-and-upgrade/configure-and-operate-a-server/environment-variables/) for more information.


## Volumes

- `/media/sonarqube`
    - The directory for sonarqube data.


## Development

To build and run for development run:
```bash
docker compose --file docker-compose-dev.yaml up --build
```

To build the image locally run:
```bash
./docker-build.sh
```
