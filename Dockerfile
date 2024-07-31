- name: docker build and push
  hosts: local  # Replace with the hostname or IP address of your target server
  become: yes  # Run tasks with sudo privileges
  tasks:
    - name: Update apt package cache
      apt:
        update_cache: yes
    - name: Build Docker Image
      command: docker build -t petstore .
      args:
        chdir: /var/lib/jenkins/workspace/petstore
    - name: tag image
      command: docker tag petstore:latest 123devops/petstore:latest
    - name: Log in to Docker Hub
      community.docker.docker_login:
        registry_url: https://index.docker.io/v1/
        username: 123devops
        password: <docker pat>
    - name: Push image
      command: docker push 123devops/petstore:latest
    - name: Run container
      command: docker run -d --name pet1 -p 8081:8080 123devops/petstore:latest
