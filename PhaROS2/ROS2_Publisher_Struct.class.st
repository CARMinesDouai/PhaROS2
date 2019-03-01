Class {
	#name : #'ROS2_Publisher_Struct',
	#superclass : #ROS2Handle,
	#category : #'PhaROS2-Struct'
}

{ #category : #publish }
ROS2_Publisher_Struct >> ffiDestroy [
	^self ffiCall: #(int rclc_destroy_publisher(self))
]

{ #category : #publish }
ROS2_Publisher_Struct >> publish: aMsg [
	aMsg inspect.
	^self ffiCall: #(int rclc_publish(self, void * aMsg))
]
