Class {
	#name : #'Sensor_msgs_Joy_struct',
	#superclass : #'ROS2_TypeSupport_struct',
	#classVars : [
		'OFFSET_ROSIDL_MESSAGE_TYPE_SUPPORT',
		'OFFSET_SIZEOF'
	],
	#category : #'PhaROS2-Struct'
}

{ #category : #'as yet unclassified' }
Sensor_msgs_Joy_struct class >> fieldsDesc [ 
^#(
Sensor_msgs_Joy* rosidl_message_type_support; int sizeof;)
]

{ #category : #'accessing structure variables' }
Sensor_msgs_Joy_struct >> rosidl_message_type_support [
	"This method was automatically generated"
	^Sensor_msgs_Joy fromHandle: (handle pointerAt: OFFSET_ROSIDL_MESSAGE_TYPE_SUPPORT)
]

{ #category : #'accessing structure variables' }
Sensor_msgs_Joy_struct >> rosidl_message_type_support: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_ROSIDL_MESSAGE_TYPE_SUPPORT put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
Sensor_msgs_Joy_struct >> sizeof [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_SIZEOF
]

{ #category : #'accessing structure variables' }
Sensor_msgs_Joy_struct >> sizeof: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_SIZEOF put: anObject
]
