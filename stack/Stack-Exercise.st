!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'testEmptyStack testNotEmptyStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'fb 5/9/2023 11:54:19'!
setUp

    testEmptyStack := OOStack new.
    testNotEmptyStack := OOStack new.

    testNotEmptyStack push:  'Hola que tal'.
    testNotEmptyStack push: 'aguante boca'.
    testNotEmptyStack push: 'y la seleccion'.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'fb 5/9/2023 11:55:07'!
test01findPrefixInEmptyStack
	| finder prefixes emptyCollection | 
	
	finder := SentenceFinderByPrefix with: testEmptyStack.
	emptyCollection := OrderedCollection new.
    	prefixes := finder find: 'Hola'.
	
    	self assert: prefixes equals:     emptyCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'fb 5/9/2023 11:55:50'!
test02findPrefixInNotEmptyStack
	| finder equalSentences auxCollection | 

    
	auxCollection := OrderedCollection new.    
	auxCollection add: 'Hola que tal'.

	finder := SentenceFinderByPrefix with: testNotEmptyStack.

	equalSentences := finder find: 'Hola'.
    
	self assert: equalSentences equals: auxCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'fb 5/9/2023 11:56:48'!
test03findDoesNotModifyStack
	| finder equalSentences auxCollection | 
	auxCollection := OrderedCollection new.    
	auxCollection add: 'Hola que tal'.
    
	finder := SentenceFinderByPrefix with: testNotEmptyStack. 

	equalSentences := finder find: 'Hola'.
	self assert: equalSentences equals: auxCollection.
	self assert: testNotEmptyStack pop equals: 'y la seleccion'.
	self assert: testNotEmptyStack pop equals: 'aguante boca'.
	self assert: testNotEmptyStack pop equals: 'Hola que tal'.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'fb 5/9/2023 11:58:12'!
test04finderWithEmptyPrefixShouldReturnError
	| finder   | 
    
	finder := SentenceFinderByPrefix with: testEmptyStack.
        
	self should: [finder find: ''.] raise: Error withMessageText: SentenceFinderByPrefix prefixCantBeEmptyError.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'fb 5/9/2023 11:58:47'!
test05finderWithBlankSpacePrefixShouldReturnError
	| finder   | 
    
	finder := SentenceFinderByPrefix with: testNotEmptyStack.
        
	self should: [finder find: 'Hola que'.] raise: Error withMessageText: SentenceFinderByPrefix prefixCantHaveBlankSpaceError.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'fb 5/9/2023 12:04:38'!
test06finderIsCaseSensitive
	| equalSentences finder  auxCollection | 
	auxCollection := OrderedCollection new.

	finder := SentenceFinderByPrefix with: testNotEmptyStack.
	equalSentences := finder find: 'hola'.

	self assert: equalSentences equals: auxCollection.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'fd 5/6/2023 20:07:45'!
isEmpty
	^elements isEmpty! !


!OOStack methodsFor: 'operations' stamp: 'fd 5/6/2023 20:43:15'!
pop
	| lastTop |

	self checkIfStackIsEmpty.	
	"(self isEmpty) ifTrue: [self error: self class stackEmptyErrorDescription ]."
	lastTop := elements removeLast.
	self updateState.
	^lastTop! !

!OOStack methodsFor: 'operations' stamp: 'fd 5/8/2023 14:53:43'!
push: anElement
	elements add: anElement.
	self updateState.! !

!OOStack methodsFor: 'operations' stamp: 'fd 5/6/2023 20:08:41'!
size
	^elements size! !

!OOStack methodsFor: 'operations' stamp: 'fd 5/6/2023 20:40:34'!
top
	self checkIfStackIsEmpty.

	^elements last! !


!OOStack methodsFor: 'state' stamp: 'fd 5/6/2023 20:40:15'!
checkIfStackIsEmpty
	state emptyStateShouldRaise: self class stackEmptyErrorDescription.! !

!OOStack methodsFor: 'state' stamp: 'fd 5/6/2023 20:30:12'!
updateState
	state := State with: self.
	"
	(elements isEmpty) ifTrue:[state := EmptyState new].
	(elements isEmpty not) ifTrue:[state := NotEmptyState new.]"! !


!OOStack methodsFor: 'initializing' stamp: 'fb 5/9/2023 12:00:59'!
initialize
	elements := OrderedCollection new.
	state := EmptyState new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'actions' stamp: 'fb 5/9/2023 12:04:11'!
find: aPrefix
	| aux lastSentence prefixesFound | 
	aux := OOStack new.
	prefixesFound := OrderedCollection new.
	
	(aPrefix includesSubString: ' ') ifTrue: [self error: self class prefixCantHaveBlankSpaceError ].
	(aPrefix isEmpty) ifTrue: [self error: self class prefixCantBeEmptyError ].	
	
	stack size timesRepeat: [
		lastSentence := stack pop.

		(lastSentence beginsWith: aPrefix) ifTrue: [prefixesFound  	add: 		lastSentence].
		
		aux push: lastSentence  ]. 
	
	aux size timesRepeat: [stack push: aux pop].
	
	^prefixesFound.
	
	! !


!SentenceFinderByPrefix methodsFor: 'initializing' stamp: 'fd 5/8/2023 22:19:31'!
initializeWith: aStack
	stack := aStack! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: 'stack prefixToLookFor'!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'fb 5/9/2023 12:01:43'!
prefixCantBeEmptyError
	^'Prefix can´t be empty'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'fb 5/9/2023 12:02:05'!
prefixCantHaveBlankSpaceError
	^'Prefix can´t have blank spaces'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'fd 5/8/2023 22:20:28'!
with: aStack
	^self new initializeWith: aStack! !


!classDefinition: #State category: 'Stack-Exercise'!
Object subclass: #State
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!State methodsFor: 'as yet unclassified' stamp: 'fd 5/6/2023 20:44:13'!
emptyStateShouldRaise: anError
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'State class' category: 'Stack-Exercise'!
State class
	instanceVariableNames: ''!

!State class methodsFor: 'as yet unclassified' stamp: 'fd 5/6/2023 20:29:16'!
fitting: aStack
	self subclassResponsibility ! !

!State class methodsFor: 'as yet unclassified' stamp: 'fd 5/8/2023 14:54:41'!
with: aStack
	^State subclasses detect: [:aSubclass | aSubclass fitting: aStack] ifFound: [:selectedSubclass | selectedSubclass new] ifNone:[]! !


!classDefinition: #EmptyState category: 'Stack-Exercise'!
State subclass: #EmptyState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyState methodsFor: 'as yet unclassified' stamp: 'fd 5/6/2023 20:44:06'!
emptyStateShouldRaise: anError
	^self error: anError! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyState class' category: 'Stack-Exercise'!
EmptyState class
	instanceVariableNames: ''!

!EmptyState class methodsFor: 'as yet unclassified' stamp: 'fd 5/6/2023 20:28:32'!
fitting: aStack
	^aStack isEmpty! !


!classDefinition: #NotEmptyState category: 'Stack-Exercise'!
State subclass: #NotEmptyState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyState methodsFor: 'as yet unclassified' stamp: 'fd 5/6/2023 20:37:31'!
emptyStateShouldRaise: anError
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyState class' category: 'Stack-Exercise'!
NotEmptyState class
	instanceVariableNames: ''!

!NotEmptyState class methodsFor: 'as yet unclassified' stamp: 'fd 5/6/2023 20:28:48'!
fitting: aStack
	^aStack isEmpty not! !
