FROM centos6

COPY ./skel /

RUN yum install -y httpd

RUN yum update -y
    
RUN chmod +x init.sh

CMD ["./init.sh"]
