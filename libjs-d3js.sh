#!/bin/bash

if [ -d "d3" ]; then
  cd d3
  git pull
else
  git clone https://github.com/mbostock/d3.git
  cd d3
fi

npm install
npm run build
npm run dist

VERSION=`cat package.json | grep '"version":' | awk -F '"' '{ print $4 }'`
#BUILD=`cat  ./build | perl -ne 'chomp; print join(".", splice(@{[split/\./,$_]}, 0, -1), map {++$_} pop @{[split/\./,$_]}), "\n";'`
#echo $BUILD > build
BUILD=1

#CHANGES=`cat CHANGELOG.md | awk -vRS="##" 'NR<=2' ORS="##" | grep -v "##"`
tar -czf ../../libjs-d3js_$VERSION.orig.tar.gz .
cd ..
#dch -v $VERSION-1 --package libjs-twitter-bootstrap $CHANGES
dch -v $VERSION-$BUILD --package libjs-d3js "Debianized $VERSION"

echo $VERSION > version.txt

debuild -i -us -uc -b

cd ..
#~/bin/publish-deb-packages.sh
