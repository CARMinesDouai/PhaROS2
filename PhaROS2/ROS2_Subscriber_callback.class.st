Class {
	#name : #'ROS2_Subscriber_callback',
	#superclass : #'ROS2_Callback',
	#category : #'PhaROS2-Struct'
}

{ #category : #native }
ROS2_Subscriber_callback class >> mySignature [
	^#(void *(void * data))
]
