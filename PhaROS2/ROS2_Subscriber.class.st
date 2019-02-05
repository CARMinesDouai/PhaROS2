Class {
	#name : #'ROS2_Subscriber',
	#superclass : #ROS2Handle,
	#instVars : [
		'parentNode',
		'topicName',
		'callback',
		'typeSupportName',
		'typeSupportStruct',
		'queueSize'
	],
	#category : #'PhaROS2-Objects'
}

{ #category : #accessing }
ROS2_Subscriber >> callback [
	^ callback
]

{ #category : #accessing }
ROS2_Subscriber >> callback: aROS2_Subscriber_Callback [
	callback := aROS2_Subscriber_Callback
]

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

{ #category : #accessing }
ROS2_Subscriber >> parentNode [
	^ parentNode
]

{ #category : #accessing }
ROS2_Subscriber >> parentNode: anObject [
	parentNode := anObject
]

{ #category : #accessing }
ROS2_Subscriber >> queueSize [
	^ queueSize
]

{ #category : #accessing }
ROS2_Subscriber >> queueSize: anObject [
	queueSize := anObject
]

{ #category : #accessing }
ROS2_Subscriber >> topicName [
	^ topicName
]

{ #category : #accessing }
ROS2_Subscriber >> topicName: anObject [
	topicName := anObject
]

{ #category : #accessing }
ROS2_Subscriber >> typeSupportName [
	^ typeSupportName
]

{ #category : #accessing }
ROS2_Subscriber >> typeSupportName: anTypeSupportName [
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
ROS2_Subscriber >> typeSupportStruct [
	^ typeSupportStruct
]
