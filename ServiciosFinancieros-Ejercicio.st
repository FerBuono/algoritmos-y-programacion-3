!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'fb 6/2/2023 18:41:37'!
test01EmptyPortfolioHasBalanceOf0

	| portfolio |
	portfolio := Portfolio new.
	
	self assert: portfolio balance equals: 0 * peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'fb 6/2/2023 18:45:21'!
test02PortfolioCanAddAnAccount

	| portfolio account |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio addAccount: account.
	
	self assert: portfolio accounts size > 0.
	self assert: portfolio accounts includes: account.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'fb 6/2/2023 18:52:59'!
test03PortfolioWithMultipleAccountsCanCalculateItsBalance

	| portfolio account1 account2 account3 |
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	portfolio addAccount: account3.
	
	Deposit register: 50 * peso on: account1.
	Deposit register: 100 * peso on: account2.
	Deposit register: 500 * peso on: account3.
	Withdraw register: 50 * peso on: account3.
		
	self assert: portfolio balance equals: 600 * peso.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'fb 6/2/2023 18:53:22'!
test04PortfolioWithOneAccountCanCalculateItsBalance

	| portfolio account |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio addAccount: account.
	
	Deposit register: 50 * peso on: account.
	
	self assert: portfolio balance equals: 50 * peso.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'fb 6/2/2023 18:55:43'!
test05PortfolioCanAddAPortfolio

	| portfolio1 portfolio2 |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio1 addAccount: portfolio2.
	
	self assert: portfolio1 accounts includes: portfolio2.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'fb 6/2/2023 19:05:45'!
test06PortfolioCanAddAPortfolioWithAccountsInIt

	| portfolio1 portfolio2 account1 account2 |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.	
	
	portfolio2 addAccount: account1 .
	portfolio2 addAccount: account2 .
		
	portfolio1 addAccount: portfolio2.
	
	self assert: (portfolio1 includesAccount: account1).
	self assert: (portfolio1 includesAccount: account2).	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'fb 6/2/2023 19:19:58'!
test07PortfolioWithAPortfolioInsideCanCalculateBalance

	| portfolio1 portfolio2 account1 account2 |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.	
	
	Deposit register: 50 * peso on: account1.
	Deposit register: 100 * peso on: account2.
	
	portfolio2 addAccount: account1 .
	portfolio2 addAccount: account2 .
		
	portfolio1 addAccount: portfolio2.
	
	self assert: portfolio1 balance equals: 150 * peso.	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'fb 6/2/2023 19:24:25'!
test08PortfolioCanSearchForATransactionOfAnAccount

	| portfolio account transaction |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.

	transaction := 	Deposit register: 50 * peso on: account.
		
	portfolio addAccount: account.
	
	self assert: (portfolio hasRegistered: transaction).	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'fb 6/2/2023 19:27:37'!
test09PortfolioWithAPortfolioAndAnAccountInsideCanCalculateBalance

	| portfolio1 portfolio2 account1 account2 account3 |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.	
	account3 := ReceptiveAccount new.	
		
	Deposit register: 50 * peso on: account1.
	Deposit register: 100 * peso on: account2.
	Deposit register: 10 * peso on: account3.
	
	portfolio2 addAccount: account1 .
	portfolio2 addAccount: account2 .
		
	portfolio1 addAccount: portfolio2.
	portfolio1 addAccount: account3.
	
	self assert: portfolio1 balance equals: 160 * peso.	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'fb 6/2/2023 19:34:26'!
test10PortfolioCanGetAllTransactionsOfAnAccount

	| portfolio account testTransactions |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	testTransactions := OrderedCollection new.
	
	testTransactions add: (Deposit register: 100 * peso on: account).
	testTransactions add: (Withdraw register: 80 * peso on: account).

	portfolio addAccount: account.
	
	self assert: testTransactions equals: (portfolio transactionsOf: account).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'fd 6/5/2023 20:14:16'!
test11PortfolioCanGetAllTransactionsOfPortfolio

	| portfolio1 portfolio2 account testTransactions |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	testTransactions := OrderedCollection new.
	
	testTransactions add: (Deposit register: 100 * peso on: account).
	testTransactions add: (Withdraw register: 80 * peso on: account).

	portfolio2 addAccount: account.
	portfolio1 addAccount: portfolio2.
	
	self assert: testTransactions equals: (portfolio1 transactionsOf: portfolio2).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'fd 6/5/2023 20:17:59'!
test12PortfolioCantAddAnAccountTwice

	| portfolio account  |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio addAccount: account.
	self should: [portfolio addAccount: account]
		raise: Error
		withMessageText: 'The account its already included, can not add it twice'
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'fd 6/5/2023 20:36:05'!
test13PortfolioCantIncludeItself

	| portfolio   |
	portfolio := Portfolio new.	
	
	self should: [portfolio addAccount: portfolio.]
		raise: Error
		withMessageText: 'Portfolio can not add itself'
	
	! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'receptiveAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fd 6/6/2023 11:50:03'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	self assert: 0 equals: receptiveAccount balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fd 6/6/2023 11:50:09'!
test02DepositIncreasesBalanceOnTransactionValue 


	Deposit register: 100 * peso on: receptiveAccount.
		
	self assert: 100 * peso equals: receptiveAccount balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fd 6/6/2023 11:50:17'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	Deposit register: 100 * peso on: receptiveAccount.
	Withdraw register: 50 * peso on: receptiveAccount.
		
	self assert: 50 * peso equals: receptiveAccount balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fd 6/6/2023 11:50:35'!
test04WithdrawValueMustBePositive 

	|  withdrawValue |
	
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: receptiveAccount) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fd 6/6/2023 11:50:49'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	|  deposit withdraw |
	
	deposit := Deposit register: 100 * peso on: receptiveAccount.
	withdraw := Withdraw register: 50 * peso on: receptiveAccount.
		
	self assert: (receptiveAccount hasRegistered: deposit).
	self assert: (receptiveAccount hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fd 6/6/2023 11:50:57'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	|  deposit withdraw |
	
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (receptiveAccount hasRegistered: deposit).
	self deny: (receptiveAccount hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fd 6/6/2023 11:51:06'!
test07AccountKnowsItsTransactions 

	|  deposit |

	
	deposit := Deposit register: 50 * peso on: receptiveAccount.
		
	self assert: 1 equals: receptiveAccount transactions size.
	self assert: (receptiveAccount transactions includes: deposit).
! !


!ReceptiveAccountTest methodsFor: 'setup' stamp: 'fd 6/6/2023 11:49:49'!
setUp
	receptiveAccount := ReceptiveAccount new.! !


!classDefinition: #TransferenceTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: 'receivingAccount remitentAccount emptyAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceTest methodsFor: 'tests' stamp: 'fd 6/6/2023 12:05:50'!
assertThat: aTransferenceLeg isCounterpartOf: anotherTransferenceLeg

	self assert: (aTransferenceLeg counterpart) equals: anotherTransferenceLeg.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'fd 6/6/2023 12:01:30'!
test01AnAccountCanTransferMoneyToAnotherAccount

	
	Transference from: remitentAccount to: receivingAccount ofValue: 50 * peso.

	self assert: 0 * peso equals: remitentAccount balance.
	self assert: 50 * peso equals: receivingAccount balance.
! !

!TransferenceTest methodsFor: 'tests' stamp: 'fd 6/6/2023 12:01:55'!
test02CanObtainValueOfATransference
	|  transfer |
	

	transfer := Transference from: remitentAccount to: receivingAccount ofValue: 50 * peso.

	self assert: 50 * peso equals: transfer value.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'fd 6/6/2023 12:06:10'!
test03ExtractionLegKnowsItsCounterpart
	|   transfer |
	
	transfer := Transference from: remitentAccount to: receivingAccount ofValue: 50 * peso.

	self assertThat: transfer extractionLeg isCounterpartOf: transfer depositLeg
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'fd 6/6/2023 12:06:31'!
test04DepositLegKnowsItsCounterpart
	|   transfer |
	
	transfer := Transference from: remitentAccount to: receivingAccount ofValue: 50 * peso.

	self assertThat: transfer depositLeg isCounterpartOf: transfer extractionLeg.

	! !

!TransferenceTest methodsFor: 'tests' stamp: 'fd 6/6/2023 12:04:06'!
test05AnAccountCantTransferWithoutFunds
	
	self should: [Transference from: emptyAccount to: receivingAccount ofValue: 50 * peso]
		raise: Error
		withMessageText: 'Insufficient balance'
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'fd 6/6/2023 12:04:20'!
test06TransferenceValueCantBeNegative

	self should: [Transference from: remitentAccount to: receivingAccount ofValue: -50 * peso]
		raise: Error
		withMessageText: 'Transference value can not be negative'
	! !


!TransferenceTest methodsFor: 'setup' stamp: 'fd 6/6/2023 12:03:56'!
setUp
	receivingAccount := ReceptiveAccount new.
	remitentAccount := ReceptiveAccount new.
	emptyAccount := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: remitentAccount .! !


!classDefinition: #Account category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Account methodsFor: 'accessing' stamp: 'fd 6/6/2023 11:46:14'!
balance
	self subclassResponsibility ! !

!Account methodsFor: 'accessing' stamp: 'fd 6/6/2023 11:44:37'!
transactions 
	self subclassResponsibility ! !


!Account methodsFor: 'checking' stamp: 'fd 6/6/2023 11:45:29'!
hasRegistered: anAccount
	self subclassResponsibility ! !

!Account methodsFor: 'checking' stamp: 'fd 6/6/2023 11:45:54'!
includesAccount: anAccount
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'accessing' stamp: 'fb 6/2/2023 18:47:37'!
accounts

	^accounts! !

!Portfolio methodsFor: 'accessing' stamp: 'fb 6/2/2023 18:51:23'!
balance
	^accounts sum: [:anAccount | anAccount balance] ifEmpty: [^0 * peso].! !

!Portfolio methodsFor: 'accessing' stamp: 'fd 6/5/2023 20:14:31'!
transactions
	
	accounts do: [:anAccount | transactions addAll: (anAccount transactions)].
	
	^transactions copy.
	! !


!Portfolio methodsFor: 'initialization' stamp: 'fb 6/2/2023 19:39:11'!
initialize

	accounts := OrderedCollection new.
	transactions := OrderedCollection new.! !


!Portfolio methodsFor: 'private' stamp: 'fd 6/5/2023 20:40:50'!
cantBeIncludedItSelf: anAccount

	^(self = anAccount) ifTrue: [self error: 'Portfolio can not add itself'].
! !

!Portfolio methodsFor: 'private' stamp: 'fd 6/5/2023 20:38:54'!
isAlreadyIncluded: anAccount
	 ^(self includesAccount: anAccount) ifTrue: [self error: 'The account its already included, can not add it twice'].! !


!Portfolio methodsFor: 'checking' stamp: 'fb 6/2/2023 19:25:49'!
hasRegistered: aTransaction 
	accounts do: [:anAccount | ^anAccount hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'checking' stamp: 'fd 6/6/2023 11:28:28'!
includesAccount: anAccount
	^accounts anySatisfy: [ :account | (account = anAccount) or: (account includesAccount: anAccount)]! !

!Portfolio methodsFor: 'checking' stamp: 'fb 6/5/2023 15:20:54'!
transactionsOf: anAccountToFind

	accounts do: [:anAccount | (anAccount = anAccountToFind) ifTrue: [^anAccount transactions]].! !


!Portfolio methodsFor: 'actions' stamp: 'fd 6/5/2023 20:40:29'!
addAccount: anAccount 
	(self isAlreadyIncluded: anAccount).
	(self cantBeIncludedItSelf: anAccount).
	accounts add: anAccount.! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'checking' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'checking' stamp: 'fb 6/2/2023 19:13:30'!
includesAccount: anAccountToSearch 
	^self = anAccountToSearch .! !


!ReceptiveAccount methodsFor: 'accessing' stamp: 'fb 6/1/2023 20:41:42'!
balance

	^transactions sum: [ :aTransaction | aTransaction netValue ] ifEmpty: [ 0 * peso ]! !

!ReceptiveAccount methodsFor: 'accessing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'actions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'accesing' stamp: 'fd 6/5/2023 20:04:51'!
value 

	^value! !


!AccountTransaction methodsFor: 'initialization' stamp: 'fd 6/5/2023 20:04:27'!
initializeFor: aValue

	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'fd 6/5/2023 20:07:06'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'accessing' stamp: 'fb 6/1/2023 15:53:59'!
netValue

	^ value! !

!Deposit methodsFor: 'accessing' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferenceDepositLeg category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferenceDepositLeg
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceDepositLeg methodsFor: 'accessing' stamp: 'fd 6/5/2023 20:00:53'!
counterpart
	^transference counterpartOf: self.! !

!TransferenceDepositLeg methodsFor: 'accessing' stamp: 'fd 6/5/2023 20:05:56'!
netValue
	^value! !


!TransferenceDepositLeg methodsFor: 'initialization' stamp: 'fd 6/5/2023 20:07:59'!
initializeFor: aValue Of: ATransference
	value := aValue.
	transference  := ATransference.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceDepositLeg class' category: 'ServiciosFinancieros-Ejercicio'!
TransferenceDepositLeg class
	instanceVariableNames: ''!

!TransferenceDepositLeg class methodsFor: 'instance creation' stamp: 'fd 6/5/2023 20:11:49'!
register: aValue of: aTransference on: anAccount
	
	| depositLeg |
	
	depositLeg := self new initializeFor: aValue Of: aTransference.
	anAccount register: depositLeg.
		
	^ depositLeg! !


!classDefinition: #TransferenceExtractionLeg category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferenceExtractionLeg
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceExtractionLeg methodsFor: 'accessing' stamp: 'fd 6/5/2023 20:01:00'!
counterpart
	^transference counterpartOf: self.! !

!TransferenceExtractionLeg methodsFor: 'accessing' stamp: 'fd 6/5/2023 20:06:07'!
netValue
	^value negated! !


!TransferenceExtractionLeg methodsFor: 'initialization' stamp: 'fd 6/5/2023 20:08:11'!
initializeFor: aValue Of: ATransference
	value := aValue.
	transference  := ATransference.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceExtractionLeg class' category: 'ServiciosFinancieros-Ejercicio'!
TransferenceExtractionLeg class
	instanceVariableNames: ''!

!TransferenceExtractionLeg class methodsFor: 'instance creation' stamp: 'fd 6/5/2023 20:12:25'!
register: aValue of: aTransference on: anAccount
	
	| extractionLeg |
	
	extractionLeg := self new initializeFor: aValue Of: aTransference.
	anAccount register: extractionLeg.
		
	^ extractionLeg! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'fd 6/5/2023 20:07:11'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'accessing' stamp: 'fb 6/1/2023 15:54:09'!
netValue

	^ value negated.! !

!Withdraw methodsFor: 'accessing' stamp: 'fb 6/1/2023 15:43:22'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'receptiveAccount receptiveAccount2 simpleMeasure extractionLeg depositLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transference methodsFor: 'initialization' stamp: 'fd 6/5/2023 20:13:25'!
initializeFrom: anExtractionAccount to: aDepositAccount ofValue: anAmountToTransfer 
	
	anExtractionAccount balance < anAmountToTransfer ifTrue: [self error: 'Insufficient balance'].
	anAmountToTransfer < 0 ifTrue: [self error: 'Transference value can not be negative'].
	
	extractionLeg := TransferenceExtractionLeg register: anAmountToTransfer of: self on: anExtractionAccount.
	depositLeg := TransferenceDepositLeg register: anAmountToTransfer of: self on: aDepositAccount.
	value := anAmountToTransfer.
! !


!Transference methodsFor: 'actions' stamp: 'fd 6/6/2023 12:09:26'!
counterpartOf: aTransferenceLeg
	(aTransferenceLeg isKindOf: TransferenceDepositLeg) ifTrue: [^extractionLeg ] ifFalse: [^depositLeg].! !


!Transference methodsFor: 'accessing' stamp: 'fb 6/5/2023 14:54:06'!
depositLeg

	^depositLeg! !

!Transference methodsFor: 'accessing' stamp: 'fb 6/5/2023 14:49:45'!
extractionLeg
	^extractionLeg .! !

!Transference methodsFor: 'accessing' stamp: 'fb 6/5/2023 14:37:16'!
value 
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'ServiciosFinancieros-Ejercicio'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'fb 6/5/2023 14:27:34'!
from: aReceptiveAccount to: aReceptiveAccount2 ofValue: aSimpleMeasure 
	
	^self new initializeFrom: aReceptiveAccount to: aReceptiveAccount2 ofValue: aSimpleMeasure ! !
