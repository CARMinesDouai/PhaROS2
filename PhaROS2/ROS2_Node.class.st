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
ROS2_Node >> destroyMe [
	^self ffiCall: #(int rclc_destroy_node(self))
]

{ #category : #'pubs_subs' }
ROS2_Node >> spinMeTimeout: anInteger [
	^self ffiCall: #(void rclc_spin_node_once(self, anInteger))
]
