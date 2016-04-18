#!/bin/bash
ids=$(/usr/local/bin/aws --region us-east-1 ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,Tags[?Key==`'$1'`].Value[]]' | grep -B 2 $2 | grep "\"i-" | cut -d "\"" -f 2 | sed -e 's/,//g')
if [ "$3" == "list" ]; then
        echo -e "Collected Ids:\n\n${ids}"
echo -e "\nDone!"

elif [ "$3" == "status" ]; then
    echo "Collecting $2 Instance IDs"
        /usr/local/bin/aws --region us-east-1 ec2 describe-instances --query 'Reservations[*].Instances[*].[Tags[?Key==`'$1'`].Value[],State.Name,InstanceId,Tags[?Key==`Name`].Value[]]' --output text | grep -A 2 $2 | sed -e 's/'$2'//g'
echo -e "\nDone!"

elif [ "$3" == "stop" ]; then
        /usr/local/bin/aws --region us-east-1 ec2 --instance-ids stop-instances ${ids}
echo -e "\nDone!"

elif [ "$3" == "start" ]; then
        /usr/local/bin/aws --region us-east-1 ec2 --instance-ids start-instances ${ids}
echo -e "\nDone!"

else
        echo -e "Run the command like the following example: \e[1;31msaver Enable start\e[0m"
fi
