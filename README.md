# Docker Reference

*This Reference is not all inclusive; shown commands may have additional options not listed*


## Vocabulary

- **Images**: The file system and configuration of our application which are used to create containers.

- **Containers**: Running instances of Docker images. Run the acutal applications. Shares the kernel with other containers, and runs as an isoalted process in user space on the host OS.

- **Docker Daemon**: background service running on the host that manages building, running, and distributing Docker containers. 

- **Docker Client**: command line tool that allows the user to interact with the Docker daemon.

- **Docker Store**: a registry of Docker Images. A directory of all available Docker images.

- **Tagging**: Documenting information about an image and setting it with `docker image tag <image_id> <wanted image name>`.

- **Push**: upload a local image to a registry somewhere to make it public.

- **Dockerfile**: text file that contains all the insturctions to build an image. Easier to change than a raw binary file. 

- **Layers**: Docker iamge is built up from a series of layers. Each layer represents an instrucitonin the image's Dockerfile. Each layer except the last one is read-only.

- **Volumes**: Special Docker contaienr layer that allows data to persist and be shared separately from the container itself.

- **Stack**: group of services that are deployed together. Multiple containerized components of an application that run in separate instances.

- **Task**: One or more containers that make up a service.

- **Swarm Mode**: Docker's native clustering configuration. Consists of manager and worker nodes where the worker nodes run the application containers.

- **Orchestration**: The coordination of automated tasks to further simplify the service. Specifically referred to as deploying an application across multiple hosts in Docker.


## Commands

- `docker info`: display general Docker and container information.

- ` docker run -dt <image> sleep infinity`: create a new container of the image and run sleep command to keep it running in the background.

- `docker kill <container ID>`: kill the container.

- `docker rename <ID> <new name>`: rename an image or container.


*\*\*NOTE: All commands below require the call to `docker`*

#### Images

- `image pull <image>`: fetches the images from the Docker registry and saves it to the system.

- `image ls`: see a list of all images on your system.
  - `--all/-a` show all images
  - `--digests` show digests
  - `--filter/-f` [filter](https://docs.docker.com/engine/reference/commandline/images/#filtering)
  - `--format` pretty-print images using a Go template
  - `--no-trunc` don't truncate output
  - `--quiet/-q` only show numeric IDs

- `image tag <image_id> <wanted image name>`: tag an image.

- `image build -t <image name>:<tag version name> .`: Build an image form a Dockerfile with tagging enabled.
  - `--rm` remove intermediate containers after a successful build.
  - `--tag/-t` name and optionally a tag in "name:tag" format

- `image history <image ID>`: Lists history of containers used to build image.

- `image inspect --format "{{ json .RootFS.Layers }}" <image ID>`: View layers used to build image as a json list.

- `images rm -a`: delete all images

- `image prune`: remove unused images.


#### Containers

- `container ls`: Also `--list`. Old: `docker ps`. List currently running containers. If you run under a Swarm node, it will only show containers running on that node. 
  - `-all/-a` show all including stopped.
  - `--filter/-f` [filter](https://docs.docker.com/engine/reference/commandline/ps/#filtering). 
  - `--format` pretty-print containers using a Go template. 
  - `--last/-n` show n last created. 
  - `--latest/-l` show latest created. 
  - `--no-trunc` don't truncate output. 
  - `--quiet/-q` only display numeric IDs. 
  - `--size/-s` dispaly total file sizes.

- `container <container ID> stop`: try to shutdown container gracefully.

- `container run <image>`: run a Docker container based of image.

- `container run <image> <command>`: run container and execute command inside. Will exit right afterwards.

- `container run -i -t <image> /bin/sh`: (also -it, -ti); Run container and open interactive shell

- `container run --interactive --tty --rm ubuntu bash`: Create and run container as interactive bash shell, allocate a pseudo-tty, and remove the container when execution in the shell is finished

- `container run -it <image> /bin/ash`: run container and open interactive ash shell. Does not terminate image after command.

- `container rm <container ID>`: remove container from list.

- `container exec <container ID> <command>`: execute command within container. If last command automatically closes container, you will have to load in interactive shell first to execute manually.

- `container start -i <container ID>`: start container with interactive shell.

- `container commmit <container ID>`: create a local copy of an image. How you can create custom images off other ones.

- `container logs <container name>`: show logs from container.

- `container top <container name>`: show top processes running inside the container.

- `container prune`: remove all stopped containers.
  - `--filter`:
    - `until=<timestamp>`
    - `label=<key>`
    - `label=<key>=<value>`
    - `label!=<key>`
    - `label!=<key>=<value>`
  - `--force/-f` do not prompt for confirmation.

- `rm (docker ps -a)`: Can also be used to remove stopped containers. Use pipes in windows.

- `kill [OPTIONS] container <container ID>`: kill one or more running containers. Use `container $(docker ps -a)` to kill all containers. Use pipes in windows.
  - `--signal/-s` signal to send to container

#### Docker Swarm

- `swarm init --advertise-addr $(hostname -i)`: Initialize Docker Swarm Manager. it listens on IP address returned by hostname -i. Use pipes in windows.

- `swarm join --token <token>`: add a worker node to the manager created.

- `swarm join-token worker`: get a token to create a worker node.

- `swarm join-token manager`: add a manager node to the manager.

- `node ls`: display all manager and worker nodes within a Swarm

- `docker service create --name <service name> <image> sleep infinity`: create a new container of the wanted image with a service and have it sleep in the background. Create services under a Swarm Manager to use **Orchestration**.

- `docker service ls`: view all created services and the image they are assigned to under the Swarm Manager.

- `service scale <service name>=<number>`: add more replcias of service manually.

- `service update --replicas <num> <service name>`: scale up/down the number of containers of the service. If you run under your Swarm manager, the containers will branch out over the worker nodes.

- ` docker node update --availability drain <node id from node ls>`: Clear node such that no containers are running on it.

- `service rm <service name>`: Remove service from Swarm when run under manager node.

- `swarm leave --force`: remove the node from the Swarm.

#### Stacks

- `stack deploy --compose-file=<stack.yml location> <stack name>`: deploy a stack

- `stack ls`: see if any stacks are deployed

- `stack services <stack name>`: get details on each service within the stack.

- `service ps <service name>`: list services of that stack.

### Proxies
To use proxies:
1.  right click on the Docker icon in your taskbar
2.  Click on Settings, go to Proxies, and select Manual
3.  Fill in HTTP, HTTPS, and bypass proxies

If using node's npm, add your proxies to the dockerfile:
```
#npm proxy
RUN npm config set proxy http://<proxy>:8080
RUN npm config set https-proxy http://<proxy>:8080
```


