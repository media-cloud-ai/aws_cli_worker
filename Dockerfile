FROM mediacloudai/rs_command_line_worker:0.2.0-ubuntu

ENV AMQP_QUEUE job_aws_cli

RUN apt-get update -y
RUN apt-get install -y curl unzip

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

