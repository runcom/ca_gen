#!/bin/sh

if [[ -z $1 ]]; then
	echo "use: $0 <username>"
	exit 1
fi

openssl genrsa -des3 -out ./private/$1.key 4096
openssl req -config ./openssl.cnf -new -key ./private/$1.key -out ./newcerts/$1.csr
openssl x509 -req \
	    -CA ./cacert.pem \
	    -CAkey ./private/cakey.pem \
	    -in ./newcerts/$1.csr \
	    -CAserial ./serial \
	    -CAcreateserial \
	    -out ./newcerts/$1.crt
openssl pkcs12 -export -clcerts \
	-in ./newcerts/$1.crt \
	-inkey ./private/$1.key \
	-out ./newcerts/$1.p12
