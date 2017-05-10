#!/bin/bash

#This is one of the bash script which provides solution for voice alerting during low battery.
#This script will be running in background and whenever battery will be below 40% then a voice 
#alert will be triggered in every 15 minutes.Once battery reaches to 10% then voice alert will 
#be triggered in every 2 minutes.

while [ true ]; do
        #to check the status of battery (charging or discharging)
       	status=`upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage" |grep state: | awk '{print $2 }'`
	
	#to check the percentage of charged battery
        charge=`upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage" |grep percentage | awk '{print $2 }'`
        len=${#charge}
        count=${charge:0:len-1}

	#loop to play audio files according to condition of battery
        while [ $status == "discharging" ]; do
	
            #condition of voice alert between 10 to 40 percentage of battery  
            if [ $count -ge 10 -a $count -lt 40 ]; then

              #playing audio1.txt file
              espeak -f audio1.txt

              #to create 15 minutes interval in each alert
              sleep 720
	    
            #condition of voice alert below 10 percentage of battery		
	    elif [ $count -lt 10 ]; then
	      
              #playing audio2.txt file
              espeak -f audio2.txt
		  
              #to create 2 minutes interval in each alert
               sleep 120
	    fi
	   
	   
            #updating battery status again for next loop
            status=`upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage" |grep state: | awk '{print $2 }'`
            #updating battery percentage again for next loop
            charge=`upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage" |grep percentage | awk '{print $2 }'`
            num=${#charge}
            count=${charge:0:num-1}
	done
done
