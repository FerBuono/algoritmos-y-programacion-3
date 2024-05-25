!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: 'account accountSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'fd 6/13/2023 15:03:55'!
assertThatTheReportGeneratedEquals: aStringToCompare

 	
	self assert: aStringToCompare equals: accountSummary generateReport.
	
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'fd 6/13/2023 15:36:42'!
test01AccountSummaryOfAnAccountWithNoTransactionsHasZeroBalance

 	
	accountSummary := AccountSummary of: account.
		
	self assertThatTheReportGeneratedEquals: (OrderedCollection with: 	'Balance = 0 pesos').
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'fd 6/13/2023 15:37:55'!
test02AccountSummaryOfAnAccountWithADepositIsGeneratedCorrectly
	
	Deposit register: 10 * peso on: account.
	accountSummary := AccountSummary of: account.

	self assertThatTheReportGeneratedEquals: (OrderedCollection with:	'Depósito por 10 pesos' with: 'Balance = 10 pesos').


	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'fd 6/13/2023 15:38:48'!
test03AccountSummaryOfAnAccountWithADepositAndAWithdrawIsGeneratedCorrectly
	
	Deposit register: 10 * peso on: account.
	Withdraw register: 6 * peso on: account.
	accountSummary := AccountSummary of: account.


	self assertThatTheReportGeneratedEquals:  (OrderedCollection with:	'Depósito por 10 pesos'
with: 'Extracción por 6 pesos' with: 'Balance = 4 pesos').



	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'fd 6/13/2023 15:39:10'!
test04AccountSummaryOfAnAccountThatMakesTransferenceIsGeneratedCorrectly

	|  anotherReceptiveAccount  |
	
	anotherReceptiveAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: account.
	Transfer amount: 5 * peso from: account  to: anotherReceptiveAccount.
	accountSummary := AccountSummary of: account.

	self assertThatTheReportGeneratedEquals:  (OrderedCollection with:	'Depósito por 10 pesos' with: 'Salida por transferencia de 5 pesos' with: 'Balance = 5 pesos').




	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'fd 6/13/2023 15:39:31'!
test05AccountSummaryOfAnAccountThatReceivesTransferenceIsGeneratedCorrectly

	|   destinationAccount  |
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: account.
	Transfer amount: 5 * peso from: account  to: destinationAccount.
	accountSummary := AccountSummary of: destinationAccount.
	

	self assertThatTheReportGeneratedEquals:  (OrderedCollection with: 'Entrada por transferencia de 5 pesos' with: 'Balance = 5 pesos').


	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'fd 6/13/2023 15:40:15'!
test06AccountSummaryOfAPortfolioWithMultipleTransactionsIsGeneratedCorrectly

	|  portfolio  anotherAccount  |
	
	portfolio := Portfolio with: account.
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
	Transfer amount: 20 * peso from: account  to: anotherAccount.
	Deposit register: 30 * peso on: anotherAccount .
	Transfer amount: 30 * peso from: anotherAccount  to: account.
	accountSummary := AccountSummary of: portfolio.
	
	self assertThatTheReportGeneratedEquals:  (OrderedCollection with: 'Depósito por 100 pesos' with: 'Extracción por 50 pesos' with: 'Salida por transferencia de 20 pesos'
		with: 'Entrada por transferencia de 30 pesos' with: 'Balance = 60 pesos').



	! !


!AccountSummaryTest methodsFor: 'setup' stamp: 'fd 6/13/2023 14:57:24'!
setUp
	account := ReceptiveAccount new.! !


!classDefinition: #PortfolioDetailedTreePrinterTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioDetailedTreePrinterTest
	instanceVariableNames: 'portfolioTree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'fb 6/13/2023 17:31:44'!
assertThatTheDetailedTreePrinterReportEquals: aDetailedTreePrinterReport
	
	
	self assert: (portfolioTree generateReport) equals: aDetailedTreePrinterReport .
	
! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'fb 6/13/2023 17:31:44'!
test01PortfolioTreePrinterReturnsReportOfAnEmptyPortfolio
	| portfolio |
	
	portfolio := Portfolio named: 'Mi Portfolio'.
	
	portfolioTree := PortfolioDetailedTreePrinter of: portfolio.
	
	self assertThatTheDetailedTreePrinterReportEquals: (OrderedCollection 
												with: 'Mi Portfolio' 
												with: String tab, 'Balance = 0 pesos').! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'fb 6/13/2023 17:31:44'!
test02PortfolioDetailedTreePrinterReturnsReportOfASingleAccountPortfolio
	| portfolio account |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
	portfolio := Portfolio named: 'Mi Portfolio' with: account.
	Deposit register: 100 * peso on: account.
	
	portfolioTree := PortfolioDetailedTreePrinter of: portfolio.
	
	self assertThatTheDetailedTreePrinterReportEquals: (OrderedCollection 
												with: 'Mi Portfolio'
												with: String tab, 'Mi cuenta'
												with: String tab, String tab, 'Depósito por 100 pesos'
												with: String tab, String tab, 'Balance = 100 pesos'
												with: String tab, 'Balance = 100 pesos').! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'fb 6/13/2023 17:33:26'!
test03PortfolioDetailedTreePrinterReturnsReportOfAMultipleAccountPortfolio
	| portfolio oneAccount anotherAccount treeCollection |
	
	treeCollection := OrderedCollection new.
	oneAccount := ReceptiveAccount named: 'Cuenta 1'.
	Deposit register: 100 * peso on: oneAccount.
	anotherAccount := ReceptiveAccount named: 'Cuenta 2'.
	Transfer amount: 50 * peso from: oneAccount to: anotherAccount.
	
	portfolio := Portfolio named: 'Mi Portfolio' with: oneAccount with: anotherAccount.
	
	treeCollection add: 'Mi Portfolio'.
	treeCollection add: String tab, 'Cuenta 1'.
	treeCollection add: String tab, String tab, 'Depósito por 100 pesos'.
	treeCollection add: String tab, String tab, 'Salida por transferencia de 50 pesos'.
	treeCollection add: String tab, String tab, 'Balance = 50 pesos'.
	treeCollection add: String tab, 'Cuenta 2'.
	treeCollection add: String tab, String tab, 'Entrada por transferencia de 50 pesos'.
	treeCollection add: String tab, String tab, 'Balance = 50 pesos'.
	treeCollection add: String tab, 'Balance = 100 pesos'.

	portfolioTree := PortfolioDetailedTreePrinter of: portfolio.
	
	self assertThatTheDetailedTreePrinterReportEquals: treeCollection .! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'fb 6/13/2023 17:32:45'!
test04PortfolioDetailedTreePrinterReturnsReportOfAPortfolioThatIncludesMultipleAccountsAndPortfolios
	
	| treeCollection angiesAccount childrenPortfolio familyPortfolio johnsAccount myAccount |
	
	treeCollection := OrderedCollection new.
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 
	myAccount := ReceptiveAccount named: 'Cuenta mia'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	Deposit register: 100 * peso on: myAccount.
	Withdraw register: 50 * peso on: myAccount.
	Transfer amount: 20 * peso from: myAccount to: angiesAccount.
	Deposit register: 10 * peso on: johnsAccount.
	Withdraw register: 2 * peso on: johnsAccount.
	
	treeCollection add: 'Portfolio de la familia'.
	treeCollection add: String tab, 'Cuenta mia'.
	treeCollection add: String tab, String tab, 'Depósito por 100 pesos'.
	treeCollection add: String tab, String tab, 'Extracción por 50 pesos'.
	treeCollection add: String tab, String tab, 'Salida por transferencia de 20 pesos'.
	treeCollection add: String tab, String tab, 'Balance = 30 pesos'.
	treeCollection add: String tab, 'Portfolio de hijos'.
	treeCollection add: String tab, String tab, 'Cuenta de Juan'.
	treeCollection add: String tab, String tab, String tab, 'Depósito por 10 pesos'.
	treeCollection add: String tab, String tab, String tab, 'Extracción por 2 pesos'.
	treeCollection add: String tab, String tab, String tab, 'Balance = 8 pesos'.
	treeCollection add: String tab, String tab, 'Cuenta de Angeles'.
	treeCollection add: String tab, String tab, String tab, 'Entrada por transferencia de 20 pesos'.
	treeCollection add: String tab, String tab, String tab, 'Balance = 20 pesos'.
	treeCollection add: String tab, String tab, 'Balance = 28 pesos'.
	treeCollection add: String tab, 'Balance = 58 pesos'.
	
	portfolioTree := PortfolioDetailedTreePrinter of: familyPortfolio.
	
	self assertThatTheDetailedTreePrinterReportEquals: treeCollection .! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #PortfolioTreePrinterTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTreePrinterTest
	instanceVariableNames: 'portfolioasd portfolioTree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'fb 6/13/2023 17:22:18'!
assertThatTheTreePrinterReportEquals: aDetailedTreePrinterReport

	
	self assert: (portfolioTree generateReport) equals: aDetailedTreePrinterReport .
	! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'fb 6/13/2023 17:22:32'!
test01PortfolioTreePrinterReturnsReportOfAnEmptyPortfolio
	| portfolio |
	
	portfolio := Portfolio named: 'Mi portfolio'.
	portfolioTree := PortfolioTreePrinter of: portfolio.
	
	self assertThatTheTreePrinterReportEquals: (OrderedCollection with: portfolio name).! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'fb 6/13/2023 17:22:18'!
test02PortfolioTreePrinterReturnsReportOfASingleAccountPortfolio
	| portfolio account |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
	portfolio := Portfolio named: 'Mi Portfolio' with: account.

	portfolioTree := PortfolioTreePrinter of: portfolio.
	
	self assertThatTheTreePrinterReportEquals: (OrderedCollection 
												with: 'Mi Portfolio' 
												with: (String tab, 'Mi cuenta')).! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'fb 6/13/2023 17:22:18'!
test03PortfolioTreePrinterReturnsReportOfAMultipleAccountPortfolio
	| portfolio oneAccount anotherAccount |
	

	oneAccount := ReceptiveAccount named: 'Cuenta 1'.
	anotherAccount := ReceptiveAccount named: 'Cuenta 2'.
	portfolio := Portfolio named: 'Mi Portfolio' with: oneAccount with: anotherAccount.

	portfolioTree := PortfolioTreePrinter of: portfolio.
	
	self assertThatTheTreePrinterReportEquals: (OrderedCollection 
												with: 'Mi Portfolio' 
												with: (String tab, 'Cuenta 1') 
												with: (String tab, 'Cuenta 2')).! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'fb 6/13/2023 17:22:18'!
test04PortfolioTreePrinterReturnsReportOfAPortfolioThatIncludesMultipleAccountsAndPortfolios
	
	| angiesAccount childrenPortfolio familyPortfolio johnsAccount myAccount  |

	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 
	myAccount := ReceptiveAccount named: 'Cuenta mia'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	portfolioTree := PortfolioTreePrinter of: familyPortfolio.
	
	self assertThatTheTreePrinterReportEquals: (OrderedCollection 
												with: 'Portfolio de la familia' 
												with: (String tab, 'Cuenta mia') 
												with: (String tab, 'Portfolio de hijos') 
												with: (String tab, String tab, 'Cuenta de Juan') 
												with: (String tab, String tab, 'Cuenta de Angeles')).! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferNetTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: 'senderAccount receiverAccount transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNetTest methodsFor: 'tests' stamp: 'fb 6/13/2023 17:11:58'!
assertThatTheReportEquals: aTransferNetBalance
	
	self assert: aTransferNetBalance equals: transferNet generateReport.

	! !

!TransferNetTest methodsFor: 'tests' stamp: 'fb 6/13/2023 17:11:58'!
test01AnAccountWithoutTransferHasZeroTransferNet


	transferNet := TransferNet of: senderAccount .
	
	self assertThatTheReportEquals: 0 * peso.

	! !

!TransferNetTest methodsFor: 'tests' stamp: 'fb 6/13/2023 17:11:58'!
test02TransferNetOfAnAccountThatReceivesATransferIsGeneratedCorrectly

	Deposit register: 10 * peso on: senderAccount .
	Transfer amount: 10 * peso from: senderAccount to: receiverAccount .
	
	transferNet := TransferNet of: receiverAccount .
	
	self assertThatTheReportEquals: 10 * peso.


	! !

!TransferNetTest methodsFor: 'tests' stamp: 'fb 6/13/2023 17:11:58'!
test03TransferNetOfAnAccountThatMakesATransferIsGeneratedCorrectly

	
	Deposit register: 10 * peso on: senderAccount .
	Transfer amount: 10 * peso from: senderAccount to: receiverAccount .
	
	transferNet := TransferNet of: senderAccount .
	
	self assertThatTheReportEquals: -10 * peso.

	! !

!TransferNetTest methodsFor: 'tests' stamp: 'fb 6/13/2023 17:11:58'!
test04TransferNetOfAPortfolioThatHasMultipleTransfersIsGeneratedCorrectly

	| portfolio |
	
	portfolio := Portfolio with: senderAccount .

	Deposit register: 10 * peso on: senderAccount .
	Deposit register: 20 * peso on: receiverAccount .
	Transfer amount: 5 * peso from: senderAccount to: receiverAccount .
	Transfer amount: 15 * peso from: receiverAccount to: senderAccount .
	
	transferNet := TransferNet of: portfolio .
	
	self assertThatTheReportEquals: 10 * peso.


	! !


!TransferNetTest methodsFor: 'setup' stamp: 'fb 6/13/2023 17:04:18'!
setUp

	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents accountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'fb 6/12/2023 15:12:47'!
initializeNamed: aName 

	accountName := aName.! !


!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'fb 6/12/2023 15:14:59'!
accounts
	
	^accounts.! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'private' stamp: 'fb 6/12/2023 20:01:03'!
generateReportOf: aReport
	
	aReport generateReportOfAPortfolio: self.
	! !

!Portfolio methodsFor: 'private' stamp: 'fb 6/12/2023 15:12:47'!
name
	^accountName.! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'instance creation' stamp: 'fb 6/12/2023 14:39:01'!
named: aName
	
	^self new initializeNamed: aName ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'fb 6/12/2023 14:50:25'!
named: anAccountName with: anAccount 

	^self new 
		initializeNamed: anAccountName;
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'fb 6/12/2023 15:18:29'!
named: anAccountName with: anAccount with: anotherAccount 

	^self new 
		initializeNamed: anAccountName;
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions accountName name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'fb 6/12/2023 14:48:35'!
initializeNamed: anAccountName 

	accountName := anAccountName.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'private' stamp: 'fb 6/12/2023 20:00:21'!
generateReportOf: aReport
	
	aReport generateReportOfAReceptiveAccount: self.
	! !

!ReceptiveAccount methodsFor: 'private' stamp: 'fb 6/12/2023 15:12:33'!
name
	^accountName! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'fb 6/12/2023 14:48:22'!
named: anAccountName 

	^self new initializeNamed: anAccountName ! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'dd - private' stamp: 'fd 6/8/2023 12:05:24'!
generateReportOf: anAccountSummary
	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'dd - private' stamp: 'fd 6/8/2023 12:03:43'!
generateReportOf: anAccountSummary
	^ anAccountSummary generateReportOfDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'dd - private' stamp: 'fb 6/8/2023 14:44:07'!
generateReportOf: aReport
	^ aReport generateReportOfTransferDepositLeg: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'dd - private' stamp: 'fb 6/8/2023 14:44:19'!
generateReportOf: aReport
	^ aReport generateReportOfTransferWithdrawLeg: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'dd - private' stamp: 'fd 6/8/2023 12:06:30'!
generateReportOf: anAccountSummary
	^ anAccountSummary generateReportOfWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Report methodsFor: 'as yet unclassified' stamp: 'fb 6/8/2023 14:56:00'!
generateReport
	self subclassResponsibility .! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'receptiveAccount account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'fb 6/7/2023 18:21:45'!
initializeOf: anAccount 
	
	account := anAccount.! !


!AccountSummary methodsFor: 'printing' stamp: 'fd 6/13/2023 15:35:30'!
generateReport
	| accountSummaryTransactionsLines accountBalance |

	accountBalance := account balance.
	
	accountSummaryTransactionsLines := (account transactions) collect: [:aTransaction | aTransaction generateReportOf: self].
	accountSummaryTransactionsLines add: ('Balance = ', accountBalance amount asString, ' pesos').
	^accountSummaryTransactionsLines.
	
	! !


!AccountSummary methodsFor: 'dd - private' stamp: 'fd 6/8/2023 12:04:42'!
generateReportOfDeposit: aDeposit
	^ 'Depósito por ', aDeposit value amount asString, ' pesos'! !

!AccountSummary methodsFor: 'dd - private' stamp: 'fd 6/8/2023 12:08:14'!
generateReportOfTransferDepositLeg: aTransferDepositLeg
	^ 'Entrada por transferencia de ', aTransferDepositLeg value amount asString, ' pesos'! !

!AccountSummary methodsFor: 'dd - private' stamp: 'fd 6/8/2023 12:08:30'!
generateReportOfTransferWithdrawLeg: aTransferWithdrawLeg
	^ 'Salida por transferencia de ', aTransferWithdrawLeg value amount asString, ' pesos'! !

!AccountSummary methodsFor: 'dd - private' stamp: 'fd 6/8/2023 12:07:48'!
generateReportOfWithdraw: aWithdraw
	^ 'Extracción por ', aWithdraw value amount asString, ' pesos'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'fb 6/7/2023 18:21:05'!
of: aReceptiveAccount 

	^self new initializeOf: aReceptiveAccount ! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros-Solucion'!
Report subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: 'portfolio portfolioDetailedTree tabCounter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinter methodsFor: 'initialization' stamp: 'fb 6/13/2023 16:59:32'!
initializeOf: aPortfolio 

	portfolio := aPortfolio.
	portfolioDetailedTree := OrderedCollection new.
	tabCounter := ''.! !


!PortfolioDetailedTreePrinter methodsFor: 'dd - private' stamp: 'fb 6/13/2023 17:00:20'!
generateReportOfAPortfolio: aPortfolio

	portfolioDetailedTree add: tabCounter, aPortfolio name.
	tabCounter := tabCounter, String tab.
	aPortfolio accounts do: [:anAccount |		anAccount generateReportOf: self].
	portfolioDetailedTree add: tabCounter, 'Balance = ', aPortfolio balance amount asString, ' pesos'. 
	tabCounter := tabCounter copyFrom: 1 to: (tabCounter size - 1).
! !

!PortfolioDetailedTreePrinter methodsFor: 'dd - private' stamp: 'fb 6/13/2023 17:01:01'!
generateReportOfAReceptiveAccount: aReceptiveAccount
	
	| accountSummary |
	
	portfolioDetailedTree add: tabCounter, aReceptiveAccount name.
	tabCounter := tabCounter, String tab.
	accountSummary := (AccountSummary of: aReceptiveAccount) generateReport.
	accountSummary do: [:aLine | portfolioDetailedTree add: tabCounter, aLine].
	tabCounter := tabCounter copyFrom: 1 to: (tabCounter size - 1).

! !


!PortfolioDetailedTreePrinter methodsFor: 'printing' stamp: 'fb 6/12/2023 21:42:08'!
generateReport

	portfolio generateReportOf: self.
	
	^portfolioDetailedTree 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioDetailedTreePrinter class' category: 'ServiciosFinancieros-Solucion'!
PortfolioDetailedTreePrinter class
	instanceVariableNames: ''!

!PortfolioDetailedTreePrinter class methodsFor: 'instance creation' stamp: 'fb 6/12/2023 20:05:50'!
of: aPortfolio 

	^self new initializeOf: aPortfolio ! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion'!
Report subclass: #PortfolioTreePrinter
	instanceVariableNames: 'portfolio portfolioAccounts portfolioName portfolioTree tabCounter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'fb 6/13/2023 16:03:40'!
initializeOf: aPortfolio 

	portfolio := aPortfolio.
	portfolioTree := OrderedCollection new.
	tabCounter := ''.
	
! !


!PortfolioTreePrinter methodsFor: 'dd - private' stamp: 'fb 6/13/2023 17:02:41'!
generateReportOfAPortfolio: aPortfolio
	
	portfolioTree add: tabCounter, aPortfolio name.
	tabCounter := tabCounter, String tab.
	aPortfolio accounts do: [:anAccount | anAccount generateReportOf: self].
	tabCounter := tabCounter copyFrom: 1 to: (tabCounter size - 1).
! !

!PortfolioTreePrinter methodsFor: 'dd - private' stamp: 'fb 6/13/2023 16:03:52'!
generateReportOfAReceptiveAccount: aReceptiveAccount
	
	portfolioTree add: (tabCounter, aReceptiveAccount name).
! !


!PortfolioTreePrinter methodsFor: 'printing' stamp: 'fb 6/12/2023 21:42:36'!
generateReport
	
	portfolio generateReportOf: self.
	
	^portfolioTree.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: 'ServiciosFinancieros-Solucion'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'fb 6/12/2023 14:41:30'!
of: aPortfolio 

	^self new initializeOf: aPortfolio ! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'receptiveAccount account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'fb 6/7/2023 19:25:42'!
initializeOf: anAccount 

	account := anAccount.! !


!TransferNet methodsFor: 'printing' stamp: 'fb 6/8/2023 14:57:38'!
generateReport

	| transferNet |
	
	transferNet := 0 * peso.
	transferNet := transferNet + ((account transactions) sum: [:aTransaction | aTransaction generateReportOf: self] ifEmpty: [0 * peso]).
	
	^transferNet .! !


!TransferNet methodsFor: 'dd - private' stamp: 'fb 6/8/2023 15:00:45'!
generateReportOfDeposit: aDeposit

	^0 * peso.
! !

!TransferNet methodsFor: 'dd - private' stamp: 'fb 6/8/2023 14:59:55'!
generateReportOfTransferDepositLeg: aTransferDepositLeg

	^aTransferDepositLeg value.! !

!TransferNet methodsFor: 'dd - private' stamp: 'fb 6/8/2023 15:00:14'!
generateReportOfTransferWithdrawLeg: aTransferWithdrawLeg

	^aTransferWithdrawLeg value negated.
! !

!TransferNet methodsFor: 'dd - private' stamp: 'fb 6/8/2023 15:00:55'!
generateReportOfWithdraw: aWithdraw

	^0 * peso.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'ServiciosFinancieros-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'fb 6/7/2023 19:25:16'!
of: aReceptiveAccount 

	^self new initializeOf: aReceptiveAccount ! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
