<h1>neteye</h1>
<p>With neteye you can search in your network or others networks for a specific port.<p>
<p>It will scan a range of ip address searching that port</p>
<h2>Usage:</h2>
<p>You need to provide a valid network such as 192.168.1.0 or 172.16.0.0 the netmask is default /24 but you can change it adding -m /16 or /8</p>
<p>Only /8, /16, /24 are supported by now</p>
<h4>Example: </h4>
<p>neteye -i 192.168.1.0 -p 80</p>
<h4>Example with netmask: </h4>
<p>neteye -i 172.16.0.0 -p 80 -m 16</p>
<h3>Global mode</h3>
<p>This scan will be extremly slow due to the 4.294.967.296 targets that will be.</p>
<p>This type of scan its about all the public ipv4 address</p>
<h4>Example: </h4>
<p>neteye -G -p 22</p>

<h2>Installation</h2>
<p>Just execute the script install.sh as root</p>



