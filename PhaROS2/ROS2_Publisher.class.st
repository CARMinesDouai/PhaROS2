Class {
	#name : #'ROS2_Publisher',
	#superclass : #ROS2Handle,
	#category : #'PhaROS2-Objects'
}

{ #category : #publish }
ROS2_Publisher >> destroy [
	^self ffiCall: #(int rclc_destroy_publisher(self))
]

{ #category : #publish }
ROS2_Publisher >> publish: aMsg [
	^self ffiCall: #(int rclc_publish(self, void * aMsg))
]
