
			lda #%00000000			;wylaczamy antic aby nie widziec smieci podczas inicjalizacji
	    	sta 559	
        	sta $d400
			
			lda 20     				;czekamy ramke zanim zaczniemy szale�
			cmp 20					;prost petelka
			beq *-2
 	
			sei        				;wy��czamy nieodwo�alnie IRQ
			lda #0        
			sta $d40e  				;wy��czamy NMI ($d40e = $00), tak na chwil�, na czas zmiany wektor�w przerwa�

			lda #$fe   
			sta $d301  				;wy��czamy OS ($d301 = $fe), mo�emy dzi�ki temu korzysta� z pami�ci $c000-$cfff, $d800-$fff0
		  	          				;i w tym momencie niejako dzia�a ju� sam CPU, wszystko inne zamar�o :)
									;mozna poszalec z jakimis mega prekalkami

  			mwa #nmi $fffa 			;przerwania - OS'a nie ma, sami o nie dbamy, adres zapisujemy w odpowiedniej kom�rce w pami�ci
            //inty 

			lda #$c0
			sta $d40e  				;w��czamy NMI ($d40e = $40, tylko VBL), ($d40e = $c0, VBL oraz DLI)
  		 
        ;tutaj nasz dalszy program poza VBLK:)

            icl 'flow.asm'


*-------------
* Obs�uga NMI
*-------------
nmi			bit $d40f 				;NMIST - rejestr statusu przerwa� NMI
	    	bpl _vbl
dliv		jmp dli   				;skok do obs�ugi DLI, ustawili�my #$c0 w $d40e

_vbl		pha       				;tutaj nasze VBL, zapamietujemy rejestry A,Y,X na stosie
        	tya
        	pha
	    	txa
	    	pha

	    	inc timer 				;licznik zwiekszany co ramke

	    	pla       		    	;zdejmujemy ze stosu warto�ci rejestr�w X,Y,A
	    	tax        				;zdejmujemy je w odwrotnej kolejno�ci jak je tam k�adli�my
	    	pla		   				;w koncu tak dziala stos
        	tay
        	pla
	    	rti                  

			;procedura dli, ktora nic nie robi poza wyjsciem z siebie - NA RAZIE :)
dli			rti
	