#!/bin/bash

############
## COLORS ##
############
nocolor='\033[0m'
whiite='\033[0;97m'
whiitebold='\033[0;1;97m'
purple='\033[0;38;5;201m'
blue='\033[0;38;5;45m'
blueblink='\033[0;5;38;5;45m'
darkblue='\033[0;38;5;27m'
green='\033[0;32m'
greendim='\033[0;3;32m'
yellow='\033[0;38;5;178m'
orange='\e[0;1;38;5;166;3m'
orangeital='\e[0;3;38;5;166m'
gray='\033[0;38;5;249m'
graybold='\033[0;1;38;5;249m'
graydim='\033[0;2;38;5;250m'
red='\033[0;91m'
## CUSTOM
# c__fctName='\033[0;38;5;45m'
c__fctName=$whiitebold
c__fctAction=$graydim
c__fct2=$gray
c__msgVar=$graybold
c__value=$blue
c__value2=$purple
c__error=$red
c__warning=$orange
c__notice=$yellow
c__success=$green

###############
## CHECK ROOT
###############
if [ "$EUID" -ne 0 ]; then
	printf "${c__error}Please run this script as root.${nocolor}\n"
	exit 1
fi

###############
## FUNCTIONS ##
###############

# Install the dependencies
InstallDependencies() {
	printf "${c__fctName}Install the dependencies${nocolor}\n"
	apt update
	apt upgrade
	apt install gzip gnupg2 wget -y

	return 0
}


# Install the repository
InstallRepository() {
	printf "${c__fctName}Install the repository${nocolor}\n"
	# Download the repository
	wget https://github.com/iredmail/iRedMail/archive/refs/tags/1.6.3.tar.gz
	# Extract the repository
	tar zxf 1.6.3.tar.gz

	return 0
}

StartIRedMailInstall() {
	printf "${c__fctName}Start the iRedMail installation${nocolor}\n"
	# Go to the repository
	cd iRedMail-1.6.3
	# Start the installation
	bash iRedMail.sh
	local test=$?
	if [ $test -ne 0 ]; then
		printf "${c__error}The installation failed${nocolor}\n"
		return 1
	fi
}


## ------------------ ##
## ----- SCRIPT ----- ##

InstallDependencies
if [ $? -ne 0 ]; then
	exit 1
fi
InstallRepository
if [ $? -ne 0 ]; then
	exit 1
fi

StartIRedMailInstall
if [ $? -ne 0 ]; then
	exit 1
else
	reboot
fi