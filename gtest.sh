#!/bin/bash
#Ubuntu 16.04, user root
set -e -x
echo "deb http://ppa.launchpad.net/zhaofeng-shu33/gtest/ubuntu xenial main" > /etc/apt/sources.list.d/gtest.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B4552FED361B2FCCEAD7193C69FDF0C946D67581
apt update
apt install --yes g++ libgtest-dev cmake gdb

cat <<EOF >> gtest_example.cpp
#include <gtest/gtest.h>
TEST(MATH, ADD){
    EXPECT_EQ(1 + 3, 4);
}
EOF

g++ -lgtest_main -lgtest -lpthread gtest_example.cpp -o gtest_example

./gtest_example

cat <<EOF >> fixtures.cpp
#include <gtest/gtest.h>
class A : public testing::Test {
  protected:
    int a;
    void SetUp() override {
        a = 2;
    }
};
TEST_F(A, power) {
  EXPECT_EQ(a * a, 4);
}
EOF

g++ -std=c++11 -lgtest_main -lgtest -lpthread fixtures.cpp -o fixtures

./fixtures

cat <<EOF >> CMakeLists.txt
cmake_minimum_required(VERSION 3.5)
project(fixtures CXX)
set(CMAKE_CXX_STANDARD 11)
find_package(GTest REQUIRED)
add_executable(fixtures fixtures.cpp)
target_link_libraries(fixtures GTest::GTest GTest::Main)
EOF

mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=DEBUG ..
make
./fixtures

cat <<EOF >> .gdbinit
set trace-commands on
b 10
run
bt
p a
quit
EOF

echo "set auto-load safe-path /" > ~/.gdbinit

gdb --batch --args ./fixtures --gtest_filter=A.power