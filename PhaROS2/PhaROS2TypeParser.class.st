Class {
	#name : #PhaROS2TypeParser,
	#superclass : #Object,
	#category : #'PhaROS2-Util'
}

{ #category : #parsing }
PhaROS2TypeParser class >> computeClassName: aType [
	|tmp|
	tmp := aType capitalized.
	tmp := tmp replaceAll: $/ with: $_.
	^tmp
]

{ #category : #parsing }
PhaROS2TypeParser class >> computeClassName: aType package: aPackage [
	|tmp|
	(PhaROS2_Type isPrimitive: aType) ifTrue: [ ^PhaROS2_Type toUFFIName: aType ] ifFalse: [ 
		tmp := aPackage,'/',aType.
		tmp := tmp capitalized.
		tmp := tmp replaceAll: $/ with: $_.
	].
	^tmp
]

{ #category : #parsing }
PhaROS2TypeParser class >> computeFieldsDescOf: aType package: aPackage [
	| field output part |
	field := ''.
	output := (PipeableOSProcess command: 'ros2 msg show ',aType)output.
	(output isEmpty) ifTrue: [ self error: 'Type empty or not exist on ',aType ]
	ifFalse: [ 
			output linesDo: [ :line | (line isEmpty) ifFalse: [part := self parseROS2Line: line package: aPackage. part isEmpty ifFalse: [ field := field, part, ';', String lf ]]].
		 ].
	^'^#(',String lf,field,String lf,')'
]

{ #category : #parsing }
PhaROS2TypeParser class >> computeROS2Name: aType package: aPackage [
	| tmp |
	tmp := (aType indexOf: $/) == 0
		ifTrue: [ aPackage , '/' , aType ]
		ifFalse: [ aType ].
	^ tmp
]

{ #category : #parsing }
PhaROS2TypeParser class >> extractDomainOf: aType [
	^(aType substrings: '/') at: 1.
]

{ #category : #parsing }
PhaROS2TypeParser class >> extractTypeNameOf: aType [
	^(aType substrings: '/') at: 2.
]

{ #category : #parsing }
PhaROS2TypeParser class >> parseROS2Line: aLine package: aPackage [
	| typeName isPrimitive openBraket closeBraket innerType typeType vPhaROS2Class typeClass|
	"Different possibiliy:
	
	Start with # --> Commented so just pass.
	
	Type
	Type[]		Juste une *
	Type[n]	un tableau [n]
	"
	^((aLine at: 1) == $#) ifTrue: [ '' ]
	ifFalse:
	[ 
		typeType := (aLine substrings: ' ') at: 1.
		typeName := (aLine substrings: ' ') at: 2.
		typeClass := PhaROS2TypeParser computeClassName: ((typeType substrings: '[') at:1) package: aPackage.
		openBraket := aLine indexOf: $[.
		isPrimitive := (PhaROS2_Type isPrimitive: ((typeType substrings: '[') at:1)).
		openBraket = 0 ifTrue: [ 
			" Is a common type "
			isPrimitive ifTrue: [ 
				"Is a primitive type"
				^typeClass, String space, typeName
			]
			ifFalse:
			[
				"Ask the typeBrowser the correct class (it will create if not exists)" 
				vPhaROS2Class := PhaROS2TypeBrowser instance need: (PhaROS2TypeParser computeROS2Name: typeType package: aPackage).
				^vPhaROS2Class name,String space,typeName.
			]
		].
		"They have an openBracket"
		closeBraket := aLine indexOf:$].
		innerType :=  aLine copyFrom: 1 to: openBraket -1.
		openBraket + 1 = closeBraket  ifTrue: [ 
		" Is a typed array  "
			isPrimitive ifTrue: [ 
					^typeClass,$*, String space, typeName
				 ]
			ifFalse: [ 
					vPhaROS2Class := PhaROS2TypeBrowser instance need: (PhaROS2TypeParser computeROS2Name: typeType package: aPackage).
				^vPhaROS2Class name,$*,String space,typeName.
				 ]
	 	] ifFalse: [ 
			" Is a typed array with fixed size "
			isPrimitive ifTrue: [ 
					^typeClass,'[',innerType,']', String space, typeName
				 ]
			ifFalse: [ 
				vPhaROS2Class := PhaROS2TypeBrowser instance need: (PhaROS2TypeParser computeROS2Name: typeType package: aPackage).
				^vPhaROS2Class name,'[',innerType,']',String space,typeName.
			 ]
		 ].
	 ]
	
]

{ #category : #parsing }
PhaROS2TypeParser class >> parseROS2Type: aType [
	| vdomain vname vclassName fieldsDesc vclass zClass|
	vdomain := self extractDomainOf: aType.
	vname := self extractTypeNameOf: aType.
	vclassName := self computeClassName: aType.
	fieldsDesc := self computeFieldsDescOf: aType package: vdomain.
	Transcript crShow:'Class name: ';show: vclassName;crShow: fieldsDesc.
	zClass := ROS2_TypeSupport_struct 
				subclass: vclassName,'_struct' asSymbol
				instanceVariableNames: ''
				classVariableNames: ''
				package: 'PhaROS2-Struct'.
	
	zClass class compile: 'fieldsDesc ',String lf, '^#(',String lf,vclassName,'* rosidl_message_type_support; int sizeof;)'.
	
	vclass := PhaROS2_Type
				subclass: vclassName asSymbol
				instanceVariableNames: ''
				classVariableNames: ''
				package: 'PhaROS2-Type'.
	vclass class compile: 'fieldsDesc ',String lf , fieldsDesc.
	vclass class compile: 'typeSupport', String lf, '^', zClass name.
	
	vclass rebuildFieldAccessors.
	zClass rebuildFieldAccessors.
	
	PhaROS_Msgs registerNewType: aType.
	
	^vclass
]
