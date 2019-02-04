Class {
	#name : #PhaROS2NodeTest,
	#superclass : #TestCase,
	#instVars : [
		'nodeName',
		'namespace',
		'node',
		'emptyMsg'
	],
	#category : #'PhaROS2-Type-Test'
}

{ #category : #test }
PhaROS2NodeTest >> createNode [
	node := RCLC createNode: nodeName namespace: namespace.
]

{ #category : #test }
PhaROS2NodeTest >> deleteNode [
	node ifNotNil: [ node destroyMe ]
]

{ #category : #test }
PhaROS2NodeTest >> setUp [
	super setUp.
	nodeName := 'nodeTest'.
	namespace := '/nsTest'.
	
	RCLC initNoArgs.
	
	emptyMsg := RCLC getMessageEmptyTypeSupport.
]

{ #category : #test }
PhaROS2NodeTest >> testNodeCreationAndDelete [
	"Work perfectly if no other node is seen"
	|ret|
	
	ret := (PipeableOSProcess command: 'ros2 node list') output.
	
	self assert: ((ret findString: nodeName) = 0) equals: true.	"No NodeName before creation" 
	
	self createNode.
	
	ret := (PipeableOSProcess command: 'ros2 node list') output.
	self assert: ((ret findString: nodeName) = 0) equals: false. 
	
	self deleteNode.
	
	ret := (PipeableOSProcess command: 'ros2 node list') output.
	self assert: ((ret findString: nodeName) = 0) equals: true.	"No NodeName after delete" 
]

{ #category : #test }
PhaROS2NodeTest >> testPubisherCreationAndDelete [
	|pub ret|
	
	self createNode.
	
	ret := (PipeableOSProcess command: 'ros2 topic list') output.
	
	self assert: ((ret findString: 'publisherTest')=0) equals: true.
	
	pub := node createPublisher: 'publisherTest' queueSize: 10 messageType: emptyMsg.
	
	ret := (PipeableOSProcess command: 'ros2 topic list') output.
	
	self assert: ((ret findString: 'publisherTest')=0) equals: false.
	
	pub destroy.
	
	ret := (PipeableOSProcess command: 'ros2 topic list') output.
	
	self assert: ((ret findString: 'publisherTest')=0) equals: true.
	
	self deleteNode.
]

{ #category : #test }
PhaROS2NodeTest >> testSubscriberCreationAndDelete [
	|ret sub callback|
	
	callback := ROS2_Subscriber_callback on: [  ].
	
	self createNode.
	
	ret := (PipeableOSProcess command: 'ros2 topic list') output.
	
	self assert: ((ret findString: 'subscriberTest')=0) equals: true.
	
	sub := node createSubscriber: 'subscriberTest' queueSize: 10 messageType: emptyMsg callback: callback ignoreLocalPublication: true.
	
	
	ret := (PipeableOSProcess command: 'ros2 topic list') output.
	
	self assert: ((ret findString: 'subscriberTest')=0) equals: false.

	sub destroy.
	
	ret := (PipeableOSProcess command: 'ros2 topic list') output.
	
	self assert: ((ret findString: 'subscriberTest')=0) equals: true.
	

	self deleteNode.
]
