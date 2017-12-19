FROM joshmahowald/cloud-workstation AS baseworkstation

FROM ruby:alpine
ENV SOURCE_ROOT /opt/projsource/


RUN chmod 755 /usr/local/bin/* 

RUN gem install awspec

RUN apk --no-cache add bash ca-certificates openssl && update-ca-certificates
COPY --from=baseworkstation /usr/local/bin/* /usr/local/bin/


# For ostensible caching purposes
COPY --from=baseworkstation /root/.terraformrc /root/.terraformrc
COPY --from=baseworkstation /root/.terraform.d /root/.terraform.d
COPY spec/ruby_path_loader.sh /etc/profile.d/
RUN cat /etc/profile.d/ruby_path_loader.sh >> /root/.profile

COPY spec $SOURCE_ROOT/spec

ONBUILD COPY terraform $SOURCE_ROOT/terraform
ONBUILD COPY spec $SOURCE_ROOT/spec
WORKDIR /workspace

ENTRYPOINT ["/bin/bash", "-l"]
#CMD ["-c", "rake spec"]