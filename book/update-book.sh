#!/bin/bash
# update the book and FbDK
# must be run from ~/pl/book/
cd ../plbook
git pull
make
cd ../book
cp ../plbook/book.pdf .
git add book.pdf
echo
echo
echo "***********************************************"
echo "files all updated, do a plcommit to finalize"


