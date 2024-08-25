#!/bin/bash

awk '
BEGIN{
    # Matches 0-255
    r4 = "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
    # Matches complete IPv4 address
    r4 = r4 "\\." r4 "\\." r4 "\\." r4
    # Matches 4 Hex Digits
    r6 = "[0-9a-fA-F]{1,4}"
    # Matches complete IPv6 address
    r6 = "(" r6 ":){7}(" r6 ")|((" r6 ":){1,7}|:):((" r6 ":){1,7}|:)|::(" r6 ":){1,5}(" r6 ")|(" r6 ":){1,5}:"
    # Matches IPv4 OR IPv6
    r = r4 "|" r6   
}
{
while(match ($0, r)) {
    print substr($0, RSTART, RLENGTH)
    $0 = substr($0, RSTART + RLENGTH)
}
}
' | sort | uniq -c | sort -nr
