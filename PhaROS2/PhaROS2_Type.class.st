Class {
	#name : #'PhaROS2_Type',
	#superclass : #FFIExternalStructure,
	#category : #'PhaROS2-Type'
}

{ #category : #primitive }
PhaROS2_Type class >> isPrimitive: aType [
	^self primitiveTypes includes: aType.
]

{ #category : #primitive }
PhaROS2_Type class >> primitiveTypes [
	^#(
		'string',
		'float64',
		'float32',
		'byte',
		'int64',
		'int32',
		'int16',
		'int8',
		'uint8',
		'uint16',
		'uint32',
		'uint64'
	)
]

{ #category : #primitive }
PhaROS2_Type class >> toUFFIName: aPrimitiveType [
	|ret|
	(self isPrimitive: aPrimitiveType) ifFalse: [ self error: 'Type: ', aPrimitiveType ,' is not a primitive type' ]
	ifTrue: [
		ret := aPrimitiveType. 
		(aPrimitiveType = 'string') ifTrue: [ ret := 'String'].
		 ].
	^ret.
]

{ #category : #primitive }
PhaROS2_Type class >> typeSupport [
	self subclassResponsibility 
]
