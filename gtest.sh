#!/bin/bash
#Ubuntu 16.04, user with sudo privilege
sudo add-apt-repository ppa:zhaofeng-shu33/gtest
sudo apt update
sudo apt install libgtest-dev

cat <<EOF >> gtest_example.cpp
#include <gtest/gtest.h>
TEST(MATH, ADD){
    EXPECT_EQ(1 + 3, 4);
}
EOF

g++ -lgtest_main -lgtest -lpthread gtest_example.cpp -o gtest_example

./gtest_example