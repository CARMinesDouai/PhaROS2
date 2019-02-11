Class {
	#name : #'PhaROS2_allocation',
	#superclass : #Object,
	#category : #'PhaROS2-Util'
}

{ #category : #allocate }
PhaROS2_allocation class >> stringToPointer: aString [
	|data|
	data := FFIExternalArray externalNewType: 'char' size: (aString size + 1).
	aString doWithIndex: [ :char :index | data at: index put: char ].
	data at: (aString size+1) put: (Character null).
	^data
]
