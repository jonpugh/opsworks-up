#! /bin/bash

# Check chef-version
version=`chef-solo -v`
if [ "$version"=="Chef: 0.9.18" ]
  then echo "Chef 9.18 installed!  Moving On..."
else
  echo "Chef 9.18 NOT AVAILABLE! Installing"
  apt-get install make
  gem uninstall chef
  gem install chef --version 0.9.18 --no-rdoc --no-ri --conservative
  gem install bundler
fi
