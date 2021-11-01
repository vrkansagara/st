
# set -e # This setting is telling the script to exit on a command error.
# set -x # You refer to a noisy script.(Used to debugging)

echo " "
export DEBIAN_FRONTEND=noninteractive
CURRENT_DATE=$(date "+%Y%m%d%H%M%S")
SCRIPT=$(readlink -f "")
SCRIPTDIR=$(dirname "$SCRIPT")

if [ "$(whoami)" != "root" ]; then
	SUDO=sudo
fi

# """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
#  Maintainer :- Vallabh Kansagara<vrkansagara@gmail.com> — @vrkansagara
#  Note		  :- Suckless terminal for DWM and general purpose.
# """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

# ${SUDO} sudo apt-get install --yes -q  --no-install-recommends 

${SUDO} cp -R hooks .git/

FILES="patches/*.diff"
for f in $FILES; do
		echo "Applying path for the [ $f ]"
		dos2unix $f
		patch --merge=diff3 -i $f
		sleep 1
done

# Give current user permission to work with source
${SUDO} chown $USER  -Rf .
${SUDO} chgrp $USER  -Rf .

${SUDO} rm -rf /usr/share/bin/st
make clean
make
${SUDO} make install
${SUDO} make clean

echo "Suckless termina is ready to use ...... [DONE]"

exit 0
