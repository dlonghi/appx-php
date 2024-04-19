#!/bin/bash
### https://gist.github.com/skarllot/9663935

set -ex

HTTPADDR=http://acraiz.icpbrasil.gov.br/credenciadas/CertificadosAC-ICP-Brasil/ACcompactado.zip
DEST="/tmp/bundle-icp-brasil"

mkdir -p ${DEST}
cd ${DEST}
rm -f *.crt
rm -f ACcompactado*.zip

wget "$HTTPADDR"

unzip *.zip

for fn in $(file *.crt|grep data|sed 's/: *data//')
do
  mv $fn  $fn.der
  openssl x509 -inform der -in $fn.der -out $fn
done

for f in $(ls *.crt); do
  sed -i 's/\r//' $f > /dev/null
  openssl x509 -text -in $f >> bundle.crt
done

ls -l $DEST/bundle.crt
