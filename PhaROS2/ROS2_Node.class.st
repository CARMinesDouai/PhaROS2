Class {
	#name : #'ROS2_Node',
	#superclass : #ROS2Handle,
	#category : #'PhaROS2-Objects'
}

{ #category : #'pubs_subs' }
ROS2_Node >> createPublisher: aName queueSize: anInt messageType: aMessageType [
	^self ffiCall: #(ROS2_Publisher rclc_create_publisher(self, ROS2_Message_type aMessageType , String aName, int anInt)).
]

{ #category : #'pubs_subs' }
ROS2_Node >> createSubscriber: aName queueSize: anInt messageType: aMessageType aCallbackBlock: aBlock [
	|callback|
	callback := ROS2_Callback on: aBlock.
	self createSubscriber: aName queueSize: anInt messageType: aMessageType callback: callback.
	^callback
]

{ #category : #'pubs_subs' }
ROS2_Node >> createSubscriber: aName queueSize: anInt messageType: aMessageType callback: aROS2_subscriber_callback [
	^self ffiCall: #(ROS2_Subscriber * rclc_create_subscription (
	self,
	ROS2_message_type type_support,
   String aName,
   ROS2_subscriber_callback aROS2_subscriber_callback,
   anInt,
   0))
]

{ #category : #'pubs_subs' }
ROS2_Node >> destroyMe [
	^self ffiCall: #(int rclc_destroy_node(self))
]

{ #category : #'pubs_subs' }
ROS2_Node >> spinMeTimeout: anInteger [
	^self ffiCall: #(void rclc_spin_node_once(self, anInteger))
]
