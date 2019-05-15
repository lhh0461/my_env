ENGINE=../engine/engine.nostrip
HOST=userd-develop-578

if [ "$1" != "" ] ; then
    ENGINE=$1
fi

if [ "$2" != "" ] ; then
    HOST=$2
fi

echo "正在编译修改过的文件..."

for f in `git st -s | grep -v "D " | awk -F" " '{print $2}'| grep "\.c"` 
do  
    $ENGINE -L -h$HOST -r$f >/dev/null 2>&1
    if [ $? -ne "0" ] ; then
        $ENGINE -L -h$HOST -r$f 2>&1
        echo "编译失败！"
        exit 1
    else
        echo "$f 编译成功！"
    fi
done

echo "编译通过！"
