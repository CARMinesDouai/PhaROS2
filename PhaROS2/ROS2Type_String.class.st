Class {
	#name : #'ROS2Type_String',
	#superclass : #ROS2Type,
	#category : #'PhaROS2-Type'
}

{ #category : #readData }
ROS2Type_String >> nextString [ 
	^data getHandle readString 
]
