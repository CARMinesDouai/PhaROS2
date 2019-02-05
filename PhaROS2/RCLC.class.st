Class {
	#name : #RCLC,
	#superclass : #Object,
	#category : #'PhaROS2-Lib'
}

{ #category : #native }
RCLC class >> createNode: nodeName namespace: aNamespace [
	" Fonction tester et OK "
	(self status) ifFalse: [ self initNoArgs ].
	^self ffiCall: #(ROS2_Node rclc_create_node(String nodeName, String aNamespace))
]

{ #category : #native }
RCLC class >> ffiLibraryName [ 
	"Kept for backward compatibility. 
	 Users should use unix32* or unix64*
	 /!\Chemin en dure"
	^ '/home/william/ros2_ws/install/lib/librclc.so'
]

{ #category : #native }
RCLC class >> getMessageByteMultiArrayTypeSupport [ 
	^self ffiCall: #(ROS2_TypeSupport_struct getByteArrayTypeSupport())
]

{ #category : #native }
RCLC class >> getMessageByteTypeSupport [ 
	^self ffiCall: #(ROS2_TypeSupport_struct getByteTypeSupport())
]

{ #category : #native }
RCLC class >> getMessageEmptyTypeSupport [ 
	^self ffiCall: #(ROS2_TypeSupport_struct getEmptyTypeSupport())
]

{ #category : #native }
RCLC class >> getMessageFloat32TypeSupport [ 
	^self ffiCall: #(ROS2_TypeSupport_struct getFloat32TypeSupport())
]

{ #category : #native }
RCLC class >> getMessageInt32TypeSupport [ 
	^self ffiCall: #(ROS2_TypeSupport_struct getInt32TypeSupport())
]

{ #category : #native }
RCLC class >> getMessageIntraProcessTypeSupport [ 
	^self ffiCall: #(ROS2_TypeSupport_struct getIntraProcessTypeSupport())
]

{ #category : #native }
RCLC class >> getMessageString: aString [
	^self ffiCall: #(void * setDataToStringTypeSupport(char * aString))
]

{ #category : #native }
RCLC class >> getMessageStringTypeSupport [ 
	^self ffiCall: #(ROS2_TypeSupport_struct getStringTypeSupport())
]

{ #category : #native }
RCLC class >> getMessageTypeSupport [ 
	^self ffiCall: #(ROS2_TypeSupport_struct getTypeSupport())
]

{ #category : #native }
RCLC class >> initNoArgs [
	|state externalArray argv|
	state := self status.
	argv := #('').
	(state = false) ifTrue: [ 
		"Need to be init"
		Transcript crShow: 'Rclc start initialization'.
		[ externalArray := FFIExternalArray externalNewType: 'char*' size: argv size.
        argv withIndexDo: [ :string :index | externalArray at: index put: (ExternalAddress fromString: string) ].
        self rcl_init: (argv size) argv: externalArray ]
                ensure: [ externalArray
                                ifNotNil: [ externalArray do: [ :item | item ifNotNil: [ :e | e free ] ].
                                        externalArray free ] ]
	]
ifFalse:
[ Transcript crShow: 'RCL already init with status ' ; show: state]
	
]

{ #category : #native }
RCLC class >> rcl_init: aArgc argv: aArgv [
	"Fonction tester et OK"
	^self ffiCall: #(int rclc_init #(int aArgc, FFIExternalArray * aArgv)).
]

{ #category : #native }
RCLC class >> status [
	"Fonction tester et OK"
	^self ffiCall: #(bool rclc_ok()).
]

{ #category : #'nb-library' }
RCLC >> ffiLibraryName [ 
	^self class ffiLibraryName
]
