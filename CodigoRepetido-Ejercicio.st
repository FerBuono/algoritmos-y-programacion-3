!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 4/24/2023 13:12:36'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	customerBook := CustomerBook new.
	
	self assertThat: [customerBook addCustomerNamed: 'John Lennon'] isLowerThanMilliseconds: 50 * millisecond.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 4/24/2023 13:12:45'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook paulMcCartney |
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self assertThat: [customerBook addCustomerNamed: paulMcCartney] isLowerThanMilliseconds: 100 * millisecond.	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 4/24/2023 14:17:31'!
test03CanNotAddACustomerWithEmptyName 
	| customerBook |
	customerBook := CustomerBook new.

	self should: [customerBook addCustomerNamed: '']
		raise: Error
		withMessageText: CustomerBook customerCanNotBeEmptyErrorMessage.
		
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 4/24/2023 21:50:29'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
		self should: [customerBook removeCustomerNamed: 'Paul McCartney'.] 
	raise: Error
	withMessageText: CustomerBook customerDoesNotExistsErrorMessage.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 4/24/2023 22:05:17'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	| customerBook paulMcCartney|
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.


	self assertThat: customerBook activeCustomersAre: 0 andSuspendedCustomersAre: 1 andTotalCustomersAre: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 4/24/2023 22:05:37'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney..

	self assertThat: customerBook activeCustomersAre: 0 andSuspendedCustomersAre: 0 andTotalCustomersAre: 0.

	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 4/24/2023 21:53:41'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self should: [customerBook suspendCustomerNamed: 'Ringo Starr'.] 
	raise: Error
	withMessageText: CustomerBook customerDoesNotExistsErrorMessage.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 4/24/2023 21:56:51'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.	
	self should: [customerBook suspendCustomerNamed: johnLennon.] 
	raise: Error
	withMessageText: CustomerBook customerAlreadySuspendedErrorMessage.
! !


!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'fd 4/24/2023 22:04:11'!
assertThat: aCustomerBook activeCustomersAre: numberOfActiveCustomers andSuspendedCustomersAre: numberOfSuspendedCustomers andTotalCustomersAre: numberOfTotalCustomers
	
	self assert: numberOfActiveCustomers equals: (aCustomerBook numberOfActiveCustomers).
	self assert: numberOfSuspendedCustomers equals: (aCustomerBook numberOfSuspendedCustomers).
	self assert: numberOfTotalCustomers equals: (aCustomerBook numberOfCustomers).
	! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'fd 4/24/2023 13:18:52'!
assertThat: actionBlockClosure isLowerThanMilliseconds: aTimeInMilliseconds
	
	^(actionBlockClosure millisecondsToRun < aTimeInMilliseconds)! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'fd 4/24/2023 20:56:40'!
assertThatCustomerGroup: aCustomerBook hasAnAmountOf: aNumberOfCustomers
	
	 self assert: aNumberOfCustomers equals: (aCustomerBook size).! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'fd 4/24/2023 14:14:30'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'fd 4/24/2023 21:51:20'!
removeCustomerNamed: aName 
 	active remove: aName ifAbsent: [suspended remove: aName ifAbsent:[self signalCustomerDoesNotExists]].
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'fd 4/24/2023 21:15:31'!
signalCustomerAlreadySuspended 

	self error: self class customerAlreadySuspendedErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'fd 4/24/2023 20:34:43'!
signalCustomerDoesNotExists 

	self error: self class customerDoesNotExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'fd 4/24/2023 22:01:35'!
suspendCustomerNamed: aName 
		(suspended includes: aName) ifTrue: [self signalCustomerAlreadySuspended].
	(active includes: aName) ifFalse: [self signalCustomerDoesNotExists].
	
	active remove: aName.
	suspended add: aName
! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'fd 4/24/2023 21:16:08'!
customerAlreadySuspendedErrorMessage
	^'Customer Already Suspended'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'fd 4/24/2023 20:35:01'!
customerDoesNotExistsErrorMessage

	^'Customer Does Not Exists'! !
