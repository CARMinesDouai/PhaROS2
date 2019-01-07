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

{ #category : #Initialization }
PhaROS2TypeBrowser >> initialize [ 
	super initialize.
	
	browse := Dictionary new.
	
]

{ #category : #ROS2 }
PhaROS2TypeBrowser >> rosType: aType [
	| typeExpand fieldDesc|
	
	^browse at: aType ifAbsent: [ 
			typeExpand := (PipeableOSProcess command: 'ros2 msg show',aType) output.
			(self typeSearch: typeExpand) do: [ :type | 
					
				 ]
		 ].
]

{ #category : #ROS2 }
PhaROS2TypeBrowser >> typeSearch: aRos2Type [
	| returned |
	returned := OrderedCollection new.
	aRos2Type
		linesDo: [ :line | 
			line size isNotEmpty
				ifTrue: [ (line at: 1 == $# not)
						ifTrue: [ returned add: ((line substrings: ' ') at: 1) ]
						]
					].
	^aRos2Type
				
]
