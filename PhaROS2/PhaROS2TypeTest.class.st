Class {
	#name : #PhaROS2TypeTest,
	#superclass : #TestCase,
	#instVars : [
		'nodeName',
		'namespace',
		'topicName',
		'node',
		'msgType',
		'callback',
		'subscriber',
		'subsName',
		'pubName',
		'publisher'
	],
	#category : #'PhaROS2-Type-Test'
}

{ #category : #ROS2 }
PhaROS2TypeTest >> callback: receivedData [
	self subclassResponsibility 
]

{ #category : #ROS2 }
PhaROS2TypeTest >> msgClass [
	self subclassResponsibility 
]

{ #category : #test }
PhaROS2TypeTest >> setUp [
	super setUp.
	nodeName := 'nodeName'.
	namespace := '/ns'.
	topicName := 'topic'.
	subsName := topicName,'subs'.
	pubName := topicName,'pub'.
	
	RCLC initNoArgs.
	node := RCLC createNode: nodeName namespace: namespace.
	
	msgType := self msgClass.
	
	callback := ROS2_Subscriber_callback on: [ :receivedData | self callback: (PhaROS2_Type  fromHandle: receivedData)].
	
	subscriber := node createSubscriber: subsName queueSize: 10 messageType: msgType callback: callback ignoreLocalPublication: true.
	publisher := node createPublisher: pubName queueSize: 10 messageType: msgType.
]

{ #category : #test }
PhaROS2TypeTest >> tearDown [ 
	super tearDown.
	
	subscriber destroy.
	publisher destroy.
	
	node destroyMe.
]

{ #category : #test }
PhaROS2TypeTest >> testPublishData [
	self subclassResponsibility 
]

{ #category : #test }
PhaROS2TypeTest >> testSubscribeData [
	self subclassResponsibility.
]
