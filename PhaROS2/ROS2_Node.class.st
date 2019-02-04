Class {
	#name : #'ROS2_Node',
	#superclass : #ROS2Handle,
	#instVars : [
		'thread',
		'spinThread'
	],
	#category : #'PhaROS2-Objects'
}

{ #category : #Factory }
ROS2_Node class >> new: aTopicName namespace: aNamespace [
	(RCLC status) ifFalse: [ RCLC initNoArgs. ].
	^RCLC createNode: aTopicName namespace: aNamespace 
]

{ #category : #'pubs_subs' }
ROS2_Node >> createPublisher: aName queueSize: anInt messageType: aMessageType [
	^self ffiCall: #(ROS2_Publisher rclc_create_publisher(self, ROS2_TypeSupport_struct aMessageType , char * aName, int anInt)).
]

{ #category : #'pubs_subs' }
ROS2_Node >> createSubscriber: aName queueSize: anInt messageType: aMessageType aCallbackBlock: aBlock [
	|callback|
	callback := ROS2_Callback on: aBlock.
	self createSubscriber: aName queueSize: anInt messageType: aMessageType callback: callback.
	^callback
]

{ #category : #'pubs_subs' }
ROS2_Node >> createSubscriber: aTopicName queueSize: anInt messageType: aMessageType callback: aROS2_subscriber_callback ignoreLocalPublication: aBoolean [
	^self ffiCall: #(ROS2_Subscriber * rclc_create_subscription(
  self,
  ROS2_TypeSupport_struct aMessageType,
  String aTopicName,
  ROS2_Subscriber_callback aROS2_subscriber_callback,
  int anInt,
  bool aBoolean))
]

{ #category : #spin }
ROS2_Node >> delayBetweenSpin [
	"The time between 2 spin"
	^10
]

{ #category : #'pubs_subs' }
ROS2_Node >> destroyMe [
	"Fonction tester et OK"
	^self ffiCall: #(int rclc_destroy_node(self))
]

{ #category : #spin }
ROS2_Node >> spinFunction [
	self spinMeTimeout: self spinTimeout.
	(Delay forMilliseconds: self delayBetweenSpin) wait.
]

{ #category : #'pubs_subs' }
ROS2_Node >> spinMeTimeout: anInteger [
	^self ffiCall: #(void rclc_spin_node_once(self, int anInteger))
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
