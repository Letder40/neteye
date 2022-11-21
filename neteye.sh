#!/bin/bash
 
red="\e[91m"
yellow="\e[33m"
end="\e[0m"
green="\e[32m"
blue="\e[34m"

function help() {
  echo -e "default /24\t scan mode: neteye -i {net ip address} -p {port}"
  echo -e "others netmasks\tneteye -i {net ip address} -p {port} -m /16 | /8 | /24"
  echo -e "\n\tParameters\n"
  echo -ne "-i\tnetwork's IPv4 address\n"
  echo -e "-p\ttarget port"
  echo -e "-m\tnetmask of the network (default /24) | 24 | 16 | 8"
  echo -e "-w\tsave the output into a text file, you have to select a name for the file"
  echo -e "-G\tGlobal mode | ip nor netmask aren't needed"
  exit 0
}

function socket () {
  if [[ $export == true ]]; then
    timeout 1 bash -c "echo '' > /dev/tcp/$target/$port" 2> /dev/null && echo -e "${yellow}->${end} $target has $port port ${green}open${end}                                " | tee -a $file &     
  else
    timeout 1 bash -c "echo '' > /dev/tcp/$target/$port" 2> /dev/null && echo -e "${yellow}->${end} $target has $port port ${green}open${end}                                " &  
  fi
    echo -ne " ( 0) ${red}looking${end} at --> ${green}$target${end}\r"
}

declare -i tester; while getopts ":i:p:m:w:Gh" arg; do
  case $arg in
    i) 
      net=$OPTARG
      let tester+=1
      ip_argument=true
      ;;
    p) 
      port=$OPTARG
      let tester+=1 
      ;;
    m) 
      netmask=$OPTARG
      netmask_parameter=true
      ;;
    w) 
      export=true
      file=$OPTARG
      echo "" > $file
      ;;
    G) global=true; let tester+=1;;
    h) help ;;
  esac
done

if [[ $port == "" ]]; then
  echo "you must specify a port"
  exit 1
fi

if [[ $tester -ne 2 ]]; then
  help
  exit 1
fi

if [[ $ip_argument && $global ]]; then 
  echo "-G (global mode) doesn't need an ip address of net because its range is always the same, retry without -i"
  exit 1
fi

if [[ $netmask == "" ]]; then
  no_netmask=true
fi


# -- MAIN --
echo -e "\n${red} The eye is open ${end}\n"

if [[ $global == true && $ip_argument == "" ]]; then
  for host1 in {1..255}; do
    for host2 in {0..255}; do
      for host3 in {0..255}; do
        for host4 in {0..255}; do
          target="$host1.$host2.$host3.$host4"
          socket
        done
      done
    done
  done
fi

if [[ $ip_argument ]]; then
if [[ $netmask == 8 || $netmask == 16 || $netmask == 24 || $no_netmask == true ]]; then

  if [[ $netmask == "8" ]]; then
    net=$(echo $net | cut -d "." -f1)
    for host2 in host2 {0..255}; do
      for host3 in {0..255}; do
        for host4 in {1..254}; do
          target=$net.$host2.$host3.$host4
          socket
        done
      done
    done
  fi

  if [[ $netmask == "16" ]]; then
    net=$(echo $net | cut -d "." -f1,2)
    for host3 in {0..255}; do
      for host4 in {1..254}; do
        target=$net.$host3.$host4
        socket
      done
    done
  fi

  if [[ $netmask == "24" || $no_netmask ]]; then
    net=$(echo $net | cut -d "." -f1,2,3)
    for host4 in {1..254}; do
      target=$net.$host4
      socket
    done
  fi

else
  echo "Only /24 | /16 | /8 netmasks are valids in neteye"
  exit 1
fi
else
  echo "network's IPv4 address must be specefied"
  exit 1
fi

echo -e "\n\n${red} The eye is closed ${end}"
# -- --

