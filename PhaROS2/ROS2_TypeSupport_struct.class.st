Class {
	#name : #'ROS2_TypeSupport_struct',
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_ROSIDL_MESSAGE_TYPE_SUPPORT',
		'OFFSET_SIZE_OF'
	],
	#category : #'PhaROS2-Struct'
}

{ #category : #'field definition' }
ROS2_TypeSupport_struct class >> fieldsDesc [ 
	^#(
		void * rosidl_message_type_support;
		int size_of;
	)
]

{ #category : #'accessing structure variables' }
ROS2_TypeSupport_struct >> rosidl_message_type_support [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_ROSIDL_MESSAGE_TYPE_SUPPORT) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
ROS2_TypeSupport_struct >> rosidl_message_type_support: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_ROSIDL_MESSAGE_TYPE_SUPPORT put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
ROS2_TypeSupport_struct >> size_of [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_SIZE_OF
]

{ #category : #'accessing structure variables' }
ROS2_TypeSupport_struct >> size_of: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_SIZE_OF put: anObject
]
