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
		'queueSize',
		'ignoreLocalPublication'
	],
	#category : #'PhaROS2-Objects'
}

{ #category : #accessing }
ROS2_Subscriber >> callback [
	^ callback
]

{ #category : #accessing }
ROS2_Subscriber >> callback: aBlock [
	| casting |
	"
		The block excepted when they received a message
		The callback is modified to cast to the correct Type
	"
	callback := (ROS2_Subscriber_callback on: [ :data | casting := (self typeSupportStruct class) fromHandle: data .aBlock cull: data] )
]

{ #category : #initialization }
ROS2_Subscriber >> destroySub [
	subscriberStruct ffiDestroy 
]

{ #category : #accessing }
ROS2_Subscriber >> ignoreLocalPublication [
	^ ignoreLocalPublication
]

{ #category : #accessing }
ROS2_Subscriber >> ignoreLocalPublication: anObject [
	ignoreLocalPublication := anObject
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
ROS2_Subscriber >> subscriberStruct [
	^ subscriberStruct
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
	"
	Any Type support
	You can find all Type with ros2 msg show command
	
	Example of type:
		- std_msgs/String
		- geometry_msgs/Twist
	"
	typeSupportName := anObject.
	PhaROS2TypeBrowser instance need: typeSupportName.
	typeSupportStruct := PhaROS_Msgs typeSupport: typeSupportName.
]

{ #category : #accessing }
ROS2_Subscriber >> typeSupportStruct [
	^ typeSupportStruct
]
