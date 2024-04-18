mkdir -t /opt/containers/nginx/tls

cd /opt/containers/nginx/tls

openssl req -new -x509 -sha512 -nodes -newkey ec:<(openssl ecparam -name secp384r1) -subj "/C=BR/ST=DF/L=Brasilia/CN=*.localhost/O=LocalOrg" -addext "subjectAltName = DNS:localhost, DNS:127.0.0.1" -keyout server.crt -out server.key -days 3650

openssl x509 -in server.crt -text

chmod 600 server.key

chown -R 1000:0 /opt/containers/nginx/tls
