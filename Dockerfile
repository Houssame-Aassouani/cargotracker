FROM payara/server-full:6.2023.12-jdk17

COPY target/postgresql.jar /opt/payara/appserver/glassfish/domains/domain1/lib/postgresql.jar

COPY target/cargo-tracker.war /opt/payara/deployments/cargo-tracker.war

COPY post-boot-commands.asadmin /opt/payara/config/

EXPOSE 8080