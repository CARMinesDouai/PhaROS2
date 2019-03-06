Class {
	#name : #Listener,
	#superclass : #Object,
	#instVars : [
		'node',
		'sub',
		'myThread',
		'active'
	],
	#category : #ROS2MyExperiment
}

{ #category : #initialization }
Listener >> createNode [
	node := ROS2_Node new.
	node namespace: '/namespace'.
	node nodeName: 'myTalker'.
	node registerNode.
]

{ #category : #initialization }
Listener >> createSubscriber [
	| callbackBlock |
	sub := ROS2_Subscriber new.
	sub topicName: '/chatter'.
	sub parentNode: node.
	sub typeSupportName: 'std_msgs/String'.
	sub queueSize: 10.
	sub ignoreLocalPublication: true.
	callbackBlock := [ :data | self myCallback: data].
	sub callback: callbackBlock.
	sub registerSub.
]

{ #category : #initialization }
Listener >> destroyNode [
	(node) ifNotNil: [ 
		node destroyNode.
	]
]

{ #category : #initialization }
Listener >> initialize [
	super initialize.
	self createNode.
	self createSubscriber.
]

{ #category : #callback }
Listener >> myCallback: data [
	| toPrint |
	toPrint := data data.
	self halt.
	Transcript crShow: toPrint.
]

{ #category : #initialization }
Listener >> start [
	node startSpin.
]

{ #category : #initialization }
Listener >> stop [
	node stopSpin .
]
