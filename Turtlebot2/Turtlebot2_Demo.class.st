Class {
	#name : #'Turtlebot2_Demo',
	#superclass : #Object,
	#instVars : [
		'node',
		'msgForJoy',
		'msgForKobuki',
		'inputTopic',
		'outputTopic',
		'pub',
		'sub',
		'thread',
		'leftTrigger',
		'rightTrigger',
		'leftJoystick',
		'accel',
		'rot'
	],
	#category : #Turtlebot2
}

{ #category : #'as yet unclassified' }
Turtlebot2_Demo >> asInteger [
	^1
]

{ #category : #compute }
Turtlebot2_Demo >> computeMove: data [
	leftTrigger := RCLC getAxesAt: 5 rosMsg: data.
	rightTrigger := RCLC getAxesAt: 2 rosMsg: data.
	leftJoystick := RCLC getAxesAt: 0 rosMsg: data.
	
	leftTrigger := leftTrigger - 1.
	rightTrigger := rightTrigger - 1.
	
	leftTrigger := leftTrigger abs / 2.0.
	rightTrigger := rightTrigger abs / 2.0 .
	
	accel := leftTrigger - rightTrigger.
	rot := leftJoystick * 5.0.
	
	Transcript clear.
	Transcript crShow: 'Left Trigger: '; show: leftTrigger.
	Transcript crShow: 'Right Trigger: '; show: rightTrigger.
	Transcript crShow: 'Left Joystick: '; show: leftJoystick.
	Transcript crShow: 'Accel: ';show: accel.
	Transcript crShow: 'Rot: ';show: rot.
]

{ #category : #initialization }
Turtlebot2_Demo >> createNode [
	node := ROS2_Node new.
	node namespace: '/phaROS2'.
	node nodeName: 'Turtlebot2_PhaROS2'.
	node registerNode .
	
]

{ #category : #initialization }
Turtlebot2_Demo >> createPublisher [
	pub := ROS2_Publisher new.
	pub topicName: '/cmd_vel'.
	pub parentNode: node.
	PhaROS2TypeBrowser instance need: msgForKobuki.
	pub typeSupportName: msgForKobuki.
	pub queueSize: 10.
	pub registerPublisher.
]

{ #category : #initialization }
Turtlebot2_Demo >> createSubscriber [
	| callbackBlock |
	sub := ROS2_Subscriber new.
	sub topicName: '/joy'.
	sub parentNode: node.
	PhaROS2TypeBrowser instance need: msgForJoy.
	sub typeSupportName: msgForJoy.
	sub queueSize: 10.
	sub ignoreLocalPublication: true.
	callbackBlock := [ :data | self computeMove: data].
	sub callback: callbackBlock.
	sub registerSub.
]

{ #category : #compute }
Turtlebot2_Demo >> defaultMove [
	|msg|
	msg := RCLC getCmdVelLx: 0.5 ly: 0.0 lz: 0.0 ax: 0.0 ay: 0.0 az: 1.0.
	
	pub publish: msg.
]

{ #category : #initialization }
Turtlebot2_Demo >> initialize [
	super initialize.
	msgForJoy :=  'sensor_msgs/Joy'.
	msgForKobuki := 'geometry_msgs/Twist'.
	
	inputTopic := '/joy'.
	outputTopic := '/cmdVel'.
	
	self createNode.
	
	(node) ifNotNil: [ 
		self createPublisher.
		self createSubscriber 
		 ]
	ifNil: [ self error: 'Node not create' ].
]

{ #category : #compute }
Turtlebot2_Demo >> sendMoveLx: lx ly: ly lz: lz ax: ax ay: ay az: az [
	|msg|
	msg := RCLC getCmdVelLx: lx ly: ly lz: lz ax: ax ay: ay az: az.
	
	pub publish: msg.
]

{ #category : #initialization }
Turtlebot2_Demo >> spinNode [
	node spinFunction.
]

{ #category : #initialization }
Turtlebot2_Demo >> startAutoSpin [
	thread := [ 
		[ node ] whileNotNil: [ 
				self spinNode.
				self sendMoveLx: accel ly: 0.0 lz: 0.0 ax: 0.0 ay: 0.0 az: rot.
				(Delay forMilliseconds: 1) wait.
			 ]
		 ] fork.
]

{ #category : #initialization }
Turtlebot2_Demo >> stop [ 	
	(node) ifNotNil: [ 
		node destroyNode.
		node := nil.
	]
]

{ #category : #initialization }
Turtlebot2_Demo >> stopAutoSpin [
	(thread) ifNotNil: [ 
			thread terminate.
			thread := nil.
		 ]
]
