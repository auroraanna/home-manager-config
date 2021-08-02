#!/bin/sh
FOLDER=".secrets"

age -d $FOLDER.tar.age > $FOLDER.tar &&
rm -rf $FOLDER.tar.age &&

tar -xf $FOLDER.tar $FOLDER &&
rm -rf $FOLDER.tar
