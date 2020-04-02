#!/bin/bash

if [ ! -z ${AWS_PROFILES_CREDENTIALS} ]; then
	profiles=`echo ${AWS_PROFILES_CREDENTIALS} | tr "#" "\n"`
	for profile in ${profiles}
	do
		profile_data=($(echo ${profile} | tr ";" "\n"))
		profile_name=${profile_data[0]}
		profile_access_key=${profile_data[1]}
		profile_secret_access_key=${profile_data[2]}
		profile_region=${profile_data[3]}

		echo "Setting profile: ${profile_name}"

		aws configure set aws_access_key_id ${profile_access_key}  --profile ${profile_name}
		aws configure set aws_secret_access_key ${profile_secret_access_key}  --profile ${profile_name}
		aws configure set default.region ${profile_region}  --profile ${profile_name}
	done
fi

command_line_worker
