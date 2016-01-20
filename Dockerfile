FROM anapsix/alpine-java:jdk

# Configuration variables
ENV JIRA_HOME     /var/atlassian/jira
ENV JIRA_INSTALL  /opt/atlassian/jira
ENV JIRA_VERSION  7.0.9

# Install Atlassian JIRA and helper tools

RUN	apk --update add curl tar \
	&& mkdir -p ${JIRA_HOME} \
	&& mkdir -p ${JIRA_INSTALL} \
	&& curl -Ls                "https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-${JIRA_VERSION}-jira-${JIRA_VERSION}.tar.gz" | tar -xz --directory "${JIRA_INSTALL}" --strip-components=1 --no-same-owner \
	&& curl -Ls                "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.36.tar.gz" | tar -xz --directory "${JIRA_INSTALL}/lib" --strip-components=1 --no-same-owner "mysql-connector-java-5.1.36/mysql-connector-java-5.1.36-bin.jar" \
 	&& echo -e                 "\njira.home=$JIRA_HOME" >> "${JIRA_INSTALL}/atlassian-jira/WEB-INF/classes/jira-application.properties"

EXPOSE 8080

VOLUME [${JIRA_HOME}]

WORKDIR ${JIRA_HOME}

CMD ["sh", "-c", "${JIRA_INSTALL}/bin/start-jira.sh -fg"]
