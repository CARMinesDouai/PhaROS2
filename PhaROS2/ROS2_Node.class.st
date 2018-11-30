Class {
	#name : #'ROS2_Node',
	#superclass : #ROS2Handle,
	#category : #'PhaROS2-Objects'
}

{ #category : #'pubs_subs' }
ROS2_Node >> createPublisher: aName queueSize: anInt [
	^self ffiCall: #(ROS2_Publisher rclc_create_publisher(self,  , String aName, int anInt)).
]

{ #category : #'pubs_subs' }
ROS2_Node >> createPublisher: aName queueSize: anInt messageType: aMessageType [
	^self ffiCall: #(ROS2_Publisher rclc_create_publisher(self, aMessageType , String aName, int anInt)).
]
