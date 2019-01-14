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

{ #category : #accessing }
ROS2Type >> struct [
	^ struct
]

{ #category : #accessing }
ROS2Type >> struct: anObject [
	struct := anObject
]
