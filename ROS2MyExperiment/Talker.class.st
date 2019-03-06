Class {
	#name : #Talker,
	#superclass : #Object,
	#instVars : [
		'node',
		'pub',
		'myThread',
		'active'
	],
	#category : #ROS2MyExperiment
}

{ #category : #initialization }
Talker >> createNode [
	node := ROS2_Node new.
	node namespace: '/namespace'.
	node nodeName: 'myTalker'.
	node registerNode.
]

{ #category : #initialization }
Talker >> createPublisher [
	pub := ROS2_Publisher new.
	pub topicName: 'talker'.
	pub parentNode: node.
	PhaROS2TypeBrowser instance need: 'std_msgs/String'.
	pub typeSupportName: 'std_msgs/String'.
	pub queueSize: 10.
	pub registerPublisher.
]

{ #category : #initialization }
Talker >> destroyNode [
	(node) ifNotNil: [ 
		node destroyNode.
	]
]

{ #category : #initialization }
Talker >> initialize [
	super initialize.
	self createNode.
	self createPublisher.
]

{ #category : #initialization }
Talker >> loopFunction [
	| toPublish allocatedString |
	[ active ] whileTrue: [ 
		toPublish := PhaROS_Msgs typeSupport: 'std_msgs/String'.
		allocatedString := PhaROS2_allocation stringToPointer: 'Hello World With phaROS2'.
		"toPublish rosidl_message_type_support data: allocatedString."
		pub publish: toPublish .
	(Delay forMilliseconds: 1000) wait.
	 ]
]

{ #category : #initialization }
Talker >> start [
	active := true.
	myThread := [ self loopFunction. ] fork.
]

{ #category : #initialization }
Talker >> stop [
	active := false.
	(myThread) ifNotNil: [myThread terminate].
]
