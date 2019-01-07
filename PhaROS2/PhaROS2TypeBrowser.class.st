Class {
	#name : #PhaROS2TypeBrowser,
	#superclass : #Object,
	#instVars : [
		'browse'
	],
	#category : #'PhaROS2-Type'
}

{ #category : #Initialization }
PhaROS2TypeBrowser >> initialize [ 
	super initialize.
	
	browse := Dictionary new.
	
	
]
