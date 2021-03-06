Class {
	#name : #'ROS2_Publisher',
	#superclass : #'ROS2_Object',
	#instVars : [
		'publisherStruct',
		'parentNode',
		'topicName',
		'typeSupportName',
		'typeSupportStruct',
		'queueSize'
	],
	#category : #'PhaROS2-Objects'
}

{ #category : #initialization }
ROS2_Publisher >> destroyPublisher [
	publisherStruct ffiDestroy.
]

{ #category : #initialization }
ROS2_Publisher >> initialize [ 
	super initialize
]

{ #category : #accessing }
ROS2_Publisher >> parentNode [
	^ parentNode
]

{ #category : #accessing }
ROS2_Publisher >> parentNode: anObject [
	parentNode := anObject
]

{ #category : #publishing }
ROS2_Publisher >> publish: aMsg [
	publisherStruct publish: aMsg getHandle.
]

{ #category : #accessing }
ROS2_Publisher >> publisherStruct: anObject [
	^ publisherStruct := anObject
]

{ #category : #accessing }
ROS2_Publisher >> queueSize [
	^ queueSize
]

{ #category : #accessing }
ROS2_Publisher >> queueSize: anObject [
	queueSize := anObject
]

{ #category : #initialization }
ROS2_Publisher >> registerPublisher [
	|vHandle|
	(parentNode) ifNotNil: [ 
		vHandle := parentNode createPublisher: self.
		(vHandle) ifNotNil: [ publisherStruct := vHandle ]
		 ] ifNil: [ 
			self error: 'Cannot register a publisher without a parentNode'.
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
ROS2_Publisher >> typeSupportName: aROS2TypeSupport [
	"
	Any Type support
	You can find all Type with ros2 msg show command
	
	Example of type:
		- std_msgs/String
		- geometry_msgs/Twist
	"
	typeSupportName := aROS2TypeSupport.
	PhaROS2TypeBrowser instance need: typeSupportName.
	typeSupportStruct := PhaROS_Msgs typeSupport: typeSupportName.
	
]

{ #category : #accessing }
ROS2_Publisher >> typeSupportStruct [
	^ typeSupportStruct
]
