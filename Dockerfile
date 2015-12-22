FROM centos6

COPY ./skel /

RUN yum update
    
RUN chmod +x init.sh

CMD ["./init.sh"]
