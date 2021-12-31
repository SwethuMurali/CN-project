BEGIN{
stime=0
ftime=0
flag=0
fsize=0
throuhput=0
latency=0
delay=0
receive=0
drop=0
total=0
rate=0
}
{
if ($1=="r" && $4==4)
{
receive++;
}
if ($1=="d")
{
drop++;
}
if ($1=="r" && $4==4)
{
fsize+=$6
if(flag==0)
{stime=$2
flag=1
}
ftime=$2
}
}
END{
latency=ftime-stime
throughput=(fsize*8)/latency
total=receive+drop
rate=(receive/total)*100
printf("Start time : %.2f \n", stime);
printf("Finish time : %.2f \n", ftime);
printf("Data : %.2f kb\n", fsize/1000);
printf("Delay : %.2f \n", latency);
printf("Throughput : %.2f kbps\n", throughput/1000);
printf("No. of Packets Received : %d \n", receive);
printf("No. of Packets dropped : %d \n", drop);
printf("Packet Delivery Rate : %.2f%%\n", rate);
printf("Packet Loss Rate : %.2f%%\n", (drop/total)*100);
}
