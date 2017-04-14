# aws-saver
A simple bash script to start and stop instances using tags, schedulable via cron to automate the start/stop process

## Features:

- Save money on aws stoping your non production instances.
- Check it if the selected instances are running or not.

## Limitations:

Limited to run on linux, tested on ubuntu only.

## Prerequisites:

- Have an IAM user limited to start and stop instances only. If you don't have it:

  * [Create AIM user](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)

  * [Create a new policy](#steps-to-create-a-new-policy)
  
  * Attach the policiy to your user.

 ####Steps to create a new policy

Go to AWS Management Console > IAM > Policies > Create new policy > Create yout own police.

Set a name, description and in Policy Document paste the following with your region and your AWS account ID:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1459458248000",
            "Effect": "Allow",
            "Action": [
                "ec2:StartInstances",
                "ec2:StopInstances"
            ],
            "Condition": {
                "StringNotEquals": {
                    "ec2:ResourceTag/Environment": "Production"
                }
            },
            "Resource": [
                "arn:aws:ec2:us-east-1:{your_account_id}:instance/*"
            ]
        }
    ]
}
```

In my case I have a condition to use the all **"Environment"** tags except **"Production"** to protect my production's instances. You can obviate the condition statement.


- Have installed the aws command line (CLI). If you don't have it go to [Installing the AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)

- Have taged the desired instances with a specific tag or multiple tags.

## Usage:

To use in the easy way you can place the bash on usr/local/bin.

if you prefer use other location, you can add on /etc/environment/ file on PATH variable the custom location.

saver.sh {tag_name} {tag_value} {tag_name} {tag_value} ... list | status | start | stop.

#### list

Display the instances with the specified tag.

#### status

Display the status (stop or running) of the instances with the specified tag.

#### start

Start (power on) the instances matching with ths specified tag.

#### stop

Stop (power off) the instances matching with ths specified tag.

## Using cron

In order to automate the process you could use cron.
```
50 3 * * * {saver_path}/saver.sh {tag_name} {tag_value} {tag_name} {tag_value} ... {action}
```
Example:
```
50 3 * * * /opt/tools/aws-saver/saver.sh Saver Enable Environment Development stop
0 12 * * * /opt/tools/aws-saver/saver.sh Saver Enable Product Biller start
```
