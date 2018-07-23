# Docker Reference


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


## Commands

### Images

- `image pull <image>`: fetches the images from the Docker registry and saves it to the system.

- `image ls`: see a list of all images on your system.

- `image tag <image_id> <wanted image name>`: tag an image.

- `image build -t <image name>:<tag version name> .`: Build an image form a Dockerfile with tagging enabled.

- `image history <image ID>`: Lists history of containers used to build image.

- `image inspect --format "{{ json .RootFS.Layers }}" <image ID>`: View layers used to build image as a json list.

### Containers

- `container run <image>`: run a Docker container based of image.

- `container run <image> <command>`: run container and execute command inside. Will exit right afterwards.

- `container run -i -t <image> /bin/sh`: (also -it, -ti); Run container and open interactive shell

- `container run -it <image> /bin/ash`: run container and open interactive ash shell. Does not terminate image after command.

- `container ls -a`: list the containers used previously. -a for all

- `container exec <container ID> <command>`: execute command within container. If last command automatically closes container, you will have to load in interactive shell first to execute manually.

- `container start -i <container ID>`: start container with interactive shell.

- `container commmit <container ID>`: create a local copy of an image. How you can create custom images off other ones.


### Docker Swarm

- `swarm init --advertise-addr $(hostname -i)`: Initialize Docker Swarm Manager. it listens on IP address returned by hostname -i.

- `swarm join-token <token>`: add a worker node to the manager created.

- `swarm join-token manager`: add a manager node to the manager.

- `node ls`: display manager and worker nodes

### Stacks

- `stack deploy --compose-file=<stack.yml location> <stack name>`: deploy a stack

- `stack ls`: see if any stacks are deployed

- `stack services <stack name>`: get details on each service within the stack.

- `service ps <stack service name>`: list tasks of that stack service.

- `service scale <service name>=<number>`: add more replcias of service manually.
