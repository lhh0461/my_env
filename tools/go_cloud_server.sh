#!/usr/bin/expect
spawn ssh q6@test-q6.chinacloudapp.cn
expect "*assword*"
send "q6@175game\r"
interact
