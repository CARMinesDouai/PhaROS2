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
	| typeName typeDomain typeExpand fieldDesc class|
	typeDomain := (aType substrings: '/') at: 1.
	typeName := (aType substrings: '/') at: 2.
	
	fieldDesc := '^#('.
	
	^browse at: aType ifAbsent: [ 
			typeExpand := (PipeableOSProcess command: 'ros2 msg show ',aType) output.
			(self typeSearch: typeExpand) associationsDo: [ :value | 
					  " browse at: typeDomain,'/',type ifAbsent: [ self rosType: type ]."
					  " fieldDesc := fieldDesc,String lf,String tab,type,String space,name,';'."
						Transcript crShow: value.
				 ].
			fieldDesc := fieldDesc,String lf,')'.
			
			class := PhaROS2_Type subclass: typeName asSymbol instanceVariableNames: '' classVariableNames: '' package: 'PhaROS2-Type'.
			class class compile: 'fieldDesc ',fieldDesc.
			class.
		 ].
]

{ #category : #ROS2 }
PhaROS2TypeBrowser >> typeSearch: aRos2Type [
	| returned |
	Transcript crShow: aRos2Type.
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
