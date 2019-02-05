Class {
	#name : #'ROS2_Publisher',
	#superclass : #ROS2Handle,
	#instVars : [
		'parentNode',
		'topicName',
		'typeSupportName',
		'typeSupportStruct'
	],
	#category : #'PhaROS2-Objects'
}

{ #category : #initialization }
ROS2_Publisher >> destroyPub [
	self ffiDestroy.
]

{ #category : #publish }
ROS2_Publisher >> ffiDestroy [
	^self ffiCall: #(int rclc_destroy_publisher(self))
]

{ #category : #initialization }
ROS2_Publisher >> initialize [ 
	super initialize.
	
]

{ #category : #accessing }
ROS2_Publisher >> parentNode [
	^ parentNode
]

{ #category : #accessing }
ROS2_Publisher >> parentNode: anObject [
	parentNode := anObject
]

{ #category : #publish }
ROS2_Publisher >> publish: aMsg [
	^self ffiCall: #(int rclc_publish(self, void * aMsg))
]

{ #category : #initialization }
ROS2_Publisher >> registerPub [
	|vHandle|
	(parentNode) ifNotNil: [ 
		vHandle := parentNode createPublisher: self.
		(vHandle) ifNotNil: [ self setHandle: vHandle ]
		 ]
]

{ #category : #accessing }
ROS2_Publisher >> topicName [
	^ topicName
]

{ #category : #accessing }
ROS2_Publisher >> topicName: anObject [
	topicName := anObject
]

{ #category : #accessing }
ROS2_Publisher >> typeSupportName [
	^ typeSupportName
]

{ #category : #accessing }
ROS2_Publisher >> typeSupportName: anTypeSupportName [
	"
	All type support is accesible with 'ros2 msg show ' command
	Example of type support Name:
		- std_msgs/String
		- geometry_msgs/Twist
	"
	
	typeSupportName := anTypeSupportName
]
