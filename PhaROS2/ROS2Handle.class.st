Class {
	#name : #ROS2Handle,
	#superclass : #FFIExternalObject,
	#category : #'PhaROS2-Objects'
}

{ #category : #native }
ROS2Handle class >> ffiLibraryName [ 
	^RCLC ffiLibraryName 
]

{ #category : #'nb-library' }
ROS2Handle >> ffiLibraryName [ 
	^self class ffiLibraryName 
]
