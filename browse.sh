#! /bin/bash

# accepts a file having a list of urls
 # Usage info
show_help(){

    cat <<EOF
 Usage: ${0##*/} [-h] 
Browse the web

     -h          display this help and exit

EOF
 }

check_program_arguments(){
     is_this_null=$1
     if [ ! -z $is_this_null ]
     then
	 # it is ok this is non zero, perhaps a file was supplied
	 if [ -f $is_this_null ]
	 then
	     #ok
	     # cat out the input file and put all the links into an array
	     deal_with_user_supplied_file $is_this_null
	 else
	     parse_program_arguments $is_this_null
	 fi
	 
     else
	 echo "Incorrect invocation"
	show_help 
	 #parse_program_arguments $is_this_null
     fi
 }

parse_program_arguments(){
 while getopts h: opt; do
     case $opt in
         h)
             show_help
             exit 0
             ;;
          *) echo "you messed up"
             show_help >&2
             exit 1
             ;;
     esac
 done
# shift "$((OPTIND-1))"   # Discard the options and sentinel --
}

display(){
clear
        cat <<EOF

b) Browse the web
L) see recommended links
l) load links from file(number of links in the supplied file)
f) select the browser: elinks lynx w3m, firefox , midori

EOF

	
    # first ten links in the file
    # create a temp html and open the same in browser
	# apart from the given links an internal list of approved links could be displayed on request
read user_choice
	let_user_decide	$user_choice
}

let_user_decide(){

    user_choice=$@
    case word in
	b)
	    #       Statement(s) to be executed if pattern1 matches	
	    echo $(1:commnd)

	    ;;
	L)
	    lynx "~/landingpage.html"
	    ;;
	l)
	    #       Statement(s) to be executed if pattern3 matches
	    ;;
	f)
	    #       Statement(s) to be executed if pattern3 matches
	    ;;

	*)
	    #      Default condition to be executed
	    ;;
    esac



}

deal_with_user_supplied_file(){
file=$@

user_supplied_url_list+=$(cat $file | grep -i http)

select opt in ${user_supplied_url_list[@]}
do case ${user_supplied_url_list[@]} in
*)
echo you selected $opt
lynx -editor=emacs $opt

echo press enter to clear
read junk
clear

;;
esac
done


}

check_program_arguments $*
