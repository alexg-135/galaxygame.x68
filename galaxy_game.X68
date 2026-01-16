* +---------------------------------------------------------------------+
* | Program 	: Galaxy Game 						|
* | Written by 	: Alexander Gustovarac 					|
* | Date 	: ak. god. 2025. / 2026. 				|
* | Description : Grada racunala - Projektni zadatak (2025/26) 		|
* | Website	: https://alexandergustovarac.from.hr/galaxygame.x68 	|
* | GitHub	: https://github.com/alexg-135/galaxygame.x68		|
* +---------------------------------------------------------------------+



;=================================================================
; DEFINICIJE
;=================================================================

PROG			EQU		$2000
DATA			EQU		$1000
WHITE			EQU		$00FFFFFF
YELLOW			EQU		$0000FFFF
BLACK			EQU		$00000000
FUEL_MAX		EQU		2000
PROJEKTIL_A_COLOR	EQU		$00FF0000
PROJEKTIL_B_COLOR	EQU		$000000FF

;=================================================================
; PODATCI
;=================================================================	

	ORG 	DATA

; --- Brojaci ---
FRAME_COUNTER:		DC.W 	0
GRAVITACIJA_COUNTER:	DC.W 	0
KEY_A_COOLDOWN:		DC.W 	5
KEY_D_COOLDOWN:		DC.W 	5
KEY_S_COOLDOWN:		DC.W 	20
KEY_4_COOLDOWN:		DC.W 	5
KEY_6_COOLDOWN:		DC.W 	5
KEY_2_COOLDOWN:		DC.W 	20
	
; --- Brod A ---
BROD_A:
X_A:			DC.W 	40
Y_A:    		DC.W 	420
VX_A:   		DC.W 	0
VY_A:			DC.W 	-1
R_A:			DC.W 	0
W_A:			DC.W 	17
H_A:			DC.W 	17
FUEL_A:			DC.W 	FUEL_MAX
COLOR_A:		DC.L 	$00AD7E42

; --- Brod B ---
BROD_B:
X_B:			DC.W 	580
Y_B:			DC.W 	40
VX_B:			DC.W 	0
VY_B: 			DC.W 	1
R_B: 			DC.W 	8
W_B: 			DC.W 	17
H_B: 			DC.W 	17
FUEL_B: 		DC.W 	FUEL_MAX
COLOR_B: 		DC.L 	$001B02AA

; --- Projektili broda A ---     
PROJ_A:
PROJ_A_1:
PX1_A: 			DC.W 	-10
PY1_A: 			DC.W 	-10
PVX1_A:			DC.W 	0
PVY1_A:			DC.W 	0
COLOR1_A: 		DC.L 	PROJEKTIL_A_COLOR

PROJ_A_2:
PX2_A: 			DC.W 	-10
PY2_A: 			DC.W 	-10
PVX2_A: 		DC.W 	0
PVY2_A: 		DC.W 	0
COLOR2_A:		DC.L 	PROJEKTIL_A_COLOR
  
PROJ_A_3:
PX3_A: 			DC.W 	-10
PY3_A: 			DC.W 	-10
PVX3_A: 		DC.W 	0
PVY3_A: 		DC.W 	0
COLOR3_A:		DC.L 	PROJEKTIL_A_COLOR

PROJ_A_4:
PX4_A: 			DC.W 	-10
PY4_A: 			DC.W 	-10
PVX4_A: 		DC.W 	0
PVY4_A: 		DC.W 	0
COLOR4_A: 		DC.L 	PROJEKTIL_A_COLOR

PROJ_A_5:
PX5_A: 			DC.W 	-10
PY5_A: 			DC.W 	-10
PVX5_A: 		DC.W 	0
PVY5_A: 		DC.W 	0
COLOR5_A:		DC.L 	PROJEKTIL_A_COLOR

; --- Projektili broda B --- 
PROJ_B:
PROJ_B_1:
PX1_B: 			DC.W 	-10
PY1_B: 			DC.W 	-10
PVX1_B: 		DC.W 	0
PVY1_B: 		DC.W 	0
COLOR1_B:		DC.L 	PROJEKTIL_B_COLOR

PROJ_B_2:
PX2_B:			DC.W 	-10
PY2_B: 			DC.W 	-10
PVX2_B: 		DC.W 	0
PVY2_B: 		DC.W 	0
COLOR2_B:		DC.L 	PROJEKTIL_B_COLOR

PROJ_B_3:
PX3_B:			DC.W 	-10
PY3_B: 			DC.W 	-10
PVX3_B: 		DC.W	0
PVY3_B: 		DC.W	0
COLOR3_B:		DC.L 	PROJEKTIL_B_COLOR

PROJ_B_4:
PX4_B: 			DC.W 	-10
PY4_B: 			DC.W 	-10
PVX4_B: 		DC.W 	0
PVY4_B: 		DC.W 	0
COLOR4_B:		DC.L 	PROJEKTIL_B_COLOR

PROJ_B_5:
PX5_B: 			DC.W 	-10
PY5_B: 			DC.W 	-10
PVX5_B: 		DC.W 	0
PVY5_B: 		DC.W 	0
COLOR5_B:		DC.L 	PROJEKTIL_B_COLOR

; --- Kordinate sunca ---
SUNCE:
SUNCE_X:		DC.W 	300	
SUNCE_Y: 		DC.W 	220

; --- Pozicije zvijezda ---
STAR_COUNT:		DC.W 	24
STAR_X:			DC.W 	438, 27,  455, 580, 355, 469, 217, 153, 124, 173, 604, 106, 392, 522, 400, 469, 217, 153, 217, 153, 124, 173, 604, 106
STAR_Y:			DC.W 	22,  445, 422, 230, 34,  402, 109, 205, 138, 124, 120, 211, 110, 204, 85,  422, 230, 34,  402, 34,  402, 109, 205, 138


; --- Stringovi za ispis tekstova ---
TXT_WELCOME:		DC.B 	'! Galaxy Game !',0
TXT_START:		DC.B 	'Pritisni space za pocetak igre ili e za kraj!',0
TXT_A_WIN:		DC.B 	'Igrac A je pobjedio',0
TXT_B_WIN: 		DC.B 	'Igrac B je pobjedio!',0
TXT_0_WIN:		DC.B 	'Izjednaceno!',0
TXT_3:			DC.B 	'3',0
TXT_2:			DC.B 	'2',0
TXT_1:			DC.B 	'1',0
TXT_0:			DC.B 	'GO!',0
TXT_A_F:		DC.B 	'Gorivo A: ',0
TXT_B_F:		DC.B 	' :Gorivo B',0


;=================================================================
; PROGRAM
;=================================================================

	ORG	PROG
START:					; Pocetak programa
	MOVE.W	#12, D0			; Iskljuci Keybord echo
	MOVE.W	#0, D1						
	TRAP	#15

	MOVEA.W	#TXT_WELCOME, A0 	; Postavi parametar FJN na adresu za TXT_START
GAME_START:
	MOVE.W 	#92, D0			; Iskljuci double buffering
	MOVE.L	#16, D1
	TRAP 	#15

	MOVE.W 	#11, D0			; Ocisti ekran
	MOVE.W	#$FF00, D1
	TRAP 	#15
	
	MOVE.W 	#80, D0			; Postavi pen na WHITE
	MOVE.L	#WHITE, D1
	TRAP 	#15
	
	MOVE.W 	#81, D0			; Postavi fill na BLACK
	MOVE.L	#BLACK, D1
	TRAP 	#15

	MOVE.W	#11, D0			; Postavi kursor za naslov
	MOVE.W	#$0404, D1		
	TRAP	#15

	MOVEA.W	A0, A1			; Ispis naslova
	MOVE.W 	#0, D0
	MOVE.W	#255, D1
	TRAP 	#15
	
	MOVE.W	#11, D0			; Postavi kursor za podnaslov
	MOVE.W	#$0420, D1		
	TRAP	#15

	MOVEA.W	#TXT_START, A1		; Ispis podnaslova
	MOVE.W	#0, D0
	MOVE.W	#255, D1
	TRAP 	#15

GAME_START_LOOP:
	MOVE.W	#0, D1			; Provjeri input
	MOVE.W	#7, D0					
	TRAP	#15
	
	CMP.B 	#0, D1			; Ako nije stisnuta tipka cekaj je opet
	BEQ	GAME_START_LOOP
	
	MOVE.W	#5, D0			; Procitaj input			
	TRAP	#15
	
	CMP.B 	#'e', D1		; Ako je stisnut 'e' zavrsi program
	BEQ	KRAJ

	CMP.B 	#' ', D1		; Ako je stisnut space pokreni igru
	BEQ	GAME_COUNDOWN	
	
	JMP	GAME_START_LOOP		; Ako se nije desilo ništa ili nije pritisnuta dobra tipka čekaj dalje

; --- Odbrojavanje 3, 2, 1, Go! ---
GAME_COUNDOWN:				
	MOVE.W 	#11, D0			; ocisti ekran
	MOVE.W	#$FF00, D1
	TRAP 	#15
	
	MOVE.W	#11, D0			; Postavi kursor za odbojavanje
	MOVE.W	#$280F, D1		
	TRAP	#15
	
	MOVEA.W	#TXT_3, A1		; Ispis broja 3
	MOVE.W 	#0, D0
	MOVE.W	#255, D1
	TRAP 	#15
	
	JSR DELAY_1S			; Cekaj 1s
	
	MOVE.W	#11, D0			; Postavi kursor za odbojavanje
	MOVE.W	#$280F, D1		
	TRAP	#15
	
	MOVEA.W	#TXT_2, A1		; Ispis broja 2
	MOVE.W 	#0, D0
	MOVE.W	#255, D1
	TRAP 	#15
	
	JSR DELAY_1S			; Cekaj 1s
	
	MOVE.W	#11, D0			; Postavi kursor za odbojavanje
	MOVE.W	#$280F, D1		
	TRAP	#15
	
	MOVEA.W	#TXT_1, A1		; Ispis broja 1
	MOVE.W 	#0, D0
	MOVE.W	#255, D1
	TRAP 	#15
	
	JSR DELAY_1S			; Cekaj 1s
	
	MOVE.W	#11, D0			; Postavi kursor za odbojavanje
	MOVE.W	#$270F, D1		
	TRAP	#15
	
	MOVEA.W	#TXT_0, A1		; Ispis broja 0
	MOVE.W 	#0, D0
	MOVE.W	#255, D1
	TRAP 	#15
	
	JSR DELAY_1S			; Cekaj 1s
	
	JMP GAME_LOOP			; Zapocni igru
	
; ---                 Glavna petlja igre                  ---
; -----------------------------------------------------------
;  Glavna petlja prvo poziva rendering ekrana zatim
;  provjerava koalizije te pomiče predmete
;
;  Brzine i akceleracije se dobijaju tako da se ne se pomiče
;  svaki frame nego neki entitet preskaču neke frejmove
; -----------------------------------------------------------
GAME_LOOP:
; --- 1. Rendering ---
	JSR	FJN_RENDER		; Ispisi trenutni status igre
	
; --- 2. Provjera koalicija ---
	MOVE.W	#0, D0			; Za provjeru koalizija potrebno je D0 postaviti na 0
		
	MOVEA	#BROD_A, A0		; Koalizija broda A i Sunca u te B pobjedjuje
	MOVEA	#SUNCE, A1
	MOVE.W	#17, D1
	MOVE.W	#40, D2
	JSR	PROVJERI_KOLIZIJU
	CMP.W	#1, D0
	BEQ	IGRAC_B_POBJEDIO

	MOVEA	#BROD_B, A0		; Koalizija broda B i Sunca te A pobjedjuje
	MOVEA	#SUNCE, A1
	MOVE.W	#17, D1
	MOVE.W	#40, D2
	JSR	PROVJERI_KOLIZIJU
	CMP.W	#1, D0
	BEQ	IGRAC_A_POBJEDIO

	MOVEA	#BROD_A, A0		; Koalizija broda A i projektila 1 od B te B pobjedjuje
	MOVEA	#PROJ_B_1, A1
	MOVE.W	#17, D1
	MOVE.W	#8, D2
	JSR	PROVJERI_KOLIZIJU
	CMP.W	#1, D0
	BEQ	IGRAC_B_POBJEDIO
	
	MOVEA	#BROD_A, A0		; Koalizija broda A i projektila 2 od B te B pobjedjuje
	MOVEA	#PROJ_B_2, A1
	MOVE.W	#17, D1
	MOVE.W	#8, D2
	JSR	PROVJERI_KOLIZIJU
	CMP.W	#1, D0
	BEQ	IGRAC_B_POBJEDIO

	MOVEA	#BROD_A, A0		; Koalizija broda A i projektila 3 od B te B pobjedjuje
	MOVEA	#PROJ_B_3, A1
	MOVE.W	#17, D1
	MOVE.W	#8, D2
	JSR	PROVJERI_KOLIZIJU
	CMP.W	#1, D0
	BEQ	IGRAC_B_POBJEDIO

	MOVEA	#BROD_A, A0		; Koalizija broda A i projektila 4 od B te B pobjedjuje
	MOVEA	#PROJ_B_4, A1
	MOVE.W	#17, D1
	MOVE.W	#8, D2
	JSR	PROVJERI_KOLIZIJU
	CMP.W	#1, D0
	BEQ	IGRAC_B_POBJEDIO

	MOVEA	#BROD_A, A0		; Koalizija broda A i projektila 5 od B te B pobjedjuje
	MOVEA	#PROJ_B_5, A1
	MOVE.W	#17, D1
	MOVE.W	#8, D2
	JSR	PROVJERI_KOLIZIJU
	CMP.W	#1, D0
	BEQ	IGRAC_B_POBJEDIO

	MOVEA	#BROD_B, A0		; Koalizija broda B i projektila 1 od A te A pobjedjuje
	MOVEA	#PROJ_A_1, A1
	MOVE.W	#17, D1
	MOVE.W	#8, D2
	JSR	PROVJERI_KOLIZIJU
	CMP.W	#1, D0
	BEQ	IGRAC_A_POBJEDIO

	MOVEA	#BROD_B, A0		; Koalizija broda B i projektila 2 od A te A pobjedjuje
	MOVEA	#PROJ_A_2, A1
	MOVE.W	#17, D1
	MOVE.W	#8, D2
	JSR	PROVJERI_KOLIZIJU
	CMP.W	#1, D0
	BEQ	IGRAC_A_POBJEDIO

	MOVEA	#BROD_B, A0		; Koalizija broda B i projektila 3 od A te A pobjedjuje
	MOVEA	#PROJ_A_3, A1
	MOVE.W	#17, D1
	MOVE.W	#8, D2
	JSR	PROVJERI_KOLIZIJU
	CMP.W	#1, D0
	BEQ	IGRAC_A_POBJEDIO

	MOVEA	#BROD_B, A0		; Koalizija broda B i projektila 4 od A te A pobjedjuje
	MOVEA	#PROJ_A_4, A1
	MOVE.W	#17, D1
	MOVE.W	#8, D2
	JSR	PROVJERI_KOLIZIJU
	CMP.W	#1, D0
	BEQ	IGRAC_A_POBJEDIO

	MOVEA	#BROD_B, A0		; Koalizija broda B i projektila 5 od A te A pobjedjuje
	MOVEA	#PROJ_A_5, A1
	MOVE.W	#17, D1
	MOVE.W	#8, D2
	JSR	PROVJERI_KOLIZIJU
	CMP.W	#1, D0
	BEQ	IGRAC_A_POBJEDIO

	MOVEA	#BROD_A, A0		; Koalizija broda A i broda B te nitko ne pobjeduje
	MOVEA	#BROD_B, A1
	MOVE.W	#19, D1
	MOVE.W	#19, D2
	JSR	PROVJERI_KOLIZIJU
	CMP.W	#1, D0
	BEQ	IGRAC_0_POBJEDIO	

; --- 3. Pomicanje entiteta ---	
	ADDI.W	#1, FRAME_COUNTER	; Brojanje frejma, da se brod pomiče svaki drugi te graviacija svaki 4 frame
	MOVE.W	#4, D0
	CMP.W 	FRAME_COUNTER, D0
	BNE	INPUT
	MOVE.W	#0, FRAME_COUNTER
INPUT:
	MOVE.W	#0, D1			; Provjeri input
	MOVE.W	#7, D0					
	TRAP	#15
	
	MOVEA.L	#KEY_A_COOLDOWN, A0	; Smanji za coluddown tipaka
	JSR	KEY_COOLDOWN
	MOVEA.L	#KEY_D_COOLDOWN, A0	
	JSR	KEY_COOLDOWN
	MOVEA.L	#KEY_S_COOLDOWN, A0	
	JSR	KEY_COOLDOWN
	MOVEA.L	#KEY_4_COOLDOWN, A0	
	JSR	KEY_COOLDOWN
	MOVEA.L	#KEY_6_COOLDOWN, A0	
	JSR	KEY_COOLDOWN
	MOVEA.L	#KEY_2_COOLDOWN, A0	
	JSR	KEY_COOLDOWN		
	
	MOVE.B	#19, D0			; ispitivanje prisutnost (w, a, d, s) tipki za brod A
	MOVE.L 	#'W'<<24+'A'<<16+'D'<<8+'S', D1	
	TRAP 	#15
	
	BTST.L	#24, D1			; Ako je neka tipka pritisnuta pozovi određeni dio programa
	BNE	BROD_A_GAS
BROD_A_GAS_NEXT:
	BTST.L	#16, D1
	BNE	BROD_A_LIJEVO
BROD_A_LIJEVO_NEXT:
	BTST.L	#8, D1
	BNE	BROD_A_DESNO
BROD_A_DESNO_NEXT:
	BTST.L	#0, D1
	BNE	BROD_A_PROJEKTIL
BROD_A_PROJEKTIL_NEXT:
	
	MOVE.B	#19, D0			; ispitivanje prisutnost (8, 4, 6, 2) tipki za brod B
	MOVE.L 	#$26252728, D1 
	TRAP 	#15
	
	BTST.L	#24, D1			; Ako je neka tipka pritisnuta pozovi određeni dio programa
	BNE	BROD_B_GAS
BROD_B_GAS_NEXT:
	BTST.L	#16, D1
	BNE	BROD_B_LIJEVO
BROD_B_LIJEVO_NEXT:
	BTST.L	#8, D1
	BNE	BROD_B_DESNO
BROD_B_DESNO_NEXT:
	BTST.L	#0, D1
	BNE	BROD_B_PROJEKTIL
BROD_B_PROJEKTIL_NEXT:
	
	JMP INPUT_KRAJ			; Završetak input dijela preskoči "funkcije" za handeling keybord unosa

; --- "funkcije" za handeling keybord unosa ---
BROD_A_LIJEVO:				; Brod A ide lijevo
	MOVE.W	KEY_A_COOLDOWN, D0	; Provjeri cooldown za tipku
	CMP.W	#0, D0
	BNE	BROD_A_LIJEVO_NEXT
	
	MOVE.W	R_A, D0			; Promijeni rotaciju broda A
	ADD.W	#-1, D0
	AND.L 	#$0000000F, D0
	MOVE.W	D0, R_A
	
	MOVE.W	#5, KEY_A_COOLDOWN	; Postavi cooldown
	
	JMP 	BROD_A_LIJEVO_NEXT	; Vrati se odakle je funkcija pozvana

BROD_A_DESNO:				; Brod A ide desno
	MOVE.W	KEY_D_COOLDOWN, D0	; Provjeri cooldown za tipku
	CMP.W	#0, D0	
	BNE	BROD_A_DESNO_NEXT

	MOVE.W	R_A, D0			; Promijeni rotaciju broda A
	ADD.W	#1, D0
	AND.L 	#$0000000F, D0
	MOVE.W	D0, R_A
	
	MOVE.W	#5, KEY_D_COOLDOWN	; Postavi cooldown
	
	JMP 	BROD_A_DESNO_NEXT	; Vrati se odakle je funkcija pozvana

BROD_A_GAS:				; Davanje brodu A gas
	MOVE.W 	#BROD_A, A0		; Poziz funkcije: BROD_GAS(A0 = *BROD_A)
	JSR	BROD_GAS
	
	JMP	BROD_A_GAS_NEXT		; Vrati se odakle je funkcija pozvana
	
BROD_A_PROJEKTIL:			; Ispucaj projektil iz broda A
	MOVE.W	KEY_S_COOLDOWN, D0	;  Provjeri cooldown za tipke
	CMP.W	#0, D0
	BNE	BROD_A_PROJEKTIL_NEXT
	MOVE.W	#20, KEY_S_COOLDOWN
	
	MOVE.W	PX1_A, D0		; Pronadi slobodno mjesto u memoriji za projektil od ukupno 5 slobodnih mjesta te ako ima pozovi projektil na slobodno mjesto
	MOVEA	#PROJ_A_1, A0
	CMP.W	#-10, D0
	BEQ	BROD_A_STVORI_PROJEKTIL
	MOVE.W	PX2_A, D0
	MOVEA	#PROJ_A_2, A0
	CMP.W	#-10, D0
	BEQ	BROD_A_STVORI_PROJEKTIL
	MOVE.W	PX3_A, D0
	MOVEA	#PROJ_A_3, A0
	CMP.W	#-10, D0
	BEQ	BROD_A_STVORI_PROJEKTIL
	MOVE.W	PX4_A, D0
	MOVEA	#PROJ_A_4, A0
	CMP.W	#-10, D0
	BEQ	BROD_A_STVORI_PROJEKTIL
	MOVE.W	PX5_A, D0
	MOVEA	#PROJ_A_5, A0
	CMP.W	#-10, D0
	BEQ	BROD_A_STVORI_PROJEKTIL

	JMP	BROD_A_PROJEKTIL_NEXT	; Nema slobodnih mjesta te se vrati odakle je funkcija pozvana

BROD_A_STVORI_PROJEKTIL:		; Ima slobodno mjesto te pozovi brod
	MOVEA	#BROD_A, A1		; Poziv funkcije STVORI_PROJEKTIL(A0 = *SLOBODNI_PROJEKTIL, A1 = *BROD_A)	
	JSR	STVORI_PROJEKTIL
	
	JMP	BROD_A_PROJEKTIL_NEXT	; Vrati se odakle je funkcija pozvana
	
BROD_B_LIJEVO:				; Brod B ide lijevo
	MOVE.W	KEY_4_COOLDOWN, D0	; Provjeri cooldown za tipku
	CMP.W	#0, D0
	BNE	BROD_B_LIJEVO_NEXT
	
	MOVE.W	R_B, D0			; Promijeni rotaciju broda B
	ADD.W	#-1, D0
	AND.L 	#$0000000F, D0
	MOVE.W	D0, R_B
	
	MOVE.W	#5, KEY_4_COOLDOWN 	; Postavi cooldown
	
	JMP 	BROD_B_LIJEVO_NEXT	; Vrati se odakle je funkcija pozvana

BROD_B_DESNO:				; Brod B ide desno
	MOVE.W	KEY_6_COOLDOWN, D0	; Provjeri cooldown za tipku
	CMP.W	#0, D0
	BNE	BROD_B_DESNO_NEXT

	MOVE.W	R_B, D0			; Promijeni rotaciju broda B
	ADD.W	#1, D0
	AND.L 	#$0000000F, D0
	MOVE.W	D0, R_B
	
	MOVE.W	#5, KEY_6_COOLDOWN	; Postavi cooldown
	
	JMP 	BROD_B_DESNO_NEXT	; Vrati se odakle je funkcija pozvana

BROD_B_GAS:				; Davanje brodu B gas 
	MOVE.W 	#BROD_B, A0		; Poziv funkcije: BROD_GAS(A0 = *BROD_B)
	JSR	BROD_GAS

	JMP	BROD_B_GAS_NEXT		; Vrati se odakle je funkcija pozvana

BROD_B_PROJEKTIL:			; Ispucaj projektil iz broda B
	MOVE.W	KEY_2_COOLDOWN, D0	; Provjeri cooldown za tipke
	CMP.W	#0, D0
	BNE	BROD_B_PROJEKTIL_NEXT
	MOVE.W	#20, KEY_2_COOLDOWN
	
	MOVE.W	PX1_B, D0		; Pronadji slobodnomjesto u memoriji ua projektil od ukupno 5 slobodnih mjesta te ako ima pozovi projektil na slobodno mjesto
	MOVEA	#PROJ_B_1, A0
	CMP.W	#-10, D0
	BEQ	BROD_B_STVORI_PROJEKTIL
	MOVE.W	PX2_B, D0
	MOVEA	#PROJ_B_2, A0
	CMP.W	#-10, D0
	BEQ	BROD_B_STVORI_PROJEKTIL
	MOVE.W	PX3_B, D0
	MOVEA	#PROJ_B_3, A0
	CMP.W	#-10, D0
	BEQ	BROD_B_STVORI_PROJEKTIL
	MOVE.W	PX4_B, D0
	MOVEA	#PROJ_B_4, A0
	CMP.W	#-10, D0
	BEQ	BROD_B_STVORI_PROJEKTIL
	MOVE.W	PX5_B, D0
	MOVEA	#PROJ_B_5, A0
	CMP.W	#-10, D0
	BEQ	BROD_B_STVORI_PROJEKTIL

	JMP	BROD_B_PROJEKTIL_NEXT	; Ako nema slobodnih mjesta vrati se odakle je funkcija pozvana

BROD_B_STVORI_PROJEKTIL:		; Stvari projektil na slobodnom mjestu
	MOVEA	#BROD_B, A1		; Pziv funkcije: STVORI_PROJEKTIL(A0 = *SLOBODNI_PROJEKTIL, A1 = *BROD_B)
	JSR	STVORI_PROJEKTIL

	JMP	BROD_B_PROJEKTIL_NEXT	; Vrati se odakle je funkcija pozvana
	
INPUT_KRAJ:				; Kraj dijela za handeling unosa
; NAPOMENA: (Handeling se ponašaju kao funkcije ali nisu funckije zapravo se radi o nisu IF naredbi)

; --- 4. pomicanje entiteta ---
	MOVE.W	#0, D0			; Sto treba pomaknuti: utjecaj gravitacija svakih 4, brodve svakih 2, projektile svakh 1 frama
	CMP.W 	FRAME_COUNTER, D0
	BEQ 	GRAVITACIJA
	MOVE.W	#2, D0
	CMP.W 	FRAME_COUNTER, D0
	BEQ 	POMAKNI_BRODOVE
BROD_NATRAG:

	MOVEA.W	#PROJ_A_1, A0		; pomakni projektil 1 broda A
	JSR	POMAKNI_PROJEKTIL

	MOVEA.W	#PROJ_A_2, A0		; pomakni projektil 2 broda A
	JSR	POMAKNI_PROJEKTIL

	MOVEA.W	#PROJ_A_3, A0		; pomakni projektil 3 broda A
	JSR	POMAKNI_PROJEKTIL

	MOVEA.W	#PROJ_A_4, A0		; pomakni projektil 4 broda A
	JSR	POMAKNI_PROJEKTIL

	MOVEA.W	#PROJ_A_5, A0		; pomakni projektil 5 broda A
	JSR	POMAKNI_PROJEKTIL

	MOVEA.W	#PROJ_B_1, A0		; pomakni projektil 1 Broda B
	JSR	POMAKNI_PROJEKTIL

	MOVEA.W	#PROJ_B_2, A0		; pomakni projektil 2 broda B
	JSR	POMAKNI_PROJEKTIL

	MOVEA.W	#PROJ_B_3, A0		; pomakni projektil 3 broda B
	JSR	POMAKNI_PROJEKTIL

	MOVEA.W	#PROJ_B_4, A0		; pomakni projektil 4 broda B
	JSR	POMAKNI_PROJEKTIL

	MOVEA.W	#PROJ_B_5, A0		; pomakni projektil 5 broda B
	JSR	POMAKNI_PROJEKTIL
	
	JSR	GAME_FRAME_DELAY	; pričekaj prije prelaska na novi frame
	JMP 	GAME_LOOP		; prijedji na novi frame

; --- "funkcije" za handeling pomicanja entitet ---
POMAKNI_BRODOVE:			; Pomakni brodove
	MOVEA.W	#BROD_A, A0		; Poziv funkcije: POMAKNI_BROD(A0 = *BROD_A)
	JSR	POMAKNI_BROD
	
	MOVEA.W	#BROD_B, A0		; Poziv funkcije: POMAKNI_BROD(A0 = *BROD_B)
	JSR	POMAKNI_BROD

	JMP BROD_NATRAG			; Vrati se odakle je funkcija pozvana

GRAVITACIJA:				; Utjecaj gravitacije
	ADDI.W	#1, GRAVITACIJA_COUNTER	; Smanjenje utjecaja gravitacije proređivanjem koje frejmove treba djelovati (svaki 4*5 = 20 frame )
	MOVE.W	#5, D0
	CMP.W 	GRAVITACIJA_COUNTER, D0
	BNE	NASTAVI_GRAVITACIJA
	MOVE.W	#0, GRAVITACIJA_COUNTER	
NASTAVI_GRAVITACIJA:			
	MOVE.W	#0, D0	
	CMP.W 	GRAVITACIJA_COUNTER, D0
	BNE 	GRAVITACIJA_FJN_BROJ	; Ako nije potrebno dijelovati gravitacijom nastavi dalje


	MOVEA.W	#BROD_A, A0		; Poziv funkcije: POMAKNI_BROD_GRAVITACIJA(A0 = *BROD_A)
	JSR	POMAKNI_BROD_GRAVITACIJA
	
	MOVEA.W	#BROD_B, A0		; Poziv funkcije: POMAKNI_BROD_GRAVITACIJA(A0 = *BROD_B)
	JSR	POMAKNI_BROD_GRAVITACIJA

GRAVITACIJA_FJN_BROJ:			; Vrati se odakle je funkcija pozvana tj moraju se i brodovi pomaknuti pa pomakni brodove
	JMP 	POMAKNI_BRODOVE

IGRAC_A_POBJEDIO:			; Pobjedio je igrac A
	MOVEA	#TXT_A_WIN, A0		; u A0 postavi odgovarajucu poruku za ispis na pocetnom ekranu

	JSR	DATA_RESET		; Resetiraj podatke u memoriji

	JMP	GAME_START		; Ponovno prikazi pocetni ekran 

IGRAC_B_POBJEDIO:			; Pobjedio je igrac B
	MOVEA	#TXT_B_WIN, A0		; u A0 postavi odgovarajucu poruku za ispis na pocetnom ekranu

	JSR	DATA_RESET		; Resetiraj podatke u memoriji

	JMP	GAME_START		; Ponovno prikazi pocetni ekran

IGRAC_0_POBJEDIO:			; Nitko nije pobjedio
	MOVEA	#TXT_0_WIN, A0		; u A0 postavi odgovarajucu poruku za ispis na pocetnom ekranu

	JSR	DATA_RESET		; Resetiraj podatke u memoriji

	JMP	GAME_START		; Ponovno prikazi pocetni ekran

; --- KRAJ PROGRAMA ---
KRAJ:					; Ukoliko je stisnuta tipka e program se zatvara			
	MOVE.W 	#11, D0			; Ocisti ekran
	MOVE.W	#$FF00, D1
	TRAP 	#15

	MOVE.B	#9,D0			; Halt simulatora
	TRAP	#15			

;=================================================================¸
; FUNKCIJE
;=================================================================

; ---                     FJN_RENDER                     ---
; ----------------------------------------------------------
;  Funkcija crta trenutni frame igre
; ----------------------------------------------------------

FJN_RENDER:
; --- priprema crtanja
	MOVE.W 	#92, D0			; Ukljuci double buffering
	MOVE.L	#17, D1
	TRAP 	#15

	MOVE.W 	#11, D0			; Ocisti ekran
	MOVE.W	#$FF00, D1
	TRAP 	#15

; --- nacrtaj zvijezde ---
	MOVE.W 	#80, D0			; Postavi pen na WHITE
	MOVE.L	#WHITE, D1
	TRAP 	#15
	
	MOVE.W 	#81, D0			; Postavi fill na WHITE
	MOVE.L	#WHITE, D1
	TRAP 	#15
	
	MOVE.L  #0, D5          	; Brojac za zvijezde = 0
	MOVEA 	#STAR_X, A0
	MOVEA	#STAR_Y, A1

DRAW_STARS:
        CMP.W  	STAR_COUNT, D5         	; Usporedi koliko je zvijezdi preostalo
        BEQ 	DONE_STARS
	
        MOVE.W 	(A0), D1		; Ucitaj kordinate 		
        MOVE.W 	(A1), D2
	MOVE.W 	(A0)+, D3 		
        MOVE.W 	(A1)+, D4
        
        ADDQ.W	#3, D3			; Udebljaj krug tj zvijezdu
	ADDQ.W	#3, D4
	
	MOVE    #88, D0			; Nacrtaj zvijezdu
        TRAP    #15

        ADDQ.L #1, D5           	; Sljedecu zvijezdu
        BRA DRAW_STARS	
DONE_STARS:

; --- nacrtaj sunce ---
	MOVE.W 	#80, D0			; Postavi pen na YELLOW
	MOVE.L	#YELLOW, D1
	TRAP 	#15
	
	MOVE.W 	#81, D0			; Postavi fill na YELLOW
	MOVE.L	#YELLOW, D1
	TRAP 	#15
	
	MOVE.W 	#300, D1		; Ucitaj koridinate za sunce 		
        MOVE.W 	#220, D2
	MOVE.W 	#340, D3
        MOVE.W 	#260, D4
        
        MOVE    #88, D0			; Nacrtaj sunce
        TRAP    #15
        
; --- Nacrtaj brodove ---
        MOVEA	#BROD_A, A0		; Nacrtaj broj A
	JSR	NACRTAJ_BROD
	
	MOVEA	#BROD_B, A0		; Nacrtaj broj B
	JSR	NACRTAJ_BROD
	
;--- Nacrtaj projektile ---
	MOVEA	#PROJ_A_1, A0		; Nacrtaj Projektil 1 broda A 
	JSR	NACRTAJ_PROJEKTIL
	MOVEA	#PROJ_A_2, A0		; Nacrtaj Projektil 2 broda A
	JSR	NACRTAJ_PROJEKTIL
	MOVEA	#PROJ_A_3, A0		; Nacrtaj Projektil 3 broda A
	JSR	NACRTAJ_PROJEKTIL
	MOVEA	#PROJ_A_4, A0		; Nacrtaj Projektil 4 broda A
	JSR	NACRTAJ_PROJEKTIL
	MOVEA	#PROJ_A_5, A0		; Nacrtaj Projektil 5 broda A
	JSR	NACRTAJ_PROJEKTIL
	
	MOVEA	#PROJ_B_1, A0		; Nacrtaj Projektil 1 broda B
	JSR	NACRTAJ_PROJEKTIL
	MOVEA	#PROJ_B_2, A0		; Nacrtaj Projektil 2 broda B
	JSR	NACRTAJ_PROJEKTIL
	MOVEA	#PROJ_B_3, A0		; Nacrtaj Projektil 3 broda B
	JSR	NACRTAJ_PROJEKTIL
	MOVEA	#PROJ_B_4, A0		; Nacrtaj Projektil 4 broda B
	JSR	NACRTAJ_PROJEKTIL
	MOVEA	#PROJ_B_5, A0		; Nacrtaj Projektil 5 broda B
	JSR	NACRTAJ_PROJEKTIL
					
; --- Ispisi tekst za gorivo na ekranu ---
; --- Ispisi gorivo za brod A ---
	MOVE.W 	#80, D0			; Postavi pen na WHITE
	MOVE.L	#WHITE, D1
	TRAP 	#15
	
	MOVE.W 	#81, D0			; Postavi fill na BLACK
	MOVE.L	#BLACK, D1
	TRAP 	#15

	MOVE.W	#11, D0			; Postavi kursor za igraca A
	MOVE.W	#$0000, D1		
	TRAP	#15

	MOVEA.W	#TXT_A_F, A1		; Ispis teskta o gorivu od A
	MOVE.W	#1, D0
	MOVE.W	#255, D1
	TRAP 	#15
	
	MOVE.W 	FUEL_A, D2		; dohva�anje broja	
		
	MULU.W	#100, D2		; pretvaranje u postotak
	DIVU.W	#FUEL_MAX, D2
	ANDI.L  #$0000FFFF, D2
	
	MOVE.W 	D2, D1			; dobivanje 3 decimale broja u D1
	DIVU.W	#100, D1		
	ANDI.L  #$0000FFFF, D1
	ADD.W	#'0', D1
	
	MOVE.W 	#6, D0			; prikazi 3 decimalu
	TRAP 	#15
	
	MOVE.W 	D2, D1			; dobivanje 2 decimale broja u D1
	DIVU.W	#10, D1
	ANDI.L  #$0000FFFF, D1
	DIVU.W	#10, D1
	SWAP	D1
	ANDI.L  #$0000FFFF, D1
	ADD.W	#'0', D1
	
	MOVE.W 	#6, D0			; prikazi 2 decimalu
	TRAP 	#15
	
	MOVE.W 	D2, D1			; dobivanje 1 decimale broja u D1
	DIVU.W	#10, D1
	SWAP	D1
	ANDI.L  #$0000FFFF, D1
	ADD.W	#'0', D1
	
	MOVE.W 	#6, D0			; prikazi 1 decimalu
	TRAP 	#15
	
; ---Ispisi gorivo za brod B ---
	MOVE.W	#11, D0			; Postavi kursor za igraca B
	MOVE.W	#$4300, D1		
	TRAP	#15

	MOVE.W 	FUEL_B, D2		; Dohvacanje broja	
		
	MULU.W	#100, D2		; Pretvaranje u postotak
	DIVU.W	#FUEL_MAX, D2
	ANDI.L  #$0000FFFF, D2


	MOVE.W 	D2, D1			; Dobivanje 3 decimale broja u D1
	DIVU.W	#100, D1
	ANDI.L  #$0000FFFF, D1
	ADD.W	#'0', D1
	
	MOVE.W 	#6, D0			; Prikazi 3 decimalu
	TRAP 	#15
	
	MOVE.W 	D2, D1			; Dobivanje 2 decimale broja u D1
	DIVU.W	#10, D1
	ANDI.L  #$0000FFFF, D1
	DIVU.W	#10, D1
	SWAP	D1
	ANDI.L  #$0000FFFF, D1
	ADD.W	#'0', D1
	
	MOVE.W 	#6, D0			; Prikazi 2 decimalu
	TRAP 	#15
	
	MOVE.W 	D2, D1			; Dobivanje 1 decimale broja u D1
	DIVU.W	#10, D1
	SWAP	D1
	ANDI.L  #$0000FFFF, D1
	ADD.W	#'0', D1
	
	MOVE.W 	#6, D0			; Prikazi 1 decimalu
	TRAP 	#15
	
	MOVEA.W	#TXT_B_F, A1		; Ispis teskta o gorivu od B
	MOVE.W	#1, D0
	MOVE.W	#255, D1
	TRAP 	#15

	MOVE.W 	#94, D0			; Prikazi buffer iz memorije na ekran
	TRAP 	#15

	RTS				; Zaustavi funkciju

; ---                    KEY_COOLDOWN                    ---
; ----------------------------------------------------------
;  Funkcija brojac s A0 smanjuje za 1 ako nije 0
; -----------------------------------------------------------
KEY_COOLDOWN:
    	MOVE.W	(A0), D0		; Dohvati vrijednost

    	CMP	#0, D0			; Usporedi je s 0
	BEQ	KEY_COOLDOWN_KRAJ
	
	ADD.W	#-1, D0			; Ako je > 0 onda smanji za 1
	
	MOVE.W	D0, (A0)		; Spremi vrijednost	

KEY_COOLDOWN_KRAJ:			; Zaustavi funkciju
    	RTS 


; ---                      DELAY_1S                      ---
; -----------------------------------------------------------
;  Funkcija ceka otprilike jednu seknudu pomocu NOP
; -----------------------------------------------------------
DELAY_1S:
	MOVE.L  #300000, D0		; Brojac iteracija

DELAY_1S_LOOP:
    	NOP				; Trosi vrijeme

    	SUBQ.L #1, D0			; Smanji brojac

    	BNE DELAY_1S_LOOP		; Ako nije 0, ponovi

    	RTS 				; Zavrsi funkciju ako je brojac dosao na 0


; ---                  GAME_FRAME_DELAY                   ---
; -----------------------------------------------------------
;  Za usporiti izmjenu frejmova
; -----------------------------------------------------------
GAME_FRAME_DELAY:
    	MOVE.L  #10000, D0		; Brojac iteracija
GAME_FRAME_DELAY_LOOP:
    	NOP				; Trosi vrijeme

    	SUBQ.L #1, D0			; Smanji brojac

    	BNE GAME_FRAME_DELAY_LOOP	; Ako nije 0, ponovi

    	RTS 				; Zavrsi funkciju ako je brojac dosao na 0


; ---                  PROVJERI_KOLIZIJU                  ---
; -----------------------------------------------------------
;  Izmedu objekata na A0 i A1 gdje je D1 duljina A0, D2 
;  duljina A1 te ako se desila kolizija: D0 postavlja se na 1 
;  inace D0 ostaje nepromjenjen
; -----------------------------------------------------------
PROVJERI_KOLIZIJU:
; --- X os ---
	MOVE.W  0(A1), D3		; D3 = A1.X - A0.X
        SUB.W   0(A0), D3      

        BPL     X_A0_LEFT     		; ako >=0 onda je A0 lijevo

; --- A0 desno od A1 ---
        NEG.W   D3             		; D3 = A0.X - A1.X

        CMP.W   D2, D3			; usporedi blizinu

        BGE     NO_COLLISION		; Nije se desila koalizija te zaustavi funkciju
        
	BRA     CHECK_Y			; Provjeri Y os

; --- A0 lijevo od A1 ---
X_A0_LEFT:
        CMP.W   D1, D3			; usporedi blizinu			
        
	BGE     NO_COLLISION

; --- Y osa ---
CHECK_Y:
        MOVE.W  2(A1), D3		; D3 = A1.Y - A0.Y
        SUB.W   2(A0), D3      			

        BPL     Y_A0_UP        		; ako >=0 onda je A0 je iznad

; --- A0 ispod A1 ---
        NEG.W   D3			; D3 = A0.Y - A1.Y

        CMP.W   D2, D3			; Usporedi blizinu

        BGE     NO_COLLISION		; Nije se desila koalizija te zaustavi funkciju

        BRA     COLLISION		; Koalizija se desila
; --- A1 ispod A0 ---
Y_A0_UP:
        CMP.W   D1, D3			; Provjeri udaljenost

        BGE     NO_COLLISION		; Nije se desila koalizija

; --- Koalizija se desila ---
COLLISION:
        MOVE.W  #1, D0			; Postavi D0 = 1

        RTS				; Izadi iz funkcije

NO_COLLISION:				; Koalizija se nije desila te izadi iz funkcije
        RTS


; ---                  STVORI_PROJEKTIL                   ---
; -----------------------------------------------------------
;  Stvori projektil pod memorijskom lokacijom A0 od broda 
;  na memorijskoj lokaciji A1
; -----------------------------------------------------------
STVORI_PROJEKTIL:
	MOVE.W	0(A1), 0(A0)		; Postavi (x, a) kordinate broda na (x, y) kordinate projektila
	MOVE.W	2(A1), 2(A0)
	
	MOVE.W	8(A1), D0		; Ulitaj u D0 orijentaciju broda
	
	CMP.W	#0, D0			; Za zadanu rotaciju posatvi ispravan vektor smjera projektila
	BEQ	STVORI_PROJEKTIL_R0
	CMP.W	#1, D0
	BEQ	STVORI_PROJEKTIL_R1
	CMP.W	#2, D0
	BEQ	STVORI_PROJEKTIL_R2
	CMP.W	#3, D0
	BEQ	STVORI_PROJEKTIL_R3
	CMP.W	#4, D0
	BEQ	STVORI_PROJEKTIL_R4
	CMP.W	#5, D0
	BEQ	STVORI_PROJEKTIL_R5
	CMP.W	#6, D0
	BEQ	STVORI_PROJEKTIL_R6
	CMP.W	#7, D0
	BEQ	STVORI_PROJEKTIL_R7
	CMP.W	#8, D0
	BEQ	STVORI_PROJEKTIL_R8
	CMP.W	#9, D0
	BEQ	STVORI_PROJEKTIL_R9
	CMP.W	#10, D0
	BEQ	STVORI_PROJEKTIL_R10
	CMP.W	#11, D0
	BEQ	STVORI_PROJEKTIL_R11
	CMP.W	#12, D0
	BEQ	STVORI_PROJEKTIL_R12
	CMP.W	#13, D0
	BEQ	STVORI_PROJEKTIL_R13
	CMP.W	#14, D0
	BEQ	STVORI_PROJEKTIL_R14
	CMP.W	#15, D0
	BEQ	STVORI_PROJEKTIL_R15

	RTS				; Nešto je poslo po zlu ali izadi iz funkije (ne bi se trebalo desili)

STVORI_PROJEKTIL_R0:			; Projek za rotaciju od 0 stupljeva
	MOVE.W	#0, 4(A0)		; Postavi odgovarajuci vektor smjera
	MOVE.W	#-3, 6(A0)

	RTS				; Zavrsi funkciju

STVORI_PROJEKTIL_R1:			; Projek za rotaciju od 22.5 stupljeva
	MOVE.W	#2, 4(A0)		; Postavi odgovarajuci vektor smjera
	MOVE.W	#-3, 6(A0)

	RTS				; Zavrsi funkciju

STVORI_PROJEKTIL_R2:			; Projek za rotaciju od 45 stupljeva
	MOVE.W	#3, 4(A0)		; Postavi odgovarajuci vektor smjera
	MOVE.W	#-3, 6(A0)

	RTS				; Zavrsi funkciju

STVORI_PROJEKTIL_R3:			; Projek za rotaciju od 67.5 stupljeva
	MOVE.W	#3, 4(A0)		; Postavi odgovarajuci vektor smjera
	MOVE.W	#-2, 6(A0)

	RTS				; Zavrsi funkciju

STVORI_PROJEKTIL_R4:			; Projek za rotaciju od 90 stupljeva
	MOVE.W	#3, 4(A0)		; Postavi odgovarajuci vektor smjera
	MOVE.W	#0, 6(A0)
	
	RTS				; Zavrsi funkciju

STVORI_PROJEKTIL_R5:			; Projek za rotaciju od 112.5 stupljeva
	MOVE.W	#3, 4(A0)		; Postavi odgovarajuci vektor smjera
	MOVE.W	#2, 6(A0)

	RTS 				; Zavrsi funkciju

STVORI_PROJEKTIL_R6:			; Projek za rotaciju od 135 stupljeva
	MOVE.W	#3, 4(A0)		; Postavi odgovarajuci vektor smjera
	MOVE.W	#3, 6(A0)

	RTS				; Zavrsi funkciju

STVORI_PROJEKTIL_R7:			; Projek za rotaciju od 157.5 stupljeva
	MOVE.W	#2, 4(A0)		; Postavi odgovarajući vektor smjera
	MOVE.W	#3, 6(A0)

	RTS				; Zavrsi funkciju

STVORI_PROJEKTIL_R8:			; Projek za rotaciju od 180 stupljeva
	MOVE.W	#0, 4(A0)		; Postavi odgovarajući vektor smjera
	MOVE.W	#3, 6(A0)

	RTS				; Zavrsi funkciju

STVORI_PROJEKTIL_R9:			; Projek za rotaciju od 202.5 stupljeva
	MOVE.W	#-2, 4(A0)		; Postavi odgovarajući vektor smjera
	MOVE.W	#3, 6(A0)

	RTS				; Zavrsi funkciju

STVORI_PROJEKTIL_R10:			; Projek za rotaciju od 225 stupljeva
	MOVE.W	#-3, 4(A0)		; Postavi odgovarajući vektor smjera
	MOVE.W	#3, 6(A0)

	RTS				; Zavrsi funkciju

STVORI_PROJEKTIL_R11:			; Projek za rotaciju od 247.5 stupljeva
	MOVE.W	#-3, 4(A0)		; Postavi odgovarajući vektor smjera
	MOVE.W	#2, 6(A0)

	RTS				; Zavrsi funkciju

STVORI_PROJEKTIL_R12:			; Projek za rotaciju od 270 stupljeva
	MOVE.W	#-3, 4(A0)		; Postavi odgovarajući vektor smjera
	MOVE.W	#0, 6(A0)

	RTS				; Zavrsi funkciju

STVORI_PROJEKTIL_R13:			; Projek za rotaciju od 292.5 stupljeva
	MOVE.W	#-3, 4(A0)		; Postavi odgovarajući vektor smjera
	MOVE.W	#-2, 6(A0)

	RTS				; Zavrsi funkciju

STVORI_PROJEKTIL_R14:			; Projek za rotaciju od 315 stupljeva
	MOVE.W	#-3, 4(A0)		; Postavi odgovarajući vektor smjera
	MOVE.W	#-3, 6(A0)

	RTS				; Zavrsi funkciju

STVORI_PROJEKTIL_R15:			; Projek za rotaciju od 337.5 stupljeva
	MOVE.W	#-2, 4(A0)		; Postavi odgovarajući vektor smjera
	MOVE.W	#-3, 6(A0)

	RTS				; Zavrsi funkciju


; ---                  NACRTAJ_PROJEKTIL                  ---
; -----------------------------------------------------------
;  Nacrtaj projektil pod memorijskom lokacijom A0
; -----------------------------------------------------------
NACRTAJ_PROJEKTIL:
	MOVE.W 	#80, D0			; Postavi pen na boju projektila
	MOVE.L	8(A0), D1
	TRAP 	#15
	
	MOVE.W 	#81, D0			; Postavi fill na boju projektila
	MOVE.L	8(A0), D1
	TRAP 	#15
	
	MOVE.W	#88, D0			; Nacrtaj projektil
	MOVE.W	0(A0), D1
	MOVE.W	2(A0), D2
	MOVE.W	0(A0), D3
	MOVE.W	2(A0), D4
	ADD.W	#5, D3
	ADD.W	#5, D4
	TRAP	#15
	
	RTS				; Zavrsi funkciju


; ---                    NACRTAJ_BROD                     ---
; -----------------------------------------------------------
;  Nacrtaj brod pod memorijskom lokacijom A0
; -----------------------------------------------------------
NACRTAJ_BROD:
	MOVE.W 	#80, D0			; Postavi pen na boju broda
	MOVE.L	16(A0), D1
	TRAP 	#15
	
	MOVE.W 	#81, D0			; Postavi fill na boju broda
	MOVE.L	16(A0), D1
	TRAP 	#15

	MOVE.W	8(A0), D0 		; Ucitaj rotaciju broda
	
	CMP.W	#0, D0			; Usporedi koja je rotacija te skoci na izabranu rotaciju za crtanje broda
	BEQ	NACRTAJ_BROD_R0
	CMP.W	#1, D0			
	BEQ	NACRTAJ_BROD_R1
	CMP.W	#2, D0			
	BEQ	NACRTAJ_BROD_R2
	CMP.W	#3, D0			
	BEQ	NACRTAJ_BROD_R3
	CMP.W	#4, D0			
	BEQ	NACRTAJ_BROD_R4
	CMP.W	#5, D0			
	BEQ	NACRTAJ_BROD_R5
	CMP.W	#6, D0			
	BEQ	NACRTAJ_BROD_R6
	CMP.W	#7, D0			
	BEQ	NACRTAJ_BROD_R7
	CMP.W	#8, D0			
	BEQ	NACRTAJ_BROD_R8
	CMP.W	#9, D0			
	BEQ	NACRTAJ_BROD_R9
	CMP.W	#10, D0			
	BEQ	NACRTAJ_BROD_R10
	CMP.W	#11, D0			
	BEQ	NACRTAJ_BROD_R11
	CMP.W	#12, D0			
	BEQ	NACRTAJ_BROD_R12
	CMP.W	#13, D0			
	BEQ	NACRTAJ_BROD_R13
	CMP.W	#14, D0			
	BEQ	NACRTAJ_BROD_R14
	CMP.W	#15, D0			
	BEQ	NACRTAJ_BROD_R15

	RTS				; Zavrsi funkciju ako je nesto poslo po krivu (Ovo se ne bi trebalo dogoditi)

NACRTAJ_BROD_R0:			; 0 stupnjeva
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#0, D2
	ADD.W	#2, D3
	ADD.W	#16, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#2, D1			; Popravi kordinate
	ADD.W	#16, D2
	ADD.W	#14, D3
	ADD.W	#16, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#14, D1			; Popravi kordinate
	ADD.W	#16, D2
	ADD.W	#8, D3
	ADD.W	#0, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funkciju

NACRTAJ_BROD_R1:			; 22.5 stupnja		
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#12, D1			; Popravi kordinate
	ADD.W	#0, D2
	ADD.W	#0, D3
	ADD.W	#12, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#0, D1			; Popravi kordinate
	ADD.W	#12, D2
	ADD.W	#10, D3
	ADD.W	#16, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#10, D1			; Uopravi kordinate
	ADD.W	#16, D2
	ADD.W	#12, D3
	ADD.W	#0, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funkciju

NACRTAJ_BROD_R2:			; 45 stupnjeva
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#16, D1			; Popravi kordinate
	ADD.W	#0, D2
	ADD.W	#0, D3
	ADD.W	#8, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#0, D1			; Popravi kordinate
	ADD.W	#8, D2
	ADD.W	#8, D3
	ADD.W	#16, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#16, D2
	ADD.W	#16, D3
	ADD.W	#0, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funciju

NACRTAJ_BROD_R3:			; 67.5 stupnjeva
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#16, D1			; Popravi kordinate
	ADD.W	#4, D2
	ADD.W	#0, D3
	ADD.W	#6, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#0, D1			; Popravi kordinate
	ADD.W	#6, D2
	ADD.W	#6, D3
	ADD.W	#16, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#6, D1			; Popravi kordinate
	ADD.W	#16, D2
	ADD.W	#16, D3
	ADD.W	#4, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funkciju

NACRTAJ_BROD_R4:			; 90 stupnjeva
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#16, D1			; Popravi kordinate
	ADD.W	#8, D2
	ADD.W	#0, D3
	ADD.W	#2, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#0, D1			; Popravi kordinate
	ADD.W	#2, D2
	ADD.W	#0, D3
	ADD.W	#14, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#0, D1			; Popravi kordinate
	ADD.W	#14, D2
	ADD.W	#16, D3
	ADD.W	#8, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funkciju

NACRTAJ_BROD_R5:			; 112,5 stuplja
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#16, D1			; Popravi kordinate
	ADD.W	#12, D2
	ADD.W	#6, D3
	ADD.W	#0, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#6, D1			; Popravi kordinate
	ADD.W	#0, D2
	ADD.W	#0, D3
	ADD.W	#10, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#0, D1			; Popravi kordinate
	ADD.W	#10, D2
	ADD.W	#16, D3
	ADD.W	#12, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funkciju

NACRTAJ_BROD_R6:			; 135 stupnjeva
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#16, D1			; Popravi kordinate
	ADD.W	#16, D2
	ADD.W	#8, D3
	ADD.W	#0, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#0, D2
	ADD.W	#0, D3
	ADD.W	#8, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#0, D1			; Popravi kordinate
	ADD.W	#8, D2
	ADD.W	#16, D3
	ADD.W	#16, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funkciju

NACRTAJ_BROD_R7:			; 157.5 stupnjeva
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#12, D1			; Popravi kordinate
	ADD.W	#16, D2
	ADD.W	#0, D3
	ADD.W	#4, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#0, D1			; Popravi kordinate
	ADD.W	#4, D2
	ADD.W	#12, D3
	ADD.W	#0, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#12, D1			; Popravi kordinate
	ADD.W	#0, D2
	ADD.W	#12, D3
	ADD.W	#16, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funkciju

NACRTAJ_BROD_R8:			; 180 stupnjeva
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#16, D2
	ADD.W	#14, D3
	ADD.W	#0, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#14, D1			; Popravi kordinate
	ADD.W	#0, D2
	ADD.W	#2, D3
	ADD.W	#0, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#2, D1			; Popravi kordinate
	ADD.W	#0, D2
	ADD.W	#8, D3
	ADD.W	#16, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funkciju

NACRTAJ_BROD_R9:			; 202.5 stupnjeva			
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#4, D1			; Popravi kordinate
	ADD.W	#16, D2
	ADD.W	#16, D3
	ADD.W	#4, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#16, D1			; Popravi kordinate
	ADD.W	#4, D2
	ADD.W	#6, D3
	ADD.W	#0, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#6, D1			; Popravi kordinate
	ADD.W	#0, D2
	ADD.W	#4, D3
	ADD.W	#16, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funkciju

NACRTAJ_BROD_R10:			; 225 stupnjeva
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#0, D1			; Popravi kordinate
	ADD.W	#16, D2
	ADD.W	#16, D3
	ADD.W	#8, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#16, D1			; Popravi kordinate
	ADD.W	#8, D2
	ADD.W	#8, D3
	ADD.W	#0, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#0, D2
	ADD.W	#0, D3
	ADD.W	#16, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funkciju

NACRTAJ_BROD_R11:			; 247.5 stupnjeva
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#0, D1			; Popravi kordinate
	ADD.W	#12, D2
	ADD.W	#16, D3
	ADD.W	#10, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#16, D1			; Popravi kordinate
	ADD.W	#10, D2
	ADD.W	#12, D3
	ADD.W	#0, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#12, D1			; Popravi kordinate
	ADD.W	#0, D2
	ADD.W	#0, D3
	ADD.W	#12, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funkciju

NACRTAJ_BROD_R12:			; 270 stupnjeva
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#0, D1			; Popravi kordinate
	ADD.W	#8, D2
	ADD.W	#16, D3
	ADD.W	#14, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#16, D1			; Popravi kordinate
	ADD.W	#14, D2
	ADD.W	#16, D3
	ADD.W	#2, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#16, D1			; Popravi kordinate
	ADD.W	#2, D2
	ADD.W	#0, D3
	ADD.W	#8, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funkciju

NACRTAJ_BROD_R13:			; 292.5 stupnjeva
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#0, D1			; Popravi kordinate
	ADD.W	#4, D2
	ADD.W	#10, D3
	ADD.W	#16, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#10, D1			; Popravi kordinate
	ADD.W	#16, D2
	ADD.W	#16, D3
	ADD.W	#6, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#16, D1			; Popravi kordinate
	ADD.W	#6, D2
	ADD.W	#0, D3
	ADD.W	#4, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funkciju

NACRTAJ_BROD_R14:			; 315 stupnjeva
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#0, D1			; Popravi kordinate
	ADD.W	#0, D2
	ADD.W	#8, D3
	ADD.W	#16, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#16, D2
	ADD.W	#16, D3
	ADD.W	#8, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#16, D1			; Popravi kordinate
	ADD.W	#8, D2
	ADD.W	#0, D3
	ADD.W	#0, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funkciju

NACRTAJ_BROD_R15:			; 337.5 stupnjeva
	MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#4, D1			; Popravi kordinate
	ADD.W	#0, D2
	ADD.W	#6, D3
	ADD.W	#16, D4

	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#6, D1			; Popravi kordinate
	ADD.W	#16, D2
	ADD.W	#16, D3
	ADD.W	#12, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	MOVE.W	$0(A0), D3
	MOVE.W	$2(A0), D4
	
	ADD.W	#16, D1			; Popravi kordinate
	ADD.W	#12, D2
	ADD.W	#4, D3
	ADD.W	#0, D4
	
	MOVE    #84, D0			; Nacrtaj liniju
        TRAP    #15
        
        MOVE.W	$0(A0), D1		; Ucitaj kordinate
	MOVE.W	$2(A0), D2
	
	ADD.W	#8, D1			; Popravi kordinate
	ADD.W	#8, D2
	
	MOVE    #89, D0			; Ispuni brod bojom
        TRAP    #15

	JMP NACRTAJ_BROD_KRAJ		; Zavrsi funkciju

NACRTAJ_BROD_KRAJ:			; Zavrsi funkciju
	RTS


; ---                    POMAKNI_BROD                     ---
; -----------------------------------------------------------
;  Pomakni brod s adrese A0
; -----------------------------------------------------------
POMAKNI_BROD:
	MOVE.W	$0(A0), D0		; Ucitaj kordinate
	MOVE.W	$2(A0), D1
	ANDI.L  #$0000FFFF, D0		
        ANDI.L  #$0000FFFF, D1
	
	ADD.W	$4(A0), D0		; Dodaj vektor smjera
	ADD.W	$6(A0), D1
	
	ADD.W	#640, D0		; Povecaj kordinate za odredeni iznost tako da vrijednosti ne budu negativne
	ADD.W	#480, D1
	
    	DIVS.W  #640, D0      		; Dn = Dn / a
	DIVS.W  #480, D1      		

    	SWAP    D0            		; Uzimanje ostatak
    	SWAP    D1
    	ANDI.L  #$0000FFFF, D0		; Dn = Dn mod a
        ANDI.L  #$0000FFFF, D1
        
        MOVE.W	D0, $0(A0)		; Spremi nove kordinate
	MOVE.W	D1, $2(A0)
        
	RTS


; ---                 POMAKNI_PROJEKTIL                  ---
;-----------------------------------------------------------
;  Pomakni projektil s adrese A0
;-----------------------------------------------------------
POMAKNI_PROJEKTIL:
	MOVE.W	$0(A0), D0		; Ucitaj kordinate
	MOVE.W	$2(A0), D1
	ANDI.L  #$0000FFFF, D0		
        ANDI.L  #$0000FFFF, D1
	
	ADD.W	$4(A0), D0		; Dodaj vektora smjera
	ADD.W	$6(A0), D1
	
; ---- provjera D0 ----
        CMP.W   #0, D0			; D0 < 0
        BLT     OUT_OF_RANGE

        CMP.W   #640, D0		; D0 > 640
        BGT     OUT_OF_RANGE

; ---- provjera D1 ----
        CMP.W   #0, D1			; D1 < 0
        BLT     OUT_OF_RANGE

        CMP.W   #480, D1		; D1 > 480
        BGT     OUT_OF_RANGE

        BRA     SAVE_XY			; sve OK

; ---- izvan granica ----
OUT_OF_RANGE:
        MOVE.W  #-10, D0		; postavi na neutralne kordinate
        MOVE.W  #-10, D1

SAVE_XY:
        MOVE.W	D0, $0(A0)		; spremi nove kordinate
	MOVE.W	D1, $2(A0)
        
	RTS


; ---                      BROD_GAS                       ---
; -----------------------------------------------------------
;  Daj gas brodu s adrese A0 ako je moguce
; -----------------------------------------------------------
BROD_GAS:
	MOVE.W	14(A0), D0		; Ucitaj vrijednost spremnika
	CMP.W	#0, D0
	BEQ	BROD_GAS_KRAJ		; Ako je na 0 onda ne radi nista
	
	ADD.W	#-1, D0			; Smanji vrijednost spremnika za 1
	MOVE.W	D0, 14(A0)
	
	MOVE.W	$8(A0), D0		; ucitaj rotaciju
	CMP.W	#0, D0
	BEQ	BROD_GAS_R0
	CMP.W	#1, D0
	BEQ	BROD_GAS_R1
	CMP.W	#2, D0
	BEQ	BROD_GAS_R2
	CMP.W	#3, D0
	BEQ	BROD_GAS_R3
	CMP.W	#4, D0
	BEQ	BROD_GAS_R4
	CMP.W	#5, D0
	BEQ	BROD_GAS_R5
	CMP.W	#6, D0
	BEQ	BROD_GAS_R6
	CMP.W	#7, D0
	BEQ	BROD_GAS_R7
	CMP.W	#8, D0
	BEQ	BROD_GAS_R8
	CMP.W	#9, D0
	BEQ	BROD_GAS_R9
	CMP.W	#10, D0
	BEQ	BROD_GAS_R10
	CMP.W	#11, D0
	BEQ	BROD_GAS_R11
	CMP.W	#12, D0
	BEQ	BROD_GAS_R12
	CMP.W	#13, D0
	BEQ	BROD_GAS_R13
	CMP.W	#14, D0
	BEQ	BROD_GAS_R14
	CMP.W	#15, D0
	BEQ	BROD_GAS_R15

	RTS				; Zavrsi funkciju ako je nesto poslo po krivu (ne bi se trebalo dogoditi)
	
BROD_GAS_R0:				; Rotacija od 0 stupnjeva
	MOVE.W	#0, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#-2, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju

BROD_GAS_R1:				; Rotacija od 22.5 stupljeva
	MOVE.W	#1, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#-2, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju

BROD_GAS_R2:				; Rotacija od 45 stupnjeva
	MOVE.W	#2, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#-2, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju

BROD_GAS_R3:				; Rotacija od 67.5 stupnjeva
	MOVE.W	#2, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#-1, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju

BROD_GAS_R4:				; Rotacija od 90 stupnjeva
	MOVE.W	#2, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#0, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju

BROD_GAS_R5:				; Rotacija od 112.5 stupnjeva
	MOVE.W	#2, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#1, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju

BROD_GAS_R6:				; Rotacija od 135 stupnjeva
	MOVE.W	#2, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#2, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju

BROD_GAS_R7:				; Rotacija od 157.5 stupnjeva
	MOVE.W	#1, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#2, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju

BROD_GAS_R8:				; Rotacija od 180 stupnjeva
	MOVE.W	#0, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#2, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju

BROD_GAS_R9:				; Rotacija od 202.5 stupnjeva
	MOVE.W	#-1, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#2, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju

BROD_GAS_R10:				; Rotacija od 225 stupnjeva
	MOVE.W	#-2, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#2, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju

BROD_GAS_R11:				; Rotacija od 247.5 stupnjeva
	MOVE.W	#-2, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#1, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju

BROD_GAS_R12:				; Rotacija od 270 stupnjeva
	MOVE.W	#-2, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#0, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju

BROD_GAS_R13:				; Rotacija od 292.5 stupnjeva
	MOVE.W	#-2, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#-1, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju

BROD_GAS_R14:				; Rotacija od 315 stupnjeva
	MOVE.W	#-2, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#-2, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju

BROD_GAS_R15:				; Rotacija od 337.5 stupnjeva
	MOVE.W	#-1, $4(A0)		; Spremi odgovarajuci vektor smjera
	MOVE.W	#-2, $6(A0)

	JMP 	BROD_GAS_KRAJ		; Zavrsi funkciju
	
BROD_GAS_KRAJ:				; Zavrsi funkciju
	RTS


; ---              POMAKNI_BROD_GRAVITACIJA               ---
; -----------------------------------------------------------
;  Pomakni brod s adrese A0 zbog gravitacije
; -----------------------------------------------------------
POMAKNI_BROD_GRAVITACIJA:
	MOVE.W	$0(A0), D0		; Ucitaj kordinate
	MOVE.W	$2(A0), D1
	ANDI.L  #$0000FFFF, D0		
        ANDI.L  #$0000FFFF, D1
	
	MOVE.W	#0, D2			; Ucitaj 0 u D2 i D3
	MOVE.W	#0, D3

        CMP.W   #320, D0		; Pronadi u kojem su kvadrantu brodovi
        BLT     X_LEFT
        BGT     X_RIGHT
        BRA     Y_CHECK     		; == 320 ostaje 0
X_LEFT:
        MOVE.W  #1, D2
        BRA     Y_CHECK
X_RIGHT:
        MOVE.W  #-1, D2
Y_CHECK:
        CMP.W   #240, D1
        BLT     Y_UP
        BGT     Y_DOWN
        BRA     XY_DONE        		; == 240 ostaje 0
Y_UP:
        MOVE.W  #1, D3
        BRA     XY_DONE

Y_DOWN:
        MOVE.W  #-1, D3
XY_DONE:
	ADD.W	$4(A0), D2		; Dodaj vektor vektoru svjera
	ADD.W	$6(A0), D3
	
        MOVE.W  D2, D0			; D0 = D2 (X koordinata)

        CMP.W   #2, D0			; Ako je iznad 2 postavi na 2
        BGT     LIMIT4_POS

        CMP.W   #-2, D0			; Ako je ispod -2 postavi na -2
        BLT     LIMIT4_NEG

        BRA     CLAMP_6			; Nije nista preskoci dalje

LIMIT4_POS:				; postavi na 2
        MOVE.W  #2, 4(A0)
        BRA     CLAMP_6

LIMIT4_NEG:				; postavi na -2
        MOVE.W  #-2, 4(A0)

CLAMP_6:
        MOVE.W  D3, D1			; D0 = D3 (Y koordinata)

        CMP.W   #2, D1			; Ako je iznad 2 postavi na 2
        BGT     LIMIT6_POS
	
        CMP.W   #-2, D1			; Ako je ispod -2 postavi na -2
        BLT     LIMIT6_NEG

        BRA     LIMIT46_DONE		; Nije nista, preskoci dalje

LIMIT6_POS:				; Postavi na 2
        MOVE.W  #2, $6(A0)
        BRA     LIMIT46_DONE

LIMIT6_NEG:				; Postavi na -2
        MOVE.W  #-2, $6(A0)

LIMIT46_DONE:
	
        MOVE.W	D0, $4(A0)		; Spremi nove kordinate
	MOVE.W	D1, $6(A0)
        
	RTS


; ---                     DATA_RESET                     ---
;-----------------------------------------------------------
;  Resetiraj podatke na pocetne vrijednosti za novu igru
;-----------------------------------------------------------
DATA_RESET:
	MOVE.W 	#40, X_A		; Postavi vrijednosti za brod A
	MOVE.W	#420, Y_A
	MOVE.W	#0, VX_A
	MOVE.W	#-1, VY_A
	MOVE.W	#0, R_A
	MOVE.W	#FUEL_MAX, FUEL_A
	
	MOVE.W 	#580, X_B		; Postavi vrijednosti za brod B
	MOVE.W	#40, Y_B
	MOVE.W	#0, VX_B
	MOVE.W	#1, VY_B
	MOVE.W	#8, R_B
	MOVE.W	#FUEL_MAX, FUEL_B
	
	MOVE.W	#-10, PX1_A		; Postavi vrijednosti za projektil 1 broda A
	MOVE.W	#-10, PY1_A
	
	MOVE.W	#-10, PX2_A		; Postavi vrijednosti za projektil 2 broda A
	MOVE.W	#-10, PY2_A
	
	MOVE.W	#-10, PX3_A		; Postavi vrijednosti za projektil 3 broda A
	MOVE.W	#-10, PY3_A
	
	MOVE.W	#-10, PX4_A		; Postavi vrijednosti za projektil 4 broda A
	MOVE.W	#-10, PY4_A
	
	MOVE.W	#-10, PX5_A		; Postavi vrijednosti za projektil 5 broda A
	MOVE.W	#-10, PY5_A
	
	MOVE.W	#-10, PX1_B		; Postavi vrijednosti za projektil 1 broda B
	MOVE.W	#-10, PY1_B
	
	MOVE.W	#-10, PX2_B		; Postavi vrijednosti za projektil 2 broda B
	MOVE.W	#-10, PY2_B
	
	MOVE.W	#-10, PX3_B		; Postavi vrijednosti za projektil 3 broda B
	MOVE.W	#-10, PY3_B
	
	MOVE.W	#-10, PX4_B		; Postavi vrijednosti za projektil 4 broda B
	MOVE.W	#-10, PY4_B
	
	MOVE.W	#-10, PX5_B		; Postavi vrijednosti za projektil 5 broda B
	MOVE.W	#-10, PY5_B
	
	RTS				; Zavrsetak funkcije


;=================================================================
; END
;=================================================================	

	END	START		; last line of source

;=================================================================
; POSTAVKE SIMULATORA
;=================================================================

; *~Font name~Courier New~, *~Font size~10~, *~Tab type~1~, *~Tab size~8~





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~8~
