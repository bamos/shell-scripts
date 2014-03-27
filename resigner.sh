#!/bin/bash
#
# resigner.sh
# Resigns an apk with debug information
#
# Brandon Amos
# 2012.08.10


# You might need to create a debug key with:
# keytool -genkey -v -keystore debug.keystore \
#   -alias androiddebugkey -keyalg RSA -keysize 2048 -validity 20000

JARSIGNER=~/jdk6/bin/jarsigner
KEYSTORE=~/.android/debug.keystore

function die {
    echo $1; exit 1;
}

[[ $# != 1 ]] && die "Usage: $0 <apk>"

# Remove the extension, if necessary
NAME=$(echo $1 | sed s'/\.apk$//')

echo Moving the original apk to a temporary location
mv $NAME.apk $NAME-temp.apk

echo Unzipping and removing META-INF
unzip $NAME-temp.apk -d $NAME
cd $NAME
rm -rf META-INF

echo Zipping and removing the directory
zip -r ../$NAME-nometa.apk *
cd ..
rm -rf $NAME

echo Aligning the zip
zipalign -v 4 $NAME-nometa.apk $NAME.apk

# JDK6 is needed because JDK7 handles certificates differently
echo Signing the apk
$JARSIGNER -keystore $KEYSTORE-storepass android \
    -keypass android $NAME.apk androiddebugkey

echo Cleaning up
rm $NAME-temp.apk $NAME-nometa.apk
