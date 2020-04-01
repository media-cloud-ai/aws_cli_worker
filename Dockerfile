FROM mediacloudai/rs_command_line_worker:ubuntu-v0.1.2

ENV AMQP_QUEUE job_aws_cli

RUN apt-get update -y
RUN apt-get install -y curl unzip

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

CMD command_line_worker
