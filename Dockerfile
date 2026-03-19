FROM np003/baseos:noble

WORKDIR ${HOME}

############################
## ENVIRONMENT VARIABLES ###
#############################
ENV USER=operator
ENV PATH=${HOME}/.npm-global/bin:$PATH

###################################
## Update and upgrade the system ##
####################################
RUN sudo apt-get update && sudo apt-get upgrade -y

RUN echo "#!/bin/bash\nchown -R ${USER}:${USER} ${PERSIST}" > ${HOME}/fix-permissions.sh && \
chmod +x fix-permissions.sh
RUN echo "fixing permissions"

##########################
## Install Node.js 22.x ##
###########################

RUN sudo mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" \ 
    | sudo tee /etc/apt/sources.list.d/nodesource.list

RUN sudo apt update && \
    sudo apt install nodejs -y && \
    sudo npm install -g npm@latest

RUN mkdir -p ${HOME}/.npm-global && \
    chown -R ${USER}:${USER} ${HOME}/.npm-global && \
    chmod -R 755 ${HOME}/.npm-global && \
    echo "prefix=${HOME}/.npm-global" > ${HOME}/.npmrc && \
    npm config set prefix '${HOME}/.npm-global'

######################
## Install OpenClaw ##
#######################
RUN npm install -g openclaw@latest

RUN ln -sf ${HOME}/.openclaw ${PERSIST}/.openclaw

COPY --chown=${USER}:${USER} --chmod=755 onboard.sh ${HOME}/onboard.sh
COPY --chown=${USER}:${USER} --chmod=755 doctorfix.sh ${HOME}/doctorfix.sh

RUN echo "#!/bin/bash\nchown -R ${USER}:${USER} ${PERSIST}" > $HOME/fix-permissions.sh && \
    chmod +x fix-permissions.sh
RUN echo "fixing permissions"

RUN sudo chown -R ${USER}:${USER} ${PERSIST}

ENV COURSE_NAME=OpenClaw

CMD ["sudo", "bash", "fix-permissions.sh"] 

WORKDIR ${PERSIST}