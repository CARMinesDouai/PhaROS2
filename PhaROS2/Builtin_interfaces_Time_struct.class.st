Class {
	#name : #'Builtin_interfaces_Time_struct',
	#superclass : #'ROS2_TypeSupport_struct',
	#classVars : [
		'OFFSET_ROSIDL_MESSAGE_TYPE_SUPPORT',
		'OFFSET_SIZEOF'
	],
	#category : #'PhaROS2-Struct'
}

{ #category : #'as yet unclassified' }
Builtin_interfaces_Time_struct class >> fieldsDesc [ 
^#(
Builtin_interfaces_Time* rosidl_message_type_support; int sizeof;)
]

{ #category : #'accessing structure variables' }
Builtin_interfaces_Time_struct >> rosidl_message_type_support [
	"This method was automatically generated"
	^Builtin_interfaces_Time fromHandle: (handle pointerAt: OFFSET_ROSIDL_MESSAGE_TYPE_SUPPORT)
]

{ #category : #'accessing structure variables' }
Builtin_interfaces_Time_struct >> rosidl_message_type_support: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_ROSIDL_MESSAGE_TYPE_SUPPORT put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
Builtin_interfaces_Time_struct >> sizeof [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_SIZEOF
]

{ #category : #'accessing structure variables' }
Builtin_interfaces_Time_struct >> sizeof: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_SIZEOF put: anObject
]
