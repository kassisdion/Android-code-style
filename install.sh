#!/bin/sh
# Simple script which installs Google's configs into your user configs.

echo "Installing Google's code style configs..."

HERE=$(dirname $0)

#Get the google config
echo ""
echo "Retrieving the config..."

CONFIG_URL=https://raw.githubusercontent.com/android/platform_development/master/ide/intellij/codestyles/AndroidStyle.xml
CONFIG_PATH=$HERE/AndroidStyleTest.xml

if ! wget -q $CONFIG_URL -O $CONFIG_PATH; then
    echo ""
    echo "Can't retrieve the config file at $CONFIG_URL"
    exit 1
fi

#Finding user config 
echo ""
echo "Searching your config directory..."
for i in $HOME/Library/Preferences/IntelliJIdea*\
	 $HOME/Library/Preferences/IdeaIC* \
	 $HOME/Library/Preferences/AndroidStudio* \
	 $HOME/.IntelliJIdea*/config \
	 $HOME/.IdeaIC*/config \
	 $HOME/.AndroidStudio*/config
do
    #Check if the directory exist
    if [ -d "$i" ]; then
	#Create the codesstyle folder if it doesn't exist
	if [ ! -d "$i/codestyles" ]; then
	   echo "mkdir $i/codestyles" && mkdir $i/codestyles
	fi

	#Copy the config file
	echo cp -f $CONFIG_PATH $i/codestyles/ && cp -f $CONFIG_PATH $i/codestyles/

	echo ""
	echo "Done."
	echo ""
	echo "Restart IntelliJ and/or AndroidStudio, go to preferences, and apply 'AndroidStyle'"
	exit 0
    fi
done

echo ""
echo "Can't find your config directory"
exit 1
