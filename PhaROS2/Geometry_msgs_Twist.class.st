Class {
	#name : #'Geometry_msgs_Twist',
	#superclass : #'PhaROS2_Type',
	#classVars : [
		'OFFSET_ANGULAR',
		'OFFSET_LINEAR'
	],
	#category : #'PhaROS2-Type'
}

{ #category : #'as yet unclassified' }
Geometry_msgs_Twist class >> fieldsDesc [ 
^#(
Geometry_msgs_Vector3 linear;
Geometry_msgs_Vector3 angular;

)
]

{ #category : #'as yet unclassified' }
Geometry_msgs_Twist class >> typeSupport [
^Geometry_msgs_Twist_struct
]

{ #category : #'accessing structure variables' }
Geometry_msgs_Twist >> angular [
	"This method was automatically generated"
	^ Geometry_msgs_Vector3 fromHandle: (handle referenceStructAt: OFFSET_ANGULAR length: Geometry_msgs_Vector3 byteSize)
]

{ #category : #'accessing structure variables' }
Geometry_msgs_Twist >> angular: anObject [
	"This method was automatically generated"
	handle structAt: OFFSET_ANGULAR put: anObject getHandle length: Geometry_msgs_Vector3 byteSize
]

{ #category : #'accessing structure variables' }
Geometry_msgs_Twist >> linear [
	"This method was automatically generated"
	^ Geometry_msgs_Vector3 fromHandle: (handle referenceStructAt: OFFSET_LINEAR length: Geometry_msgs_Vector3 byteSize)
]

{ #category : #'accessing structure variables' }
Geometry_msgs_Twist >> linear: anObject [
	"This method was automatically generated"
	handle structAt: OFFSET_LINEAR put: anObject getHandle length: Geometry_msgs_Vector3 byteSize
]
