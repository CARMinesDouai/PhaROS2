# PhaROS2

## Installation
### ROS2 Installation
To install ROS2 on your Ubuntu follow [this link](https://index.ros.org/doc/ros2/Installation/Linux-Install-Debians/).

You can find the installation for turtlebot2 with ROS2 at [this link](https://github.com/ros2/turtlebot2_demo)

*Note: All of my devellopement was done on Ubuntu 18.04.1 LTS with ROS2 Bouncy*

### Creation of new Pharo Image
Just use PharoLauncher follow [this link](https://pharo.org/download).

### Start a PhaROS2 Image
Pharo Image should be run in ROS2 environment.

To improve the simplicity, I've write a Shell-Script to run your PhaROS2 Image in ROS2 environment. To use this script, name the image in PharoLauncher: `PhaROS2`

```shell
#!/bin/bash
export ROS_DOMAIN_ID=10
source /opt/ros/bouncy/setup.bash

cd ~/Pharo/vms/70-x64/
./pharo ../../images/PhaROS2/PhaROS2

echo
echo
echo
echo '--------------------------'
echo '--        PhaRO2        --'
echo '-- Press enter to quit  --'
echo '--------------------------'
read
```

*Note: ROS_DOMAIN_ID permit to split the network in 256 (0->255) ROS2 domain. Each sub-domain is independant.*

###Dependicie in Pharo
You need to use some depencie to use PhaROS2. We need to install `OSProcess` and `CommandShell` to execute PhaROS2 correctly.


```smalltalk
 Gofer new
	squeaksource: 'OSProcess';
	package: 'OSProcess';
	load. 

 Gofer new
	squeaksource: 'CommandShell';
	package: 'CommandShell-Piping';
	load.
```

### Import in new Pharo Image
With `Iceberg` import PhaROS2 project host on GitHub: `https://github.com/CARMinesDouai/PhaROS2.git` and load `PhaROS2` package

To ensure everything work correctly, try to run the `Test cases`.

## Utilisation of PhaROS2
ROS2 like ROS1 is based on `type` so you need to create type before using it on PhaROS2

This is the way you have to get the correct structure. All subsctructure will be create, and a dictionary is used to optimize the creation.

The `PharROS2TypeBrowser` is a singleton.


```smalltalk
PhaROS2TypeBrowser instance ros2Type: 'geometry_msgs/Twist'.
PhaROS2TypeBrowser instance ros2Type: 'geometry_msgs/TwistWithCovarianceStamped'.
PhaROS2TypeBrowser instance ros2Type: 'std_msgs/String'.
```

All of your type is a subclass of `PhaROS2_Type`.

If you want to reset the `PhaROS2TypeBrowser`, you can execute the following code. They will delete all `PhaROS2_type` and ` ROS2TypeSupport_struct` subclasses and the dictionary will be erase.

```smalltalk
PhaROS2TypeBrowser reset.
```

*Note: The subclasses of ROS2_TypeSupport_struct is not for users. Users only use PhaROS2_Type subclasses*


