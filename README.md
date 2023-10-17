## Description

This repo has the barebones for playground with SCDF and contains the following

Docker Compose file with:
* Spring Cloud Dataflow server
* Spring Cloud Skipper
* Kafka for communicating between apps
* Nexus Server for dataflow-server and skipper to poll your artifacts
* Simple processor that adds onto the source text with a greet.

## Setup
```
   ./scripts/setupDocker.sh
   ./scripts/setupRepository.sh
   ./scripts/setupStream.sh
```

## Verification 
* java -jar ./scripts/spring-cloud-dataflow-shell-2.11.0.jar
* dataflow:>http post --target http://localhost:20001 --data "World"
* Go to dashboard at http://localhost:9393
* Streams Dropdown -> Streams -> "hello-world-stream"
* Click "View Log" next to "log" in the Run-time widget
* Verify the following
  > [container-0-C-1] log-sink                                 : Hello: World!
