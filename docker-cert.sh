#!/bin/bash

###############
# Name: Protect the Docker daemon socket
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-10-16
# Version: dev
###############

default_cert_path=/usr/local/cert/docker
default_cert_san=DNS:127.0.0.1,IP:127.0.0.1

[[ -z ${cert_path} ]] && read -p ">>> Please enter the cert path (default: ${default_cert_path}): " read_cert_path
[[ -z ${cert_path} ]] && [[ -z ${read_cert_path} ]] && cert_path=${default_cert_path}
[[ -n ${read_cert_path} ]] && cert_path=${read_cert_path}

[[ -z ${cert_san} ]] && read -p ">>> Please enter the cert san (default: ${default_cert_san}): " read_cert_san
[[ -z ${cert_san} ]] && [[ -z ${read_cert_san} ]] && cert_san=${default_cert_san}
[[ -n ${read_cert_san} ]] && cert_san=${read_cert_san}

mkdir -p ${cert_path}
openssl rand -writerand ~/.rnd
pass_phrase=$(openssl rand -base64 32)

# cert
openssl genrsa \
    -aes256 \
    -out ${cert_path}/ca-key.pem \
    -passout "pass:${pass_phrase}"  \
    4096

openssl req \
    -new \
    -x509 \
    -days 365 \
    -key ${cert_path}/ca-key.pem \
    -sha256 \
    -out ${cert_path}/ca.pem \
    -subj "/CN=docker-cert" \
    -passin "pass:${pass_phrase}"

# server
openssl genrsa \
    -out ${cert_path}/server-key.pem \
    4096

openssl req \
    -subj "/CN=docker-server" \
    -sha256 \
    -new \
    -key ${cert_path}/server-key.pem \
    -out ${cert_path}/server.csr

echo "subjectAltName = ${cert_san}" > ${cert_path}/extfile-server.cnf
echo "extendedKeyUsage = serverAuth" >> ${cert_path}/extfile-server.cnf

openssl x509 \
    -req \
    -days 365 \
    -sha256 \
    -in ${cert_path}/server.csr \
    -CA ${cert_path}/ca.pem \
    -CAkey ${cert_path}/ca-key.pem \
    -CAcreateserial \
    -out ${cert_path}/server-cert.pem \
    -extfile ${cert_path}/extfile-server.cnf \
    -passin "pass:${pass_phrase}"

# client
openssl genrsa \
    -out ${cert_path}/key.pem \
    4096

openssl req \
    -subj '/CN=client' \
    -new -key ${cert_path}/key.pem \
    -out ${cert_path}/client.csr

echo "extendedKeyUsage = clientAuth" > ${cert_path}/extfile-client.cnf

openssl x509 \
    -req \
    -days 365 \
    -sha256 \
    -in ${cert_path}/client.csr \
    -CA ${cert_path}/ca.pem \
    -CAkey ${cert_path}/ca-key.pem \
    -CAcreateserial \
    -out ${cert_path}/cert.pem \
    -extfile ${cert_path}/extfile-client.cnf \
    -passin "pass:${pass_phrase}"

rm -v ${cert_path}/client.csr
rm -v ${cert_path}/server.csr
rm -v ${cert_path}/extfile-server.cnf
rm -v ${cert_path}/extfile-client.cnf

chmod -v 0400 ${cert_path}/ca-key.pem
chmod -v 0400 ${cert_path}/key.pem
chmod -v 0400 ${cert_path}/server-key.pem

chmod -v 0444 ${cert_path}/ca.pem
chmod -v 0444 ${cert_path}/server-cert.pem
chmod -v 0444 ${cert_path}/cert.pem
