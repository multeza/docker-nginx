# docker-nginx

## How to use this docker image

### Preparation of your system 

    apt update && apt install docker.io docker-compose
    
### Install

Download docker-compose.yml and ModSecurity Core Rules Set (from https://coreruleset.org/)

    git clone https://github.com/multeza/docker-nginx.git /opt/nginx
  
Retrieve the docker image

    docker pull multeza/nginx:1.21.6
    
Activate ModSecurity in nginx

Load ModSecurity module, define it at the top of your nginx.conf

    load_module modules/ngx_http_modsecurity_module.so;

Activate ModSecurity
    http {
      ...
      ...
      ...
      modsecurity on;
      modsecurity_rules_file /opt/nginx/conf/modsecurity.conf;
      
      server {
      ...
      ...
      ...

  
