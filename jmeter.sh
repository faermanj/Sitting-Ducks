#!/bin/bash

rm -rf target/jmeter
mkdir -p target/jmeter
date
jmeter -n -t load_testing_101.jmx -l target/jmeter/results -e -o target/jmeter/out
