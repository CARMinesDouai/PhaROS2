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
ROS2_Publisher >> destroyPub [
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
ROS2_Publisher >> registerPub [
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
ROS2_Publisher >> typeSupportName: anObject [
	typeSupportName := anObject
]

{ #category : #accessing }
ROS2_Publisher >> typeSupportStruct [
	^ typeSupportStruct
]

{ #category : #accessing }
ROS2_Publisher >> typeSupportStruct: anObject [
	typeSupportStruct := anObject
]
