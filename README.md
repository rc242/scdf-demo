## Description

This repo has the barebones for playground with SCDF and contains the following

Docker Compose file with:
* Spring Cloud Dataflow server
  * Exposed on port 9393
* Spring Cloud Skipper
  * Exposed on port 7577
  * Exposed on ports 20000 - 20195 for streams
* Kafka for communicating between apps
* Nexus Server for dataflow-server and skipper to poll your artifacts
  * Exposed on port 8081
* Prometheus and Grafana
  * Grafana exposed on port 3000
* Simple processor that adds onto the source text with a greet.
  
## Setup
```
   ./scripts/setupDocker.sh
   ./scripts/setupRepository.sh
   ./scripts/setupStream.sh
```
* Sets up Docker environment
* Configures Nexus and pushes example stream jar
* Sets up the following for the example stream
  * http (port 20001) -> processor (port 20002) -> log (port 20003)
  
## Verification 
* java -jar ./scripts/spring-cloud-dataflow-shell-2.11.0.jar
* dataflow:>http post --target http://localhost:20001 --data "World"
* Go to dashboard at http://localhost:9393
* Streams Dropdown -> Streams -> "hello-world-stream"
* Click "View Log" next to "log" in the Run-time widget
* Verify the following
  > [container-0-C-1] log-sink                                 : Hello: World!

## Resources
* [SCDF Docker](https://dataflow.spring.io/docs/installation/local/docker/)
* [Spring Cloud Data Flow Reference](https://docs.spring.io/spring-cloud-dataflow/docs/2.11.1/reference/htmlsingle/#getting-started)
* [Nexus API](https://help.sonatype.com/repomanager3/integrations/rest-and-integration-api)
