#!/bin/sh

# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_171.jdk/Contents/Home

# https://www.scala-sbt.org/1.0/docs/Installing-sbt-on-Linux.html
# curl https://bintray.com/sbt/rpm/rpm | sudo tee /etc/yum.repos.d/bintray-sbt-rpm.repo
# sudo yum install java-1.8.0-openjdk-devel sbt

sbt gatling:test