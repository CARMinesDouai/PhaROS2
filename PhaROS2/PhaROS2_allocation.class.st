Class {
	#name : #'PhaROS2_allocation',
	#superclass : #Object,
	#category : #'PhaROS2-Util'
}

{ #category : #allocate }
PhaROS2_allocation class >> encodefloat64: aFloat [
	| ret |
	ret := FFIFloat64 new.
		
	
	^ret.
]

{ #category : #allocate }
PhaROS2_allocation class >> encodefloat64: aFloat handle: aHandle [
	| ret |
	ret := FFIFloat64 new.
	ret basicAt: aHandle put: aFloat.
]

{ #category : #allocate }
PhaROS2_allocation class >> stringToPointer: aString [
	|data|
	data := FFIExternalArray externalNewType: 'char' size: (aString size + 1).
	aString doWithIndex: [ :char :index | data at: index put: char ].
	data at: (aString size+1) put: (Character null).
	^data
]
