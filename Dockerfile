# phase build

FROM maven:3.8.1-jdk-8 as builder

COPY ./ /usr/local/services/

WORKDIR /usr/local/services/

RUN mvn clean \
    && mvn package \
    && GENJAR=`ls target | grep -E \.jar$` \
    && mv target/${GENJAR} target/application.jar

# phase start

FROM openjdk:8-jdk-oracle as starter

COPY --from=0 /usr/local/services/target/application.jar /usr/local/services/

WORKDIR /usr/local/services/

CMD ["java", "-jar", "application.jar"]
