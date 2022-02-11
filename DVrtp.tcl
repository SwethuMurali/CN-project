#Create a simulator object
set ns [new Simulator]
ns rtproto DV
#set val(rp)             DV

#Open trace file
set tr [open "rip.tr" w]
$ns trace-all $tr
#Open the nam trace file
set nf [open rip.nam w]
$ns namtrace-all $nf
set ft [open "dvthroughput" "w"]
set fb [open "dvbandwidth" "w"]
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



set udp [new Agent/RTP]
$ns attach-agent $n(0) $udp
set null [new Agent/Null]
$ns attach-agent $n(6) $null
$ns connect $udp $null
set traffic_ftp2 [new Application/FTP]
$traffic_ftp2 attach-agent $udp
proc finish { } {
global ns nf ft fb 
$ns flush-trace
close $nf
close $ft
close $fb
exec xgraph dvbandwidth &
exec xgraph dvthroughput &
puts "running nam..."
exec nam rip.nam &
exit 0
}







$ns at 0.5 "$traffic_ftp2 start"
$ns at 3.0 "$traffic_ftp2 start"

$ns at 4.0 "$traffic_ftp2 stop"
#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

#Run the simulation
$ns run

