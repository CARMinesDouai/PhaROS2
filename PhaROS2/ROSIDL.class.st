Class {
	#name : #ROSIDL,
	#superclass : #Object,
	#category : #'PhaROS2-Lib'
}

{ #category : #native }
ROSIDL class >> ffiLibraryName [
	^'/opt/ros/bouncy/lib/librosidl_generator_c.so'
]

{ #category : #native }
ROSIDL class >> getMessageTypeSupport [
	^self ffiCall: #(ROS2_Message_Type_Support ROSIDL_GET_MESSAGE_TYPE_SUPPORT(std_msgs, String Int32))
]

{ #category : #native }
ROSIDL class >> getMessageTypeSupportHandle: aIdentifier [
	|ret|
	ret := ROSIDL_message_type_support_t externalNew.
	self ffiCall: #(ROSIDL_message_type_support_t * get_message_typesupport_handle(ret, String aIdentifier)).
	^ret
]

{ #category : #native }
ROSIDL class >> getMessageTypeSupportHandle: aString msgTypeAddr: aROSIDL_message_type_support_t [ 
	self shouldBeImplemented.
]

{ #category : #native }
ROSIDL class >> getMessageTypeSupportPkg: aPkg dir: aDir msg: aMsg [
	^self ffiCall: #(ROS2_Message_Type_Support ROSIDL_GET_MESSAGE_TYPE_SUPPORT(const char * aPkg, const char * aDir, const char * aMsg))
]

{ #category : #'library path' }
ROSIDL >> ffiLibraryName [ 
	^self class ffiLibraryName 
]
