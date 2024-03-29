FROM jkarkoszka/azure-terratest-runner:latest

ARG ARM_CLIENT_ID
ARG ARM_CLIENT_SECRET
ARG ARM_TENANT_ID
ARG ARM_SUBSCRIPTION_ID

ENV ARM_CLIENT_ID $ARM_CLIENT_ID
ENV ARM_CLIENT_SECRET $ARM_CLIENT_SECRET
ENV ARM_TENANT_ID $ARM_TENANT_ID
ENV ARM_SUBSCRIPTION_ID $ARM_SUBSCRIPTION_ID

COPY . /terraform-modules

WORKDIR /terraform-modules/test

RUN az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID

CMD go test -v -timeout 60m
