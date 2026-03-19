# rayor (Run At Your Own Risk)
## dockerized-openclaw

- Building this docker will install the latest openclaw 
- Workspace has a symbolic link to ~/.openclaw for persistence
- The base OS for this container is at 
- - https://hub.docker.com/r/np003/baseos/tags 
- - https://github.com/nocturnal33/baseos/tree/main


```bash
docker build -t claw .
```

```bash
mkdir DATA
docker run -d -p 6901:6901 -v $(pwd)/DATA:~/workspace --name opclaw claw  
```

Open a local web browser and go to http://localhost:6901 to interact with the container

Start by onboarding - open a terminal and run:
```bash
openclaw onboard
```

Since there is no systemd, you will need to run the gateway manually

Open a new terminal and run 
```bash
openclaw gateway run

# or in the background
openclaw gateway run &
```

