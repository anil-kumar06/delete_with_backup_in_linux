#!/bin/bash

INPUT=1
INPUT1=$1
INPUT2=$2
DIRECTORY=/tmp/deleted
PWRD=`pwd`
USER="$USER"
FILE_LIST=".file_list"
NO_OF_FILES=$#
LINE=$@

if [ ! -d "$DIRECTORY" ]; then
  mkdir -p $DIRECTORY
fi
usage() { echo "Usage: $0 [-a <No Option>] [-d <directory name>]" 1>&2; exit 1; }

remove_all_files()
{
  ls -t > $FILE_LIST
  NO_OF_FILES_TO_DELETE=`ls | wc -l`
  
  echo "Removing all files of $PWD"
  
  file=$FILE_LIST
  while IFS= read line
  do
    # display $line or do somthing with $line
    cp $line $DIRECTORY  
    cd $DIRECTORY 
    attr -s $USER -V "Path is : $PWRD" $line > /dev/null 2>&1 
    cd $PWRD
    #echo "$line"
  done <"$file"
  #rm *
}

remove_directory()
{
  echo "Choosed option d and directory name is $d"
  if [ ! -d "$d" ]; then
    usage
  else
    cp -r $d $DIRECTORY
    cd $DIRECTORY
    attr -s $USER -V "Path is : $PWRD" $d
    cd $PWRD
    rmdir $d
  fi
}

remove_directory_and_files()
{
  cd $r

   
  cd $PWRD
}

remove_multiple_files()
{
  
  echo "$INPUT   TOTAL = $NO_OF_FILES"
  while [ $INPUT -ne $NO_OF_FILES ]
    do
     
    echo "$INPUT"  
     if [ $INPUT -gt $NO_OF_FILES ]; then
         break
     fi
     

     INPUT=`expr $INPUT + 1`
  done
}


remove_several_files()
{
  for word in $LINE;
    do echo $word >> $FILE_LIST ;
  done
 
  while IFS= read line
  do
    # display $line or do somthing with $line
    cp $line $DIRECTORY
    cd $DIRECTORY 
    attr -s $USER -V "Path is : $PWRD" $line > /dev/null 2>&1
    cd $PWRD
    #echo "$line"
  done <"$file"
  #rm $LINE 
}



###########	start	###########	

#remove_multiple_files

if [ "$#" -eq 0 ]; then
  usage
fi

  if [ -f "$1" ]; then
    cp $1 $DIRECTORY
    cd $DIRECTORY
    attr -s $USER -V "Path is : $PWRD" $1
    cd $PWRD
    rm $1
  else
    while getopts ":ad:r:s:" o; do
      case "${o}" in
          a)
              remove_all_files
              ;;
          d)
              d=${OPTARG}
              remove_directory
              ;;
          r)
              r=${OPTARG}
             # remove_directory_and_files
              ;;
          s)
              remove_several_files
	      ;;
          [?])
              usage
              ;;
      esac
    done
    shift $((OPTIND-1))
  fi

<<"COMMENT"


  usage
  cp $1 $DIRECTORY
  cd $DIRECTORY
  attr -s $USER -V "Path is : $PWRD" $1
  cd $PWRD
  rm $1

file=".file_list"
while IFS= read line
do
        cp $line $DIRECTORY
        # display $line or do somthing with $line
	echo "$line"
done <"$file"

COMMENT


#attr -s netstorm.status -V "Path is defined" abc.txt

#getfattr -n user.netstorm abc.txt




