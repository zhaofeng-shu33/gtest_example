#!/bin/bash
#Ubuntu 16.04, user root
add-apt-repository ppa:zhaofeng-shu33/gtest
apt update
apt install g++ libgtest-dev

cat <<EOF >> gtest_example.cpp
#include <gtest/gtest.h>
TEST(MATH, ADD){
    EXPECT_EQ(1 + 3, 4);
}
EOF

g++ -lgtest_main -lgtest -lpthread gtest_example.cpp -o gtest_example

./gtest_example