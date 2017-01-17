#!/bin/sh

if [[ -z $1 ]]; then
	echo "use: $0 <username>"
	exit 1
fi

openssl ca -config ./openssl.cnf -name CA_custom \
	-revoke ./newcerts/$1.crt \
	-keyfile ./private/cakey.pem \
	-cert ./cacert.pem
openssl ca -config ./openssl.cnf -name CA_custom -gencrl \
	-keyfile ./private/cakey.pem \
	-cert ./cacert.pem \
	-out ./crl/ca.crl
