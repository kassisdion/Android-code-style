#!/bin/bash
# Simple script which installs Google's configs into yout user configs.

echo "Installing Google's code style configs..."

HERE=$(dirname $0)

#get the config
echo ""
echo "Retrieving the config..."
wget -q https://raw.githubusercontent.com/android/platform_development/master/ide/intellij/codestyles/AndroidStyle.xml -O $HERE/AndroidStyle.xml

echo ""
echo "Copying the config file..."
for i in $HOME/Library/Preferences/IntelliJIdea*\
	 $HOME/Library/Preferences/IdeaIC* \
	 $HOME/Library/Preferences/AndroidStudio* \
	 $HOME/.IntelliJIdea*/config \
	 $HOME/.IdeaIC*/config \
	 $HOME/.AndroidStudio*/config
do
    if [ -d "$i" ]; then
	#Create the codesStyle folder if it doesn't exist
	echo mkdir $i/codestyles
	mkdir $i/codestyles
	
	#Copy the config file
	echo cp -f $HERE/AndroidStyle.xml* $i/codestyles/
	cp -f $HERE/AndroidStyle.xml* $i/codestyles/
    fi
done

echo ""
echo "Done."
echo ""
echo "Restart IntelliJ and/or AndroidStudio, go to preferences, and apply 'AndroidStyle'"
