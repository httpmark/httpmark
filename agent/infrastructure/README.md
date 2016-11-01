# Infrastructure

Once code is merged into `master`, Circle CI manages deployment of infrastructure changes as well as building of the Docker image, as necessary.

Therefore, the steps below are only required when you're setting up the project for the first time, or in the case of ECR, manually pushing rebuilt images to the registry.

## Infrastructure Deployments

All infrastructure is described through Terraform, so you'll need to [install it](https://www.terraform.io/intro/getting-started/install.html) in the environment you're performing the deployment in.

### State Storage

[Terraform state](https://www.terraform.io/docs/state/) is currently only configured to be stored [remotely using an S3 bucket](https://www.terraform.io/docs/state/remote/s3.html). Therefore, an S3 bucket needs to be manually setup, before attempting an infrastructure deployment for the first time.

### Deployments
You must ensure the following environment variables are set.

* `AWS_ACCESS_KEY_ID`: AWS access key ID
* `AWS_SECRET_ACCESS_KEY`: AWS secret access key
* `TERRAFORM_STATE_S3_BUCKET_NAME`: The name of the S3 bucket you've previously created.
* `TERRAFORM_STATE_S3_BUCKET_KEY`: The path in the bucket in which Terraform should look for the remote state file
* `AWS_REGION`: Use `eu-west-1` for the time being.
* `PUBLIC_KEY_PATH`: The local path to the public key you wish to associate to the ECS Container Instance. E.g `~/.ssh/webapptest_rsa.pub`

```bash
cd infrastructure

# View execution plan
bin/infrastructure.sh -t plan -e $ENVIRONMENT

# Apply execution plan
bin/infrastructure.sh -t apply -e $ENVIRONMENT # Where $ENVIRONMENT describes the context of the deployment. For example `development`, `production`, etc.
```

### Building And Uploading The Docker Image To ECR

Even though you'll now have all the necessary infrastructure provisioned, you'll still be unable to run the container from the AWS, since no Docker image will exist in the ECR registry.

The following steps will walk you through how to do that.

## Container Creation And Docker Image Building

### Building the Docker image
```bash
docker build -t webapptest_test-agent .
```

### Running a container based off the image
```bash
docker run -it -e TEST_ENDPOINT='http://www.example.com' $IMAGE_ID

# Where $IMAGE_ID is the ID of the Docker image you've just built.
```

Running the above command will return a real-time stream of asset loading to stdout from the headless Chrome instance inside the container. It's not very impressive right now, but it will be very soon!

### Pushing The Docker Image To ECR
```bash
bin/deploy-image.sh
```
