docker build -t jenkins-agent .
docker kill jenkins-agent
docker rm jenkins-agent
docker run  -d -v ja:/home/jenkins -v /var/run/docker.sock:/var/run/docker.sock -p 5789:22 --name jenkins-agent jenkins-agent