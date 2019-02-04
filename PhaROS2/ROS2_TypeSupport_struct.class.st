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
	self subclassResponsibility 
]
