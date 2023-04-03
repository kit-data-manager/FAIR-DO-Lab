FROM eclipse-temurin:20 AS build-env-java
LABEL maintainer="pfeil@kit.edu"
LABEL stage=build-env
RUN apt-get update && \
    apt-get upgrade --assume-yes && \
    apt-get install --no-install-recommends --assume-yes git && \
    mkdir -p /var/repository && \
    mkdir -p /kitdm20/


FROM build-env-java as build-indexer
LABEL maintainer="pfeil@kit.edu"
LABEL stage=build-contains-credentials
RUN cd /kitdm20/ && \
    git clone -v https://git.scc.kit.edu/on3151/indexing-service.git service && \
    cd service && \
    ./gradlew -Pclean-release build && \
    mv $(ls build/libs/*.jar) build/libs/indexer.jar && \
    cp build/libs/indexer.jar ../


# Clean image
FROM eclipse-temurin:20 as run-indexer
LABEL maintainer="pfeil@kit.edu"
LABEL stage=run
RUN mkdir -p /kitdm20/config
COPY --from=build-indexer /kitdm20/indexer.jar /kitdm20/
COPY --from=build-indexer /kitdm20/service/src/main/resources/mytemplate.hbs /kitdm20/
COPY indexer/conf/application.properties /kitdm20/config/application.properties
COPY java-release-run.sh /kitdm20/
EXPOSE 8080
CMD bash /kitdm20/java-release-run.sh indexer.jar
