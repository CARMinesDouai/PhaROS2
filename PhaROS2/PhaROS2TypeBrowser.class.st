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
	"PhaROS2_Type allSubclassesDo: [ :class | class remove ]."
	instance := nil.
]

{ #category : #Initialization }
PhaROS2TypeBrowser >> initialize [ 
	super initialize.
	
	browse := Dictionary new.
	
]

{ #category : #ROS2 }
PhaROS2TypeBrowser >> rosType: aType [
	| typeName typeDomain typeExpand fieldDesc class value type className |
	typeDomain := (aType substrings: '/') at: 1.
	typeName := (aType substrings: '/') at: 2.
	className := aType capitalized.
	className := className replaceAll: $/ with: $_.
	fieldDesc := '^#('.
	^ browse
		at: className
		ifAbsentPut: [ 
			Transcript crShow: 'Type search: '; show: aType; cr.
			typeExpand := (PipeableOSProcess command: 'ros2 msg show ' , aType) output.
			type := self typeSearch: typeExpand.
			type keysDo: [ :key | 
					value := type at: key.
					browse
						at: typeDomain , '/' , value
						ifAbsent: [ self rosType: typeDomain , '/' , value ].
					fieldDesc := fieldDesc , String lf , String tab , typeDomain , '_' , value , String space , key , ';'
				].
			fieldDesc := fieldDesc , String lf , ')'.
			
			class := PhaROS2_Type
				subclass: className asSymbol
				instanceVariableNames: ''
				classVariableNames: ''
				package: 'PhaROS2-Type'.
				
			class class compile: 'fieldDesc ' , fieldDesc.
			class ]
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
