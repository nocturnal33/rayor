# rayor (Run At Your Own Risk)
## dockerized-openclaw

This uses baseos

Workspace has a symbolic link to ~/.openclaw for persistence

```bash
mkdir DATA
docker run -d -p 6901:6901 -v $(pwd)/DATA:~/workspace --name opclaw claw  
```

Open a local web browser and go to http://localhost:6901 to interact with the container

Start by onboarding:
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

