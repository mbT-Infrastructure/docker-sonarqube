FROM sonarqube:community AS sonarqube

USER root
RUN rm -r /opt/sonarqube/data /opt/sonarqube/logs
USER sonarqube


FROM madebytimo/java

RUN mkdir --parents /media/sonarqube/data
RUN mkdir --parents /media/sonarqube/logs
RUN mkdir /opt/sonarqube
RUN ln --symbolic --force /media/sonarqube/data /opt/sonarqube
RUN ln --symbolic --force /media/sonarqube/logs /opt/sonarqube

COPY --from=sonarqube /opt/sonarqube /opt/sonarqube
COPY --from=mc1arke/sonarqube-with-community-branch-plugin \
    /opt/sonarqube/extensions/plugins/sonarqube-community-branch-plugin-*.jar \
    /opt/sonarqube/extensions/plugins/sonarqube-community-branch-plugin.jar

ENV DATABASE_JDBC_URL=""
ENV FRONTEND_URL=""
ENV SONAR_CE_JAVAOPTS="-javaagent:./extensions/plugins/sonarqube-community-branch-plugin.jar=ce"
ENV SONAR_WEB_JAVAOPTS="-javaagent:./extensions/plugins/sonarqube-community-branch-plugin.jar=web"
ENV SONAR_WEB_PORT="80"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "java", "-jar", "/opt/sonarqube/lib/sonarqube.jar", "-Dsonar.log.console=true"]
