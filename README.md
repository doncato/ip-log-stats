# ip-log-stats
A simple bash script to extract anything that matches an IPv4 or IPv6 from STDIN and outputs the count of occurences for each IP found on STDOUT.

## Installation
Just download the `ip-log-stats.sh` script, e.g. by using `wget`:

```sh
wget https://raw.githubusercontent.com/doncato/ip-log-stats/main/ip-log-stats.sh
```

If you want to 'install' it, it's probably a good idea to put it in your PATH:

```sh
mv ip-log-stats.sh /usr/local/bin/ip-log-stats
```

And finally make sure you can execute it 
```sh
chmod a+x /usr/local/bin/ip-log-stats
```

## Usage
To use it you can just pipe any log from anywhere into the script, and it will output
the number of occurences followed by the ip like this:

```txt
    152 10.20.20.20
     54 192.168.178.1
     11 10.20.2.5
      5 1.1.1.1
      2 127.0.0.1
```

### Usage Examples
#### Simple showoff
```sh
# Will simply output the contents for human consumption
cat /var/log/syslog | ip-log-stats
```

#### Email the stats:
```sh
# Will mail the results to webmaster@example.com with the subject stats
cat /var/log/syslog | (echo "From: IP Log Stats <monitor@example.com>"; echo "To: postmaster@example.com"; echo "Subject: IP Log Stats"; echo ""; ip-log-stats) | sendmail -F "IP Log Stats <monitor@example.com>" postmaster@example.com
```

#### Get only IPs
```sh
# Will filter to output to just print the ips without the count
cat /var/log/syslog | ip-log-stats | awk '$1=$1;1' | cut -d" " -f2
````

#### Display total sum:
```sh
# Will output how many occurences were found in total
cat /var/log/syslog | ip-log-stats | awk '$1=$1;1' | cut -d" " -f1 | awk '{ sum += $1 } END { print sum }'
```

## Limitations

This script was meant to be kinda dumb, the motivation was that it doesn't matter in which
context an IP is found because often there can be many different applications and cases
where something is reported and everything is reported in a different format, so the aim was
to get a very simple statistic.

As a result there are some things that are to be considered during usage:

(These are not necessarily limitations but can also common reasons for misinterpretation)

### Self-reporting / local IPs
Obviously your own IP (the host IP of the syslog) will end up getting counted along all others
this is due to the fact that you often get logs like this:

```txt
[Date] Accepted connection remote_ip:X.X.X.X local_ip:Y.Y.Y.Y
```

### False Detections
Certain things in log messages sometimes look like an IP Address while they aren't an actual
IP, the script will report it regardless, an example can be the Version number of the
Browser reported in the User Agent of Webserver logs. So the User agent could contain
something like `(Windows NT 10.0; Win64; x64) Chrome/128.0.0.0` where `128.0.0.0` would
be falsely reported

### Counting Interpretation
Obviously the count of occurences counts how often an IP was found, it is hard to tell
how many requests or connections any IP actually made using this script. For example
if you have `fail2ban` set up, an IP may get reported twice or even more often just
for one connection, because `fail2ban` also reports that it has found the IP and 
for example banned it. Such things obviously increase the number this IP appears in your logs

## Contributing

Feel free to contribute through the usual ways (e.g. opening Issues or submitting Pull Requests)
