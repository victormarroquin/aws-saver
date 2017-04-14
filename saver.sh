#!/bin/bash
key="0"
for i in "${@:2}"; do
        if [ "$key" -eq 0 ]; then
                texto="$texto Name=tag:$i"; key=1;
        else
                texto="$texto,Values=$i"; key=0
        fi
done
echo $texto
ids=$(/usr/local/bin/aws --region us-east-1 ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,Tags[].Value[]]' --filters $texto | jq -r ".[][][0]")
if [ "$1" == "list" ]; then
        echo -e "Collected Ids:\n\n${ids}"
echo -e "\nDone!"

elif [ "$1" = "stop" ]; then
        /usr/local/bin/aws --region us-east-1 ec2 --instance-ids stop-instances ${ids}
echo -e "\nDone!"

elif [ "$1" = "start" ]; then
        /usr/local/bin/aws --region us-east-1 ec2 --instance-ids start-instances ${ids}
echo -e "\nDone!"

else
        echo -e "Run the command like the following example: \e[1;31NNameTag ValueTag Action (start, stop, list)\e[0m"
fi
