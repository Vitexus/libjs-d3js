#!/bin/bash
npm install d3

VERSION=`cat node_modules/d3/build/package.js | grep "export var version" | cut -d'"' -f 2`
BUILD=`cat  ./build | perl -ne 'chomp; print join(".", splice(@{[split/\./,$_]}, 0, -1), map {++$_} pop @{[split/\./,$_]}), "\n";'`
echo $BUILD > build
BUILD=1

#CHANGES=`cat CHANGELOG.md | awk -vRS="##" 'NR<=2' ORS="##" | grep -v "##"`
#tar -czf ../../libjs-d3js_$VERSION.orig.tar.gz .

#dch -v $VERSION-1 --package libjs-twitter-bootstrap $CHANGES
dch -v $VERSION-$BUILD --package libjs-d3js "Debianized $VERSION"

echo $VERSION > version.txt

debuild -i -us -uc -b

cd ..
#~/bin/publish-deb-packages.sh
