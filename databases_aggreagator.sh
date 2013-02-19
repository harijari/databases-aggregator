#!/bin/bash


IFS=$'\n'

output_dir='.';
configuration_dir='.';

# Note that we use `"$@"' to let each command-line parameter expand to a 
# separate word. The quotes around `$@' are essential!
# We need TEMP as the `eval set --' would nuke the return value of getopt.
TEMP=`getopt -o o:c:h --long help,output_dir:,configuration_dir: \
     -n 'database_aggregator' -- "$@"`  

if [ $? != 0 ] ; then echo "Terminating... (problems with getopt)" >&2 ; exit 1 ; fi

# Note the quotes around `$TEMP': they are essential!
echo $TEMP;
eval set -- "$TEMP"

while true ; do
        case "$1" in
                -o|--output_dir) output_dir=$2 ; shift 2 ;;
                -c|--configuration_dir) configuration_dir=$2 ; shift 2 ;;
		-h|--help) echo  "Avaiable options 
-o, --output_dir=DIRECTORY_PATH	        Directory, where downloaded files are stored. Current directory by default.
-c, --configuration_dir=DIRECTORY_PATH	Directory, with configuration files. By default current directory." ; shift; exit 0; ;;
                --) shift ; break ;;
        esac
done

for file in $(ls $configuration_dir/*.conf);do 
	for row in $(cat $file|sed 's,#.*,,g');do 
		host=$(echo $row|cut -f 2);
		user=$(echo $row|cut -f 1);
		path=$(echo $row|cut -f 3);

		port=$(echo $host|cut -d ':' -f 2);

		if ( [ -z $port ] ); then
			port=22;	
		else 
			host=$(echo $host|cut -d ':' -f 1);
		fi

		echo "Downloading: $user@$host:$path"
		scp -P$port $user@$host:$path $output_dir/$(basename $path);
	done;
done;
