!/bin/bash

# Root CA
openssl genrsa -out root-ca-key.pem 2048
openssl req -new -x509 -sha256 -key root-ca-key.pem -subj "/C=US/ST=State/L=City/O=Org/CN=root-ca" -out root-ca.pem -days 730

# Admin certificate
cat > admin.cnf << EOF
[req]
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no

[req_distinguished_name]
C = US
ST = State
L = City
O = Org
CN = admin

[v3_req]
basicConstraints = critical,CA:FALSE
keyUsage = critical,digitalSignature,keyEncipherment
extendedKeyUsage = clientAuth
EOF

openssl genrsa -out admin-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in admin-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out admin-key.pem
openssl req -new -key admin-key.pem -config admin.cnf -out admin.csr
openssl x509 -req -in admin.csr \
    -CA root-ca.pem \
    -CAkey root-ca-key.pem \
    -CAcreateserial \
    -out admin.pem \
    -days 730 \
    -sha256 \
    -extfile admin.cnf \
    -extensions v3_req

# Node certificate
cat > node.cnf << EOF
[req]
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no

[req_distinguished_name]
C = US
ST = State
L = City
O = Org
CN = opensearch-node1

[v3_req]
basicConstraints = critical,CA:FALSE
keyUsage = critical,digitalSignature,keyEncipherment
extendedKeyUsage = serverAuth,clientAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
DNS.2 = opensearch-node1
IP.1 = 127.0.0.1
EOF

openssl genrsa -out node-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in node-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out node-key.pem
openssl req -new -key node-key.pem -config node.cnf -out node.csr
openssl x509 -req -in node.csr \
    -CA root-ca.pem \
    -CAkey root-ca-key.pem \
    -CAcreateserial \
    -out node.pem \
    -days 730 \
    -sha256 \
    -extfile node.cnf \
    -extensions v3_req

# Cleanup
rm admin.csr admin-key-temp.pem node.csr node-key-temp.pem admin.cnf node.cnf root-ca.srl

# Set permissions
chmod 600 *.pem