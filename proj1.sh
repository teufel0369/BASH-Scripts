#!/bin/bash 

function fileSpace {
    for i in "$@" ; do
        if [ $i != "" ] ; then #if the argument is not blank
            if [[ -d $i ]] ; then #if the file is a directory
                echo Directory: $(basename "$i") #retrieves the basename and appends the next
                echo
                dir="$2"$(basename "$i") #concatenates the string
                for file in "$i"/* ; do  #recursively loops through the directories
                    fileSpace "$file" "$dir" 
                done
                
            
            elif [[ -f $i ]] ; then #if the file is a regular file
                if [[ ! -h $i ]] ; then  #if the file is not a symbolic link
                    magic=$(file -b "$i") #file --brief output
                    echo File: $i $magic #echo magic file contents
                    echo
                    echo Size: $(du -sh "$i") bytes #retrieve the size information
                    echo
                else
                    link=$(readlink -n "$i")
                    echo Symbolic Link: $link
                    echo
                fi
            
            
                echo End of directory: $(basename "$i") #prints the end of the directory
                echo
            else
               echo Unkown: "$i"
            fi
        else #otherwise 
            i=. 
        fi    
    done
}

#main function
fileSpace $1