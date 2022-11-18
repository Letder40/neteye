#!/bin/bash
 
 red="\e[91m"
 yellow="\e[33m"
 end="\e[0m"
 green="\e[32m"
 blue="\e[34m"
 NOT_24=false

if [[ $1 == "--help" ]]; then
  echo "neteye -i {net ip address} -p {port}"
  exit 0
fi

if [[ $1 == "--internet" && $2 == "-p" && $3 =~ [0-9]{1,5} && $3 -le 65536 ]]; then   
echo -e "\n${red} The eye is open ${end}\n"
for host1 in $(seq 1 254); do
  for host2 in $(seq 1 254); do
    for host3 in $(seq 1 254); do
      for host4 in $(seq 1 254); do
        target="$host1.$host2.$host3.$host4"
        echo -ne " ( 0) ${red}looking${end} at --> ${green}$target${end}\r"
          timeout 1 bash -c "echo '' > /dev/tcp/$target/$3" 2> /dev/null && echo -e "${yellow}->${end} $target has $4 port ${green}open${end}                        " &
        done
      done
    done
  done; wait
  echo -e "\n\n${red} The eye is closed ${end}"
fi

if [[ $# -ge 5 ]]; then
if [[ $5 == "-m" ]]; then
  if [[ $6 == 8 || $6 == 16 || $6 == 24 ]]; then
    NOT_24=true
  else
    echo "only class A | B | C , ip address are valids"
  fi
else
  echo "invalid argument, try ( -m ) if you want to select a netmask"
  exit 1
fi
fi

if [[ $1 = "-i" && $2 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ && $3 = "-p" && $4 =~ ^[0-9]{1,5}$ && $4 -le 65536 ]]; then
  echo -e "\n${red} The eye is open ${end}\n"
  
  if [[ $NOT_24 == false || $6 == 24 ]]; then
    net=$(echo $2 | cut -d "." -f1,2,3)
    for host4 in $(seq 1 254) ; do
      target="$net.$host4"
      echo -ne " ( 0) ${red}looking${end} at --> ${green}$target${end}\r"
      timeout 1 bash -c "echo '' > /dev/tcp/$target/$4" 2> /dev/null && echo -e "${yellow}->${end} $target has $4 port ${green}open${end}                           " &   
    done; wait
  fi

  if [[ $NOT_24 == true ]]; then
    
    if [[ $6 == 8 ]]; then
      net=$(echo $2 | cut -d "." -f1)
      for host2 in $(seq 1 254); do
        for host3 in $(seq 1 254); do
          for host4 in $(seq 1 254); do
            target="$net.$host2.$host3.$host4"
            echo -ne " ( 0) ${red}looking${end} at --> ${green}$target${end}\r"
            timeout 1 bash -c "echo '' > /dev/tcp/$target/$4" 2> /dev/null && echo -e "${yellow}->${end} $target has $4 port ${green}open${end}                     " &
          done
        done
      done; wait
    fi

    if [[ $6 == 16 ]]; then
      net=$(echo $2 | cut -d "." -f1,2)
      for host3 in $(seq 1 254); do
       for host4 in $(seq 1 254); do
          target="$net.$host3.$host4"
          echo -ne " ( 0) ${red}looking${end} at --> ${green}$target${end}\r"
          timeout 1 bash -c "echo '' > /dev/tcp/$target/$4" 2> /dev/null && echo -e "${yellow}->${end} $target has $4 port ${green}open${end}                     " &
        done
      done; wait
    fi

  fi
    echo -e "\n\n${red} The eye is closed ${end}"
else  
  echo -e "\nsyntax: neteye -i {net ip address} -p {port}\n"
  exit 1
fi



