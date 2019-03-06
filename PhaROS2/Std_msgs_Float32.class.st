Class {
	#name : #'Std_msgs_Float32',
	#superclass : #'PhaROS2_Type',
	#classVars : [
		'OFFSET_DATA'
	],
	#category : #'PhaROS2-Type'
}

{ #category : #'as yet unclassified' }
Std_msgs_Float32 class >> fieldsDesc [ 
^#(
float32 data;

)
]

{ #category : #'as yet unclassified' }
Std_msgs_Float32 class >> typeSupport [
^Std_msgs_Float32_struct
]

{ #category : #'accessing structure variables' }
Std_msgs_Float32 >> data [
	"This method was automatically generated"
	^handle floatAt: OFFSET_DATA
]

{ #category : #'accessing structure variables' }
Std_msgs_Float32 >> data: anObject [
	"This method was automatically generated"
	handle floatAt: OFFSET_DATA put: anObject
]
