#!/bin/bash
 
 red="\e[91m"
 yellow="\e[33m"
 end="\e[0m"
 green="\e[32m"
 blue="\e[34m"

if [[ $1 == "--help" ]]; then
  echo "neteye -i {net ip address} -p {port}"
  exit 0
fi

if [[ $1 = "-i" ]]; then
  if [[ $2 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    
    if [[ $3 = "-p" ]]; then
      if [[ $4 =~ ^[0-9]{1,5}$  ]]; then   
       net=$(echo $2 | cut -d "." -f1,2,3)
       echo -e "\n${yellow}[!] only nets with /24 are valids${end}\n"   
       echo -e "${red} The eye is open ${end}\n"
       for i in $(seq 1 254) ; do
        target="$net.$i"
        timeout 1 bash -c "echo '' > /dev/tcp/$target/$4" 2> /dev/null && echo -e "${yellow}->${end} $target has $4 port ${green}open${end}" &
       
       done; wait
       echo -e "\n${red} The eye is closed ${end}"

      else

        echo "ports invalid"

      fi

    fi 

    exit 0
  else 
    echo "ip address not valid"
    exit 1 
  fi
else
  echo -e "\nsyntax: neteye -i {net ip address} -p {port}\n"
fi

