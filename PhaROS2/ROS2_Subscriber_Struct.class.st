Class {
	#name : #'ROS2_Subscriber_Struct',
	#superclass : #ROS2Handle,
	#instVars : [
		'parentNode',
		'topicName',
		'callback',
		'typeSupportName',
		'typeSupportStruct',
		'queueSize'
	],
	#category : #'PhaROS2-Struct'
}

{ #category : #accessing }
ROS2_Subscriber_Struct >> callback [
	^ callback
]

{ #category : #accessing }
ROS2_Subscriber_Struct >> callback: aROS2_Subscriber_Callback [
	callback := aROS2_Subscriber_Callback
]

{ #category : #initialization }
ROS2_Subscriber_Struct >> destroySub [
	self ffiDestroy 
]

{ #category : #native }
ROS2_Subscriber_Struct >> ffiDestroy [ 
	^self ffiCall: #(int rclc_destroy_subscription(self))
]

{ #category : #initialization }
ROS2_Subscriber_Struct >> initialize [
	super initialize
]

{ #category : #accessing }
ROS2_Subscriber_Struct >> parentNode [
	^ parentNode
]

{ #category : #accessing }
ROS2_Subscriber_Struct >> parentNode: anObject [
	parentNode := anObject
]

{ #category : #accessing }
ROS2_Subscriber_Struct >> queueSize [
	^ queueSize
]

{ #category : #accessing }
ROS2_Subscriber_Struct >> queueSize: anObject [
	queueSize := anObject
]

{ #category : #accessing }
ROS2_Subscriber_Struct >> topicName [
	^ topicName
]

{ #category : #accessing }
ROS2_Subscriber_Struct >> topicName: anObject [
	topicName := anObject
]

{ #category : #accessing }
ROS2_Subscriber_Struct >> typeSupportName [
	^ typeSupportName
]

{ #category : #accessing }
ROS2_Subscriber_Struct >> typeSupportName: anTypeSupportName [
		"
	All type support is accesible with 'ros2 msg show ' command
	Example of type support Name:
		- std_msgs/String
		- geometry_msgs/Twist
	"
	
	typeSupportName := anTypeSupportName.
	typeSupportStruct := PhaROS2TypeBrowser instance need: typeSupportName getStruct.
]

{ #category : #accessing }
ROS2_Subscriber_Struct >> typeSupportStruct [
	^ typeSupportStruct
]
