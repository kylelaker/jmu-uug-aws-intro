#!/usr/bin/env bash

STACK_NAME="${STACK_NAME:-Demo-Basic-Resources}"

create_stack() {
    aws cloudformation create-stack \
        --stack-name "$STACK_NAME" \
        --capabilities CAPABILITY_NAMED_IAM \
        --parameters \
            ParameterKey=DefaultPassword,ParameterValue="$1" \
            ParameterKey=BucketName,ParameterValue="$2" \
        --template-body file://basic.yaml
}

upload_file() {
    aws s3 cp hello.txt s3://"$1"/hello.txt
}

main() {
    if [ -z "$AWS_PROFILE" ]; then
        echo "!!! No value set for AWS_PROFILE -- ensure the default profile is desired"
    fi
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "!!! Make sure a valid default password and S3 bucket name are given"
        exit 1
    fi
    create_stack "$1" "$2"
    echo "==> Waiting for the stack creation to complete"
    aws cloudformation wait stack-create-complete --stack-name "STACK_NAME"
    stack_creation="$?"
    if [ "$stack_creation" -ne 0 ]; then
        echo "!!! Stack creation may have failed. Delete the stack and try again."
    else
        upload_file "$2"
    fi
}

main "$@"
