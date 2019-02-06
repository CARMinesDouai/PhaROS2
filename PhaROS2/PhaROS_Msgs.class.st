Class {
	#name : #'PhaROS_Msgs',
	#superclass : #Object,
	#category : #'PhaROS2-Lib'
}

{ #category : #generation }
PhaROS_Msgs class >> addFunction: aType [
	| writeStream function tmp |
	tmp := '/' split: aType.
	function := 'rclc_message_type_support_t ',(self signatureOf: aType),'() { return RCLC_GET_MSG_TYPE_SUPPORT('.
	
	function := function,tmp first,',msg,',tmp last.
	
	function := function,');}',String crlf.
	
	writeStream := PhaROS_Msgs pathToSrc asFileReference writeStream.
	writeStream setToEnd.
	writeStream nextPutAll: function.
	writeStream flush.
	writeStream close.
]

{ #category : #generation }
PhaROS_Msgs class >> addGeneratedFunction: aType [
	PhaROS_Msgs class compile: (PhaROS_Msgs signatureOf: aType),String lf,'^self ffiCall: #(ROS2_TypeSupport_struct ',(PhaROS_Msgs signatureOf: aType),'())'.
]

{ #category : #generation }
PhaROS_Msgs class >> addToIncludes: aType [
	| writeStream includePath tmp |
	
	includePath := '#include "'.
	tmp := '/' split: aType.
	tmp insert: 'msg' before: 2.
	
	1 to: (tmp size-1) do: [ :index | includePath := includePath,(tmp at: index),'/' ].
	includePath := includePath,(tmp last) uncapitalized,'.h"'.
	
	writeStream := PhaROS_Msgs pathToIncludes asFileReference writeStream.
	writeStream setToEnd.
	writeStream nextPutAll: includePath,String crlf.
	writeStream flush.
	writeStream close.
	
]

{ #category : #generation }
PhaROS_Msgs class >> addToSignature: aType [
	| writeStream signature |
	signature := 'rclc_message_type_support_t '.
	
	signature := signature,(self signatureOf: aType),'();'.
	
	writeStream := PhaROS_Msgs pathToSignatures asFileReference writeStream.
	writeStream setToEnd.
	writeStream nextPutAll: signature.
	writeStream flush.
	writeStream close.
]

{ #category : #generation }
PhaROS_Msgs class >> amentRecompile [
	"Command to execute:
	src/ament_tools/scripts/ament.py build --build-tests --symlink-install --only-packages pharosmsgs
	"
	OSProcess waitForCommand: '/home/william/ros2_ws/src/ament_tools/scripts/ament.py build --build-tests --symlink-install --only-packages pharosmsgs'
]

{ #category : #ffi }
PhaROS_Msgs class >> ffiLibraryName [ 
	"Kept for backward compatibility. 
	 Users should use unix32* or unix64*
	 "
	^ '/home/william/ros2_ws/install/lib/libpharosmsgs.so'
]

{ #category : #path }
PhaROS_Msgs class >> pathToIncludes [
	^'/home/william/ros2_ws/src/pharosmsgs/pharosmsgs/include/pharosmsgs/includes.h'
]

{ #category : #path }
PhaROS_Msgs class >> pathToSignatures [
	^'/home/william/ros2_ws/src/pharosmsgs/pharosmsgs/include/pharosmsgs/signatures.h'
]

{ #category : #path }
PhaROS_Msgs class >> pathToSrc [
	^'/home/william/ros2_ws/src/pharosmsgs/pharosmsgs/src/pharostypes.c'
]

{ #category : #generation }
PhaROS_Msgs class >> registerNewType: aType [
	self addToIncludes: aType copy.
	self addToSignature: aType copy.
	self addFunction: aType copy.
	
	self amentRecompile.
	self addGeneratedFunction: aType copy.
]

{ #category : #generation }
PhaROS_Msgs class >> resetLib [
	PhaROS_Msgs pathToIncludes asFileReference ensureDelete writeStreamDo: [ :stream | stream flush;close ].
	PhaROS_Msgs pathToSignatures asFileReference ensureDelete writeStreamDo: [ :stream | stream flush;close ].
	PhaROS_Msgs pathToSrc asFileReference ensureDelete writeStreamDo: [ :stream | stream nextPutAll: '#include <pharosmsgs/pharostypes.h>';nextPutAll:String crlfcrlf;flush;close ].
	PhaROS_Msgs amentRecompile.
]

{ #category : #signature }
PhaROS_Msgs class >> signatureOf: aType [
	|tmp|
	tmp := aType replaceAll: $/ with: $_.
	tmp uncapitalized.
	^'get_',tmp
]

{ #category : #ffi }
PhaROS_Msgs >> ffiLibraryName [ 
	^self class ffiLibraryName
]
