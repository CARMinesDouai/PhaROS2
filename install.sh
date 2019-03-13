#!/bin/bash

echo "------------------"
echo "-                -"
echo "- ROS2 & PhaROS2 -"
echo "-                -"
echo "------------------"

sudo apt update && sudo apt install curl gnupg2 lsb-release
curl http://repo.ros2.org/repos.key | sudo apt-key add -

sudo sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'

echo "deb http://packages.ros.org/ros/ubuntu bionic main" >> /etc/apt/source.list.d/ros-latest.list

sudo apt update

echo "---------------------------"
echo "-                         -"
echo "- Installing dependencies -"
echo "-                         -"
echo "---------------------------"

export ROS2_DISTRO=bouncy
export ROS1_DISTRO=melodic
sudo apt update && sudo apt upgrade -y
sudo apt install -y python3-argcomplete
sudo apt install -y python3-vcstools
sudo apt install -y python-vcstools
sudo apt install -y git
sudo apt install -y ros-$ROS2_DISTRO-desktop
sudo apt install -y ros-$ROS1_DISTRO-catkin
sudo apt install -y ros-$ROS1_DISTRO-kobuki-driver
sudo apt install -y ros-$ROS2_DISTRO-turtlebot2*
sudo apt install -y ros-$ROS1_DISTRO-kobuki-ftdi


mkdir -p ~/ros2_ws/src
mkdir -p ~/ros2_ws/git
cd ~/ros2_ws/git
git clone https://github.com/CARMinesDouai/PhaROS2.git
cd PhaROS2
mv ros2_src.zip ../../src/
cd ~/ros2_ws/src
unzip ros2_src.zip
rm -f ros2_src.zip

echo "------------------------"
echo "-                      -"
echo "- PhaROS2 installation -"
echo "-                      -"
echo "------------------------"

cd ~/ros2_ws/git/PhaROS2
mv PhaROS2-image.zip ~/
cd ~
unzip PhaROS2-image.zip
rm -f PhaROS2-image.zip
rm -rf ~/ros2_ws/git
cd PhaROS2

curl https://get.pharo.org/64/vm70 | bash 

echo
echo "-----------------------"
echo "-                     -"
echo "- Adding some scripts -"
echo "-                     -"
echo "-----------------------"

echo "alias ros2ify=\"export ROS_DOMAIN_ID=10;source /opt/ros/bouncy/setup.bash\"" >> .bashrc
echo "alias ros1ify=\"source /opt/ros/melodic/setup.bash\"" >> .bashrc

echo "alias pharos2=\"exec ~/bin/pharos2.sh\"" >> .bashrc

mkdir -p ~/bin

echo "ros2ify && ~/PhaROS2/pharo PaROS2.image" > ~/bin/pharos2.sh
chmod +x ~/bin/pharos2.sh

echo
echo
echo
echo
echo "Command added"
echo "You can run ros2ify to source your environment"
echo "You can run pharos2 to start a the PhaROS2 image"
