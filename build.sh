#!/bin/sh
STC_PATH="/Users/natiz/Develop/svn/STC/src"
PHP_PATH="/usr/bin/php"
path=`dirname $0`;
first=${path:0:1};
if [[ $first != '/' ]];then
    path=$(pwd);
fi

if [ -d ${path}"/output" ];then
	rm -rf ${path}"/output";
fi
mkdir ${path}"/output";
if [ ! -f ${path}"/config.php" ];then
	cp $STC_PATH/config/config.php ${path};
fi
#path=$(pwd);
$PHP_PATH $STC_PATH/index.php ${path} test $1;
if [ -f ${path}"/stc.error.log" ]; then
    rm -rf ${path}"/stc.error.log";
    #exit 1;
fi
cp src/manifest.json output/src/
cp -r src/bin output/src/;
mv output/src/ output/Fiddler;
if [[ $1 == "1" ]];then
    /usr/local/bin/php clean.php;
    cd output;
    zip -r Fiddler.zip Fiddler/;
fi
