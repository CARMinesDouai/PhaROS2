Class {
	#name : #'ROS2_Callback',
	#superclass : #FFICallback,
	#category : #'PhaROS2-Struct'
}

{ #category : #native }
ROS2_Callback class >> mySignature [
	self subclassResponsibility 
]

{ #category : #native }
ROS2_Callback class >> on: aBlock [
	^self signature: self mySignature
	 block: aBlock
]
