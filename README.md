# AWS CLI WORKER

This worker is architectured to be integrated into the Media Cloud AI plateform. For more information, you can check the documentation [here](https://media-cloud.ai/).

This worker is used to send command to aws using aws client ([version 2](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-using.html)).
It will connect to RabbitMQ and wait for a message which tell it what to do.

## Requirements

The following tool must be installed on your computer:

* Docker version 19.03.5+

## Makefile 

### Targets

Commands below will be used for both stacks (backend & workers):

| Command                      | Description                                              |
|------------------------------|----------------------------------------------------------|
| `make docker-build`          | Build locally a docker image                             |
| `make docker-clean`          | Remove locally the built docker image                    |
| `make docker-push-registry`  | Push the locally built docker image                      |
| `make docker-registry-login` | Allow to log user on docker registry                     |

### Variables

| Variable name           | Default value               | Description                                                  |
|-------------------------|-----------------------------|--------------------------------------------------------------|
| `DOCKER_IMG_NAME`       | mediacloudai/aws_cli_worker | Docker image name.                                           |
| `DOCKER_REGISTRY`       |                             | Docker registry.                                             |
| `DOCKER_REGISTRY_LOGIN` |                             | User name used to connect to the docker registry.            |
| `DOCKER_REGISTRY_PWD`   |                             | Password used to connect to the docker registry.             |

## Docker

The command `make docker-build` will build an image named `mediacloudai/aws_cli_worker:1.0.0`.

The command `make docker-push-registry` will push the built image in the official docker registry (note: the login to the docker registry must eventually by done before).


Example:
```
# Login to the docker registry
make docker-registry-login DOCKER_REGISTRY_LOGIN=mylogin DOCKER_REGISTRY_PWD=mypassword

# Push the built image to the docker registry
make docker-push-registry
```

## Gitlab

If you use gitlab, a `.gitlab-ci.yml` file is provided. This file define a pipeline which needs the two environment variables `DOCKER_REGISTRY_LOGIN` and `DOCKER_REGISTRY_PWD` to be defined in your repository to works.

## Environment variables

All variables allowing to describe the AMQP connection will be find in the rs_amqp_worker which can be found [here](https://github.com/media-cloud-ai/rs_amqp_worker).

| Variable name           | Default value              | Description                                   |
|-------------------------|----------------------------|-----------------------------------------------|
| `AWS_SECRET_ACCESS_KEY` |                            | AWS access key used by the aws client.        |
| `AWS_ACCESS_KEY_ID`     |                            | AWS access secret key used by the aws client. |

## Message format

The aws cli worker will accept a message matching to the following example:

```json
{
  "parameters": [
    {
      "value": "aws2 s3 cp s3://mybucket/{element_filename} /data/element_filename.mp4",
      "type": "string",
      "id": "command_template"
    },
    {
      "value": "media.mp4",
      "type": "string",
      "id": "element_filename"
    }
  ],
  "job_id": 123
}
```

This message tells the worker to copy the `media.mp4` (available in the AWS S3 bucket `mybucket`) into the directory `/data` with the target name `element_filename.mp4`.