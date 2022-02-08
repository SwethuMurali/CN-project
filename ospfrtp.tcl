#Create a simulator object
set ns [new Simulator]
ns rtproto OSPF
#set val(rp)             OSPF

#Open trace file
set tr [open "OSPF.tr" w]
$ns trace-all $tr
#Open the nam trace file
set nf [open OSPF.nam w]
$ns namtrace-all $nf
set ft [open "OSPFthroughput" "w"]
set fb [open "OSPFbandwidth" "w"]
#Create the nodes
for {set i 0} {$i < 11} {incr i} {
 set n($i) [$ns node]
}
$n(0) color red

$n(6) color red

for {set j 1} {$j < 6} {incr j} {
$n($j) shape box
$n($j) color green
}
$n(7) color green
$n(8) color green
$n(9) color green
$n(10) color green

#Assigning address to the nodes
#$n(0) addr "fe80:0000:0000:0000:0204:61ff:fe9d:f10f"
#$n(1) addr "fe80:0000:0000:0000:0204:61ff:fe9d:f110"
#$n(2) addr "fe80:0000:0000:0000:0204:61ff:fe9d:f111"
#$n(3) addr "fe80:0000:0000:0000:0204:61ff:fe9d:f112"
#$n(4) addr "fe80:0000:0000:0000:0204:61ff:fe9d:f113"
#$n(5) addr "fe80:0000:0000:0000:0204:61ff:fe9d:f114"
#$n(6) addr "fe80:0000:0000:0000:0204:61ff:fe9d:f115"
#$n(7) addr "fe80:0000:0000:0000:0204:61ff:fe9d:f116"
#$n(8) addr "fe80:0000:0000:0000:0204:61ff:fe9d:f117"
#$n(9) addr "fe80:0000:0000:0000:0204:61ff:fe9d:f118"
#$n(10) addr "fe80:0000:0000:0000:0204:61ff:fe9d:f119"

#Create link between the nodes
$ns duplex-link $n(0) $n(1) 2Mb 15ms DropTail
$ns duplex-link $n(0) $n(3) 2Mb 15ms DropTail
$ns duplex-link $n(1) $n(2) 2Mb 15ms DropTail
$ns duplex-link $n(2) $n(7) 2Mb 15ms DropTail
$ns duplex-link $n(3) $n(4) 2Mb 15ms DropTail
$ns duplex-link $n(4) $n(5) 2Mb 15ms DropTail
$ns duplex-link $n(5) $n(6) 2Mb 15ms DropTail
$ns duplex-link $n(6) $n(7) 2Mb 15ms DropTail
$ns duplex-link $n(0) $n(8) 2Mb 15ms DropTail
$ns duplex-link $n(8) $n(9) 2Mb 15ms DropTail
$ns duplex-link $n(9) $n(10) 2Mb 15ms DropTail
$ns duplex-link $n(10) $n(7) 2Mb 15ms DropTail

#Orientation of nodes
$ns duplex-link-op $n(0) $n(1) orient right-down
$ns duplex-link-op $n(0) $n(3) orient up
$ns duplex-link-op $n(1) $n(2) orient right
$ns duplex-link-op $n(2) $n(7) orient right-up
$ns duplex-link-op $n(3) $n(4) orient right
$ns duplex-link-op $n(4) $n(5) orient right
$ns duplex-link-op $n(5) $n(6) orient right
$ns duplex-link-op $n(6) $n(7) orient right-down
$ns duplex-link-op $n(0) $n(8) orient right
$ns duplex-link-op $n(8) $n(9) orient right
$ns duplex-link-op $n(9) $n(10) orient right
$ns duplex-link-op $n(10) $n(7) orient right


$ns cost $n(0) $n(1)  1      
$ns cost $n(1) $n(0)  3
$ns cost $n(0) $n(3) 13
$ns cost $n(3) $n(0)  4
$ns cost $n(1) $n(2)  8
$ns cost $n(2) $n(1) 15
$ns cost $n(2) $n(7) 100
$ns cost $n(7) $n(2) 43
$ns cost $n(0) $n(8)  9       
$ns cost $n(8) $n(0)  3
$ns cost $n(3) $n(4) 12       
$ns cost $n(4) $n(3)  2
$ns cost $n(4) $n(5)  4      
$ns cost $n(5) $n(4)  9
$ns cost $n(5) $n(6)  1      
$ns cost $n(6) $n(5)  3
$ns cost $n(6) $n(7) 10       
$ns cost $n(7) $n(6)  5
$ns cost $n(8) $n(9) 10       
$ns cost $n(9) $n(8)  3
$ns cost $n(9) $n(10) 10       
$ns cost $n(10) $n(9)  3
set udp [new Agent/UDP]
$ns attach-agent $n(0) $udp
set null [new Agent/Null]
$ns attach-agent $n(6) $null
$ns connect $udp $null
set traffic_ftp2 [new Application/RTP]
$traffic_ftp2 attach-agent $udp
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 6500
$cbr0 set interval_ 0.06
$cbr0 attach-agent $tcp2
proc finish { } {
global ns nf ft fb 
$ns flush-trace
close $nf
close $ft
close $fb
exec xgraph OSPFbandwidth &
exec xgraph OSPFthroughput &
puts "running nam..."
exec nam OSPF.nam &
exit 0
}




proc next_ip {ip} {
for {set k 0} {$k < 11} {incr k} {
   set parts [split $ip :]

   set last_part 0x[lindex $parts end]
   set next [format %x [expr {$last_part + $k}]]
   lset parts end $next
   set next_ipv6 [join $parts ":"]
   global n
   $n($k) addr "$next_ipv6"
   puts "Address of node($k) is $next_ipv6"
}
}

next_ip fe80:0000:0000:0000:0204:61ff:fe9d:f10f




$ns at 0.5 "$traffic_ftp2 start"

$ns at 3.0 "$traffic_ftp2 start"
$ns at 4.0 "$traffic_ftp2 stop"
#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

#Run the simulation
$ns run



