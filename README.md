# AWS Introduction

These were some resources used as part of a _very_ basic AWS introduction. The goals were to
introduce the console UI and some AWS services. A batch of IAM users are created for attendees.
There isn't really a _need_ for multiple IAM users but it felt like a good demonstration for Users,
Groups, and Policies. The really bad practice demonstrated is the public S3 bucket. The users are
given `s3:*Object*` in the bucket and then the bucket is publicly accessible. This was to let them
experience the console UI and also get real feedback from their actions.

## Deploying

Set up the AWS CLI using `aws configure` and set the `AWS_PROFILE` environment variable if
needed. Then run `deploy.sh` passing the desired IAM user password (same password is used for
all IAM users) and the desired S3 bucket name as arguments. For example, during the demo, the
following was used:

```
./deploy.sh DemoSamplePassword1 jmu-uug-demo
```

## Resources

The following resources are in this repository:

 - `basic.yaml`: The CloudFormation stack used to create the demo resources
 - `deploy.sh`: The deployment script
 - `hello.txt`: A sample file that gets uploaded to the S3 bucket
 - `AWS.md`: A `marp` presentation
 - `images/*` A set of images used in the presentation
