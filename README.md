# FAIR Digital Object Lab


[![Docker image build](https://github.com/kit-data-manager/FAIR-DO-Lab/actions/workflows/main.yml/badge.svg)](https://github.com/kit-data-manager/FAIR-DO-Lab/actions/workflows/main.yml)

The FAIR DO Lab Software Stack is an extendable and adjustable architecture for generic FAIR Digital Object (FAIR DO) tasks. It consists of a set of interacting components with services and tools for creation, validation, discovery, curation, and more. It is the successor of the [FAIR DO Ecosystem Testbed](https://github.com/kit-data-manager/testbed4inf), but has the main goal to get to a production-ready state soon. Additionally, instead of being a set of background services, we aim to integrate generic tools directly to ease the interaction with FAIR DOs.

Current high-level functionality roadmap:

- [x] Create, update, retrieve and validate FAIR DOs (status: done)
- [x] Search within PID records (status: prototype)
- [x] Notification of PID activities for other services (status: done)
- [x] Includes an instance of our collection registry to create and manage collections (status: done)
- [x] browse FAIR DOs (status: done)
- [ ] curate FAIR DOs (status: planning phase)

Related Publications:

- [Poster from RDA VP17 Poster Session (about its precedessor, the testbed)](https://www.doi.org/10.5445/IR/1000131613)

## Goals

- be a production-ready, customizable FAIR DO Lab
- offer generic tools for the direct interaction with FAIR DOs
- offer important components for integration with existing tools (APIs)

## Components / Status

| component | status |
|-----------|--------|
| FAIRDOscope (a FAIR DO Browser) | production-ready |
| Fairris | deprecated (demo interface) |
| Typed PID Maker | production-ready, 1.0 release soon |
| Indexer | prototype |
| Messaging of FAIR DO activities | production-ready |
| Collection Registry | production-ready |
| Elasticsearch (search index) | production-ready, external development |
| Kibana (Elasticsearch management) | production-ready, external development |
| RabbitMQ (Message broker) | production-ready, external development |

_"external development": These services are reused open-source components, not developed in our department._

## Getting Started


You will need:

- `Git` to clone this repo. Alternatively, [download it as a zip file](https://github.com/kit-data-manager/FAIR-DO-Lab/archive/refs/heads/master.zip) to skip this requirement.
- `Docker Desktop` (Installation on [Windows](https://www.docker.com/products/docker-desktop/), [Linux](https://docs.docker.com/desktop/install/linux-install/), [macOS](https://docs.docker.com/desktop/install/mac-install/), [macOS on ARM](https://docs.docker.com/desktop/mac/apple-silicon/)).
    > **Note**
    > 
    > Before you start, make sure your docker environment has at least 4 GB of memory (RAM) available. This is especially required if it runs in a virtual machine (which is the case e.g., if you use Apples macOS). You can do this the easiest using Docker Desktop in the preference menu under "Resources". The FAIR DO Lab consists of several services, and in sum the default of 2 GB RAM will not be enough.
    
    > **Note**
    > 
    > If the `docker compose` command (preferred) is not available, you can use `docker-compose` (note the "-") as a fallback. This may be the case on older systems, for example.

All other requirements will be available through the docker setup.

Using the command line, the Lab can be started like this:

```bash
# Skip this command if you download the zip file instead
git clone https://github.com/kit-data-manager/FAIR-DO-Lab.git
cd fair-do-lab
# start all services defined in docker-compose.yml
docker compose up
# use `docker-compose up` (note the dash), if "docker compose" (preferred) is not available.
```

Wait until the containers started. After that, you may explore the possibilities of the FAIR DO Lab using the following URLs:

- [FAIRDOscope](http://localhost:8081/)
    - To browse real FAIR DOs in a graphical and human readable way.
    - The FAIRDOscope does currently not support sandboxed PIDs.
- [PIT-Service API Documentation: http://localhost:8090/swagger-ui.html](http://localhost:8090/swagger-ui.html)
    - Use this API to manage PID records. You can find [details about the PIT-Service here](https://github.com/kit-data-manager/pit-service).
- [Message Broker Management UI](http://localhost:15672/#/)
    - The message broker will receive messages from the PIT service when records are created or updated. The broker will persist those messages in the queues of interested (registered) clients. In the FAIR DO Lab is currently only one such client: The indexer, which will receive the messages, resolve the record and finally ingest all information into the seach index. This interface will let you watch into internal statistics and the internal state of the broker.
- [Search Index Management UI: http://localhost:5601/app/kibana](http://localhost:5601/app/kibana)
    - Use this interface to create a view on the record index and create queries. There are also APIs available directly to the elasticsearch index, which enables developers to create different kinds of search experiences.
- [Collection Service API Documentation: http://localhost:8091/swagger-ui.html](http://localhost:8091/swagger-ui.html)
    - Use this API to manage collections. You can find [details about the collection service here](https://github.com/kit-data-manager/collection-api).
- [Collection Service Content Map: http://localhost:8091/static/overview.html](http://localhost:8091/static/overview.html)
    - If you registered Collections using the API, you can get an overview of the registered collections using this interface.

## Customization

Detailed usage documentation beyond the short "getting started" introduction.

The FAIR DO Lab consists of several services, managed with docker-compose. Some of them do not yet have an image on docker hub and need to be built on the machine. This will happen automatically when starting them.

Use `docker compose up` to start all services or `docker compose up fairris pit-service` to only start a selection, analogous to the build steps.

### Update services

```bash
git pull
docker compose down  # shut down all services and delete its containers
docker compose pull  # pull new image versions
docker compose up    # starts all services
```

## Repository structure

- The `documentation` folder contains advanced documentation about the FAIR DO Lab and some workflows within it for some better understanding of the architecture.
- Service-specific files are in folders named after the service. The configurations inside the folders are used either at build time or container creation time. So if you want to change the configuration, you need to make sure to execute the corresponding action afterwards, in order to use the new configurations.
- `docker-compose.yml` contains all services and how they are wired together.
    - It is recommended to use override files to make custom modifications. It will make pulling new versions of the repository easier for you.
    - Use the compose file as a documentation of exposed ports etc.
- `java-release-run.sh` will be copied into the images of java-based services to run them properly (helper script).
