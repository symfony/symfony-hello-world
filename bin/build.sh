#!/bin/sh

DIR=`php -r "echo realpath(dirname(\\$_SERVER['argv'][0]));"`
cd $DIR

if [ ! -d "$DIR/build" ]; then
    mkdir -p $DIR/build
fi

$DIR/bin/build_bootstrap.php

# Without vendors
rm -rf /tmp/Symfony
mkdir /tmp/Symfony
cp -r app /tmp/Symfony/
cp -r src /tmp/Symfony/
cp -r web /tmp/Symfony/
cp -r README.md /tmp/Symfony/
cp -r LICENSE /tmp/Symfony/
cd /tmp/Symfony
sudo rm -rf app/cache app/logs .git*
mkdir -p app/cache app/logs
chmod 777 app/cache app/logs
cd ..

cd $DIR
rm -rf /tmp/vendor
mkdir /tmp/vendor
TARGET=/tmp/vendor
cd $TARGET

if [ ! -d "$DIR/vendor" ]; then
    echo "The master vendor directory does not exist"
    exit
fi

cp -r $DIR/vendor/* .

# Symfony
cd symfony && rm -rf README.md phpunit.xml* tests *.sh autoload* vendor src/Symfony/Bridge/ \
src/Symfony/Bundle/Doctrine* src/Symfony/Bundle/SecurityBundle \
src/Symfony/Bundle/SwiftMailerBundle src/Symfony/Bundle/TwigBundle src/Symfony/Bundle/MonologBundle \
src/Symfony/Bundle/WebProfilerBundle \
src/Symfony/Component/BrowserKit src/Symfony/Component/Console src/Symfony/Component/CssSelector \
src/Symfony/Component/DomCrawler src/Symfony/Component/Form src/Symfony/Component/Locale \
src/Symfony/Component/Process src/Symfony/Component/Security src/Symfony/Component/Serializer \
src/Symfony/Component/Translation src/Symfony/Component/Validator
cd $TARGET

# cleanup
find . -name .git | xargs rm -rf -
find . -name .gitignore | xargs rm -rf -

cd /tmp/
mv /tmp/vendor /tmp/Symfony/
# avoid the creation of ._* files
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
export COPYFILE_DISABLE=true
tar zcpf $DIR/build/Symfony_Hello_Vendors.tgz Symfony
