Class {
	#name : #'ROS2Type_Int32',
	#superclass : #ROS2Type,
	#category : #'PhaROS2-Type'
}

{ #category : #read }
ROS2Type_Int32 >> nextInt32 [
	^data getHandle asInteger.
]
