Class {
	#name : #'Std_msgs_Float64',
	#superclass : #'PhaROS2_Type',
	#classVars : [
		'OFFSET_DATA'
	],
	#category : #'PhaROS2-Type'
}

{ #category : #'as yet unclassified' }
Std_msgs_Float64 class >> fieldsDesc [ 
^#(
float64 data;

)
]

{ #category : #'as yet unclassified' }
Std_msgs_Float64 class >> typeSupport [
^Std_msgs_Float64_struct
]

{ #category : #'accessing structure variables' }
Std_msgs_Float64 >> data [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_DATA
]

{ #category : #'accessing structure variables' }
Std_msgs_Float64 >> data: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_DATA put: anObject
]
