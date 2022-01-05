#!/bin/bash
# update the FbDK
cd ~/pl/fbdk
echo pulling...
git pull
echo deleting old unzipped fbdk dist...
cd ~/pl/book
git rm -r dist/fbdk/*
rm dist/dist.zip
echo building...
cd ~/pl/fbdk
dune clean
dune build dist
cd ../book/
echo copying over new dist and unzipping a copy.. do an A if there is a previous dist.zip
cp -a ../fbdk/dist/dist.zip dist/
mkdir dist/fbdk
cd dist/fbdk
unzip ../dist.zip
cd ../..
echo adding new dist to git...
git add -f dist
echo
echo
echo "***********************************************"
echo "files all updated, do a plcommit to finalize"


