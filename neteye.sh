#!/bin/bash

if [[ $1 == "help" ]]; then
  echo "nothing 4 now"
  exit 0
fi

if [[ $1 = "-i" ]]; then
  if [[ $2 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    
    if [[ $3 = "-p" ]]; then
      if [[ $4 =~ ^[0-9]{1,5}$  ]]; then   
        
       echo -e "\t[!] only nets with /24 are valids\n"
       net=$(echo $2 | cut -d "." -f1,2,3)

       for i in $(seq 1 254) ; do
         bash -c "echo '' > /dev/tcp/$net.$i/$4" &>/dev/null && echo " $net.$i has $4 port open" &
       

       done; wait
      

      else

        echo "ports invalid"

      fi

    fi

    echo "" > /dev/tcp/$2/$4 
    exit 0
  else 
    echo "ip address not valid"
    exit 1 
  fi
fi

