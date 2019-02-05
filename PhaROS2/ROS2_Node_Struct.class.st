Class {
	#name : #'ROS2_Node_Struct',
	#superclass : #ROS2Handle,
	#category : #'PhaROS2-Struct'
}

{ #category : #Factory }
ROS2_Node_Struct class >> new: aTopicName namespace: aNamespace [
	(RCLC status) ifFalse: [ RCLC initNoArgs. ].
	^RCLC createNode: aTopicName namespace: aNamespace 
]

{ #category : #uffi }
ROS2_Node_Struct >> ffiCreatePublisher: aName queueSize: anInt messageType: aMessageType [
	^self ffiCall: #(#ROS2_Publisher_Struct rclc_create_publisher(self, #aMessageType class name aMessageType , char * aName, int anInt)).
]

{ #category : #uffi }
ROS2_Node_Struct >> ffiCreateSubscriber: aTopicName queueSize: anInt messageType: aMessageType callback: aROS2_subscriber_callback ignoreLocalPublication: aBoolean [
	^self ffiCall: #(#ROS2_Subscriber_Struct * rclc_create_subscription(
  self,
  ROS2_TypeSupport_struct aMessageType,
  String aTopicName,
  ROS2_Subscriber_callback aROS2_subscriber_callback,
  int anInt,
  bool aBoolean))
]

{ #category : #uffi }
ROS2_Node_Struct >> ffiDestroyNode [
	"Fonction tester et OK"
	^self ffiCall: #(int rclc_destroy_node(self)).
]

{ #category : #uffi }
ROS2_Node_Struct >> ffiSpinMeTimeout: anInteger [
	^self ffiCall: #(void rclc_spin_node_once(self, int anInteger))
]
