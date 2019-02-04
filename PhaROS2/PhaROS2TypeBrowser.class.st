Class {
	#name : #PhaROS2TypeBrowser,
	#superclass : #Object,
	#instVars : [
		'browse'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'PhaROS2-Type'
}

{ #category : #accessing }
PhaROS2TypeBrowser class >> instance [
	^instance ifNil: [ instance := super new ] .
]

{ #category : #accessing }
PhaROS2TypeBrowser class >> new [
	self error: 'This is Singleton, use instance instead of new'
]

{ #category : #initialization }
PhaROS2TypeBrowser class >> reset [ 
	PhaROS2_Type allSubclassesDo: [ :class | class removeFromSystem ].
	instance := nil.
]

{ #category : #Initialization }
PhaROS2TypeBrowser >> initialize [ 
	super initialize.
	
	browse := Dictionary new.
	self populateDict.
]

{ #category : #ROS2 }
PhaROS2TypeBrowser >> need: aROS2Type [
	|nClass|
	^browse at: aROS2Type ifAbsent: [ 
		nClass := self ros2Type: aROS2Type .
		browse at: aROS2Type put: nClass.
		^nClass
		 ].
]

{ #category : #Initialization }
PhaROS2TypeBrowser >> populateDict [
	ROS2Type subclassesDo: [ :sub | browse at: sub name put: sub].
]

{ #category : #ROS2 }
PhaROS2TypeBrowser >> ros2Type: aType [
	^browse at: aType ifAbsent: [PhaROS2TypeParser parseROS2Type: (aType asString).]
]

{ #category : #ROS2 }
PhaROS2TypeBrowser >> typeSearch: aRos2Type [
	| returned |
	returned := Dictionary new.
	aRos2Type
		linesDo: [ :line | 
			line isNotEmpty
				ifTrue: [ (((line at: 1) == $#) not)
						ifTrue: [ returned at: ((line substrings: ' ') at: 2) put: ((line substrings: ' ') at: 1) ]
						]
					].
	^returned
				
]
