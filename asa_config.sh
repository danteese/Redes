# ASA ROUTER
config t
# interface 0/0 - OUTSIDE
interface e0/0
nameif outside
security-level 0
ip address 10.10.40.254 255.255.255.0
no su
exit
# interface 1/0 - INSIDE
interface e1/0
security-level 100
ip address 10.10.20.254 255.255.255.0
no su
exit
# interface DMZ
interface e2/0
nameif dmz
security-level 50
ip address 10.10.30.254 255.255.255.0
no su
exit
# Configurar ruta por default de salida
route outside 0.0.0.0 0.0.0.0 10.10.40.254
# Configurar NAT de salida para LAN
object network inside-subnet
subnet 10.10.20.0 255.255.255.0
nat (inside,outside) dynamic interface
exit
# Configurar NAT de salida para servidores
object newtork dmz-subnet
subnet 10.10.40.0 255.255.255.0
nat (dmz,outside) synamic interface

# DHCP
int e1/0
ip add 10.10.20.254 255.255.255.0
no su
exit
service DHCP
ip DHCP pool DHCP-POOL-20
network 10.10.20.0 255.255.255.0
default-router 10.10.20.254
dns-server 8.8.8.8
lease 2 0 0
exit
ip DHCP excluded-address 10.10.20.1 10.10.20.5
exit
show ip dhcp binding
show ip dchp pool
exit
# Configuracion de listas de acceso
access-list 101 permit ip any any
access-list 102 permit tcp any any
access-list 103 permit icmp any any
show access-list
end
show ip interface brief
copy running-config startup-config
