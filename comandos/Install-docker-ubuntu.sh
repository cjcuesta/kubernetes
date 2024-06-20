#!/bin/bash
 
# Actualiza los repos
sudo apt-get update
 
# Instalar utilidades que se necesitran mas adelante o que docker necesita para su intalacion
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
 
# Agregar el gpg para la validación de la integridad de los paquetes
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
 
# Agregar el repo
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
 
# Actualizar de nuevo
sudo apt-get update
 
# Instalar docker
sudo apt-get install docker-ce -y
 
# Habilitar servicio para Iniciar con el sistema
sudo systemctl enable docker
 
# Agregar usuario al grupo docker
USERNAME=$(whoami)
sudo usermod -aG docker $USERNAME

# Solicitar al usuario el directorio para mover Docker
echo "Por favor, ingresa el directorio donde quieres mover el directorio de Docker (por ejemplo, /home/usuario o /V1app/apps/docker): "
read DOCKER_DIRECTORY
 
# Mover directorio de Docker y crear enlace simbólico
sudo service docker stop
sudo mv /var/lib/docker $DOCKER_DIRECTORY
sudo ln -s $DOCKER_DIRECTORY/docker /var/lib/docker
 
# Start Docker
sudo service docker start

# Instalar Portainer
sudo docker volume create portainer_data
sudo docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

# Validar la versión de Docker
echo "Versión de Docker instalada:"
docker --version
 
# Validar la versión de Portainer
echo "Versión de Portainer instalada:"
docker ps | grep portainer/portainer
 
# Salir de la sesión
echo "Por favor, cierra sesión de la terminal ejecutando 'exit' y vuelve a iniciarla para que los cambios surtan efecto."
 
# Iniciar de nuevo con el usuario y probar
echo "Después de cerrar sesión, vuelve a iniciar sesión, ejecuta 'docker run hello-world' para probar Docker y accede a Portainer desde tu navegador en http://localhost:9000 para comenzar a administrar Docker."
