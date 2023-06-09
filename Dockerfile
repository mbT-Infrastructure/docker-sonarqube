FROM sonarqube:community AS sonarqube

USER root
RUN rm -r /opt/sonarqube/data /opt/sonarqube/logs


FROM madebytimo/java

RUN adduser user --disabled-password --gecos ""

COPY --from=sonarqube --chown=user:user /opt/sonarqube /opt/sonarqube
RUN mkdir --parents /media/sonarqube/data
RUN mkdir --parents /media/sonarqube/logs
RUN chown --recursive user /media/sonarqube
RUN ln --symbolic --force /media/sonarqube/data /opt/sonarqube
RUN ln --symbolic --force /media/sonarqube/logs /opt/sonarqube

# RUN curl --silent --location --output "url/plugin.jar" "/opt/sonarqube/extensions/plugin.jar"

ENV DATABASE_JDBC_URL=""
ENV FRONTEND_URL=""
ENV SONAR_WEB_PORT="80"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "java", "-jar", "/opt/sonarqube/lib/sonarqube.jar", "-Dsonar.log.console=true"]
