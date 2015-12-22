# nginx-container-test
Nginx Sample Container #2

You will need 2 execute build steps in Jenkins:

git clone https://github.com/dnowell/nginx-container-test.git
echo ${BUILD_NUMBER} > nginx-jenkins-marathon-test/skel/build
docker build -t docker-pilot.dsc.umich.edu:31111/nginx-container-test nginx-container-test/
docker tag docker-pilot.dsc.umich.edu:31111/nginx-container-test docker-pilot.dsc.umich.edu:31111/nginx-container-test:${BUILD_NUMBER}
docker push docker-pilot.dsc.umich.edu:31111/nginx-container-test

sed -i -e "s|docker-pilot.dsc.umich.edu:31111/nginx-container-test:latest|docker-pilot.dsc.umich.edu:31111/nginx-container-test:$BUILD_NUMBER|g" \
    nginx-container-test/nginx-container-test.host.marathon.local.json
curl -X PUT -H "Accept: application/json" -H "Content-Type: application/json" \
http://docker-pilot.dsc.umich.edu:8080/v2/apps/nginx-container-test -d @nginx-container-test/nginx-container-test.host.marathon.local.json
