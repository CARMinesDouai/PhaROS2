Class {
	#name : #'ROS2_Node',
	#superclass : #'ROS2_Object',
	#instVars : [
		'nodeStruct',
		'thread',
		'spinThread',
		'subscribers',
		'publishers',
		'namespace',
		'nodeName'
	],
	#category : #'PhaROS2-Objects'
}

{ #category : #publishers }
ROS2_Node >> createPublisher: aPublisher [
	| vHandle |
	aPublisher parentNode: self.
	publishers add: aPublisher.
	vHandle := nodeStruct ffiCreatePublisher: aPublisher topicName queueSize: aPublisher queueSize messageType: aPublisher typeSupportStruct.
	^vHandle
]

{ #category : #subscribers }
ROS2_Node >> createSubcriber: aSubscriber [
	| vHandle |
	aSubscriber parentNode: self.
	subscribers add: aSubscriber.
	vHandle := self ffiCreateSubscriber: aSubscriber topicName queueSize: aSubscriber queueSize messageType: aSubscriber typeSupportStruct callback: aSubscriber callback ignoreLocalPublication: aSubscriber ignoreLocalPublication.
	^vHandle
]

{ #category : #spin }
ROS2_Node >> delayBetweenSpin [
	"The time between 2 spin"
	^10
]

{ #category : #initialization }
ROS2_Node >> destroyNode [
	publishers do: [ :aPub | aPub destroyPublisher. ].
	subscribers do: [ :aSub | aSub destroySub. ].
	
	spinThread ifNotNil: [ spinThread terminate ].
	
	nodeStruct ffiDestroyNode.
]

{ #category : #initialization }
ROS2_Node >> initialize [
	super initialize.
	
	publishers := OrderedCollection new.
	subscribers := OrderedCollection new.
]

{ #category : #accessing }
ROS2_Node >> namespace [
	^ namespace
]

{ #category : #accessing }
ROS2_Node >> namespace: anObject [
	namespace := anObject
]

{ #category : #accessing }
ROS2_Node >> nodeName [
	^ nodeName
]

{ #category : #accessing }
ROS2_Node >> nodeName: anObject [
	nodeName := anObject
]

{ #category : #accessing }
ROS2_Node >> publishers [
	^ publishers
]

{ #category : #ROS2 }
ROS2_Node >> registerNode [
	nodeStruct := (RCLC createNode: self nodeName namespace: self namespace).
]

{ #category : #spin }
ROS2_Node >> spinFunction [
	nodeStruct ffiSpinMeTimeout: self spinTimeout.
	(Delay forMilliseconds: self delayBetweenSpin) wait.
]

{ #category : #spin }
ROS2_Node >> spinTimeout [
	"Timeout for each spin in milliseconds"
	^200
]

{ #category : #spin }
ROS2_Node >> startSpin [
	"Start the spining thread"
	(spinThread) ifNil: [ 
		spinThread := [ self spinFunction ] fork.
	]
]

{ #category : #spin }
ROS2_Node >> stopSpin [
	"Stop the spinning thread"
	(spinThread) ifNotNil: [ 
		spinThread terminate.
		spinThread := nil.
	]
]

{ #category : #accessing }
ROS2_Node >> subscribers [
	^ subscribers
]
