#!/data/data/com.termux/files/usr/bin/bash

if test ! -f /data/data/com.termux/files/usr/bin/chdman;
then

	echo "Downloading the binary:"

		wget  https://github.com/Pipetto-crypto/mame/releases/download/termux-chdman/chdman

	echo "Installing the binary:"
		chmod a+rwx chdman
		mv chdman /data/data/com.termux/files/usr/bin
fi

read -p 'Where are your games located(absolute path):' location

if test ! -f $location/conversion.sh;
then
	echo "Creating conversion script in games folder:"
	touch $location/conversion.sh
	chmod a+rwx $location/conversion.sh
	echo 'for i in *.iso' >> $location/conversion.sh
	echo 'do' >> $location/conversion.sh
	echo '	chdman createcd -i "$i" -o "${i%.*}.chd"' >> $location/conversion.sh
	echo '	rm -rf "$i"' >> $location/conversion.sh
	echo 'done' >> $location/conversion.sh
fi
read -p 'Do you want to convert your games(this will delete your .isos to save space after conversion)?' prompt
if test "$prompt"="yes";
then
	cd  $location
	echo "Starting conversion of all your games"
	bash conversion.sh
	echo "Leaving"
	cd ~
fi

