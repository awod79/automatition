# start_instances.sh

# export AWS_ACCESS_KEY="Your-Access-Key"
# export AWS_SECRET_KEY="Your-Secret-Key"

today=`date +"%d-%m-%Y","%T"`
logfile="/var/log/start-instances.log"

# Grab all Instance IDs for START action and export the IDs to a text file
aws ec2 describe-instances --filters Name=tag-key,Values=bash-start Name=tag-value,Values=02-00 Name=tag-value,Values=ad --query Reservations[*].Instances[*].[InstanceId] --output text > /tmp/start_ad_instance_info.txt

# Take list of starting instances
for instance_id in $(cat /tmp/start_ad_instance_info.txt)

do

# Start instances
startresult=$(aws ec2 start-instances --instance-ids $instance_id)

# Put info into log file
echo Started $today instances by AWS CLI with command $startresult >> $logfile
done