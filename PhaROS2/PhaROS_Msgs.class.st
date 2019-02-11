Class {
	#name : #'PhaROS_Msgs',
	#superclass : #Object,
	#classInstVars : [
		'generatedTypeDict'
	],
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
	PhaROS_Msgs class compile: (PhaROS_Msgs signatureOf: aType),String lf,'^self ffiCall: #(',(PhaROS2TypeParser computeClassName: (aType copy)),'_struct ',(PhaROS_Msgs signatureOf: aType),'())'.
	"(generatedTypeDict) ifNil: [ generatedTypeDict := Dictionary new. ].
	generatedTypeDict at: (PhaROS_Msgs signatureOf: aType copy) put: [ ^self ffiCall: {[(PhaROS2TypeParser computeClassName: (aType copy))], '_struct', [PhaROS_Msgs signatureOf: aType],'())'} asArray ]"
]

{ #category : #generation }
PhaROS_Msgs class >> addToCMake: aType [
	| writeStream splitted |
	
	splitted := '/' split: aType.
	
	writeStream := PhaROS_Msgs pathToCMake asFileReference writeStream.
	writeStream setToEnd.
	"Add to findpackage"
	writeStream nextPutAll: 'find_package('.
	writeStream nextPutAll: (splitted at: 1).
	writeStream nextPutAll: ' REQUIRED)'.
	writeStream nextPutAll: String crlf.
	"Add to target dependencie"
	writeStream nextPutAll: 'list(APPEND pharosmsgs_depend '.
	writeStream nextPutAll: (splitted at: 1).
	writeStream nextPutAll: ')'.
	writeStream nextPutAll: String crlf.
	"End des appeds"
	writeStream flush.
	writeStream close.
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
	|shell|
	"Command to execute:
	src/ament_tools/scripts/ament.py build --build-tests --symlink-install --only-packages pharosmsgs
	"
	"PipeableOSProcess waitForCommand: '/home/william/ros2_ws/src/ament_tools/scripts/ament.py build --symlink-install --only-packages pharosmsgs'."
	shell := PipeableOSProcess bash.
	shell exec: 'source /opt/ros/bouncy/setup.bash';exec: '/home/william/ros2_ws/src/ament_tools/scripts/ament.py build --symlink-install --only-packages pharosmsgs'.
	Transcript crShow: shell upToEnd.
	shell close.
	PhaROS_Msgs reloadLib.
]

{ #category : #ffi }
PhaROS_Msgs class >> ffiLibraryName [ 
	"Kept for backward compatibility. 
	 Users should use unix32* or unix64*
	 "
	^ '/home/william/ros2_ws/install/lib/libpharosmsgs.so'
]

{ #category : #path }
PhaROS_Msgs class >> pathToCMake [
	^'/home/william/ros2_ws/src/pharosmsgs/pharosmsgs/addingdep.cmake'
]

{ #category : #path }
PhaROS_Msgs class >> pathToIncludes [
	^'/home/william/ros2_ws/src/pharosmsgs/pharosmsgs/include/pharosmsgs/includes.h'
]

{ #category : #path }
PhaROS_Msgs class >> pathToPackage [
	^'/home/william/ros2_ws/src/pharosmsgs/pharosmsgs/package.xml'
]

{ #category : #path }
PhaROS_Msgs class >> pathToSignatures [
	^'/home/william/ros2_ws/src/pharosmsgs/pharosmsgs/include/pharosmsgs/signatures.h'
]

{ #category : #path }
PhaROS_Msgs class >> pathToSrc [
	^'/home/william/ros2_ws/src/pharosmsgs/pharosmsgs/src/functions.c'
]

{ #category : #generation }
PhaROS_Msgs class >> registerNewType: aType [
	self addToIncludes: aType copy.
	self addToSignature: aType copy.
	self addFunction: aType copy.
	self addToCMake: aType copy.
	
	self amentRecompile.
	self addGeneratedFunction: aType copy.
]

{ #category : #generation }
PhaROS_Msgs class >> reloadLib [
	Smalltalk vm unloadModule: 'module_name'.
	"garbage collect"
	Smalltalk garbageCollect.
]

{ #category : #generation }
PhaROS_Msgs class >> resetLib [
	PhaROS_Msgs pathToIncludes asFileReference ensureDelete writeStreamDo: [ :stream | stream flush;close ].
	PhaROS_Msgs pathToSignatures asFileReference ensureDelete writeStreamDo: [ :stream | stream flush;close ].
	PhaROS_Msgs pathToCMake asFileReference ensureDelete writeStreamDo: [ :stream | stream flush;close ].
	PhaROS_Msgs pathToSrc asFileReference ensureDelete writeStreamDo: [ :stream | stream nextPutAll: '#include <pharosmsgs/pharosmsgs.h>';nextPutAll:String crlfcrlf;flush;close ].
	generatedTypeDict := nil.
	PhaROS_Msgs amentRecompile.
]

{ #category : #generation }
PhaROS_Msgs class >> signatureOf: aType [
	|tmp|
	tmp := aType replaceAll: $/ with: $_.
	tmp uncapitalized.
	^'get_',tmp
]

{ #category : #usage }
PhaROS_Msgs class >> typeSupport: aType [
	| sign |
	sign := (PhaROS_Msgs signatureOf: aType copy) asSymbol.
	Transcript crShow: sign.
	"^(generatedTypeDict) ifNil: [ self error: 'Generated method dict is nil' ] ifNotNil: [ 
		^((generatedTypeDict at: sign ifAbsent:[self error: 'method not generated'])value)
		 ]"
	^PhaROS_Msgs perform: sign.
]

{ #category : #ffi }
PhaROS_Msgs >> ffiLibraryName [ 
	^self class ffiLibraryName
]
