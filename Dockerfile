FROM sonarqube:community AS sonarqube

USER root
RUN rm -r /opt/sonarqube/data /opt/sonarqube/logs


FROM madebytimo/java

RUN mkdir --parents /media/sonarqube/data
RUN mkdir --parents /media/sonarqube/logs
RUN mkdir /opt/sonarqube
RUN chown --recursive user /media/sonarqube
RUN ln --symbolic --force /media/sonarqube/data /opt/sonarqube
RUN ln --symbolic --force /media/sonarqube/logs /opt/sonarqube

COPY --from=sonarqube /opt/sonarqube /opt/sonarqube

ENV DATABASE_JDBC_URL=""
ENV FRONTEND_URL=""
ENV SONAR_WEB_PORT="80"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "java", "-jar", "/opt/sonarqube/lib/sonarqube.jar", "-Dsonar.log.console=true"]
