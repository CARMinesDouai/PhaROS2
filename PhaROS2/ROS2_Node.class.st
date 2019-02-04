Class {
	#name : #'ROS2_Node',
	#superclass : #ROS2Handle,
	#instVars : [
		'thread'
	],
	#category : #'PhaROS2-Objects'
}

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

{ #category : #'pubs_subs' }
ROS2_Node >> destroyMe [
	"Fonction tester et OK"
	^self ffiCall: #(int rclc_destroy_node(self))
]

{ #category : #'pubs_subs' }
ROS2_Node >> spinMeTimeout: anInteger [
	^self ffiCall: #(void rclc_spin_node_once(self, int anInteger))
]
