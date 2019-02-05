Class {
	#name : #'ROS2_Subscriber',
	#superclass : #ROS2Handle,
	#instVars : [
		'parentNode',
		'topicName',
		'callback'
	],
	#category : #'PhaROS2-Objects'
}

{ #category : #initialization }
ROS2_Subscriber >> destroySub [
	self ffiDestroy 
]

{ #category : #native }
ROS2_Subscriber >> ffiDestroy [ 
	^self ffiCall: #(int rclc_destroy_subscription(self))
]

{ #category : #initialization }
ROS2_Subscriber >> initialize [
	super initialize
]
