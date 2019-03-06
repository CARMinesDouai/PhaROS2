Class {
	#name : #'Builtin_interfaces_Time',
	#superclass : #'PhaROS2_Type',
	#classVars : [
		'OFFSET_NANOSEC',
		'OFFSET_SEC'
	],
	#category : #'PhaROS2-Type'
}

{ #category : #'as yet unclassified' }
Builtin_interfaces_Time class >> fieldsDesc [ 
^#(
int32 sec;
uint32 nanosec;

)
]

{ #category : #'as yet unclassified' }
Builtin_interfaces_Time class >> typeSupport [
^Builtin_interfaces_Time_struct
]

{ #category : #'accessing structure variables' }
Builtin_interfaces_Time >> nanosec [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_NANOSEC
]

{ #category : #'accessing structure variables' }
Builtin_interfaces_Time >> nanosec: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_NANOSEC put: anObject
]

{ #category : #'accessing structure variables' }
Builtin_interfaces_Time >> sec [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_SEC
]

{ #category : #'accessing structure variables' }
Builtin_interfaces_Time >> sec: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_SEC put: anObject
]
