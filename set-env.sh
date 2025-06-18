# set-env.sh
# a script to read input from command line and set aws ak/sk/role to a profile, then use that profile

#!/bin/bash

# Unset all AWS_* environment variables
for var in $(env | grep '^AWS_' | awk -F= '{print $1}'); do
    unset $var
done

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <AWS_ACCESS_KEY_ID> <AWS_SECRET_ACCESS_KEY> <AWS_ROLE_ARN>"
    exit 0
fi

AWS_ACCESS_KEY_ID="$1"
AWS_SECRET_ACCESS_KEY="$2"
AWS_ROLE_ARN="$3"
BASE_PROFILE="base_profile"
ASSUME_PROFILE="assume_role_profile"

# Configure the base profile using awscli
aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" --profile "$BASE_PROFILE"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" --profile "$BASE_PROFILE"

# Write role_arn and source_profile to ~/.aws/config
aws configure set region us-west-2 --profile "$ASSUME_PROFILE"
aws configure set role_arn "$AWS_ROLE_ARN" --profile "$ASSUME_PROFILE"
aws configure set source_profile "$BASE_PROFILE" --profile "$ASSUME_PROFILE"

# Set AWS_PROFILE environment variable
export AWS_PROFILE="$ASSUME_PROFILE"

echo "AWS profile '$ASSUME_PROFILE' with role_arn has been configured and is now active."

export TF_DATA_DIR="$(pwd)/.terraform"
export TF_PLUGIN_CACHE_DIR="$(pwd)/.terraform.d/plugin-cache"
echo "Terraform data directory set to: $TF_DATA_DIR $TF_PLUGIN_CACHE_DIR"