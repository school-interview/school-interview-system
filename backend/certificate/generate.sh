openssl genrsa 2048 > private.key
openssl req -new -key private.key > server.csr
openssl x509 -req -days 3650 -signkey private.key < server.csr > server.crt