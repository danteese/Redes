Referencias:
http://gns3-tutorials.blogspot.mx/2015/01/router-basic-command-and-static-route.html
http://commonerrors.blogspot.mx/2015/08/cisco-basic-commands-for-beginners.html
http://commonerrors.blogspot.mx/2014/11/configure-vpcs-ip-address-and-gateway.html
https://docs.gns3.com/1vFs-KENh2uUFfb47Q2oeSersmEK4WahzWX-HrMIMd00/index.html
https://www.youtube.com/watch?v=M_Rzir9PnUk&list=WL&index=9
https://www.youtube.com/watch?v=PY4A08s4ii4&index=10&list=WL
https://www.youtube.com/watch?v=xtHtEgVGLSU
Simple Screen Recorder

Configurar router para conexión con nube por UDP-tunnel:
Router
---512MiB
---512 kiB
Nube
---UDP tunnel 1
--- Local port 20000
---Remote host 192.168.127.102
---Remote port 30000
#enable
#config t
#line console 0
#no exec-timeout
#do wr
#end
#show ip int b
#config t
#interface f0/0
#ip address 172.16.1.2 255.255.255.0
#no shutdown
#end
#show ip int b
#ping 172.16.1.1

Configurar NAT en el router:
config t
ip domain-lookup
interface f1/0
ip address 10.10.10.254 255.255.255.0
no shut
exit
interface f0/0
ip nat outside
exit
interface f1/0
ip nat inside
exit
access-list 1 permit 10.10.10.0 0.0.0.255
ip nat inside source list 1 interface f0/0 overload
ip dhcp pool internal-client
nertwork 10.10.10.254 255.255.255.0
default-router 10.10.10.254
end

*********
config t
ip route 10.10.20.0 255.255.255.0 172.16.1.1
end
show ip route
*********

Configurar dirección IP (estática) de los nodos:
#clear ip
#ip 10.10.10.5 /24 10.10.10.254
#show ip
#save

Configurar nombre y dirección IP del router:
#enable
#configure terminal
#hostname Cisco3725
#end
#config t
#interface f0/1
#ip address 10.10.10.254 255.255.255.0
#no shutdown
#exit
#end
#show ip interface brief
#copy running-config startup-config

Configurar servidor DHCP:
#config t
#interface f0/1
#ip address 10.10.10.254 255.255.255.0
#no shutdown
#exit
#service dhcp
#ip dhcp pool DHCPsrvr
#network 10.10.10.0 255.255.255.0
#default-router 10.10.10.254
#dns-server 8.8.8.8 8.8.4.4
#lease 21 0 0
#exit
#ip dhcp excluded-address 10.10.10.1 10.10.10.5
#exit
#show ip int b
#show ip dhcp binding
#show ip dhcp pool

Configurar dirección DHCP en las computadoras:
#ip dhcp
#show ip

Configurar servidor DNS en un router:
#config t
#ip domain lookup
#ip host PC-1 10.10.10.6
#exit
#ping PC-1

Configurar SSH en el router:
#config t
#ip domain-name SSHup1
#crypto key generate rsa
#username Router1 password r123
#line vty 0 4
#transport input ssh
#login local
#C^z

Conectar entre uno o más routers con SSH:
#ssh -l Router1 10.10.10.254
>exit


***********
Nube
Configurar --> UDP tunels --> Remote host, IP de la otra
Otra topologia, --> UDP tunels --> puertos se intercambias
Router
Configurar looop back
line console 0
no exec-timeout
Agregar tablas de enrutamiento
