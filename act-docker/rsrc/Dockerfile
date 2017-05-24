FROM openjdk:8
RUN apt-get update && apt-get -y install maven && apt-get -y install unzip
ADD . /usr/local/act
RUN cd /usr/local/act/ && chmod 755 run && chmod 755 start && chmod 755 service.sh && chmod 755 service-runner.sh && chmod 755 service-installer.sh
CMD [""]
ENTRYPOINT ["/usr/local/act/service-installer.sh"]
