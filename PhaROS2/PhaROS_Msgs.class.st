Class {
	#name : #'PhaROS_Msgs',
	#superclass : #Object,
	#category : #'PhaROS2-Lib'
}

{ #category : #generation }
PhaROS_Msgs class >> addFunction: aType [
	| writeStream function tmp |
	tmp := '/' split: aType.
	function := 'rclc_message_type_support_t ',(self getSignatureOf: aType),'() { return RCLC_GET_MSG_TYPE_SUPPORT('.
	
	function := function,tmp first,',msg,',tmp last.
	
	function := function,');}',String crlf.
	
	writeStream := PhaROS_Msgs pathToSrc asFileReference writeStream.
	writeStream setToEnd.
	writeStream nextPutAll: function.
	writeStream flush.
	writeStream close.
]

{ #category : #generation }
PhaROS_Msgs class >> addToIncludes: aType [
	| writeStream includePath tmp |
	
	includePath := '#include "'.
	tmp := '/' split: aType.
	tmp insert: 'msgs' before: 2.
	
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
	
	signature := signature,(self getSignatureOf: aType),'();'.
	
	writeStream := PhaROS_Msgs pathToSignatures asFileReference writeStream.
	writeStream setToEnd.
	writeStream nextPutAll: signature.
	writeStream flush.
	writeStream close.
]

{ #category : #generation }
PhaROS_Msgs class >> amentRecompile [
	self error:'is in ament recompile'
]

{ #category : #ffi }
PhaROS_Msgs class >> ffiLibraryName [ 
	"Kept for backward compatibility. 
	 Users should use unix32* or unix64*
	 "
	^ '/home/william/ros2_ws/install/lib/libpharosmsgs.so'
]

{ #category : #ffi }
PhaROS_Msgs class >> getMessageByteTypeSupport [ 
	^self ffiCall: #(ROS2_TypeSupport_struct getByteTypeSupport())
]

{ #category : #ffi }
PhaROS_Msgs class >> getMessageStringTypeSupport [ 
	^self ffiCall: #(Std_msgs_String_struct getStringTypeSupport())
]

{ #category : #signature }
PhaROS_Msgs class >> getSignatureOf: aType [
	|tmp|
	tmp := aType replaceAll: $/ with: $_.
	tmp uncapitalized.
	^'get_',tmp
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
	self addToIncludes: aType.
	self addToSignature: aType.
	self addFunction: aType.
	
	self amentRecompile.
]

{ #category : #ffi }
PhaROS_Msgs >> ffiLibraryName [ 
	^self class ffiLibraryName
]
