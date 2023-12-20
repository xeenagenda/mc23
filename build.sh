for var in "$@"
do
    if [ "$var" = "--debug" ]; then
        debug='true'
    fi
done

./mads.exe mc23.asm -o:mc23.xex -t:mc23.lab -l:mc23.lst

if [ -z "$debug" ] ; then
    rm -r -f *.pck 
    rm -r -f *.lst
    rm -r -f *.lab 
    rm -r -f *.obx
else 
    echo "keeping temporary objects"    
fi