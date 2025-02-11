/bin/sh

PROJECT=$1
DEVELOPER_KEY=$2
OUTPUT=$3

mkdir -p $(dirname $OUTPUT)

java \
    -Xms1g \
    -Dfile.encoding=UTF-8 \
    -Dapple.awt.UIElement=true \
    -jar /connectiq/bin/monkeybrains.jar \
    -e -r -w \
    -o $OUTPUT \
     -f $PROJECT \
     -y $DEVELOPER_KEY