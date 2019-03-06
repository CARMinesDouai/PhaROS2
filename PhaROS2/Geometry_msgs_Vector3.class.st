Class {
	#name : #'Geometry_msgs_Vector3',
	#superclass : #'PhaROS2_Type',
	#classVars : [
		'OFFSET_X',
		'OFFSET_Y',
		'OFFSET_Z'
	],
	#category : #'PhaROS2-Type'
}

{ #category : #'as yet unclassified' }
Geometry_msgs_Vector3 class >> fieldsDesc [ 
^#(
float64 x;
float64 y;
float64 z;

)
]

{ #category : #'as yet unclassified' }
Geometry_msgs_Vector3 class >> typeSupport [
^Geometry_msgs_Vector3_struct
]

{ #category : #'accessing structure variables' }
Geometry_msgs_Vector3 >> x [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_X
]

{ #category : #'accessing structure variables' }
Geometry_msgs_Vector3 >> x: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_X put: anObject
]

{ #category : #'accessing structure variables' }
Geometry_msgs_Vector3 >> y [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_Y
]

{ #category : #'accessing structure variables' }
Geometry_msgs_Vector3 >> y: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_Y put: anObject
]

{ #category : #'accessing structure variables' }
Geometry_msgs_Vector3 >> z [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_Z
]

{ #category : #'accessing structure variables' }
Geometry_msgs_Vector3 >> z: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_Z put: anObject
]
