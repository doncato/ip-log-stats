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
# Will simple output the contents for human consumption
cat /var/log/syslog | ip-log-stats
```

#### Email the Stats:
```sh
# Will mail the results to webmaster@example.com with the subject stats
cat /var/log/syslog | (echo "From: monitor@example.com"; echo "To: webmaster@example.com"; echo "Subject: IP Log Stats"; echo ""; ip-log-stats) | sendmail -F "IP Log Stats <monitor@example.com>" webmaster@example.com
```
