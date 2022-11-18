if [[ $USER == "root" ]]; then
  chmod +x ./neteye.sh
  cp ./neteye.sh /usr/bin/neteye
  echo "susccesfully installed -> you can run it calling neteye"
else 
  echo "install.sh must be run as root"
fi

