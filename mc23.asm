		icl 'vars.asm'
		icl 'inflate.asm'

		org start

		//init here if necessary 
		//depack and stuff like that


		//flow is here with rom disabling at the beginning
		//reduce colors
		//we can use shadow befor rom is switch off 
		//font first
.local
		lda #$0f
		sta 709
		lda #$02
		sta 710
		sta 712
		

l0
		lda 20
		cmp 20
		beq *-2


		inc 710
		inc 712
		lda 710
		cmp 709
		bne l0
.endl
		//nastala jasnoc - tutaj mozna zrobic jakis progress bar na czarno np 
	

.local
l0
		lda 20
		cmp 20
		beq *-2

		dec 712
		dec 710
		dec 709
		bne l0

.endl
		
		icl 'nmi.asm'

    	RUN start



