FROM clojure:lein-2.8.1 as build

COPY . /build/

WORKDIR /build
RUN lein uberjar

FROM openjdk:8u191-jre-alpine3.9

COPY --from=build /build/target/life-fhir-store-0.2-SNAPSHOT-standalone.jar /app/
COPY fhir /app/fhir/

WORKDIR /app

EXPOSE 80

CMD ["/bin/sh", "-c", "java $JVM_OPTS -jar life-fhir-store-0.2-SNAPSHOT-standalone.jar"]
