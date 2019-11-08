#!/bin/bash
#Ubuntu 16.04, user root
set -e -x
echo "deb http://ppa.launchpad.net/zhaofeng-shu33/gtest/ubuntu xenial main" > /etc/apt/sources.list.d/gtest.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B4552FED361B2FCCEAD7193C69FDF0C946D67581
apt update
apt install --yes g++ libgtest-dev

cat <<EOF >> gtest_example.cpp
#include <gtest/gtest.h>
TEST(MATH, ADD){
    EXPECT_EQ(1 + 3, 4);
}
EOF

g++ -lgtest_main -lgtest -lpthread gtest_example.cpp -o gtest_example

./gtest_example