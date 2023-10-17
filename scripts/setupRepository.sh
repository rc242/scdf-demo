#!/bin/zsh
projDir=`dirname $0`/..
password=`cat ${projDir}/docker/nexus.admin.password`
newPassword=${1:=myNexusPassword}
serverStatusCode=`curl --write-out "%{http_code}\n" --silent --output /dev/null "http://localhost:8081/service/rest/v1/status/writable"`

while [[ $serverStatusCode != "200" ]] ; do
  echo "Waiting for Nexus to return read/writable status"
  sleep 30
  serverStatusCode=`curl --write-out "%{http_code}\n" --silent --output /dev/null "http://localhost:8081/service/rest/v1/status/writable"`
done

echo "Changing password to $newPassword"
curl -X PUT http://localhost:8081/service/rest/v1/security/users/admin/change-password -H 'Content-Type: text/plain' -d ${newPassword} -u admin:${password}

password=$newPassword

repoStatusCode=`curl --write-out "%{http_code}\n" --silent --output /dev/null -X GET "http://localhost:8081/service/rest/v1/repositories/maven/hosted/example" -u admin:${password}`
if [[ $repoStatusCode == "200" ]] ; then
  echo "Repo alreaady created"
else
  echo "Trying to create the example repo"
  while [[ $repoStatusCode != "200" ]] ; do 
    curl -X post http:/localhost:8081/service/rest/v1/repositories/maven/hosted -d '
    {
      "name": "example",
      "online": true,
      "storage": {
        "blobStoreName": "default",
        "strictContentTypeValidation": true,
        "writePolicy": "allow_once"
      },
      "cleanup": {
        "policyNames": [
          "string"
        ]
      },
      "component": {
        "proprietaryComponents": true
      },
      "maven": {
        "versionPolicy": "MIXED",
        "layoutPolicy": "STRICT",
        "contentDisposition": "ATTACHMENT"
      }
    }' -H 'Content-Type: application/json' -u admin:${password}
    repoStatusCode=`curl --write-out "%{http_code}\n" --silent --output /dev/null -X GET "http://localhost:8081/service/rest/v1/repositories/maven/hosted/example" -u admin:${password}`
  done
  echo "Repo created"
fi
cd ${projDir}/demo
./gradlew clean publish
