FROM mediacloudai/rs_command_line_worker:ubuntu-v0.1.3

ENV AMQP_QUEUE job_transfer

RUN apt-get update -y
RUN apt-get install -y curl unzip

RUN curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

CMD command_line_worker
