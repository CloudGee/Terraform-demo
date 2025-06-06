// a script to read input from command line and set aws ak/sk to environment variables
#!/bin/bash
# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <AWS_ACCESS_KEY_ID> <AWS_SECRET_ACCESS_KEY>"
    exit 1
fi
# Set the AWS access key and secret access key as environment variables
export AWS_ACCESS_KEY_ID="$1"
export AWS_SECRET_ACCESS_KEY="$2"
# Print a message indicating that the environment variables have been set
echo "AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY have been set."