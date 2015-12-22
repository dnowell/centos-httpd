# centos-httpd
Testing centos & httpd

You will need 2 execute build steps in Jenkins:

git clone https://github.com/dnowell/centos-httpd.git
echo ${BUILD_NUMBER} > nginx-jenkins-marathon-test/skel/build
docker build -t docker-pilot.dsc.umich.edu:31111/centos-httpd centos-httpd/
docker tag docker-pilot.dsc.umich.edu:31111/centos-httpd docker-pilot.dsc.umich.edu:31111/centos-httpd:${BUILD_NUMBER}
docker push docker-pilot.dsc.umich.edu:31111/centos-httpd

sed -i -e "s|docker-pilot.dsc.umich.edu:31111/centos-httpd:latest|docker-pilot.dsc.umich.edu:31111/centos-httpd:$BUILD_NUMBER|g" \
    centos-httpd/centos-httpd.marathon.json
curl -X PUT -H "Accept: application/json" -H "Content-Type: application/json" \
http://docker-pilot.dsc.umich.edu:8080/v2/apps/centos-httpd -d @centos-httpd/centos-httpd.marathon.json
