!classDefinition: #MarsRoverTest category: 'MarsRover-Test'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRoverInicialNorte marsRoverInicialEste marsRoverInicialOeste marsRoverInicialSur'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Test'!

!MarsRoverTest methodsFor: 'setup' stamp: 'fd 5/29/2023 19:11:22'!
assertQue: unMarsRover seEncuentraEnLaPosicion: unaPosicion apuntandoA: unaOrientacion luegoDeRecibirLosComandos: unosComandos 

	unMarsRover recibirComandos: unosComandos.

	
	self assert: unMarsRover posicionActual equals: unaPosicion.
	self assert: (unMarsRover orientacion isKindOf: unaOrientacion).! !

!MarsRoverTest methodsFor: 'setup' stamp: 'fd 5/29/2023 19:24:38'!
setUp
	
	marsRoverInicialNorte := MarsRover enPosicion: (0@0) apuntandoA: Norte new .
	marsRoverInicialEste := MarsRover enPosicion: (0@0) apuntandoA: Este new .
 	marsRoverInicialOeste:= MarsRover enPosicion: (0@0) apuntandoA: Oeste new .
	marsRoverInicialSur := MarsRover enPosicion: (0@0) apuntandoA: Sur new .


	! !


!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:24:03'!
test01MarsRoverNoHaceNadaCuandoRecibeUnComandoVacio
	
	self assertQue: marsRoverInicialNorte seEncuentraEnLaPosicion: (0@0) apuntandoA:  Norte luegoDeRecibirLosComandos: ''! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:24:03'!
test02MarsRoverApuntandoANorteSeMueveHaciaAdelanteConElComandoF
	self assertQue: marsRoverInicialNorte seEncuentraEnLaPosicion: (0@1) apuntandoA:  Norte luegoDeRecibirLosComandos: 'f'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:24:03'!
test03MarsRoverApuntandoANorteSeMueveHaciaAtrasConElComandoB
	self assertQue: marsRoverInicialNorte seEncuentraEnLaPosicion: (0@-1) apuntandoA:  Norte luegoDeRecibirLosComandos: 'b'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:24:03'!
test04MarsRoverApuntandoANorteRotaHaciaLaDerechaConElComandoR
	self assertQue: marsRoverInicialNorte seEncuentraEnLaPosicion: (0@0) apuntandoA:  Este luegoDeRecibirLosComandos: 'r'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:24:03'!
test05MarsRoverApuntandoANorteRotaHaciaLaIzquierdaConElComandoL
	self assertQue: marsRoverInicialNorte seEncuentraEnLaPosicion: (0@0) apuntandoA:  Oeste luegoDeRecibirLosComandos: 'l'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:25:42'!
test06MarsRoverApuntandoAEsteSeMueveHaciaAdelanteConElComandoF
	self assertQue: marsRoverInicialEste seEncuentraEnLaPosicion: (1@0) apuntandoA: Este luegoDeRecibirLosComandos: 'f'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:26:02'!
test07MarsRoverApuntandoAEsteSeMueveHaciaAtrasConElComandoB
	self assertQue: marsRoverInicialEste seEncuentraEnLaPosicion: (-1@0) apuntandoA: Este luegoDeRecibirLosComandos: 'b'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:26:39'!
test08MarsRoverApuntandoAEsteRotaHaciaLaDerechaConElComandoR
	self assertQue: marsRoverInicialEste seEncuentraEnLaPosicion: (0@0) apuntandoA: Sur luegoDeRecibirLosComandos: 'r'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:27:01'!
test09MarsRoverApuntandoAEsteRotaHaciaLaIzquierdaConElComandoL
	self assertQue: marsRoverInicialEste seEncuentraEnLaPosicion: (0@0) apuntandoA: Norte luegoDeRecibirLosComandos: 'l'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:28:20'!
test10MarsRoverApuntandoAOesteSeMueveHaciaAdelanteConElComandoF
	self assertQue: marsRoverInicialOeste seEncuentraEnLaPosicion: (-1@0) apuntandoA: Oeste luegoDeRecibirLosComandos: 'f'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:28:31'!
test11MarsRoverApuntandoAOesteSeMueveHaciaAtrasConElComandoB
	self assertQue: marsRoverInicialOeste seEncuentraEnLaPosicion: (1@0) apuntandoA: Oeste luegoDeRecibirLosComandos: 'b'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:29:00'!
test12MarsRoverApuntandoAOesteRotaHaciaLaDerechaConElComandoR
	self assertQue: marsRoverInicialOeste seEncuentraEnLaPosicion: (0@0) apuntandoA: Norte luegoDeRecibirLosComandos: 'r'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:29:19'!
test13MarsRoverApuntandoAOesteRotaHaciaLaIzquierdaConElComandoL
	self assertQue: marsRoverInicialOeste seEncuentraEnLaPosicion: (0@0) apuntandoA: Sur luegoDeRecibirLosComandos: 'l'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:30:01'!
test14MarsRoverApuntandoASurSeMueveHaciaAdelanteConElComandoF
	self assertQue: marsRoverInicialSur seEncuentraEnLaPosicion: (0@-1) apuntandoA: Sur luegoDeRecibirLosComandos: 'f'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:30:27'!
test15MarsRoverApuntandoASurSeMueveHaciaAtrasConElComandoB
	self assertQue: marsRoverInicialSur seEncuentraEnLaPosicion: (0@1) apuntandoA: Sur luegoDeRecibirLosComandos: 'b'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:30:48'!
test16MarsRoverApuntandoASurRotaHaciaLaDerechaConElComandoR
	self assertQue: marsRoverInicialSur seEncuentraEnLaPosicion: (0@0) apuntandoA: Oeste luegoDeRecibirLosComandos: 'r'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:31:08'!
test17MarsRoverApuntandoASurRotaHaciaLaIzquierdaConElComandoL
	self assertQue: marsRoverInicialSur seEncuentraEnLaPosicion: (0@0) apuntandoA: Este luegoDeRecibirLosComandos: 'l'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:33:14'!
test18MarsRoverRespondeCorrectamenteATodosLosComandos

	self assertQue: marsRoverInicialNorte seEncuentraEnLaPosicion: (1@1) apuntandoA:  Norte luegoDeRecibirLosComandos: 'flbr'.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:31:38'!
test19MarsRoverNoProcesaLosComandosSiguientesAUnComandoErroneo	

	self should: [marsRoverInicialNorte recibirComandos: 'ffboquitafflr'.]
		raise: Error
		withMessageText: 'Comando invalido'.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'fd 5/29/2023 19:33:07'!
test20MarsRoverSeMueve3PosicionesHaciaAdelanteCuandoRecibeElComandoFFF

	
	self assertQue: marsRoverInicialNorte seEncuentraEnLaPosicion: (0@3) apuntandoA:  Norte luegoDeRecibirLosComandos: 'fff'.! !
!classDefinition: #MarsRover category: 'MarsRover-Model'!
Object subclass: #MarsRover
	instanceVariableNames: 'posicion orientacion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!MarsRover methodsFor: 'initialization' stamp: 'fb 5/29/2023 00:08:23'!
initializeEnPosicion: unaPosicion apuntandoA: unaOrientacion 

	posicion := unaPosicion.
	orientacion := unaOrientacion .! !


!MarsRover methodsFor: 'private' stamp: 'fd 5/29/2023 10:39:28'!
procesarComando: unComando

	(self comandoEsDeTipoForward: unComando) ifTrue: [^self moverHaciaAdelante].
	(self comandoEsDeTipoBackward: unComando) ifTrue: [^self moverHaciaAtras].
	(self comandoEsDeTipoRotacionDerecha: unComando) ifTrue: [^self rotarALaDerecha].
	(self comandoEsDeTipoRotacionIzquierda: unComando) ifTrue: [^self rotarALaIzquierda].
	
	self error: self class ComandoInvalidoError! !

!MarsRover methodsFor: 'private' stamp: 'fd 5/29/2023 19:03:03'!
recibirComandos: unosComandos
	unosComandos do: [:comando | self procesarComando: comando]	

	! !


!MarsRover methodsFor: 'actions' stamp: 'fb 5/29/2023 00:29:11'!
moverHaciaAdelante

	posicion := posicion + orientacion adelante.! !

!MarsRover methodsFor: 'actions' stamp: 'fb 5/29/2023 00:29:19'!
moverHaciaAtras

	posicion := posicion + orientacion adelante negated.! !

!MarsRover methodsFor: 'actions' stamp: 'fb 5/29/2023 00:29:58'!
rotarALaDerecha

	orientacion := orientacion rotarADerecha.! !

!MarsRover methodsFor: 'actions' stamp: 'fb 5/29/2023 00:30:11'!
rotarALaIzquierda

	orientacion := orientacion rotarAIzquierda.! !


!MarsRover methodsFor: 'accessing' stamp: 'fb 5/29/2023 00:08:23'!
orientacion
	
	^orientacion.! !

!MarsRover methodsFor: 'accessing' stamp: 'fb 5/28/2023 22:40:52'!
posicionActual
	
	^posicion.! !


!MarsRover methodsFor: 'checking' stamp: 'fd 5/29/2023 19:02:17'!
comandoEsDeTipoBackward: unComando
	^unComando = $b! !

!MarsRover methodsFor: 'checking' stamp: 'fd 5/29/2023 19:02:22'!
comandoEsDeTipoForward: unComando
	^unComando = $f! !

!MarsRover methodsFor: 'checking' stamp: 'fd 5/29/2023 19:02:28'!
comandoEsDeTipoRotacionDerecha: unComando
	^unComando = $r! !

!MarsRover methodsFor: 'checking' stamp: 'fd 5/29/2023 19:02:34'!
comandoEsDeTipoRotacionIzquierda: unComando
	^unComando = $l! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Model'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'fb 5/28/2023 22:38:42'!
enPosicion: unaPosicion apuntandoA: unPuntoCardinal 

	^self new initializeEnPosicion: unaPosicion apuntandoA: unPuntoCardinal ! !


!MarsRover class methodsFor: 'exception' stamp: 'fd 5/29/2023 10:40:48'!
ComandoInvalidoError
 	^'Comando invalido'! !


!classDefinition: #OrientacionMarsRover category: 'MarsRover-Model'!
Object subclass: #OrientacionMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!OrientacionMarsRover methodsFor: 'private' stamp: 'fd 5/29/2023 19:33:42'!
adelante
	self subclassResponsibility ! !

!OrientacionMarsRover methodsFor: 'private' stamp: 'fd 5/29/2023 19:33:53'!
rotarADerecha
	self subclassResponsibility ! !

!OrientacionMarsRover methodsFor: 'private' stamp: 'fd 5/29/2023 19:33:57'!
rotarAIzquierda
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrientacionMarsRover class' category: 'MarsRover-Model'!
OrientacionMarsRover class
	instanceVariableNames: ''!

!OrientacionMarsRover class methodsFor: 'instance creation' stamp: 'fb 5/28/2023 23:37:23'!
apuntandoA: aSymbol 
	"DO NOT FORGET TO RENAME COLLABORATORS AND REMOVE THIS COMMENT!!!!"
	self shouldBeImplemented.
	^self new initializeApuntandoA: aSymbol ! !


!classDefinition: #Este category: 'MarsRover-Model'!
OrientacionMarsRover subclass: #Este
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!Este methodsFor: 'private' stamp: 'fb 5/29/2023 00:34:49'!
adelante
	^1@0.! !

!Este methodsFor: 'private' stamp: 'fb 5/29/2023 00:34:35'!
rotarADerecha
	^Sur new.! !

!Este methodsFor: 'private' stamp: 'fb 5/28/2023 23:55:29'!
rotarAIzquierda
	^Norte new.! !


!classDefinition: #Norte category: 'MarsRover-Model'!
OrientacionMarsRover subclass: #Norte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!Norte methodsFor: 'private' stamp: 'fb 5/29/2023 00:16:59'!
adelante
	^0@1.! !

!Norte methodsFor: 'private' stamp: 'fb 5/28/2023 23:52:55'!
rotarADerecha
	^Este new.! !

!Norte methodsFor: 'private' stamp: 'fb 5/29/2023 00:07:22'!
rotarAIzquierda
	^Oeste new.! !


!classDefinition: #Oeste category: 'MarsRover-Model'!
OrientacionMarsRover subclass: #Oeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!Oeste methodsFor: 'private' stamp: 'fb 5/29/2023 00:17:26'!
adelante
	^-1@0.! !

!Oeste methodsFor: 'private' stamp: 'fb 5/29/2023 00:19:57'!
rotarADerecha
	^Norte new.! !

!Oeste methodsFor: 'private' stamp: 'fb 5/29/2023 00:34:01'!
rotarAIzquierda
	^Sur new.! !


!classDefinition: #Sur category: 'MarsRover-Model'!
OrientacionMarsRover subclass: #Sur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!Sur methodsFor: 'private' stamp: 'fb 5/29/2023 00:33:16'!
adelante
	^0@-1.! !

!Sur methodsFor: 'private' stamp: 'fb 5/29/2023 00:33:24'!
rotarADerecha
	^Oeste new.! !

!Sur methodsFor: 'private' stamp: 'fb 5/29/2023 00:33:30'!
rotarAIzquierda
	^Este new.! !
