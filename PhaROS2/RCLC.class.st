Class {
	#name : #RCLC,
	#superclass : #Object,
	#category : #'PhaROS2-Lib'
}

{ #category : #native }
RCLC class >> createNode: nodeName namespace: aNamespace [
	" Fonction tester et OK "
	(self status) ifFalse: [ self initNoArgs ].
	^self ffiCall: #(#ROS2_Node_Struct rclc_create_node(String nodeName, String aNamespace))
]

{ #category : #native }
RCLC class >> ffiLibraryName [ 
	"Kept for backward compatibility. 
	 Users should use unix32* or unix64*
	 "
	^ '/home/william/ros2_ws/install/lib/librclc.so'
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
