# Jenkins Pipeline Base

## Introduction
This provides Docker image for a base Jenkins pipeline that can be used by  applications. This is derived from the official dockerfile/jenkins image with support for Java 8 applications. Install docker on the host and follow the instructions below to get a base pipeline started. You can fill in the dtails of what each job of the pipeline does according to your requirements.

## Quick Start
The following command should get you started pretty quickly. It has most of the pipeline steps covered and all you need to do is fill in the details.

```
docker run -p 8080:8080 vgadang/jenkins
```

## Persistent data
The above command will create transient data that will be cleaned up when the docker conatiner is stopped. It may be ok for testing, but not so great for a real environment. So you may want to mount the jenkins home to the hosts directory. The image defines the jenkins home directory as /var/jenkins_home

The following command will persist the data in the host.

```
docker run -d -p 8080:8080 -v /data/servers/jenkins/jenkins_home:/var/jenkins_home --name=jenkins vgadang/jenkins
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
To extend this image simply create another Docker image, build it and run it.

### Extend the image to install maven 
The image can easily be extended to include maven by creating your Dockerfile that looks like this. Build it and run the new image

```
FROM vgadang/jenkins

RUN apt-get update && apt-get install -y maven
```


### Add additional plugins
For example to add additional plugins, you can create a Dockerfile that has the following (assuming the plugins are in directory called 'plugins'). Build it and run the new image

```
FROM vgadang/jenkins

COPY plugins /usr/share/jenkins/ref/plugins
```

### Add additional jobs
To add additional plugins, you can create a Dockerfile that has the following (assuming the jobs are in directory called 'jobs'). Build it and run the new image

```
FROM vgadang/jenkins

COPY jobs /usr/share/jenkins/ref/jobs
```


