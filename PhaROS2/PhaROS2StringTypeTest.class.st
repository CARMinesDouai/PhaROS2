Class {
	#name : #PhaROS2StringTypeTest,
	#superclass : #PhaROS2TypeTest,
	#instVars : [
		'strReceived'
	],
	#category : #'PhaROS2-Type-Test'
}

{ #category : #ROS2 }
PhaROS2StringTypeTest >> callback: receivedData [
	strReceived := receivedData nextString.
]

{ #category : #ROS2 }
PhaROS2StringTypeTest >> msgClass [
	^RCLC getMessageStringTypeSupport
]

{ #category : #test }
PhaROS2StringTypeTest >> testPublishData [
	|msg data msgToSend process out|
	msg := 'PhaROS2 Test'.
	
	data := FFIExternalArray newType: 'char' size: (msg size + 1).
	msg doWithIndex: [ :char :index | data at: index put: char ].
	data at: (msg size+1) put: (Character null).
	
	msgToSend := RCLC getMessageString: data getHandle.
	
	process := (PipeableOSProcess command: 'ros2 topic echo ',namespace,'/',pubName).
	
	publisher publish: msgToSend.
	
	(Delay forMilliseconds: 300) wait.
	process processProxy sigterm .
	out := process upToEnd.
	process inspect.
	out inspect.
	self assert: out isEmpty equals: false.
]
