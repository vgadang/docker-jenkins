# Jenkins Pipeline Base

## Introduction
This provides Docker image for a base Jenkins pipeline that can be used by  applications. This is derived from the official dockerfile/jenkins image with suuport for java 8 applications. Install docker on the host and follow the instructions below to get a base pipeline started. You can fill in the dtails of what each job of the pipeline does according to your requirements.

## Quick Start
The following command should get you started pretty quickly. It has most of the pipeline steps covered and all you need to do is fill in the details.

```
docker run -p 8080:8080 docker.obi.aol.com/jenkins
```

## Persistent data
The above command will create transient data that will be cleaned up when the docker conatiner is stopped. It may be ok for testing, but not so great for a real environment. So you may want to mount the jenkins home to the hosts directory. The image defines the jenkins home directory as /var/jenkins_home

The following command will persist the data in the host.

```
docker run -d -p 8080:8080 -v /data/servers/jenkins/jenkins_home:/var/jenkins_home --name=jenkins docker.obi.aol.com/jenkins
```

## Plugins
The image comes with the following plugins installed.

* Build Pipeline
* Build Name Setter
* Clone workspace SCM
* Copy Artifact
* Email Extension
* GIT plugin
* Gradle plugin 
* Parametrized Trigger plugin
* PMD
* Performance plugin

## Jenkins setup information

* Jenkins home location - /var/jenkins_home
* Container Port - 8080
* Slave agent port - 50000

## Extending this image
To extend this image simply create anothe Docker image from this and copy your plugins and jobs into /usr/share/jenkins/ref location inside the container.

* plugins - /usr/share/jenkins/ref/plugins
* jobs - /usr/share/jenkins/ref/jobs

