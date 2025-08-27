#!/bin/bash

# Power-up types
powerup_pool=("A" "D" "H" "S") # A: Attack, D: Defense, H: Heal, S: Dodge
max_powerups=2
active_powerups=()

# Quiz database
questions=(
"Which command lists all active network connections?"
"What command updates the package list in Kali Linux?"
"Which command is used to change directories in the shell?"
"What command is used to copy files?"
"Which command is used to display the manual of other commands?"
"Which command searches text in files?"
"Which command displays the current working directory?"
"What command shows disk usage?"
"What command lists running processes?"
"Which command is used to create directories?"
"Which command removes files?"
"What command shows IP addresses assigned to network interfaces?"
"What command is used to display contents of a file?"
"Which command moves or renames files?"
"What command changes file permissions?"
"What command is used to download files from the internet?"
"What command displays the current date and time?"
"Which command displays environment variables?"
"What command is used to ping a host?"
"Which command terminates a running process?"
"What is a common type of malware that replicates itself and spreads to other computers?"
"Which malware encrypts the victim’s files and demands payment?"
"What type of malware logs keystrokes to steal sensitive information?"
"Which malware disguises itself as legitimate software but is malicious?"
"Which malware exploits vulnerabilities in software to infiltrate a system?"
)
options=(
"a) ls\nb) netstat\nc) pwd\nd) ifconfig"
"a) apt-get update\nb) apt-get upgrade\nc) apt-get install\nd) apt-get remove"
"a) cd\nb) ls\nc) pwd\nd) mv"
"a) rm\nb) mv\nc) cp\nd) mkdir"
"a) man\nb) help\nc) info\nd) guide"
"a) grep\nb) find\nc) locate\nd) search"
"a) ls\nb) pwd\nc) cd\nd) whoami"
"a) df\nb) du\nc) ls\nd) top"
"a) ps\nb) kill\nc) jobs\nd) monitor"
"a) rm\nb) mkdir\nc) touch\nd) rmdir"
"a) rm\nb) mv\nc) cp\nd) touch"
"a) ip\nb) ifconfig\nc) netstat\nd) route"
"a) cat\nb) more\nc) less\nd) head"
"a) mv\nb) cp\nc) touch\nd) ls"
"a) chmod\nb) chown\nc) chgrp\nd) chperm"
"a) wget\nb) curl\nc) ftp\nd) scp"
"a) date\nb) time\nc) cal\nd) now"
"a) env\nb) set\nc) printenv\nd) export"
"a) ping\nb) traceroute\nc) netstat\nd) ifconfig"
"a) kill\nb) stop\nc) terminate\nd) end"
"a) virus\nb) worm\nc) trojan\nd) spyware"
"a) ransomware\nb) adware\nc) spam\nd) rootkit"
"a) keylogger\nb) bot\nc) worm\nd) rootkit"
"a) malware\nb) trojan\nc) worm\nd) virus"
"a) exploit\nb) rootkit\nc) spyware\nd) ransomware"
)
answers=(
"b" "a" "a" "c" "a"
"a" "b" "b" "a" "b"
"a" "b" "a" "a" "a"
"a" "a" "c" "a" "a"
"b" "a" "a" "b" "a"
)

# Select random quiz
idx=$(( RANDOM % ${#questions[@]} ))
echo "Kali Linux Challenge:"
echo "${questions[$idx]}"
echo -e "${options[$idx]}"
read -p "Your answer (a/b/c/d): " user_answer

if [[ "${user_answer,,}" == "${answers[$idx]}" ]]; then
    echo "Correct! Power-ups granted:"
    while (( ${#active_powerups[@]} < max_powerups )); do
        pu="${powerup_pool[$RANDOM % ${#powerup_pool[@]}]}"
        if [[ ! " ${active_powerups[*]} " =~ " $pu " ]]; then
            active_powerups+=("$pu")
            echo "Power-up: $pu"
        fi
    done
    exit 0
else
    echo "Incorrect. The correct answer was: ${answers[$idx]}"
    exit 1
fi
