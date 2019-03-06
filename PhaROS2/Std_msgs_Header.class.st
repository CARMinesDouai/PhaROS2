Class {
	#name : #'Std_msgs_Header',
	#superclass : #'PhaROS2_Type',
	#classVars : [
		'OFFSET_FRAME_ID',
		'OFFSET_STAMP'
	],
	#category : #'PhaROS2-Type'
}

{ #category : #'as yet unclassified' }
Std_msgs_Header class >> fieldsDesc [ 
^#(
Builtin_interfaces_Time stamp;
String frame_id;

)
]

{ #category : #'as yet unclassified' }
Std_msgs_Header class >> typeSupport [
^Std_msgs_Header_struct
]

{ #category : #'accessing structure variables' }
Std_msgs_Header >> frame_id [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_FRAME_ID) type: ExternalType char asPointerType
]

{ #category : #'accessing structure variables' }
Std_msgs_Header >> frame_id: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_FRAME_ID put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
Std_msgs_Header >> stamp [
	"This method was automatically generated"
	^ Builtin_interfaces_Time fromHandle: (handle referenceStructAt: OFFSET_STAMP length: Builtin_interfaces_Time byteSize)
]

{ #category : #'accessing structure variables' }
Std_msgs_Header >> stamp: anObject [
	"This method was automatically generated"
	handle structAt: OFFSET_STAMP put: anObject getHandle length: Builtin_interfaces_Time byteSize
]
