enable
config t
line consol 0
no exec-ti
end
config t
int fa0/0
ip add 172.16.1.1 255.255.255.0
no shu
exit
int lo0
ip add 10.10.1.1 255.255.255.0
int lo1
ip add 10.10.2.1 255.255.255.0
end
wr me
config t
int fa1/0
ip add 10.10.20.254 255.255.255.0
no shu
end
