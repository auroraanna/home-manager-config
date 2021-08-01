#!/bin/sh
FOLDER=".secrets"
tar -cf $FOLDER.tar $FOLDER/*
rm -rf $FOLDER
age -p $FOLDER.tar > $FOLDER.tar.age
rm -rf $FOLDER.tar