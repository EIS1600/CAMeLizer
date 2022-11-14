#!/bin/sh

FILESFROM=./*.docx
FILESTO=../texts/

for f in $FILESFROM

do
	echo ${f}
	pandoc -f docx -t markdown ${f} -o $FILESTO"${f}".md

	# echo "\n"
	# echo "\t\t\t\tNumber of files processed: $COUNTER "
	# echo "\n"
    # COUNTER=$[$COUNTER +1]

	# echo $f
	# NUMOFLINES=$(wc -l < $f)
	# echo "\t"$NUMOFLINES
	# IFS='/' read -a fNew <<< "$f"
  	# echo "\tProcessing: ${fNew[2]} file..."
  	# if [ $NUMOFLINES -lt $THRESH ]
  	# 	then
	# 	  	echo "\tCopying: ${fNew[2]} file..."
	# 	  	mv $f ./Books_Splits/${fNew[2]}
	# 	  	#gzip ./RAW_To_Archive_Gz/${fNew[2]}
	# 	 else
	# 		split -a 1 -l $THRESH $f ./Books_Splits/${fNew[2]}"_"
	# 		mv $f ./Books_Processed/${fNew[2]}
	# 		echo "\tSplitted: ${fNew[2]} file..."
  	# fi



done

printf "\n\nDone!"
