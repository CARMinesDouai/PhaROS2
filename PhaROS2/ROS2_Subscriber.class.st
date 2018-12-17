Class {
	#name : #'ROS2_Subscriber',
	#superclass : #ROS2Handle,
	#category : #'PhaROS2-Objects'
}

{ #category : #native }
ROS2_Subscriber >> destroy [ 
	^self ffiCall: #(int rclc_destroy_subscription(self))
]
