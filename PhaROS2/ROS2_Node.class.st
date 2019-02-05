Class {
	#name : #'ROS2_Node',
	#superclass : #ROS2Handle,
	#instVars : [
		'thread',
		'spinThread',
		'subcriber',
		'publisher'
	],
	#category : #'PhaROS2-Objects'
}

{ #category : #Factory }
ROS2_Node class >> new: aTopicName namespace: aNamespace [
	(RCLC status) ifFalse: [ RCLC initNoArgs. ].
	^RCLC createNode: aTopicName namespace: aNamespace 
]

{ #category : #pubs }
ROS2_Node >> createPublisher: aPublisher [
	
]

{ #category : #subs }
ROS2_Node >> createSubcriber: aSubscriber [
	
]

{ #category : #subs }
ROS2_Node >> createSubscriber: aName queueSize: anInt messageType: aMessageType aCallbackBlock: aBlock [
	|callback|
	callback := ROS2_Callback on: aBlock.
	self ffiCreateSubscriber: aName queueSize: anInt messageType: aMessageType callback: callback.
	^callback
]

{ #category : #spin }
ROS2_Node >> delayBetweenSpin [
	"The time between 2 spin"
	^10
]

{ #category : #initialization }
ROS2_Node >> destroyNode [
	publisher do: [ :aPub | aPub destroyPub. ].
	subcriber do: [ :aSub | aSub destroySub. ].
	
	spinThread ifNotNil: [ spinThread terminate ].
	
	self ffiDestroyNode.
]

{ #category : #uffi }
ROS2_Node >> ffiCreatePublisher: aName queueSize: anInt messageType: aMessageType [
	^self ffiCall: #(ROS2_Publisher rclc_create_publisher(self, ROS2_TypeSupport_struct aMessageType , char * aName, int anInt)).
]

{ #category : #uffi }
ROS2_Node >> ffiCreateSubscriber: aTopicName queueSize: anInt messageType: aMessageType callback: aROS2_subscriber_callback ignoreLocalPublication: aBoolean [
	^self ffiCall: #(ROS2_Subscriber * rclc_create_subscription(
  self,
  ROS2_TypeSupport_struct aMessageType,
  String aTopicName,
  ROS2_Subscriber_callback aROS2_subscriber_callback,
  int anInt,
  bool aBoolean))
]

{ #category : #uffi }
ROS2_Node >> ffiDestroyNode [
	"Fonction tester et OK"
	^self ffiCall: #(int rclc_destroy_node(self))
]

{ #category : #uffi }
ROS2_Node >> ffiSpinMeTimeout: anInteger [
	^self ffiCall: #(void rclc_spin_node_once(self, int anInteger))
]

{ #category : #initialization }
ROS2_Node >> initialize [
	super initialize.
	
	publisher := OrderedCollection new.
	subcriber := OrderedCollection new.
]

{ #category : #naming }
ROS2_Node >> namespace [
	self subclassResponsibility
]

{ #category : #naming }
ROS2_Node >> nodeName [
	self subclassResponsibility
]

{ #category : #uffi }
ROS2_Node >> registerNode [
	| vHandle |
	vHandle := (RCLC createNode: self nodeName namespace: self namespace).
	self handle: vHandle.
]

{ #category : #spin }
ROS2_Node >> spinFunction [
	self ffiSpinMeTimeout: self spinTimeout.
	(Delay forMilliseconds: self delayBetweenSpin) wait.
]

{ #category : #spin }
ROS2_Node >> spinTimeout [
	"Timeout for each spin in milliseconds"
	^200
]

{ #category : #spin }
ROS2_Node >> startSpin [
	"Start the spining thread"
	(spinThread) ifNil: [ 
		spinThread := [ self spinFunction ] fork.
	]
]

{ #category : #spin }
ROS2_Node >> stopSpin [
	"Stop the spinning thread"
	(spinThread) ifNotNil: [ 
		spinThread terminate.
		spinThread := nil.
	]
]
