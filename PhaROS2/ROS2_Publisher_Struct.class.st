Class {
	#name : #'ROS2_Publisher_Struct',
	#superclass : #ROS2Handle,
	#instVars : [
		'parentNode',
		'topicName',
		'typeSupportName',
		'typeSupportStruct',
		'queueSize'
	],
	#category : #'PhaROS2-Struct'
}

{ #category : #publish }
ROS2_Publisher_Struct >> ffiDestroy [
	^self ffiCall: #(int rclc_destroy_publisher(self))
]

{ #category : #publish }
ROS2_Publisher_Struct >> publish: aMsg [
	^self ffiCall: #(int rclc_publish(self, void * aMsg))
]
