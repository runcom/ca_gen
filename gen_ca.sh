#!/bin/sh

# TODO: check ./openssl.cnf
# TODO: provide a cleanup function to reset

mkdir -p crl newcerts private
touch index.txt
echo "01" > crlnumber

openssl genrsa -des3 -out ./private/cakey.pem 4096
openssl req -config ./openssl.cnf -new -x509 -key ./private/cakey.pem -out cacert.pem
openssl ca -config ./openssl.cnf -name CA_custom -gencrl -out crl.pem
