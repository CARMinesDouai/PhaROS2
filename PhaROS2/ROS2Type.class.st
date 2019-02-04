Class {
	#name : #ROS2Type,
	#superclass : #Object,
	#instVars : [
		'handle',
		'struct',
		'data'
	],
	#category : #'PhaROS2-Type'
}

{ #category : #factory }
ROS2Type class >> fromHandle: aHandle [
	|a|
	a := self new.
	^a handle: aHandle;
		yourself
]

{ #category : #primitive }
ROS2Type class >> primitiveTypes [
	^#(
		string,
		float64,
		float32,
		byte,
		int64,
		int32,
		int16,
		int8,
		uint8,
		uint16,
		uint32,
		uint64
	)
]

{ #category : #accessing }
ROS2Type >> data [
	^ data
]

{ #category : #accessing }
ROS2Type >> data: anObject [
	data := anObject
]

{ #category : #accessing }
ROS2Type >> handle [
	^ handle
]

{ #category : #accessing }
ROS2Type >> handle: anHandle [
	handle := anHandle.
	struct := ROS2_TypeSupport_struct fromHandle: handle.
	data := FFIExternalStructure fromHandle: (struct rosidl_message_type_support).
]

{ #category : #primitive }
ROS2Type >> nextByte [
	^data getHandle asInteger.
]

{ #category : #primitive }
ROS2Type >> nextFloat32 [
	| rawFloatValue |
	rawFloatValue := Float fromIEEE32Bit: ('16r',data getHandle getHandle asByteArrayPointer reverse hex) asSymbol .
	((rawFloatValue isNaN) or: [rawFloatValue isInfinite]) ifTrue: [ ^ rawFloatValue ].
	^ rawFloatValue
]

{ #category : #primitive }
ROS2Type >> nextInt32 [
	^data getHandle asInteger.
]

{ #category : #primitive }
ROS2Type >> nextString [ 
	^data getHandle readString 
]

{ #category : #accessing }
ROS2Type >> struct [
	^ struct
]

{ #category : #accessing }
ROS2Type >> struct: anObject [
	struct := anObject
]
