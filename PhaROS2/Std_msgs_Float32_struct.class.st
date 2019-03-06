Class {
	#name : #'Std_msgs_Float32_struct',
	#superclass : #'ROS2_TypeSupport_struct',
	#classVars : [
		'OFFSET_ROSIDL_MESSAGE_TYPE_SUPPORT',
		'OFFSET_SIZEOF'
	],
	#category : #'PhaROS2-Struct'
}

{ #category : #'as yet unclassified' }
Std_msgs_Float32_struct class >> fieldsDesc [ 
^#(
Std_msgs_Float32* rosidl_message_type_support; int sizeof;)
]

{ #category : #'accessing structure variables' }
Std_msgs_Float32_struct >> rosidl_message_type_support [
	"This method was automatically generated"
	^Std_msgs_Float32 fromHandle: (handle pointerAt: OFFSET_ROSIDL_MESSAGE_TYPE_SUPPORT)
]

{ #category : #'accessing structure variables' }
Std_msgs_Float32_struct >> rosidl_message_type_support: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_ROSIDL_MESSAGE_TYPE_SUPPORT put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
Std_msgs_Float32_struct >> sizeof [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_SIZEOF
]

{ #category : #'accessing structure variables' }
Std_msgs_Float32_struct >> sizeof: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_SIZEOF put: anObject
]
