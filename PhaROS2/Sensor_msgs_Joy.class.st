Class {
	#name : #'Sensor_msgs_Joy',
	#superclass : #'PhaROS2_Type',
	#classVars : [
		'OFFSET_AXES',
		'OFFSET_BUTTONS',
		'OFFSET_HEADER'
	],
	#category : #'PhaROS2-Type'
}

{ #category : #'as yet unclassified' }
Sensor_msgs_Joy class >> fieldsDesc [ 
^#(
Std_msgs_Header header;
float32* axes;
int32* buttons;

)
]

{ #category : #'as yet unclassified' }
Sensor_msgs_Joy class >> typeSupport [
^Sensor_msgs_Joy_struct
]

{ #category : #'accessing structure variables' }
Sensor_msgs_Joy >> axes [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_AXES) type: ExternalType float asPointerType
]

{ #category : #'accessing structure variables' }
Sensor_msgs_Joy >> axes: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_AXES put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
Sensor_msgs_Joy >> buttons [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_BUTTONS) type: ExternalType long asPointerType
]

{ #category : #'accessing structure variables' }
Sensor_msgs_Joy >> buttons: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_BUTTONS put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
Sensor_msgs_Joy >> header [
	"This method was automatically generated"
	^ Std_msgs_Header fromHandle: (handle referenceStructAt: OFFSET_HEADER length: Std_msgs_Header byteSize)
]

{ #category : #'accessing structure variables' }
Sensor_msgs_Joy >> header: anObject [
	"This method was automatically generated"
	handle structAt: OFFSET_HEADER put: anObject getHandle length: Std_msgs_Header byteSize
]
