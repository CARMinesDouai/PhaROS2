Class {
	#name : #'Std_msgs_String',
	#superclass : #'PhaROS2_Type',
	#classVars : [
		'OFFSET_DATA'
	],
	#category : #'PhaROS2-Type'
}

{ #category : #'as yet unclassified' }
Std_msgs_String class >> fieldsDesc [ 
^#(
String data;

)
]

{ #category : #'as yet unclassified' }
Std_msgs_String class >> typeSupport [
^Std_msgs_String_struct
]

{ #category : #'accessing structure variables' }
Std_msgs_String >> data [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_DATA) type: ExternalType char asPointerType
]

{ #category : #'accessing structure variables' }
Std_msgs_String >> data: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_DATA put: anObject getHandle.
]
