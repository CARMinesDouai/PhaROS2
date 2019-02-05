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

{ #category : #initialization }
ROS2_Publisher_Struct >> destroyPub [
	self ffiDestroy.
]

{ #category : #publish }
ROS2_Publisher_Struct >> ffiDestroy [
	^self ffiCall: #(int rclc_destroy_publisher(self))
]

{ #category : #initialization }
ROS2_Publisher_Struct >> initialize [ 
	super initialize.
	
]

{ #category : #accessing }
ROS2_Publisher_Struct >> parentNode [
	^ parentNode
]

{ #category : #accessing }
ROS2_Publisher_Struct >> parentNode: anObject [
	parentNode := anObject
]

{ #category : #publish }
ROS2_Publisher_Struct >> publish: aMsg [
	^self ffiCall: #(int rclc_publish(self, void * aMsg))
]

{ #category : #accessing }
ROS2_Publisher_Struct >> queueSize [
	^queueSize 
]

{ #category : #accessing }
ROS2_Publisher_Struct >> queueSize: anInt [
	queueSize := anInt
]

{ #category : #initialization }
ROS2_Publisher_Struct >> registerPub [
	|vHandle|
	(parentNode) ifNotNil: [ 
		vHandle := parentNode createPublisher: self.
		(vHandle) ifNotNil: [ self setHandle: vHandle ]
		 ] ifNil: [ 
			self error: 'Cannot register a publisher without a parentNode'.
		 ]
]

{ #category : #accessing }
ROS2_Publisher_Struct >> topicName [
	^ topicName
]

{ #category : #accessing }
ROS2_Publisher_Struct >> topicName: anObject [
	topicName := anObject
]

{ #category : #accessing }
ROS2_Publisher_Struct >> typeSupportName [
	^ typeSupportName
]

{ #category : #accessing }
ROS2_Publisher_Struct >> typeSupportName: anTypeSupportName [
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
ROS2_Publisher_Struct >> typeSupportStruct [
	^typeSupportStruct 
]
