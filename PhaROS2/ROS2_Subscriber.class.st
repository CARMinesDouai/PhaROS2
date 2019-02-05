Class {
	#name : #'ROS2_Subscriber',
	#superclass : #'ROS2_Object',
	#instVars : [
		'subscriberStruct',
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
ROS2_Subscriber >> callback: aBlock [
	"The block excepted when they received a message"
	callback := aBlock
]

{ #category : #initialization }
ROS2_Subscriber >> destroySub [
	subscriberStruct ffiDestroy 
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

{ #category : #initialization }
ROS2_Subscriber >> registerSub [
	|vHandle|
	(parentNode) ifNotNil: [ 
		vHandle := parentNode createSubcriber: self.
		(vHandle) ifNotNil: [ subscriberStruct := vHandle ]
		 ] ifNil: [ 
			self error: 'Cannot register a subscriber without a parentNode'.
		 ]
]

{ #category : #accessing }
ROS2_Subscriber >> subscriberStruct: anObject [
	^ subscriberStruct := anObject
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
ROS2_Subscriber >> typeSupportName: anObject [
	typeSupportName := anObject
]
