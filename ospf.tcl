#Create a simulator object
set ns [new Simulator]
$ns rtproto OSPF
#set val(rp)             OSPF

$ns color 1 Red
$ns color 2 Blue
$ns color 3 Indigo

#Open trace file
set tr [open "ospfipv6.tr" w]
$ns trace-all $tr
#Open the nam trace file
set nf [open ospfipv6.nam w]
$ns namtrace-all $nf
set f1t [open "sender1_throughput" "w"]
set f2t [open "sender2_throughput" "w"]
set f3t [open "sender3_throughput" "w"]
set ftt [open "TotalThroughput" "w"]

set f1b [open "Bandwidth1" "w"]
set f2b [open "Bandwidth2" "w"]
set f3b [open "Bandwidth3" "w"]
set ftb [open "TotalBandwidth" "w"]
#Create the nodes
for {set i 0} {$i < 20} {incr i} {
 set n($i) [$ns node]
}
$n(0) color red
$n(1) color green
$n(2) color green
$n(3) color blue
$n(4) color green
$n(5) color indigo
$n(6) color green
$n(7) color green
$n(8) color green
$n(9) color green
$n(10) color green
$n(11) color blue
$n(12) color green
$n(13) color green
$n(14) color indigo
$n(15) color red
$n(16) color green
$n(17) color green
$n(18) color green
$n(19) color green




#Create link between the nodes
$ns duplex-link $n(0) $n(1) 20Mb 10ms DropTail
$ns duplex-link $n(0) $n(2) 100Mb 2ms DropTail
$ns duplex-link $n(0) $n(3) 30Mb 4ms DropTail
$ns duplex-link $n(0) $n(4) 10Mb 4ms DropTail
$ns duplex-link $n(4) $n(7) 10Mb 4ms DropTail
$ns duplex-link $n(2) $n(7) 45Mb 5ms DropTail
$ns duplex-link $n(2) $n(18) 4Mb 5ms DropTail
$ns duplex-link $n(3) $n(4) 29Mb 15ms DropTail
$ns duplex-link $n(4) $n(5) 4Mb 9ms DropTail
$ns duplex-link $n(5) $n(6) 30Mb 5ms DropTail
$ns duplex-link $n(6) $n(7) 80Mb 13ms DropTail
$ns duplex-link $n(6) $n(8) 2Mb 15ms DropTail
$ns duplex-link $n(8) $n(9) 14Mb 8ms DropTail
$ns duplex-link $n(9) $n(10) 2Mb 9ms DropTail
$ns duplex-link $n(10) $n(11) 24Mb 15ms DropTail
$ns duplex-link $n(11) $n(12) 5Mb 4ms DropTail
$ns duplex-link $n(12) $n(13) 63Mb 2ms DropTail
$ns duplex-link $n(7) $n(14) 2Mb 1ms DropTail
$ns duplex-link $n(13) $n(14) 42Mb 12ms DropTail
$ns duplex-link $n(14) $n(15) 2Mb 9ms DropTail
$ns duplex-link $n(15) $n(16) 35Mb 7ms DropTail
$ns duplex-link $n(16) $n(17) 2Mb 5ms DropTail
$ns duplex-link $n(17) $n(18) 79Mb 5ms DropTail
$ns duplex-link $n(18) $n(19) 2Mb 10ms DropTail


#Orientation of nodes
$ns duplex-link-op $n(0) $n(1) orient left-down
$ns duplex-link-op $n(0) $n(3) orient right-up
$ns duplex-link-op $n(0) $n(2) orient down
$ns duplex-link-op $n(0) $n(4) orient right
$ns duplex-link-op $n(2) $n(7) orient right-down
$ns duplex-link-op $n(2) $n(18) orient left-down
$ns duplex-link-op $n(3) $n(4) orient right
$ns duplex-link-op $n(4) $n(5) orient right
$ns duplex-link-op $n(4) $n(7) orient right-down
$ns duplex-link-op $n(5) $n(6) orient right
$ns duplex-link-op $n(6) $n(7) orient down
$ns duplex-link-op $n(6) $n(8) orient right-down
$ns duplex-link-op $n(8) $n(9) orient right
$ns duplex-link-op $n(9) $n(10) orient right
$ns duplex-link-op $n(10) $n(11) orient left-down
$ns duplex-link-op $n(11) $n(12) orient left
$ns duplex-link-op $n(12) $n(13) orient left
$ns duplex-link-op $n(13) $n(14) orient left-down
$ns duplex-link-op $n(7) $n(14) orient left-down
$ns duplex-link-op $n(14) $n(15) orient left
$ns duplex-link-op $n(15) $n(16) orient left-down
$ns duplex-link-op $n(16) $n(17) orient left-up
$ns duplex-link-op $n(17) $n(18) orient up
$ns duplex-link-op $n(18) $n(19) orient left


$ns cost $n(0) $n(1)  1      
$ns cost $n(1) $n(0)  3
$ns cost $n(0) $n(3) 13
$ns cost $n(3) $n(0)  4
$ns cost $n(0) $n(2)  8
$ns cost $n(2) $n(0) 15
$ns cost $n(0) $n(4) 100
$ns cost $n(4) $n(0) 43
$ns cost $n(2) $n(7)  9       
$ns cost $n(7) $n(2)  3
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
$ns cost $n(9) $n(10) 20       
$ns cost $n(10) $n(9)  5
$ns cost $n(10) $n(11) 9
$ns cost $n(11) $n(10) 19
$ns cost $n(11) $n(12) 7
$ns cost $n(12) $n(11) 6
$ns cost $n(12) $n(13) 9
$ns cost $n(13) $n(12) 2
$ns cost $n(13) $n(14) 12
$ns cost $n(14) $n(13) 10
$ns cost $n(7) $n(14) 24
$ns cost $n(14) $n(7) 2
$ns cost $n(14) $n(15) 9
$ns cost $n(15) $n(14) 6
$ns cost $n(15) $n(16) 5
$ns cost $n(16) $n(15) 9
$ns cost $n(16) $n(17) 11
$ns cost $n(17) $n(16) 34
$ns cost $n(17) $n(18) 13
$ns cost $n(18) $n(17) 9
$ns cost $n(18) $n(19) 17
$ns cost $n(19) $n(18) 4



set tcp2 [new Agent/TCP]
$tcp2 set class_ 1
$ns attach-agent $n(0) $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n(15) $sink2
$ns connect $tcp2 $sink2

set udp0 [new Agent/UDP]
$udp0 set class_ 2
$ns attach-agent $n(3) $udp0
set null0 [new Agent/LossMonitor]
$ns attach-agent $n(11) $null0
$ns connect $udp0 $null0

set udp1 [new Agent/UDP]
$udp1 set class_ 3
$ns attach-agent $n(5) $udp1
set null1 [new Agent/LossMonitor]
$ns attach-agent $n(14) $null1
$ns connect $udp1 $null1

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 6500
$cbr0 set interval_ 0.06
$cbr0 attach-agent $udp0

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 2700
$cbr1 set interval_ 0.08
$cbr1 attach-agent $udp1


proc finish { } {
global ns nf f1t f2t  f3t ftt f1b f2b f3b ftb tr
$ns flush-trace
close $nf
close $f1t
close $f2t
close $f3t
close $ftt
close $f1b
close $f2b
close $f3b
close $ftb
close $tr
exec xgraph sender1_throughput &
exec xgraph sender2_throughput &
exec xgraph sender3_throughput &
exec xgraph Totalthroughput &
exec xgraph Bandwidth1 &
exec xgraph Bandwidth2 &
exec xgraph Bandwidth3 &
exec xgraph TotalBandwidth &
puts "running nam..."
exec nam ospfipv6.nam &
exit 0
}


proc record {} {
global sink2 null0 null1 f1t f2t f3t ftt f1b f2b f3b ftb
global ftp cbr0 cbr1
set ns [Simulator instance]

set time 0.1
set now [$ns now]
set bw0 [$sink2 set bytes_]
set bw1 [$null0 set bytes_]
set bw2 [$null1 set bytes_]

set totbw [expr $bw0 + $bw1 + $bw2]
puts $ftt "$now [expr $totbw/$time*8/1000000]"

puts $f1t "$now [expr $bw0/$time*8/1000000]"
puts $f2t "$now [expr $bw1/$time*8/1000000]"
puts $f3t "$now [expr $bw2/$time*8/1000000]"

puts $f1b "$now [expr $bw0]"
puts $f2b "$now [expr $bw1]"
puts $f3b "$now [expr $bw2]"
puts $ftb "$now [expr $totbw]"
$sink2 set bytes_ 0
$null0 set bytes_ 0
$null1 set bytes_ 0
$ns at [expr $now+$time] "record"
}





$ns at 0.55 "record"
$ns at 0.5 "$n(0) color \"red\""
$ns at 0.5 "$n(15) color \"red\""
$ns at 0.5 "$ftp2 start"
$ns at 0.5 "$ns trace-annotate \"Starting FTP0 node0 to node15\""
$ns at 1.9 "$n(3) color \"blue\""
$ns at 1.9 "$n(11) color \"blue\""
$ns at 1.9 "$ns trace-annotate \"Starting CBR0 node3 to node11\""
$ns at 1.9 "$cbr0 start"
$ns at 2.6 "$n(5) color \"indigo\""
$ns at 2.6 "$n(14) color \"indigo\""
$ns at 2.6 "$ns trace-annotate \"Starting CBR1 node5 to node14\""
$ns at 2.6 "$cbr1 start"

$ns rtmodel-at 1.5 down $n(2) $n(0)
$ns at 1.5 "$ns trace-annotate \"Simulating Link Failure at node2 to node0\""
$ns at 2.7 "$ns trace-annotate \"Link Active at node2 to node0\""
$ns rtmodel-at 2.7 up $n(2) $n(0)

$ns rtmodel-at 2.5 down $n(8) $n(9)
$ns at 2.5 "$ns trace-annotate \"Simulating Link Failure at node8 to node9\""
$ns at 3.9 "$ns trace-annotate \"Link Active at node8 to node9\""
$ns rtmodel-at 3.5 up $n(8) $n(9)
$ns at 10.0 "$ftp2 stop"
$ns at 10.2 "$cbr0 stop"
$ns at 10.4 "$cbr1 stop"

#Call the finish procedure after 5 seconds of simulation time
$ns at 30.0 "finish"

#Run the simulation
$ns run
