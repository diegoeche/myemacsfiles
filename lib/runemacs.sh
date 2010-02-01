#! /bin/bash
if emacsclient ~/newFile 
then 
    echo "using client"
else 
    emacs &
    echo "using server"
fi
