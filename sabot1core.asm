;----------------------------------------------------------------------------

	ORG $6270

;----------------------------------------------------------------------------

L6270:	DEFB	$3E,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00

; Show title picture (two ninjas)
L6289: 	LD HL,L62DB	; Encoded picture data address
 	LD DE,L6590	; Tile screens address, used as a buffer
L628F: 	LD A,(HL)	; Load next byte of picture data
 	CP $02		; check for control byte $02 - end of sequence
 	JR Z,L62A9 	; => Copy the buffer to screen
 	INC HL		; move to next source byte
 	CP $00		; check for repeater marker
 	JR Z,L62A1 	; => repeat byte N times
 	CP $FF		; check for block marker
 	JR Z,L62A1 	; => repeat byte N times
 	LD (DE),A	; Store regular byte into tile screen
 	INC DE		; next buffer address
 	JR L628F	; Loop back to process next byte
L62A1: 	LD B,(HL)	; get repeat count
L62A2: 	LD (DE),A	; store repeated byte in buffer
 	INC DE		; next buffer address
 	DJNZ L62A2	; repeat B times
 	INC HL		; move to next source byte
 	JR L628F	; continue processing
;
; Buffer is ready, copy to screen
L62A9: 	LD HL,$4000	; Start of screen
 	LD DE,L6590	; Tile screens address
 	LD C,$0C	; Number of columns = 12
L62B1: 	PUSH HL		; save screen address
 	LD B,$18	; Number of rows = 24
L62B4: 	PUSH HL		; save screen address
 	PUSH BC		; save counters
 	LD B,$08	; 8 lines
L62B8: 	LD A,(DE)	; get picture byte
 	OR (HL)		; bitwise OR with screen pixels
 	LD (HL),A	; put to the screen
 	INC DE		; next address in the buffer
 	INC H		; next line
 	DJNZ L62B8	; Repeat 8 times
 	POP BC		; restore counters
 	POP HL		; save screen address
 	RR H
 	RR H
 	RR H
 	PUSH DE		; save address in picture buffer
 	LD DE,$0020	; 32
 	ADD HL,DE	; move HL to next tile row
 	POP DE		; restore address in picture buffer
 	RL H
 	RL H
 	RL H
 	DJNZ L62B4	; continue loop for rows
 	POP HL		; restore screen address
 	INC HL		; next column
 	DEC C		; decrement column counter
 	JR NZ,L62B1	; continue loop for columns
 	RET

; Title picture (two ninjas), RLE encoded
L62DB:	DEFB	$00,$07,$FF,$01,$00,$01,$FF,$01
	DEFB	$03,$00,$14,$01,$01,$01,$01,$01
	DEFB	$01,$01,$03,$03,$03,$03,$03,$03
	DEFB	$03,$03,$07,$07,$0F,$0F,$1F,$1F
	DEFB	$0F,$0F,$0F,$07,$07,$07,$07,$03
	DEFB	$03,$03,$01,$01,$01,$00,$05,$01
	DEFB	$01,$01,$01,$03,$03,$03,$07,$07
	DEFB	$07,$07,$03,$01,$00,$01,$01,$03
	DEFB	$07,$03,$01,$01,$01,$03,$03,$07
	DEFB	$07,$0F,$0F,$0F,$0F,$0F,$0F,$1F
	DEFB	$6F,$EF,$F7,$F7,$FF,$01,$F7,$E7
	DEFB	$07,$07,$07,$03,$03,$03,$03,$03
	DEFB	$03,$03,$03,$03,$01,$01,$01,$01
	DEFB	$01,$01,$01,$01,$01,$03,$07,$07
	DEFB	$07,$03,$03,$03,$01,$01,$01,$01
	DEFB	$01,$00,$01,$01,$01,$01,$03,$07
	DEFB	$03,$01,$01,$01,$01,$01,$01,$01
	DEFB	$00,$07,$01,$01,$01,$01,$01,$01
	DEFB	$01,$00,$01,$01,$01,$01,$03,$03
	DEFB	$03,$03,$03,$01,$00,$13,$80,$7E
	DEFB	$FF,$01,$F8,$07,$00,$0D,$01,$07
	DEFB	$0F,$3F,$7F,$FF,$97,$7F,$3F,$1F
	DEFB	$00,$10,$07,$F8,$0A,$FD,$1D,$17
	DEFB	$10,$0F,$00,$05,$01,$0F,$3F,$FF
	DEFB	$03,$FE,$FC,$F8,$FB,$F7,$EF,$EF
	DEFB	$DF,$DF,$DF,$BF,$7F,$7E,$7E,$BF
	DEFB	$BF,$DF,$EF,$FF,$07,$F8,$FF,$3C
	DEFB	$FD,$FC,$FC,$F8,$F8,$F8,$F0,$F8
	DEFB	$F8,$F8,$FC,$FC,$FC,$FE,$FE,$FE
	DEFB	$FF,$0B,$FE,$FE,$FE,$FC,$FC,$FC
	DEFB	$FC,$F9,$F8,$F8,$F8,$F0,$F0,$F0
	DEFB	$E0,$E0,$E0,$C0,$C0,$C0,$C0,$C0
	DEFB	$80,$80,$80,$80,$80,$C0,$E0,$E0
	DEFB	$E0,$F0,$F8,$F8,$F8,$FC,$FC,$FC
	DEFB	$FE,$FE,$FE,$FC,$F8,$C0,$00,$10
	DEFB	$E0,$78,$8D,$23,$4F,$4F,$FF,$01
	DEFB	$0F,$9F,$7F,$7F,$7F,$FF,$02,$FC
	DEFB	$F8,$E0,$C0,$00,$04,$FC,$FF,$07
	DEFB	$00,$01,$FF,$01,$3F,$C0,$FE,$FE
	DEFB	$FF,$04,$FB,$FB,$F7,$CF,$3F,$FF
	DEFB	$15,$FE,$FE,$FE,$FC,$FC,$FD,$FB
	DEFB	$FB,$F7,$F7,$EF,$EF,$F7,$F7,$F4
	DEFB	$F8,$F8,$FC,$FE,$FE,$FE,$FF,$14
	DEFB	$7F,$0F,$01,$00,$05,$01,$01,$01
	DEFB	$03,$07,$07,$07,$07,$07,$0F,$0F
	DEFB	$0F,$0F,$0F,$1F,$1F,$1F,$1F,$1F
	DEFB	$3F,$7F,$7F,$7F,$FF,$06,$FE,$00
	DEFB	$31,$F8,$FC,$FE,$FE,$FE,$FC,$FC
	DEFB	$FC,$FE,$FF,$03,$7F,$3F,$1F,$1F
	DEFB	$1F,$3F,$3F,$3F,$7F,$7F,$FF,$05
	DEFB	$7F,$7F,$7F,$7F,$7F,$FF,$06,$FE
	DEFB	$F8,$F0,$F0,$E0,$C0,$80,$80,$C0
	DEFB	$C0,$E0,$E0,$E0,$E0,$C0,$C0,$C0
	DEFB	$C0,$C0,$80,$80,$80,$80,$00,$09
	DEFB	$80,$C0,$E0,$E0,$F0,$E0,$C0,$00
	DEFB	$02,$01,$01,$01,$01,$01,$01,$00
	DEFB	$01,$C0,$E0,$F0,$FC,$FE,$FF,$33
	DEFB	$00,$3C,$80,$80,$C0,$C0,$C0,$E0
	DEFB	$E0,$E0,$F0,$F0,$F8,$F8,$F8,$F0
	DEFB	$F0,$E0,$C0,$C0,$C0,$C0,$C0,$80
	DEFB	$80,$80,$80,$00,$19,$01,$03,$03
	DEFB	$07,$07,$07,$07,$0F,$3F,$3F,$07
	DEFB	$07,$07,$07,$07,$07,$07,$7F,$FF
	DEFB	$0C,$7F,$BF,$DF,$EF,$F7,$F7,$FB
	DEFB	$FB,$FB,$FB,$FB,$FB,$FB,$FB,$FD
	DEFB	$FD,$FD,$FD,$FD,$FB,$FB,$F7,$F7
	DEFB	$EF,$EF,$DF,$DF,$BF,$BF,$BF,$BF
	DEFB	$BF,$BF,$BF,$7F,$7F,$7F,$7F,$78
	DEFB	$00,$03,$80,$C0,$F0,$F8,$F8,$FC
	DEFB	$FE,$FC,$F8,$C0,$00,$6B,$0F,$3F
	DEFB	$FF,$05,$FE,$F0,$FF,$38,$F8,$F0
	DEFB	$E0,$C0,$00,$7B,$C0,$F0,$F8,$FC
	DEFB	$FC,$FC,$FC,$04,$04,$FC,$FC,$FC
	DEFB	$FC,$FC,$F8,$F8,$FF,$30,$00,$02
	DEFB	$01,$01,$01,$01,$01,$03,$03,$03
	DEFB	$03,$03,$01,$00,$83,$80,$F0,$FE
	DEFB	$FF,$02,$F8,$07,$FF,$07,$7F,$1F
	DEFB	$07,$01,$00,$07,$E0,$FC,$FF,$22
	DEFB	$00,$86,$38,$FF,$0E,$1F,$03,$00
	DEFB	$07,$E0,$FF,$15,$FE,$FC,$F8,$F0
	DEFB	$E0,$F0,$F8,$F8,$F8,$F8,$F8,$00
	DEFB	$88,$80,$C0,$C0,$C0,$80,$80,$00
	DEFB	$03,$80,$F0,$FE,$FF,$04,$1F,$0F
	DEFB	$00,$06,$C0,$FE,$FF,$09,$FE,$FC
	DEFB	$FC,$FC,$F8,$F0,$E0,$C0,$80,$00
	DEFB	$9D,$38,$FC,$FC,$F8,$F0,$F0,$F0
	DEFB	$E0,$00,$9A,$02
L658F:	DEFB	$00		; end marker

; Tile screen 0 30x17 tiles, 510 bytes - background
; Code to show anti-piracy message just once at the very beginning
L6590: 	LD HL,$5800 	; Start of screen attribute area
 	LD DE,$5801 	; Start of screen attribute area + 1
 	LD BC,$0020 	; 32
 	LD (HL),$46 	; set the attribute
 	LDIR 		; copy to the rest of the row
 	LD BC,$02C0 	; 704 = 22 attribute rows
 	LD (HL),$0F 	; set the attribute
 	LDIR
 	LD BC,$001F
 	LD (HL),$06
 	LDIR
 	LD HL,$58E0
 	LD DE,$0000
 	LD C,$07
 	LD A,$06
L65B5: 	LD B,$20
L65B7: 	LD (HL),A
 	INC HL
 	DJNZ L65B7
 	ADD HL,DE
 	DEC C
 	JR NZ,L65B5
 	LD HL,L65E7 	; Start of anti-piracy message
 	LD DE,$4000 	; Screen address
 	LD C,$00
 	CALL LAED1 	; Print string
 	LD DE,$4800 	; Screen address
 	LD C,$00
 	CALL LAED1 	; Print string
 	LD DE,$5000 	; Screen address
 	LD C,$00
 	CALL LAED1 	; Print string

; Wait for any key and RET
L65DA: 	XOR A
 	LD ($5C08),A 	; clear LASTK
 	RST $38
 	LD A,($5C08) 	; check LASTK
 	CP $00 		; any key?
 	JR Z,L65DA 	; no => wait
 	RET

L65E7:	DEFM	"          ",$60
	DEFM	"100  REWARD           If your copy  of this game doesnot  have  a"
	DEFM	" blue  cassette bodywith DURELL  embossed on it, anddoes not have"
	DEFM	" DURELL on the leadin strip then it is a forgery.   Please send a"
	DEFM	"ny forgeries to          DURELL SOFTWARE Ltd.             Castle "
	DEFM	"Lodge                     Castle Green                     TAUNTO"
	DEFM	"N                         TA1 4AB                         Somerse"
	DEFM	"t                     "
; Tile screen 1 30x17 tiles, 510 bytes - update flags
L678E:	DEFM	"   ENGLAND                    with your name and address,and the "
	DEFM	"name and address  of theperson  who  supplied  you  withthe forge"
	DEFM	"ry.                          You will be sent a genuinereplacemen"
	DEFM	"t copy and a reward of",$60
	DEFM	"100  if your information  leads    to a successful prosecution.  "
	DEFM	"                                 PRESS ANY KEY TO CONTINUE    "
	DEFB	$00,$00,$01,$01,$01,$01,$01,$01
	DEFB	$00,$C0,$E0,$F0,$FC,$FE,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$80,$C0,$C0,$C0,$E0,$E0,$E0,$F0,$F0
	DEFB	$F8,$F8,$F8,$F0,$F0,$E0,$C0,$C0,$C0,$C0,$C0,$80,$80,$80,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
; Tile screen 2 30x17 tiles, 510 bytes - Ninja screen
L698C:	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$03,$03,$07,$07,$07,$07,$0F,$3F,$3F,$07,$07,$07,$07,$07,$07,$07,$7F,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$7F,$BF,$DF,$EF,$F7,$F7,$FB,$FB,$FB,$FB,$FB,$FB,$FB,$FB,$FD,$FD,$FD,$FD,$FD,$FB
	DEFB	$FB,$F7,$F7,$EF,$EF,$DF,$DF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$7F,$7F,$7F,$7F,$78,$00,$00,$00,$80,$C0,$F0,$F8,$F8,$FC,$FE,$FC
	DEFB	$F8,$C0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0F,$3F,$FF,$FF,$FF,$FF,$FF,$FE,$F0,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F8,$F0,$E0,$C0,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$C0,$F0,$F8,$FC,$FC,$FC,$FC,$04,$04,$FC,$FC,$FC,$FC,$FC,$F8,$F8,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$00,$00,$01,$01,$01,$01,$01,$03,$03,$03,$03,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
; Tile screen 3 30x17 tiles, 510 bytes - Dog screen
L6B8A:
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80
	DEFB	$F0,$FE,$FF,$FF,$F8,$07,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$7F,$1F,$07,$01,$00,$00,$00,$00,$00,$00,$00,$E0,$FC,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$38,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$1F
	DEFB	$03,$00,$00,$00,$00,$00,$00,$00,$E0,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FE,$FC,$F8,$F0,$E0,$F0,$F8,$F8,$F8,$F8,$F8,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$C0,$C0
	DEFB	$C0,$80,$80,$00,$00,$00,$80,$F0,$FE,$FF,$FF,$FF,$FF,$1F,$0F,$00,$00,$00,$00,$00,$00,$C0,$FE,$FF,$FF,$FF,$FF,$FF,$FF,$FF
; Tile screen 4 30x17 tiles, 510 bytes - Guard screen
L6D88:
	DEFB	$FF,$FF,$FE,$FC,$FC,$FC,$F8,$F0,$E0,$C0,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$38,$FC,$FC,$F8,$F0,$F0,$F0,$E0,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
; Tile screen 5 30x17 tiles, 510 bytes - front
L6F86:	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$14,$15,$16,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$17,$18,$19,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$1A,$1B,$1C,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$14,$15,$00,$01,$01,$01,$02,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$01,$01,$02,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$17,$18,$03,$04,$04,$04,$05,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$03,$04,$04,$05,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$1A,$1B,$06,$07,$07,$07,$08,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$06,$07,$07,$08,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

L7184:	DEFW	L84A8	; Current Room address
L7186:	DEFW	LA0B5	; Ninja sprite address

; Blocks for rooms
L7188:	DEFB	$FF,$2F,$30,$31,$32,$FF	; Front block 6x2 - pile of garbage
	DEFB	$33,$34,$35,$36,$37,$38
L7194:	DEFB	$0E,$0F,$10,$11		; Back block 4x3 - pier fencing
	DEFB	$12,$0D,$0D,$0D
	DEFB	$12,$0D,$0D,$0D
L71A0:	DEFB	$00,$01,$02		; Front block 3x3 - box
	DEFB	$03,$04,$05
	DEFB	$06,$07,$08
L71A9:	DEFB	$0D,$0D,$0D,$0E		; Front block 4x4 - computer part
	DEFB	$0F,$10,$10,$11
	DEFB	$0D,$13,$0D,$0D
	DEFB	$12,$12,$12,$12
L71B9:	DEFB	$07,$0A			; Back block 2x1 - ladder black on blue
L71BB:	DEFB	$1F,$20			; Front block 2x4 - console
	DEFB	$21,$22
	DEFB	$23,$24
	DEFB	$25,$26

; Current Guard data
L71C3:	DEFW	$0101	; Current Guard position in tilemap
L71C5:	DEFB	$11	; Current Guard X position
L71C6:	DEFB	$08	; Current Guard Y position

L71C7:	DEFB	$0E,$00,$0E,$00

; Current Dog data, 9 bytes
L71CB:	DEFW	$018E	; Dog position in tilemap
L71CD:	DEFB	$00	; Dog direction
L71CE:	DEFB	$08	; Dog X position
L71CF:	DEFB	$00	; Dog ??
L71D0:	DEFB	$07	; Dog's left limit
L71D1:	DEFB	$17	; Dog's right limit
L71D2:	DEFB	$00	; Dog ??
L71D3:	DEFB	$06	; Dog Y position

L71D4:	DEFB	$F3	; ??
L71D5:	DEFB	$01	; ??
L71D6:	DEFB	$7A,$00,$00,$02,$00,$01,$16,$00,$FD	; Room 79C6 dog data
L71DF:	DEFB	$9E,$00,$01,$08,$00,$01,$16,$01
L71E7:	DEFB	$FE,$B8,$67,$B0,$6F,$0A,$D9,$67
L71EF:	DEFB	$D1,$6F,$0D

; Sprite Dog 1
L71F2:	DEFB	$FF,$00,$FF,$01
	DEFB	$02,$03,$04,$05
	DEFB	$06,$07,$08,$09
; Sprite Dog 2
L71FE:	DEFB	$FF,$FF,$0A,$0B
	DEFB	$0C,$0D,$0E,$0F
	DEFB	$10,$11,$12,$13
; Sprite Dog 3
L720A:	DEFB	$FF,$14,$15,$16
	DEFB	$17,$18,$19,$1A
	DEFB	$1B,$1C,$1D,$1E
; Sprite Dog 4
L7216:	DEFB	$FF,$1F,$20,$FF
	DEFB	$21,$22,$23,$24
	DEFB	$25,$26,$27,$FF

L7222:	DEFB	$00		; Input method: 1 = Joystick, 0 = Keyboard or Protek
L7223:	DEFB	$EF,$01,$04	; Ports and bits for the current input method
	DEFB	$EF,$08,$03
	DEFB	$EF,$10,$02
	DEFB	$F7,$10,$01
	DEFB	$EF,$04,$00
L7232:	DEFB	$00		; Input bits: 000FUDLR
L7233:	DEFW	$5A41		; Screen attributes address stored during tile map drawing
L7235:	DEFW	$7184		; Tile screen 5 address stored during tile map drawing
L7237:	DEFW	$6F86		; Tile screen 4 address stored during tile map drawing
L7239:	DEFB	$00		; Byte mirror flag

; Mirror table
L723A:	DEFB	$01,$81,$41,$C1,$21,$A1,$61,$E1,$11,$91,$51,$D1,$31,$B1,$71,$F1	; Mirror table 1st part
	DEFB	$09,$89,$49,$C9,$29,$A9,$69,$E9,$19,$99,$59,$D9,$39,$B9,$79,$F9
	DEFB	$05,$85,$45,$C5,$25,$A5,$65,$E5,$15,$95,$55,$D5,$35,$B5,$75,$F5
	DEFB	$0D,$8D,$4D,$CD,$2D,$AD,$6D,$ED,$1D,$9D,$5D,$DD,$3D,$BD,$7D,$FD
	DEFB	$03,$83,$43,$C3,$23,$A3,$63,$E3,$13,$93,$53,$D3,$33,$B3,$73,$F3
	DEFB	$0B,$8B,$4B,$CB,$2B,$AB,$6B,$EB,$1B,$9B,$5B,$DB,$3B,$BB,$7B,$FB
	DEFB	$07,$87,$47,$C7,$27,$A7,$67,$E7,$17,$97,$57,$D7,$37,$B7,$77,$F7
	DEFB	$0F,$8F,$4F,$CF,$2F,$AF,$6F,$EF,$1F,$9F,$5F,$DF,$3F,$BF,$7F,$FF
L72BA:	DEFB	$00,$80,$40,$C0,$20,$A0,$60,$E0,$10,$90,$50,$D0,$30,$B0,$70,$F0	; Mirror table 2nd part
	DEFB	$08,$88,$48,$C8,$28,$A8,$68,$E8,$18,$98,$58,$D8,$38,$B8,$78,$F8
	DEFB	$04,$84,$44,$C4,$24,$A4,$64,$E4,$14,$94,$54,$D4,$34,$B4,$74,$F4
	DEFB	$0C,$8C,$4C,$CC,$2C,$AC,$6C,$EC,$1C,$9C,$5C,$DC,$3C,$BC,$7C,$FC
	DEFB	$02,$82,$42,$C2,$22,$A2,$62,$E2,$12,$92,$52,$D2,$32,$B2,$72,$F2
	DEFB	$0A,$8A,$4A,$CA,$2A,$AA,$6A,$EA,$1A,$9A,$5A,$DA,$3A,$BA,$7A,$FA
	DEFB	$06,$86,$46,$C6,$26,$A6,$66,$E6,$16,$96,$56,$D6,$36,$B6,$76,$F6
	DEFB	$0E,$8E,$4E,$CE,$2E,$AE,$6E,$EE,$1E,$9E,$5E,$DE,$3E,$BE,$7E,$FE

L733A:	DEFB	$00	; Ninja walking phase

; Table of four addresses of Ninja/Guard walking sprites
L733B:	DEFW	LD3DE	; Sprite Ninja/Guard walking 1
	DEFW	LD408	; Sprite Ninja/Guard walking 2
	DEFW	LD432	; Sprite Ninja/Guard walking 3
	DEFW	LD45C	; Sprite Ninja/Guard walking 4

L7343:	DEFB	$07	; Counter used in movement handlers
L7344:	DEFB	$00	; Dog's flag: 1 = ignore left/right limit
L7345:	DEFB	$14	; Dog ??
L7346:	DEFB	$0A	; Guard walking phase $00..$03 or other state: $09 = Guard dead; ...
L7347:	DEFB	$01	; Guard direction
L7348:	DEFB	$05,$08

; Proceed to the next room token (redirect to B702)
L734A:	JP LB702

; Room token #0E: Put one tile at the given address; params: 3 bytes (tile, address)
L734D:	POP HL		; Restore token sequence address
	INC HL		; Skip token byte
	LD C,(HL)	; get tile byte
	INC HL
	LD A,(HL)	; get address low byte
	INC HL
	PUSH HL
	LD H,(HL)	; get address high byte
	LD L,A
	LD (HL),C	; put tile into tilemap
	JR L734A	; => B702 Proceed to the next room token

; Room token #0D: Set border color; params: 1 byte
L7359:	POP HL		; Restore token sequence address
	INC HL		; Skip token byte
	LD A,(HL)	; get byte
	PUSH HL
	OUT ($FE),A
	JR L734A	; => B702 Proceed to the next room token

; Room token #?? - Draw frame with one tile; params: 1 byte (UNUSED)
L7361:	POP HL		; Restore token sequence address
	INC HL		; Skip token byte
	LD A,(HL)	; get tile byte
	PUSH HL
	LD HL,L6590	; Tile screen 0 start address
	LD B,$1E	; 30
L736A:	LD (HL),A
	INC HL
	DJNZ L736A
	LD B,$0F
	LD DE,$001D
L7373:	LD (HL),A
	ADD HL,DE
	LD (HL),A
	INC HL
	DJNZ L7373
	LD B,$1E
L737B:	LD (HL),A
	INC HL
	DJNZ L737B
	JR L734A	; => B702 Proceed to the next room token

; Room token #01: Fill downward; params: 4 bytes (count, filler, address)
L7381:	LD DE,$001E	; 30
;
L7384:	POP HL		; Restore token sequence address
	INC HL		; Skip token byte
	LD B,(HL)	; get count byte
	INC HL
	LD C,(HL)	; get tile byte
	INC HL
	LD A,(HL)	; get address low byte
	INC HL
	PUSH HL
	LD H,(HL)	; get address high byte
	LD L,A
L738F:	LD (HL),C
	ADD HL,DE
	DJNZ L738F
	JR L734A	; => B702 Proceed to the next room token

; Room token #0A: Fill down-right; params: 4 bytes (count, filler, address)
L7395:	LD DE,$001F	; 30 + 1 (move down/right)
	JR L7384
; Room token #0B: Fill down-left; params: 4 bytes (count, filler, address)
L739A:  LD DE,$001D	; 30 - 1 (move down/left)
	JR L7384
; Room token #02: Fill to right; params: 4 bytes (count, filler, address)
L739F:	LD DE,$0001	; Move right
	JR L7384

; Room token #06: Fill triangle from wide top
L73A4:	LD A,$23	; A = "INC HL" command
;
L73A6:	LD (L73BB),A	; set the command
	POP HL		; Restore token sequence address
	INC HL		; Skip token byte
	LD D,(HL)	; get filler tile
	INC HL
	LD B,(HL)	; get count
	INC HL
	LD A,(HL)	; get address low byte
	INC HL
	PUSH HL
	LD H,(HL)	; get address high byte
	LD L,A
	LD A,D
	LD DE,$001E	; 30
L73B8:	PUSH HL
	LD C,B
L73BA:	LD (HL),A
L73BB:	INC HL		; !!MUT-CMD!! "INC HL" or "DEC HL" - move to next column
	DEC C
	JR NZ,L73BA
	POP HL
	ADD HL,DE	; next row
	DJNZ L73B8
	JR L734A	; => B702 Proceed to the next room token

; Room token #07: Fill triangle from wide bottom; params: 4 bytes (filler, count, address)
L73C5:	LD A,$23	; A = "INC HL" command
;
L73C7:	LD (L73DE),A	; set the command
	POP HL		; Restore token sequence address
	INC HL		; Skip token byte
	LD D,(HL)	; get filler tile
	INC HL
	LD B,(HL)	; get count
	INC HL
	LD A,(HL)	; get address low byte
	INC HL
	PUSH HL
	LD H,(HL)	; get address high byte
	LD L,A
	LD A,D
	LD DE,$001E	; 30
	LD C,$01
L73DB:	PUSH HL
	PUSH BC
L73DD:	LD (HL),A
L73DE:	INC HL		; !!MUT-CMD!! "INC HL" or "DEC HL" - move right/left
	DEC C
	JR NZ,L73DD
	POP BC
	INC C
	POP HL
	ADD HL,DE	; next row
	DJNZ L73DB
	JP L734A	; => B702 Proceed to the next room token

; Room token #08: Fill triangle from wide bottom; params: 4 bytes (filler, count, address)
L73EB:	LD A,$2B	; A = "DEC HL" command
	JR L73C7

; Room token #09: Fill triangle from wide top; params: 4 bytes (filler, count, address)
L73EF:	LD A,$2B	; A = "DEC HL" command
	JR L73A6

; Room token #04: Fill whole Tile screen 0 with one tile; params: 1 byte (filler)
L73F3:	POP HL		; Restore token sequence address
	INC HL		; Skip token byte
	LD A,(HL)	; get tile byte
	PUSH HL
	LD HL,L6590	; Tile screen 0 start address
	LD DE,L6590+1	; Tile screen 0 start address + 1
	LD (HL),A
	LD BC,$01FD	; 510 - 1
	LDIR
	JP L734A	; => B702 Proceed to the next room token

; Room token #05: Copy block of tiles; params: 6 bytes (width, height, srcaddr, address)
L7406:	POP HL		; Restore token sequence address
	INC HL		; Skip token byte
	LD B,(HL)	; get width byte
	INC HL
	LD C,(HL)	; get height byte
	INC HL
	LD E,(HL)	; get source address low byte
	INC HL
	LD D,(HL)	; get source address high byte
	INC HL
	LD A,(HL)	; get address low byte
	INC HL
	PUSH HL
	LD H,(HL)	; get address high byte
	LD L,A
L7415:	PUSH BC
	PUSH HL
L7417:	LD A,(DE)
	LD (HL),A
	INC HL
	INC DE
	DJNZ L7417	; continue loop by columns
	POP HL
	PUSH DE
	LD DE,$001E	; 30
	ADD HL,DE
	POP DE
	POP BC
	DEC C
	JR NZ,L7415	; continue loop by rows
	JP L734A	; => B702 Proceed to the next room token

; Room token #0C: Copy block of tiles N times; params: 6 bytes (srcaddr, width, count, address)
L742B:	POP HL		; Restore token sequence address
	INC HL		; Skip token byte
	LD E,(HL)	; get source address low byte
	INC HL
	LD D,(HL)	; get source address high byte
	INC HL
	LD C,(HL)	; get width byte
	INC HL
	LD B,(HL)	; get height byte
	INC HL
	LD A,(HL)	; get address low byte
	INC HL
	PUSH HL
	LD H,(HL)	; get address high byte
	LD L,A
L743A:	PUSH HL
	PUSH BC
	PUSH DE
L743D:	LD A,(DE)
	LD (HL),A
	INC HL
	INC DE
	DEC C
	JR NZ,L743D	; continue loop by columns
	POP DE
	POP BC
	POP HL
	PUSH DE
	LD DE,$001E	; 30
	ADD HL,DE
	POP DE
	DJNZ L743A	; continue loop by rows
	JP L734A	; => B702 Proceed to the next room token

; Room token #03: Fill rectangle; params: 5 bytes (filler, width, height, address)
L7452:	POP HL		; Restore token sequence address
	INC HL		; Skip token byte
	LD D,(HL)
	INC HL
	LD C,(HL)
	INC HL
	LD B,(HL)
	INC HL
	LD A,(HL)
	INC HL
	PUSH HL
	LD H,(HL)
	LD L,A
	LD A,D
	LD DE,$001E	; 30
L7463:	PUSH HL
	PUSH BC
L7465:	LD (HL),A
	INC HL
	DEC C
	JR NZ,L7465
	POP BC
	POP HL
	ADD HL,DE
	DJNZ L7463
	JP L734A	; => B702 Proceed to the next room token

L7472:	DI
	LD (L74F0+1),SP
	LD SP,L753B
	LD DE,$0005
	LD A,$FF
	LD C,$10
L7481:	POP HL
	ADD HL,DE
	LD B,$0F
L7485:	LD (HL),A
	INC HL
	DJNZ L7485
	DEC C
	JR NZ,L7481
	LD SP,(L74F0+1)
	LD A,$13
L7492:	LD (L749C),A	; set Energy = MAX
	LD A,$01
L7497:	LD (L749D),A
	EI
	RET

L749C:	DEFB	$13	; Energy $04..$13
L749D:	DEFB	$01	; Energy lower, running bit

L749E:	DI
	LD (L74F0+1),SP
	LD SP,L753B
	LD A,(L749C)	; get Energy
	LD E,A
	LD D,$00
	LD B,$10
	LD A,(L749D)
	LD C,A
L74B2:	POP HL
	ADD HL,DE
	LD A,C
	XOR (HL)
	LD (HL),A
	DJNZ L74B2
	LD A,(L749D)
	RLC A
	LD ($749D),A
	JR NC,L74C7
	LD HL,L749C	; Energy address
	DEC (HL)	; Decrease Energy
L74C7:	LD SP,(L74F0+1)
	EI
	RET

; Draw NEAR/HELD item
L74CD:	LD A,$00	; !!MUT-ARG!! item number
	LD H,$00
	LD L,A
	ADD HL,HL
L74D3:	LD DE,LB5B0	; !!MUT-ARG!! address for Table of items
	ADD HL,DE
	LD E,(HL)
	INC HL
	LD D,(HL)
	DI
	LD (L74F0+1),SP
	LD SP,L751B
	LD C,$18
L74E4:	POP HL
	LD B,$04
L74E7:	LD A,(DE)
	LD (HL),A
	INC DE
	INC HL
	DJNZ L74E7
	DEC C
	JR NZ,L74E4
L74F0:	LD SP,$6255
L74F3:	LD HL,$5A61
	LD C,$03
L74F8:	LD B,$04
L74FA:	LD A,(DE)
	LD (HL),A
	INC HL
	INC DE
	DJNZ L74FA
	PUSH DE
	LD DE,$001C	; 28
	ADD HL,DE
	POP DE
	DEC C
	JR NZ,L74F8
	EI
	RET

L750B:	DEFB	$00,$00,$6C,$00,$D8,$00,$44,$01
L7513:	DEFB	$B0,$01,$1C,$02,$88,$02,$F4,$02

L751B:	DEFW	$5061,$5161,$5261,$5361
L7523:	DEFW	$5461,$5561,$5661,$5761
L752B:	DEFW	$5081,$5181,$5281,$5381
L7533:	DEFW	$5481,$5581,$5681,$5781
L753B:	DEFW	$50A1,$51A1,$52A1,$53A1
L7543:	DEFW	$54A1,$55A1,$56A1,$57A1
L754B:	DEFW	$50C1,$51C1,$52C1,$53C1
L7553:	DEFW	$54C1,$55C1,$56C1,$57C1

L755B:	DEFB	$00		; Ninja falling count, to decrease Energy on hit

L755C:	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00,$00,$00,$00,$00
	DEFB	$00,$00,$00,$00

; Room procedure (for 19 rooms with a guard)
L7918: JP LB44C     ; Jump to common guard room logic

; Rooms 7C9C / 92EF initialization
L791B: JP LB425     ; Jump to room-specific initialization routine

; Room 791E (room with pier)
L791E:	DEFW	LB446	; Room procedure (AI/logic handler)
L7920:	DEFW	LC64C	; Initialization routine (for actors, consoles, etc.)
	DEFW	$0000	; Unused
	DEFW	L79C6	; Room to the right
	DEFW	$0000	; Room to the left
	DEFW	$0000	; Room below
	DEFB	$04,$0D	; Fill entire screen with $0D
	DEFB	$03,$FF,$07,$0A,$79,$66	; Rectangle 7x10 tiles with $FF at $6679
	DEFB	$02,$17,$F5,$70,$67	; Fill horz 23 tiles with $F5 at $6770
	DEFB	$02,$17,$0B,$EE,$70	; Fill horz 23 tiles with $0B at $70EE
	DEFB	$03,$0C,$17,$03,$0C,$71	; Rectangle 23x3 tiles with $0C at $710C
	DEFB	$02,$13,$F6,$6A,$66	; Fill horz 19 tiles with $F6 at $666A
	DEFB	$01,$08,$0C,$89,$66	; Fill vert 8 tiles with $0C at $6689
	DEFB	$01,$08,$0C,$8E,$66	; Fill vert 8 tiles with $0C at $668E
	DEFB	$01,$08,$0C,$93,$66	; Fill vert 8 tiles with $0C at $6693
	DEFB	$01,$0C,$F2,$EB,$65	; Fill vert 12 tiles with $F2 at $65EB
	DEFB	$05,$04,$03,$94,$71,$11,$66	; Block 4x3 tiles from 7194 to $6611
	DEFB	$05,$04,$03,$94,$71,$15,$66	; Block 4x3 tiles from 7194 to $6615
	DEFB	$05,$04,$03,$94,$71,$19,$66	; Block 4x3 tiles from 7194 to $6619
	DEFB	$05,$04,$03,$94,$71,$1D,$66	; Block 4x3 tiles from 7194 to $661D
	DEFB	$05,$04,$03,$94,$71,$21,$66	; Block 4x3 tiles from 7194 to $6621
	DEFB	$01,$03,$12,$25,$66	; Fill vert 3 tiles with $12 at $6625
	DEFB	$FF	; End of sequence

; Blocks for rooms
L7984:	DEFB	$F1,$F0		; Back block 2x5 - ladder black on blue
	DEFB	$07,$0A
	DEFB	$07,$0A
	DEFB	$07,$0A
	DEFB	$07,$0A
L798E:	DEFB	$FF,$FF,$39,$58	; Front block 4x7 - ladder fencing
	DEFB	$FF,$39,$3A,$58
	DEFB	$39,$3A,$3A,$58
	DEFB	$3A,$3A,$3A,$58
	DEFB	$3A,$3A,$3B,$FF
	DEFB	$3A,$3B,$FF,$FF
	DEFB	$3B,$FF,$FF,$FF
L79AA:	DEFB	$59,$3C,$FF,$FF	; Front block 4x7 - ladder fencing
	DEFB	$59,$3D,$3C,$FF
	DEFB	$59,$3D,$3D,$3C
	DEFB	$59,$3D,$3D,$3D
	DEFB	$FF,$3E,$3D,$3D
	DEFB	$FF,$FF,$3E,$3D
	DEFB	$FF,$FF,$FF,$3E

; Room 79C6 (next to room with pier)
L79C6:	DEFW	LB452	; Room procedure
	DEFW	LB42E	; Initialization
	DEFW	L791E	; Room to Left
	DEFW	L7A17	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$04,$0D			; Fill entire screen with $0D
	DEFB	$03,$FF,$1E,$0A,$62,$66	; Rectangle 30x10 tiles with $FF at $6662
	DEFB	$03,$02,$15,$06,$C5,$66	; Rectangle 21x6 tiles with $02 at $66C5
	DEFB	$02,$15,$03,$A7,$66	; Fill horz 21 tiles with $03 at $66A7
	DEFB	$0C,$B9,$71,$02,$09,$6C,$66	; Block 2 tiles from 71B9 to $666C copy 9 times
	DEFB	$03,$00,$08,$06,$C4,$65	; Rectangle 8x6 tiles with $00 at $65C4
	DEFB	$02,$0A,$FF,$A4,$65	; Fill horz 10 tiles with $FF at $65A4
	DEFB	$05,$02,$04,$BB,$71,$F8,$6F	; Block 2x4 tiles from 71BB to $6FF8
	DEFB	$0E,$2A,$B9,$6F		; Put tile $2A at $6FB9
	DEFB	$01,$05,$2B,$D7,$6F	; Fill vert 5 tiles with $2B at $6FD7
	DEFB	$05,$06,$02,$88,$71,$3D,$71	; Block 6x2 tiles from 7188 to $713D
	DEFB	$0E,$F1,$6C,$66		; Put tile $F1 at $666C
	DEFB	$0E,$F0,$6D,$66		; Put tile $F0 at $666D
	DEFB	$FF	; End of sequence

; Room 7A17
L7A17:	DEFW	LB483	; Room procedure
	DEFW	LA142	; Initialization
	DEFW	L79C6	; Room to Left
	DEFW	L7B90	; Room to Right
	DEFW	L8238	; Room Up
	DEFW	$0000
	DEFB	$04,$02			; Fill entire screen with $02
	DEFB	$08,$FF,$06,$CD,$66	; Triangle with $FF, count=6 at $66CD
	DEFB	$02,$12,$FF,$70,$67	; Fill horz 18 tiles with $FF at $6770
	DEFB	$03,$FF,$0C,$08,$B0,$66	; Rectangle 12x8 tiles with $FF at $66B0
	DEFB	$03,$00,$04,$06,$AE,$65	; Rectangle 4x6 tiles with $00 at $65AE
	DEFB	$02,$0B,$FF,$80,$66	; Fill horz 11 tiles with $FF at $6680
	DEFB	$02,$05,$FF,$62,$66	; Fill horz 5 tiles with $FF at $6662
	DEFB	$01,$05,$2B,$C6,$6F	; Fill vert 5 tiles with $2B at $6FC6
	DEFB	$0E,$2A,$A8,$6F		; Put tile $2A at $6FA8
	DEFB	$02,$05,$FF,$90,$65	; Fill horz 5 tiles with $FF at $6590
	DEFB	$02,$0C,$FF,$9A,$65	; Fill horz 12 tiles with $FF at $659A
	DEFB	$0C,$B9,$71,$02,$08,$98,$65	; Block 2 tiles from 71B9 to $6598 copy 8 times
	DEFB	$05,$04,$07,$8E,$79,$9F,$70	; Block 4x7 tiles from 798E to $709F
	DEFB	$05,$04,$07,$8E,$79,$48,$70	; Block 4x7 tiles from 798E to $7048
	DEFB	$05,$04,$07,$8E,$79,$2B,$70	; Block 4x7 tiles from 798E to $702B
	DEFB	$FF	; End of sequence

; Room 7A75
L7A75:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	$0000
	DEFW	L7BD2	; Room Up
	DEFW	L7A9E	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$02,$12,$03,$0F,$66	; Fill horz 18 tiles with $03 at $660F
	DEFB	$03,$02,$12,$05,$2D,$66	; Rectangle 18x5 tiles with $02 at $662D
	DEFB	$0C,$B9,$71,$02,$11,$98,$65	; Block 2 tiles from 71B9 to $6598 copy 17 times
	DEFB	$0E,$F1,$C4,$66		; Put tile $F1 at $66C4
	DEFB	$0E,$F0,$C5,$66		; Put tile $F0 at $66C5
	DEFB	$FF	; End of sequence

; Room 7A9E
L7A9E:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	L7ACD	; Room to Right
	DEFW	L7A75	; Room Up
	DEFW	$0000
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$02,$1C,$03,$82,$66	; Fill horz 28 tiles with $03 at $6682
	DEFB	$03,$02,$1C,$06,$A0,$66	; Rectangle 28x6 tiles with $02 at $66A0
	DEFB	$0C,$B9,$71,$02,$0F,$98,$65	; Block 2 tiles from 71B9 to $6598 copy 15 times
	DEFB	$05,$06,$02,$88,$71,$15,$71	; Block 6x2 tiles from 7188 to $7115
	DEFB	$05,$06,$02,$88,$71,$20,$71	; Block 6x2 tiles from 7188 to $7120
	DEFB	$FF	; End of sequence

; Room 7ACD
L7ACD:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L7A9E	; Room to Left
	DEFW	L7AF8	; Room to Right
	DEFW	L7B56	; Room Up
	DEFW	$0000
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$02,$1E,$06,$80,$66	; Rectangle 30x6 tiles with $02 at $6680
	DEFB	$02,$1A,$03,$66,$66	; Fill horz 26 tiles with $03 at $6666
	DEFB	$02,$04,$03,$80,$66	; Fill horz 4 tiles with $03 at $6680
	DEFB	$02,$0A,$02,$34,$67	; Fill horz 10 tiles with $02 at $6734
	DEFB	$0C,$B9,$71,$02,$0E,$A2,$65	; Block 2 tiles from 71B9 to $65A2 copy 14 times
	DEFB	$FF	; End of sequence

; Room 7AF8
L7AF8:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L7ACD	; Room to Left
	DEFW	$0001
	DEFW	L7C6D	; Room Up
	DEFW	$0000
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$02,$1C,$08,$80,$66	; Rectangle 28x8 tiles with $02 at $6680
	DEFB	$02,$0D,$03,$86,$66	; Fill horz 13 tiles with $03 at $6686
	DEFB	$0C,$B9,$71,$02,$0F,$98,$65	; Block 2 tiles from 71B9 to $6598 copy 15 times
	DEFB	$02,$06,$03,$62,$66	; Fill horz 6 tiles with $03 at $6662
	DEFB	$02,$09,$FF,$93,$66	; Fill horz 9 tiles with $FF at $6693
	DEFB	$02,$09,$03,$B1,$66	; Fill horz 9 tiles with $03 at $66B1
	DEFB	$05,$06,$02,$88,$71,$3C,$71	; Block 6x2 tiles from 7188 to $713C
	DEFB	$02,$02,$FF,$34,$67	; Fill horz 2 tiles with $FF at $6734
	DEFB	$02,$0E,$FF,$52,$67	; Fill horz 14 tiles with $FF at $6752
	DEFB	$0E,$FE,$83,$67		; Put tile $FE at $6783
	DEFB	$0E,$FE,$8A,$67		; Put tile $FE at $678A
	DEFB	$05,$01,$02,$4F,$7B,$56,$67	; Block 1x2 tiles from 7B4F to $6756
	DEFB	$05,$01,$02,$4F,$7B,$5E,$67	; Block 1x2 tiles from 7B4F to $675E
	DEFB	$FF	; End of sequence

; Blocks for rooms
L7B4F:	DEFB	$FE	; Back block 1x2 - vertical pipe
	DEFB	$FD
L7B51:	DEFB	$FD	; Back block 1x1 - vertical pipe
L7B52:	DEFB	$FD	; Back block 1x4 - vertical pipe
	DEFB	$FD
	DEFB	$FD
	DEFB	$FC

; Room 7B56
L7B56:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	$0000
	DEFW	L7D5A	; Room Up
	DEFW	L7ACD	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$02,$08,$06,$28,$66	; Rectangle 8x6 tiles with $02 at $6628
	DEFB	$03,$02,$0A,$05,$33,$66	; Rectangle 10x5 tiles with $02 at $6633
	DEFB	$02,$08,$03,$0A,$66	; Fill horz 8 tiles with $03 at $660A
	DEFB	$02,$0A,$03,$15,$66	; Fill horz 10 tiles with $03 at $6615
	DEFB	$0C,$B9,$71,$02,$0B,$94,$65	; Block 2 tiles from 71B9 to $6594 copy 11 times
	DEFB	$0C,$B9,$71,$02,$11,$A2,$65	; Block 2 tiles from 71B9 to $65A2 copy 17 times
	DEFB	$0C,$84,$79,$02,$01,$CE,$66	; Block 2 tiles from 7984 to $66CE copy 1 times
	DEFB	$FF	; End of sequence

; Room 7B90
L7B90:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L7A17	; Room to Left
	DEFW	L7BD2	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$04,$01			; Fill entire screen with $01
	DEFB	$03,$02,$05,$09,$90,$65	; Rectangle 5x9 tiles with $02 at $6590
	DEFB	$02,$06,$FF,$92,$65	; Fill horz 6 tiles with $FF at $6592
	DEFB	$0E,$2A,$A9,$6F		; Put tile $2A at $6FA9
	DEFB	$01,$07,$2B,$C7,$6F	; Fill vert 7 tiles with $2B at $6FC7
	DEFB	$03,$FF,$0F,$08,$9E,$66	; Rectangle 15x8 tiles with $FF at $669E
	DEFB	$03,$FF,$0F,$03,$43,$67	; Rectangle 15x3 tiles with $FF at $6743
	DEFB	$07,$FF,$04,$CB,$66	; Triangle with $FF, count=4 at $66CB
	DEFB	$05,$04,$07,$AA,$79,$68,$70	; Block 4x7 tiles from 79AA to $7068
	DEFB	$05,$04,$07,$AA,$79,$2A,$70	; Block 4x7 tiles from 79AA to $702A
	DEFB	$FF	; End of sequence

; Room 7BD2
L7BD2:	DEFW	LB41F	; Room procedure
L7BD4:	DEFW	LB422	; Initialization
	DEFW	L7B90	; Room to Left
	DEFW	L7D5A	; Room to Right
	DEFW	L8162	; Room Up
	DEFW	L7A75	; Room Down
	DEFB	$04,$01			; Fill entire screen with $01
	DEFB	$03,$FF,$14,$03,$34,$67	; Rectangle 20x3 tiles with $FF at $6734
	DEFB	$02,$0A,$FF,$84,$67	; Fill horz 10 tiles with $FF at $6784
	DEFB	$0E,$FF,$66,$67		; Put tile $FF at $6766
	DEFB	$05,$03,$04,$0C,$7C,$B5,$70	; Block 3x4 tiles from 7C0C to $70B5
	DEFB	$05,$03,$03,$18,$7C,$24,$71	; Block 3x3 tiles from 7C18 to $7124
	DEFB	$0C,$2A,$7C,$02,$0E,$9E,$65	; Block 2 tiles from 7C2A to $659E copy 14 times
	DEFB	$05,$02,$03,$84,$79,$3C,$67	; Block 2x3 tiles from 7984 to $673C
	DEFB	$FF	; End of sequence

; Blocks for rooms
L7C0C:	DEFB	$3F,$40,$41	; Front block 3x4
	DEFB	$42,$43,$44
	DEFB	$45,$46,$47
	DEFB	$48,$49,$4A
L7C18:	DEFB	$4B,$4C,$4D	; Front block 3x3
	DEFB	$45,$46,$47
	DEFB	$48,$49,$4A
L7C21:	DEFB	$14,$15,$16	; Front block 3x3 - barrel - to drow using token #00
	DEFB	$17,$18,$19
	DEFB	$1A,$1B,$1C
L7C2A:	DEFB	$06,$09	; Back block 2x1 - ladder black on green
L7C2C:	DEFB	$ED,$EC	; Back block 2x1 - ladder black on green

; Room 7C2E
L7C2E:	DEFW	LB458	; Room procedure
	DEFW	LA1A6	; Initialization
	DEFW	L7D5A	; Room to Left
	DEFW	$0000
	DEFW	L7DA9	; Room Up
	DEFW	L7C6D	; Room Down
	DEFB	$04,$01			; Fill entire screen with $01
	DEFB	$03,$FF,$1E,$04,$16,$67	; Rectangle 30x4 tiles with $FF at $6716
	DEFB	$03,$FF,$05,$06,$90,$65	; Rectangle 5x6 tiles with $FF at $6590
	DEFB	$03,$FF,$03,$0D,$AB,$65	; Rectangle 3x13 tiles with $FF at $65AB
	DEFB	$0E,$2A,$3B,$70		; Put tile $2A at $703B
	DEFB	$01,$06,$2B,$59,$70	; Fill vert 6 tiles with $2B at $7059
	DEFB	$0C,$2A,$7C,$02,$0D,$95,$65	; Block 2 tiles from 7C2A to $6595 copy 13 times
	DEFB	$05,$02,$04,$84,$79,$1E,$67	; Block 2x4 tiles from 7984 to $671E
	DEFB	$05,$02,$04,$84,$79,$2A,$67	; Block 2x4 tiles from 7984 to $672A
	DEFB	$FF	; End of sequence

; Room 7C6D
L7C6D:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	L7FC4	; Room to Right
	DEFW	L7C2E	; Room Up
	DEFW	L7AF8	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$0C,$B9,$71,$02,$11,$98,$65	; Block 2 tiles from 71B9 to $6598 copy 17 times
	DEFB	$03,$02,$0E,$06,$90,$66	; Rectangle 14x6 tiles with $02 at $6690
	DEFB	$02,$09,$03,$72,$66	; Fill horz 9 tiles with $03 at $6672
	DEFB	$02,$05,$03,$99,$66	; Fill horz 5 tiles with $03 at $6699
	DEFB	$0C,$B9,$71,$02,$0E,$A4,$65	; Block 2 tiles from 71B9 to $65A4 copy 14 times
	DEFB	$FF	; End of sequence

; Blocks for rooms
L7C9A:	DEFB	$06,$09	; Back block 2x1 - ladder black on green

; Room 7C9C
L7C9C:	DEFW	LC6A5	; Room procedure
	DEFW	L791B	; Initialization
L7CA0:	DEFW	L947C	; Room to Left
L7CA2:	DEFW	L93DF	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$02,$1E,$03,$62,$66	; Fill horz 30 tiles with $03 at $6662
	DEFB	$03,$02,$1E,$07,$80,$66	; Rectangle 30x7 tiles with $02 at $6680
	DEFB	$03,$22,$04,$02,$AB,$66	; Rectangle 4x2 tiles with $22 at $66AB
	DEFB	$03,$21,$1E,$02,$16,$67	; Rectangle 30x2 tiles with $21 at $6716
	DEFB	$05,$06,$07,$0D,$7D,$82,$70	; Block 6x7 tiles from 7D0D to $7082
	DEFB	$05,$05,$01,$08,$7D,$53,$67	; Block 5x1 tiles from 7D08 to $6753
	DEFB	$05,$05,$01,$08,$7D,$62,$67	; Block 5x1 tiles from 7D08 to $6762
	DEFB	$05,$05,$07,$E5,$7C,$87,$66	; Block 5x7 tiles from 7CE5 to $6687
	DEFB	$05,$05,$07,$37,$7D,$92,$66	; Block 5x7 tiles from 7D37 to $6692
	DEFB	$FF	; End of sequence

; Blocks for rooms
L7CE5:	DEFB	$02,$E9,$E8,$E7,$E7	; Back block 5x7 - Train part
	DEFB	$17,$0D,$15,$15,$0D
	DEFB	$18,$0D,$15,$15,$0D
	DEFB	$19,$0D,$0D,$0D,$0D
	DEFB	$22,$22,$22,$22,$22
	DEFB	$22,$22,$22,$22,$22
	DEFB	$1F,$0D,$0D,$0D,$0D
	DEFB	$FB,$FB,$FF,$FF,$FB
L7D0D:	DEFB	$56,$4E,$4E,$4E,$4E,$57	; Front block 6x7 - Train central part
	DEFB	$52,$4F,$4F,$4F,$4F,$54
	DEFB	$52,$4F,$4F,$4F,$4F,$54
	DEFB	$52,$6C,$6D,$6E,$50,$54
	DEFB	$53,$6F,$70,$71,$51,$55
	DEFB	$53,$72,$73,$74,$51,$55
	DEFB	$52,$50,$50,$50,$50,$54
L7D37:	DEFB	$E7,$E7,$E6,$E5,$02	; Back block 5x7 - Train part
	DEFB	$0D,$15,$15,$0D,$1C
	DEFB	$0D,$15,$15,$0D,$1D
	DEFB	$0D,$0D,$0D,$0D,$1E
	DEFB	$22,$22,$22,$22,$22
	DEFB	$22,$22,$22,$22,$22
	DEFB	$0D,$0D,$0D,$0D,$20

; Room 7D5A
L7D5A:	DEFW	LB483	; Room procedure
	DEFW	LA14A	; Initialization
	DEFW	L7BD2	; Room to Left
	DEFW	L7C2E	; Room to Right
	DEFW	$0000
	DEFW	L7B56	; Room Down
	DEFB	$04,$01			; Fill entire screen with $01
	DEFB	$03,$FF,$1E,$06,$90,$65	; Rectangle 30x6 tiles with $FF at $6590
	DEFB	$0C,$2A,$7C,$02,$10,$9B,$65	; Block 2 tiles from 7C2A to $659B copy 16 times
	DEFB	$02,$02,$EA,$31,$66	; Fill horz 2 tiles with $EA at $6631
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$03,$FF,$06,$03,$2E,$67	; Rectangle 6x3 tiles with $FF at $672E
	DEFB	$08,$FF,$02,$4B,$67	; Triangle with $FF, count=2 at $674B
	DEFB	$0C,$84,$79,$02,$01,$74,$67	; Block 2 tiles from 7984 to $6774 copy 1 times
	DEFB	$0C,$84,$79,$02,$01,$82,$67	; Block 2 tiles from 7984 to $6782 copy 1 times
	DEFB	$0E,$2A,$56,$70		; Put tile $2A at $7056
	DEFB	$01,$06,$2B,$74,$70	; Fill vert 6 tiles with $2B at $7074
	DEFB	$05,$04,$07,$8E,$79,$A9,$70	; Block 4x7 tiles from 798E to $70A9
	DEFB	$FF	; End of sequence

; Room 7DA9
L7DA9:	DEFW	L7918	; Room procedure
	DEFW	LA0E8	; Initialization
	DEFW	$0000
	DEFW	L7E8C	; Room to Right
	DEFW	L7E05	; Room Up
	DEFW	L7C2E	; Room Down
	DEFB	$04,$01			; Fill entire screen with $01
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$02,$1E,$FF,$90,$65	; Fill horz 30 tiles with $FF at $6590
	DEFB	$03,$FF,$03,$03,$AE,$65	; Rectangle 3x3 tiles with $FF at $65AE
	DEFB	$01,$0C,$EB,$09,$66	; Fill vert 12 tiles with $EB at $6609
	DEFB	$05,$03,$04,$0C,$7C,$F0,$70	; Block 3x4 tiles from 7C0C to $70F0
	DEFB	$0C,$2C,$7C,$02,$01,$75,$67	; Block 2 tiles from 7C2C to $6775 copy 1 times
	DEFB	$0C,$9A,$7C,$02,$10,$99,$65	; Block 2 tiles from 7C9A to $6599 copy 16 times
	DEFB	$0C,$9A,$7C,$02,$10,$9C,$65	; Block 2 tiles from 7C9A to $659C copy 16 times
	DEFB	$0C,$9A,$7C,$02,$10,$9F,$65	; Block 2 tiles from 7C9A to $659F copy 16 times
	DEFB	$05,$03,$03,$18,$7C,$22,$71	; Block 3x3 tiles from 7C18 to $7122
	DEFB	$05,$03,$04,$0C,$7C,$01,$71	; Block 3x4 tiles from 7C0C to $7101
	DEFB	$05,$03,$04,$0C,$7C,$06,$71	; Block 3x4 tiles from 7C0C to $7106
	DEFB	$FF	; End of sequence

; Room 7E05
L7E05:	DEFW	LB452	; Room procedure
	DEFW	LA35C	; Initialization
	DEFW	$0000
	DEFW	L80A7	; Room to Right
	DEFW	L83ED	; Room Up
	DEFW	L7DA9	; Room Down
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$0C,$2C,$7C,$02,$01,$79,$67	; Block 2 tiles from 7C2C to $6779 copy 1 times
	DEFB	$0C,$2C,$7C,$02,$01,$7C,$67	; Block 2 tiles from 7C2C to $677C copy 1 times
	DEFB	$0C,$2C,$7C,$02,$01,$7F,$67	; Block 2 tiles from 7C2C to $677F copy 1 times
	DEFB	$0C,$48,$73,$02,$10,$99,$65	; Block 2 tiles from 7348 to $6599 copy 16 times
	DEFB	$01,$0C,$EB,$09,$66	; Fill vert 12 tiles with $EB at $6609
	DEFB	$05,$03,$03,$21,$7C,$B5,$70	; Block 3x3 tiles from 7C21 to $70B5
	DEFB	$05,$03,$03,$21,$7C,$0E,$71	; Block 3x3 tiles from 7C21 to $710E
	DEFB	$05,$03,$03,$21,$7C,$11,$71	; Block 3x3 tiles from 7C21 to $7111
	DEFB	$05,$03,$04,$0C,$7C,$03,$71	; Block 3x4 tiles from 7C0C to $7103
	DEFB	$05,$04,$03,$7B,$7E,$1F,$71	; Block 4x3 tiles from 7E7B to $711F
	DEFB	$05,$03,$01,$87,$7E,$44,$71	; Block 3x1 tiles from 7E87 to $7144
	DEFB	$05,$02,$01,$8A,$7E,$61,$71	; Block 2x1 tiles from 7E8A to $7161
	DEFB	$05,$02,$01,$8A,$7E,$64,$71	; Block 2x1 tiles from 7E8A to $7164
	DEFB	$02,$05,$FF,$90,$65	; Fill horz 5 tiles with $FF at $6590
	DEFB	$03,$FF,$03,$03,$AE,$65	; Rectangle 3x3 tiles with $FF at $65AE
	DEFB	$FF	; End of sequence

; Blocks for rooms
L7E7B:	DEFB	$00,$01,$01,$02	; Front block 4x3 wooden box
	DEFB	$03,$04,$04,$05
	DEFB	$06,$07,$07,$08
L7E87:	DEFB	$09,$1D,$0A	; Block 3x1
L7E8A:	DEFB	$09,$0A	; Block 2x1

; Room 7E8C
L7E8C:	DEFW	L7918	; Room procedure
	DEFW	LA0ED	; Initialization
	DEFW	L7DA9	; Room to Left
	DEFW	L7EF2	; Room to Right
	DEFW	$0000
	DEFW	L7F48	; Room Down
	DEFB	$04,$01	; Fill entire screen with $01
	DEFB	$02,$1E,$FF,$90,$65	; Fill horz 30 tiles with $FF at $6590
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$0C,$2C,$7C,$02,$01,$72,$67	; Block 2 tiles from 7C2C to $6772 copy 1 times
	DEFB	$0C,$2C,$7C,$02,$01,$84,$67	; Block 2 tiles from 7C2C to $6784 copy 1 times
	DEFB	$05,$03,$03,$18,$7C,$0C,$71	; Block 3x3 tiles from 7C18 to $710C
	DEFB	$05,$03,$04,$0C,$7C,$F2,$70	; Block 3x4 tiles from 7C0C to $70F2
	DEFB	$05,$04,$03,$7B,$7E,$11,$71	; Block 4x3 tiles from 7E7B to $7111
	DEFB	$05,$04,$03,$7B,$7E,$15,$71	; Block 4x3 tiles from 7E7B to $7115
	DEFB	$05,$04,$03,$7B,$7E,$BE,$70	; Block 4x3 tiles from 7E7B to $70BE
	DEFB	$05,$03,$03,$A0,$71,$BA,$70	; Block 3x3 tiles from 71A0 to $70BA
	DEFB	$05,$03,$03,$A0,$71,$1B,$71	; Block 3x3 tiles from 71A0 to $711B
	DEFB	$05,$03,$03,$18,$7C,$22,$71	; Block 3x3 tiles from 7C18 to $7122
	DEFB	$05,$03,$04,$0C,$7C,$06,$71	; Block 3x4 tiles from 7C0C to $7106
	DEFB	$FF	; End of sequence

; Room 7EF2
L7EF2:	DEFW	LB47A	; Room procedure
	DEFW	LA154	; Initialization
	DEFW	L7E8C	; Room to Left
	DEFW	$0000
	DEFW	$0000
	DEFW	$0000
	DEFB	$04,$01			; Fill entire screen with $01
	DEFB	$02,$1E,$FF,$90,$65	; Fill horz 30 tiles with $FF at $6590
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$01,$0F,$EB,$CA,$65	; Fill vert 15 tiles with $EB at $65CA
	DEFB	$05,$04,$03,$7B,$7E,$63,$70	; Block 4x3 tiles from 7E7B to $7063
	DEFB	$05,$04,$03,$7B,$7E,$BA,$70	; Block 4x3 tiles from 7E7B to $70BA
	DEFB	$05,$04,$03,$7B,$7E,$17,$71	; Block 4x3 tiles from 7E7B to $7117
	DEFB	$05,$03,$03,$A0,$71,$C0,$70	; Block 3x3 tiles from 71A0 to $70C0
	DEFB	$05,$03,$03,$A0,$71,$0E,$71	; Block 3x3 tiles from 71A0 to $710E
	DEFB	$05,$03,$03,$A0,$71,$12,$71	; Block 3x3 tiles from 71A0 to $7112
	DEFB	$05,$03,$03,$A0,$71,$1C,$71	; Block 3x3 tiles from 71A0 to $711C
	DEFB	$05,$03,$03,$A0,$71,$23,$71	; Block 3x3 tiles from 71A0 to $7123
	DEFB	$FF	; End of sequence

; Room 7F48
L7F48:	DEFW	LB483	; Room procedure
	DEFW	LA14F	; Initialization
	DEFW	$0000
	DEFW	L7F9C	; Room to Right
	DEFW	L7E8C	; Room Up
	DEFW	L7FC4	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$01,$08,$0C,$B2,$65	; Rectangle 8x12 tiles with $01 at $65B2
	DEFB	$03,$01,$12,$07,$6E,$66	; Rectangle 18x7 tiles with $01 at $666E
	DEFB	$02,$04,$01,$1E,$67	; Fill horz 4 tiles with $01 at $671E
	DEFB	$07,$01,$05,$D8,$65	; Triangle with $01, count=5 at $65D8
	DEFB	$0C,$9A,$7C,$02,$0D,$92,$65	; Block 2 tiles from 7C9A to $6592 copy 13 times
	DEFB	$0C,$9A,$7C,$02,$0E,$A4,$65	; Block 2 tiles from 7C9A to $65A4 copy 14 times
L7F7A:	DEFB	$01,$01,$E4,$5E,$66	; Fill vert 1 tiles with $E4 at $665E
	DEFB	$05,$03,$03,$18,$7C,$DF,$70	; Block 3x3 tiles from 7C18 to $70DF
	DEFB	$05,$01,$03,$4F,$7B,$42,$67	; Block 1x3 tiles from 7B4F to $6742
	DEFB	$05,$01,$03,$4F,$7B,$4B,$67	; Block 1x3 tiles from 7B4F to $674B
	DEFB	$05,$02,$03,$84,$79,$3E,$67	; Block 2x3 tiles from 7984 to $673E
	DEFB	$FF	; End of sequence

; Room 7F9C
L7F9C:	DEFW	LB458	; Room procedure
	DEFW	LA1B5	; Initialization
	DEFW	L7F48	; Room to Left
	DEFW	$0000
	DEFW	$0000
	DEFW	L8008	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$01,$1B,$07,$62,$66	; Rectangle 27x7 tiles with $01 at $6662
	DEFB	$01,$01,$E4,$46,$66	; Fill vert 1 tiles with $E4 at $6646
	DEFB	$05,$02,$03,$84,$79,$38,$67	; Block 2x3 tiles from 7984 to $6738
	DEFB	$05,$02,$03,$84,$79,$48,$67	; Block 2x3 tiles from 7984 to $6748
	DEFB	$FF	; End of sequence

; Room 7FC4
L7FC4:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L7C6D	; Room to Left
	DEFW	L8008	; Room to Right
	DEFW	L7F48	; Room Up
	DEFW	$0000
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$02,$0D,$06,$80,$66	; Rectangle 13x6 tiles with $02 at $6680
	DEFB	$02,$04,$03,$80,$66	; Fill horz 4 tiles with $03 at $6680
	DEFB	$02,$09,$03,$66,$66	; Fill horz 9 tiles with $03 at $6666
	DEFB	$0C,$B9,$71,$02,$0E,$9A,$65	; Block 2 tiles from 71B9 to $659A copy 14 times
	DEFB	$01,$11,$FD,$9E,$65	; Fill vert 17 tiles with $FD at $659E
	DEFB	$02,$0E,$03,$36,$66	; Fill horz 14 tiles with $03 at $6636
	DEFB	$03,$02,$0E,$05,$54,$66	; Rectangle 14x5 tiles with $02 at $6654
	DEFB	$05,$01,$06,$4F,$7B,$F1,$66	; Block 1x6 tiles from 7B4F to $66F1
	DEFB	$05,$01,$05,$51,$7B,$A7,$65	; Block 1x5 tiles from 7B51 to $65A7
	DEFB	$FF	; End of sequence

; Room 8008
L8008:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L7FC4	; Room to Left
	DEFW	$0000
	DEFW	L7F9C	; Room Up
	DEFW	L8076	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$02,$0D,$03,$26,$66	; Fill horz 13 tiles with $03 at $6626
	DEFB	$02,$0B,$03,$36,$66	; Fill horz 11 tiles with $03 at $6636
	DEFB	$03,$02,$0D,$05,$44,$66	; Rectangle 13x5 tiles with $02 at $6644
	DEFB	$03,$02,$0B,$06,$54,$66	; Rectangle 11x6 tiles with $02 at $6654
	DEFB	$02,$0A,$02,$DD,$66	; Fill horz 10 tiles with $02 at $66DD
	DEFB	$0C,$B9,$71,$02,$0C,$94,$65	; Block 2 tiles from 71B9 to $6594 copy 12 times
	DEFB	$0C,$B9,$71,$02,$0C,$A4,$65	; Block 2 tiles from 71B9 to $65A4 copy 12 times
	DEFB	$05,$02,$05,$84,$79,$FF,$66	; Block 2x5 tiles from 7984 to $66FF
	DEFB	$05,$02,$05,$84,$79,$0C,$67	; Block 2x5 tiles from 7984 to $670C
	DEFB	$05,$01,$05,$4F,$7B,$02,$67	; Block 1x5 tiles from 7B4F to $6702
	DEFB	$05,$01,$05,$4F,$7B,$0A,$67	; Block 1x5 tiles from 7B4F to $670A
	DEFB	$05,$01,$05,$4F,$7B,$11,$67	; Block 1x5 tiles from 7B4F to $6711
	DEFB	$05,$01,$05,$51,$7B,$A2,$65	; Block 1x5 tiles from 7B51 to $65A2
	DEFB	$05,$01,$05,$51,$7B,$A9,$65	; Block 1x5 tiles from 7B51 to $65A9
	DEFB	$01,$11,$FD,$9E,$65	; Fill vert 17 tiles with $FD at $659E
	DEFB	$FF	; End of sequence

; Room 8076
L8076:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	$0000
	DEFW	L8008	; Room Up
	DEFW	L8384	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$01,$11,$FD,$9A,$65	; Fill vert 17 tiles with $FD at $659A
	DEFB	$01,$11,$FD,$9E,$65	; Fill vert 17 tiles with $FD at $659E
	DEFB	$01,$11,$FD,$A2,$65	; Fill vert 17 tiles with $FD at $65A2
	DEFB	$01,$11,$FD,$A9,$65	; Fill vert 17 tiles with $FD at $65A9
	DEFB	$0C,$B9,$71,$02,$11,$97,$65	; Block 2 tiles from 71B9 to $6597 copy 17 times
	DEFB	$0C,$B9,$71,$02,$11,$A4,$65	; Block 2 tiles from 71B9 to $65A4 copy 17 times
	DEFB	$FF	; End of sequence

; Room 80A7
L80A7:	DEFW	LB458	; Room procedure
	DEFW	LA1CB	; Initialization
	DEFW	L7E05	; Room to Left
	DEFW	L80F6	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$02,$1E,$FF,$90,$65	; Fill horz 30 tiles with $FF at $6590
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$05,$03,$04,$0C,$7C,$F0,$70	; Block 3x4 tiles from 7C0C to $70F0
	DEFB	$05,$03,$03,$21,$7C,$13,$71	; Block 3x3 tiles from 7C21 to $7113
	DEFB	$05,$03,$03,$A0,$71,$17,$71	; Block 3x3 tiles from 71A0 to $7117
	DEFB	$05,$04,$03,$7B,$7E,$1C,$71	; Block 4x3 tiles from 7E7B to $711C
	DEFB	$05,$03,$03,$21,$7C,$C3,$70	; Block 3x3 tiles from 7C21 to $70C3
	DEFB	$05,$03,$03,$21,$7C,$C9,$70	; Block 3x3 tiles from 7C21 to $70C9
	DEFB	$05,$03,$03,$21,$7C,$22,$71	; Block 3x3 tiles from 7C21 to $7122
	DEFB	$05,$03,$03,$21,$7C,$25,$71	; Block 3x3 tiles from 7C21 to $7125
	DEFB	$FF	; End of sequence

; Room 80F6
L80F6:	DEFW	LB452	; Room procedure
	DEFW	LA38E	; Initialization
	DEFW	L80A7	; Room to Left
	DEFW	$0000
	DEFW	$0000
	DEFW	$0000
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$03,$FF,$02,$10,$AC,$65	; Rectangle 2x16 tiles with $FF at $65AC
	DEFB	$05,$02,$04,$BB,$71,$F1,$70	; Block 2x4 tiles from 71BB to $70F1
	DEFB	$05,$03,$03,$21,$7C,$BA,$70	; Block 3x3 tiles from 7C21 to $70BA
	DEFB	$05,$03,$03,$21,$7C,$12,$71	; Block 3x3 tiles from 7C21 to $7112
	DEFB	$05,$03,$03,$21,$7C,$15,$71	; Block 3x3 tiles from 7C21 to $7115
	DEFB	$05,$03,$03,$21,$7C,$6F,$70	; Block 3x3 tiles from 7C21 to $706F
	DEFB	$05,$03,$03,$21,$7C,$C7,$70	; Block 3x3 tiles from 7C21 to $70C7
	DEFB	$05,$03,$03,$21,$7C,$CB,$70	; Block 3x3 tiles from 7C21 to $70CB
	DEFB	$05,$03,$03,$21,$7C,$1F,$71	; Block 3x3 tiles from 7C21 to $711F
	DEFB	$05,$03,$03,$21,$7C,$22,$71	; Block 3x3 tiles from 7C21 to $7122
	DEFB	$05,$03,$03,$21,$7C,$25,$71	; Block 3x3 tiles from 7C21 to $7125
	DEFB	$05,$04,$03,$7B,$7E,$1A,$71	; Block 4x3 tiles from 7E7B to $711A
	DEFB	$05,$02,$01,$8A,$7E,$55,$71	; Block 2x1 tiles from 7E8A to $7155
	DEFB	$FF	; End of sequence

; Room 8162
L8162:	DEFW	LB458	; Room procedure
	DEFW	LA1C0	; Initialization
	DEFW	L81E5	; Room to Left
	DEFW	$0000
	DEFW	L8321	; Room Up
	DEFW	L7BD2	; Room Down
	DEFB	$03,$01,$1C,$08,$80,$66	; Rectangle 28x8 tiles with $01 at $6680
	DEFB	$02,$1C,$FF,$62,$66	; Fill horz 28 tiles with $FF at $6662
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$02,$0D,$FF,$90,$65	; Fill horz 13 tiles with $FF at $6590
	DEFB	$02,$07,$FF,$A7,$65	; Fill horz 7 tiles with $FF at $65A7
	DEFB	$0C,$E3,$81,$02,$0F,$CA,$65	; Block 2 tiles from 81E3 to $65CA copy 15 times
	DEFB	$0C,$48,$73,$02,$07,$A0,$65	; Block 2 tiles from 7348 to $65A0 copy 7 times
	DEFB	$05,$02,$04,$BB,$71,$E7,$6F	; Block 2x4 tiles from 71BB to $6FE7
	DEFB	$05,$03,$04,$0C,$7C,$EF,$70	; Block 3x4 tiles from 7C0C to $70EF
	DEFB	$05,$03,$03,$18,$7C,$10,$71	; Block 3x3 tiles from 7C18 to $7110
	DEFB	$05,$03,$03,$18,$7C,$1D,$71	; Block 3x3 tiles from 7C18 to $711D
	DEFB	$05,$03,$04,$0C,$7C,$04,$71	; Block 3x4 tiles from 7C0C to $7104
	DEFB	$05,$03,$03,$18,$7C,$25,$71	; Block 3x3 tiles from 7C18 to $7125
	DEFB	$0E,$2A,$A8,$6F		; Put tile $2A at $6FA8
	DEFB	$01,$05,$2B,$C6,$6F	; Fill vert 5 tiles with $2B at $6FC6
	DEFB	$0E,$2A,$AF,$6F		; Put tile $2A at $6FAF
	DEFB	$01,$05,$2B,$CD,$6F	; Fill vert 5 tiles with $2B at $6FCD
	DEFB	$0E,$2A,$BC,$6F		; Put tile $2A at $6FBC
	DEFB	$01,$05,$2B,$DA,$6F	; Fill vert 5 tiles with $2B at $6FDA
	DEFB	$0C,$2C,$7C,$02,$01,$7E,$67	; Block 2 tiles from 7C2C to $677E copy 1 times
	DEFB	$FF	; End of sequence

; Blocks for rooms
L81E3:	DEFB	$FF,$FF	; Block 2x1

; Room 81E5
L81E5:	DEFW	LB452	; Room procedure
	DEFW	LA353	; Initialization
	DEFW	L8238	; Room to Left
	DEFW	L8162	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$03,$FF,$1E,$09,$80,$66	; Rectangle 30x9 tiles with $FF at $6680
	DEFB	$03,$01,$1C,$07,$A0,$66	; Rectangle 28x7 tiles with $01 at $66A0
	DEFB	$02,$05,$00,$80,$66	; Fill horz 5 tiles with $00 at $6680
	DEFB	$02,$06,$FF,$9E,$66	; Fill horz 6 tiles with $FF at $669E
	DEFB	$02,$0C,$FF,$90,$65	; Fill horz 12 tiles with $FF at $6590
	DEFB	$02,$0B,$FF,$A3,$65	; Fill horz 11 tiles with $FF at $65A3
	DEFB	$06,$FF,$02,$AE,$65	; Triangle with $FF, count=2 at $65AE
	DEFB	$0E,$2A,$AC,$6F		; Put tile $2A at $6FAC
	DEFB	$0E,$2A,$B8,$6F		; Put tile $2A at $6FB8
	DEFB	$01,$06,$2B,$CA,$6F	; Fill vert 6 tiles with $2B at $6FCA
	DEFB	$01,$05,$2B,$D6,$6F	; Fill vert 5 tiles with $2B at $6FD6
	DEFB	$02,$0A,$01,$94,$66	; Fill horz 10 tiles with $01 at $6694
	DEFB	$02,$18,$01,$A4,$66	; Fill horz 24 tiles with $01 at $66A4
	DEFB	$02,$0B,$FF,$75,$66	; Fill horz 11 tiles with $FF at $6675
	DEFB	$FF	; End of sequence

; Room 8238
L8238:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	L81E5	; Room to Right
	DEFW	L8279	; Room Up
	DEFW	L7A17	; Room Down
	DEFB	$04,$FF	; Fill entire screen with $FF
	DEFB	$03,$00,$1C,$06,$EC,$65	; Rectangle 28x6 tiles with $00 at $65EC
	DEFB	$02,$0E,$00,$A0,$66	; Fill horz 14 tiles with $00 at $66A0
	DEFB	$0C,$B9,$71,$02,$11,$98,$65	; Block 2 tiles from 71B9 to $6598 copy 17 times
	DEFB	$0C,$48,$73,$02,$07,$F2,$65	; Block 2 tiles from 7348 to $65F2 copy 7 times
	DEFB	$05,$02,$01,$84,$79,$C4,$66	; Block 2x1 tiles from 7984 to $66C4
	DEFB	$0E,$2A,$E4,$6F		; Put tile $2A at $6FE4
	DEFB	$0E,$2A,$F8,$6F		; Put tile $2A at $6FF8
	DEFB	$01,$06,$2B,$02,$70	; Fill vert 6 tiles with $2B at $7002
	DEFB	$01,$05,$2B,$16,$70	; Fill vert 5 tiles with $2B at $7016
	DEFB	$FF	; End of sequence

; Room 8279
L8279:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	L82DD	; Room to Right
	DEFW	$0000
	DEFW	L8238	; Room Down
	DEFB	$0C,$E3,$81,$02,$11,$90,$65	; Block 2 tiles from 81E3 to $6590 copy 17 times
	DEFB	$07,$FF,$04,$BE,$66	; Triangle with $FF, count=4 at $66BE
	DEFB	$02,$0F,$FF,$34,$67	; Fill horz 15 tiles with $FF at $6734
	DEFB	$02,$15,$FF,$52,$67	; Fill horz 21 tiles with $FF at $6752
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$05,$03,$03,$21,$7C,$A5,$70	; Block 3x3 tiles from 7C21 to $70A5
	DEFB	$05,$03,$03,$21,$7C,$C7,$70	; Block 3x3 tiles from 7C21 to $70C7
	DEFB	$05,$03,$03,$21,$7C,$DB,$70	; Block 3x3 tiles from 7C21 to $70DB
	DEFB	$05,$03,$03,$21,$7C,$FD,$70	; Block 3x3 tiles from 7C21 to $70FD
	DEFB	$05,$03,$03,$21,$7C,$00,$71	; Block 3x3 tiles from 7C21 to $7100
	DEFB	$05,$03,$03,$21,$7C,$21,$71	; Block 3x3 tiles from 7C21 to $7121
	DEFB	$05,$03,$03,$21,$7C,$24,$71	; Block 3x3 tiles from 7C21 to $7124
	DEFB	$05,$02,$03,$84,$79,$3C,$67	; Block 2x3 tiles from 7984 to $673C
	DEFB	$0E,$00,$BE,$66	; Put tile $00 at $66BE
	DEFB	$FF	; End of sequence

; Room 82DD
L82DD:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L8279	; Room to Left
	DEFW	L8321	; Room to Right
	DEFW	$0000
	DEFW	L81E5	; Room Down
	DEFB	$02,$0D,$FF,$70,$67	; Fill horz 13 tiles with $FF at $6770
	DEFB	$02,$07,$FF,$58,$67	; Fill horz 7 tiles with $FF at $6758
	DEFB	$02,$06,$FF,$64,$67	; Fill horz 6 tiles with $FF at $6764
	DEFB	$02,$0C,$FF,$82,$67	; Fill horz 12 tiles with $FF at $6782
	DEFB	$05,$03,$03,$21,$7C,$0C,$71	; Block 3x3 tiles from 7C21 to $710C
	DEFB	$05,$03,$03,$21,$7C,$0F,$71	; Block 3x3 tiles from 7C21 to $710F
	DEFB	$05,$03,$03,$21,$7C,$F5,$70	; Block 3x3 tiles from 7C21 to $70F5
	DEFB	$05,$03,$03,$A0,$71,$02,$71	; Block 3x3 tiles from 71A0 to $7102
	DEFB	$05,$04,$03,$7B,$7E,$25,$71	; Block 4x3 tiles from 7E7B to $7125
	DEFB	$FF	; End of sequence

; Room 8321
L8321:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L82DD	; Room to Left
	DEFW	$0000
	DEFW	L844E	; Room Up
	DEFW	L8162	; Room Down
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$05,$02,$01,$84,$79,$80,$67	; Block 2x1 tiles from 7984 to $6780
	DEFB	$03,$FF,$03,$04,$AB,$65	; Rectangle 3x4 tiles with $FF at $65AB
	DEFB	$01,$0C,$EB,$24,$66	; Fill vert 12 tiles with $EB at $6624
	DEFB	$05,$04,$03,$7B,$7E,$0E,$71	; Block 4x3 tiles from 7E7B to $710E
	DEFB	$05,$04,$03,$7B,$7E,$B6,$70	; Block 4x3 tiles from 7E7B to $70B6
	DEFB	$05,$03,$03,$A0,$71,$13,$71	; Block 3x3 tiles from 71A0 to $7113
	DEFB	$05,$03,$03,$21,$7C,$18,$71	; Block 3x3 tiles from 7C21 to $7118
	DEFB	$05,$03,$03,$A0,$71,$1F,$71	; Block 3x3 tiles from 71A0 to $711F
	DEFB	$05,$03,$03,$A0,$71,$24,$71	; Block 3x3 tiles from 71A0 to $7124
	DEFB	$05,$02,$01,$8A,$7E,$5F,$71	; Block 2x1 tiles from 7E8A to $715F
	DEFB	$05,$04,$03,$7B,$7E,$C7,$70	; Block 4x3 tiles from 7E7B to $70C7
	DEFB	$0C,$48,$73,$02,$10,$A0,$65	; Block 2 tiles from 7348 to $65A0 copy 16 times
	DEFB	$FF	; End of sequence

; Room 8384
L8384:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	$0000
	DEFW	L8076	; Room Up
	DEFW	L9376	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$02,$0F,$07,$28,$66	; Rectangle 15x7 tiles with $02 at $6628
	DEFB	$02,$0F,$03,$0A,$66	; Fill horz 15 tiles with $03 at $660A
	DEFB	$03,$02,$06,$07,$3C,$66	; Rectangle 6x7 tiles with $02 at $663C
	DEFB	$02,$06,$03,$1E,$66	; Fill horz 6 tiles with $03 at $661E
	DEFB	$0C,$B9,$71,$02,$0C,$97,$65	; Block 2 tiles from 71B9 to $6597 copy 12 times
	DEFB	$0C,$B9,$71,$02,$11,$A4,$65	; Block 2 tiles from 71B9 to $65A4 copy 17 times
	DEFB	$05,$02,$05,$84,$79,$FC,$66	; Block 2x5 tiles from 7984 to $66FC
	DEFB	$05,$02,$01,$84,$79,$0C,$67	; Block 2x1 tiles from 7984 to $670C
	DEFB	$01,$11,$FD,$A2,$65	; Fill vert 17 tiles with $FD at $65A2
	DEFB	$05,$01,$04,$52,$7B,$9A,$65	; Block 1x4 tiles from 7B52 to $659A
	DEFB	$05,$01,$04,$52,$7B,$9E,$65	; Block 1x4 tiles from 7B52 to $659E
	DEFB	$05,$01,$04,$52,$7B,$A9,$65	; Block 1x4 tiles from 7B52 to $65A9
	DEFB	$05,$01,$05,$4F,$7B,$02,$67	; Block 1x5 tiles from 7B4F to $6702
	DEFB	$05,$01,$05,$4F,$7B,$11,$67	; Block 1x5 tiles from 7B4F to $6711
	DEFB	$FF	; End of sequence

; Room 83ED
L83ED:	DEFW	LB452	; Room procedure
	DEFW	LA361	; Initialization
	DEFW	$0000
	DEFW	L920A	; Room to Right
	DEFW	L913F	; Room Up
	DEFW	L7E05	; Room Down
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$0C,$48,$73,$02,$10,$99,$65	; Block 2 tiles from 7348 to $6599 copy 16 times
	DEFB	$05,$02,$01,$84,$79,$79,$67	; Block 2x1 tiles from 7984 to $6779
	DEFB	$03,$FF,$03,$04,$90,$65	; Rectangle 3x4 tiles with $FF at $6590
	DEFB	$02,$02,$FF,$93,$65	; Fill horz 2 tiles with $FF at $6593
	DEFB	$01,$0C,$EB,$09,$66	; Fill vert 12 tiles with $EB at $6609
	DEFB	$05,$03,$04,$0C,$7C,$F2,$70	; Block 3x4 tiles from 7C0C to $70F2
	DEFB	$05,$03,$03,$A0,$71,$0E,$71	; Block 3x3 tiles from 71A0 to $710E
	DEFB	$05,$02,$01,$8A,$7E,$4E,$71	; Block 2x1 tiles from 7E8A to $714E
	DEFB	$05,$04,$03,$7B,$7E,$C4,$70	; Block 4x3 tiles from 7E7B to $70C4
	DEFB	$05,$04,$03,$7B,$7E,$1B,$71	; Block 4x3 tiles from 7E7B to $711B
	DEFB	$05,$03,$04,$0C,$7C,$06,$71	; Block 3x4 tiles from 7C0C to $7106
	DEFB	$05,$04,$03,$7B,$7E,$21,$71	; Block 4x3 tiles from 7E7B to $7121
	DEFB	$FF	; End of sequence

; Room 844E
L844E:	DEFW	LB452	; Room procedure
	DEFW	LA37F	; Initialization
	DEFW	L84A8	; Room to Left
	DEFW	$0000
	DEFW	$0000
	DEFW	L8321	; Room Down
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$02,$06,$FF,$52,$67	; Fill horz 6 tiles with $FF at $6752
	DEFB	$03,$FF,$03,$04,$AB,$65	; Rectangle 3x4 tiles with $FF at $65AB
	DEFB	$01,$0C,$EB,$24,$66	; Fill vert 12 tiles with $EB at $6624
	DEFB	$05,$02,$01,$84,$79,$80,$67	; Block 2x1 tiles from 7984 to $6780
	DEFB	$05,$03,$03,$A0,$71,$F0,$70	; Block 3x3 tiles from 71A0 to $70F0
	DEFB	$05,$03,$03,$A0,$71,$12,$71	; Block 3x3 tiles from 71A0 to $7112
	DEFB	$00,$BE,$70	; Barrel 3x3 tiles at $70BE
	DEFB	$00,$16,$71	; Barrel 3x3 tiles at $7116
	DEFB	$00,$19,$71	; Barrel 3x3 tiles at $7119
	DEFB	$05,$04,$03,$7B,$7E,$1F,$71	; Block 4x3 tiles from 7E7B to $711F
	DEFB	$05,$03,$04,$9C,$84,$07,$71	; Block 3x4 tiles from 849C to $7107
	DEFB	$FF	; End of sequence

; Blocks for rooms
L849C:	DEFB	$00,$01,$02	; Front block 3x4
	DEFB	$03,$04,$05
	DEFB	$03,$04,$05
	DEFB	$06,$07,$08

; Room 84A8
L84A8:	DEFW	LB41F	; Room procedure
	DEFW	LF973	; Initialization
	DEFW	L84EE	; Room to Left
	DEFW	L844E	; Room to Right
	DEFW	$0000
	DEFW	L82DD	; Room Down
	DEFB	$03,$FF,$0D,$02,$52,$67	; Rectangle 13x2 tiles with $FF at $6752
	DEFB	$03,$FF,$0C,$02,$64,$67	; Rectangle 12x2 tiles with $FF at $6764
	DEFB	$02,$03,$FF,$BC,$65	; Fill horz 3 tiles with $FF at $65BC
	DEFB	$02,$0D,$FF,$9A,$65	; Fill horz 13 tiles with $FF at $659A
	DEFB	$00,$F0,$70	; Barrel 3x3 tiles at $70F0
	DEFB	$00,$97,$70	; Barrel 3x3 tiles at $7097
	DEFB	$05,$04,$03,$7B,$7E,$04,$71	; Block 4x3 tiles from 7E7B to $7104
	DEFB	$05,$05,$03,$DF,$84,$F2,$70	; Block 5x3 tiles from 84DF to $70F2
	DEFB	$FF	; End of sequence

; Blocks for rooms
L84DF:	DEFB	$00,$01,$01,$01,$02	; Front block 5x3 - box
	DEFB	$03,$04,$04,$04,$05
	DEFB	$06,$07,$07,$07,$08

; Room 84EE
L84EE:	DEFW	L7918	; Room procedure
	DEFW	LA10B	; Initialization
	DEFW	$0000
	DEFW	L84A8	; Room to Right
	DEFW	L8526	; Room Up
	DEFW	$0000
	DEFB	$03,$FF,$02,$0F,$90,$65	; Rectangle 2x15 tiles with $FF at $6590
	DEFB	$03,$FF,$1E,$02,$52,$67	; Rectangle 30x2 tiles with $FF at $6752
	DEFB	$0C,$48,$73,$02,$0F,$98,$65	; Block 2 tiles from 7348 to $6598 copy 15 times
	DEFB	$00,$F0,$70	; Barrel 3x3 tiles at $70F0
	DEFB	$00,$F3,$70	; Barrel 3x3 tiles at $70F3
	DEFB	$00,$4D,$70	; Barrel 3x3 tiles at $704D
	DEFB	$00,$A6,$70	; Barrel 3x3 tiles at $70A6
	DEFB	$00,$A9,$70	; Barrel 3x3 tiles at $70A9
	DEFB	$00,$FE,$70	; Barrel 3x3 tiles at $70FE
	DEFB	$00,$01,$71	; Barrel 3x3 tiles at $7101
	DEFB	$00,$04,$71	; Barrel 3x3 tiles at $7104
	DEFB	$FF	; End of sequence

; Room 8526
L8526:	DEFW	LB483	; Room procedure
	DEFW	LA179	; Initialization
	DEFW	$0000
	DEFW	L858F	; Room to Right
	DEFW	L8608	; Room Up
	DEFW	L84EE	; Room Down
	DEFB	$0C,$E3,$81,$02,$10,$90,$65	; Block 2 tiles from 81E3 to $6590 copy 16 times
	DEFB	$0C,$48,$73,$02,$10,$98,$65	; Block 2 tiles from 7348 to $6598 copy 16 times
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$05,$02,$01,$84,$79,$78,$67	; Block 2x1 tiles from 7984 to $6778
	DEFB	$00,$B4,$70	; Barrel 3x3 tiles at $70B4
	DEFB	$00,$0F,$71	; Barrel 3x3 tiles at $710F
	DEFB	$00,$26,$71	; Barrel 3x3 tiles at $7126
	DEFB	$05,$02,$02,$77,$85,$38,$71	; Block 2x2 tiles from 8577 to $7138
	DEFB	$05,$03,$04,$9C,$84,$00,$71	; Block 3x4 tiles from 849C to $7100
	DEFB	$05,$02,$02,$77,$85,$3E,$71	; Block 2x2 tiles from 8577 to $713E
	DEFB	$05,$02,$02,$77,$85,$41,$71	; Block 2x2 tiles from 8577 to $7141
	DEFB	$02,$06,$FF,$9F,$65	; Fill horz 6 tiles with $FF at $659F
	DEFB	$FF	; End of sequence

; Blocks for rooms
L8577:	DEFB	$00,$02	; Front block 2x2 - box
	DEFB	$06,$08
L857B:	DEFB	$00,$01,$01,$01,$02	; Front block 5x4 - box
	DEFB	$03,$04,$04,$04,$05
	DEFB	$03,$04,$04,$04,$05
	DEFB	$06,$07,$07,$07,$08

; Room 858F
L858F:	DEFW	L7918	; Room procedure
	DEFW	LA106	; Initialization
	DEFW	L8526	; Room to Left
	DEFW	L85BD	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$05,$05,$04,$7B,$85,$F2,$70	; Block 5x4 tiles from 857B to $70F2
	DEFB	$05,$05,$04,$7B,$85,$F9,$70	; Block 5x4 tiles from 857B to $70F9
	DEFB	$05,$02,$01,$8A,$7E,$4E,$71	; Block 2x1 tiles from 7E8A to $714E
	DEFB	$05,$03,$03,$A0,$71,$1E,$71	; Block 3x3 tiles from 71A0 to $711E
	DEFB	$FF	; End of sequence

; Room 85BD
L85BD:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L858F	; Room to Left
	DEFW	$0000
	DEFW	L8689	; Room Up
	DEFW	$0000
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$03,$FF,$03,$04,$AB,$65	; Rectangle 3x4 tiles with $FF at $65AB
	DEFB	$01,$0C,$EB,$24,$66	; Fill vert 12 tiles with $EB at $6624
	DEFB	$0C,$48,$73,$02,$10,$9D,$65	; Block 2 tiles from 7348 to $659D copy 16 times
	DEFB	$00,$04,$70		; Barrel 3x3 tiles at $7004
	DEFB	$00,$5D,$70		; Barrel 3x3 tiles at $705D
	DEFB	$00,$60,$70		; Barrel 3x3 tiles at $7060
	DEFB	$00,$B5,$70		; Barrel 3x3 tiles at $70B5
	DEFB	$00,$B8,$70		; Barrel 3x3 tiles at $70B8
	DEFB	$00,$BB,$70		; Barrel 3x3 tiles at $70BB
	DEFB	$00,$0E,$71		; Barrel 3x3 tiles at $710E
	DEFB	$00,$11,$71		; Barrel 3x3 tiles at $7111
	DEFB	$00,$14,$71		; Barrel 3x3 tiles at $7114
	DEFB	$00,$1D,$71		; Barrel 3x3 tiles at $711D
	DEFB	$00,$21,$71		; Barrel 3x3 tiles at $7121
	DEFB	$00,$24,$71		; Barrel 3x3 tiles at $7124
	DEFB	$00,$17,$71		; Barrel 3x3 tiles at $7117
	DEFB	$FF	; End of sequence

; Room 8608
L8608:	DEFW	LB452	; Room procedure
	DEFW	LA37A	; Initialization
	DEFW	$0000
	DEFW	L86FD	; Room to Right
	DEFW	$0000
	DEFW	L8526	; Room Down
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$02,$1C,$FF,$82,$66	; Fill horz 28 tiles with $FF at $6682
	DEFB	$02,$0C,$FF,$74,$66	; Fill horz 12 tiles with $FF at $6674
	DEFB	$0C,$E3,$81,$02,$10,$90,$65	; Block 2 tiles from 81E3 to $6590 copy 16 times
	DEFB	$02,$0E,$FF,$92,$65	; Fill horz 14 tiles with $FF at $6592
	DEFB	$0C,$E3,$81,$02,$07,$BA,$66	; Block 2 tiles from 81E3 to $66BA copy 7 times
	DEFB	$05,$02,$01,$84,$79,$78,$67	; Block 2x1 tiles from 7984 to $6778
	DEFB	$05,$03,$03,$A0,$71,$C4,$6F	; Block 3x3 tiles from 71A0 to $6FC4
	DEFB	$05,$04,$03,$7B,$7E,$1E,$70	; Block 4x3 tiles from 7E7B to $701E
	DEFB	$05,$03,$03,$A0,$71,$24,$70	; Block 3x3 tiles from 71A0 to $7024
	DEFB	$00,$28,$70		; Barrel 3x3 tiles at $7028
	DEFB	$05,$03,$03,$18,$7C,$11,$70	; Block 3x3 tiles from 7C18 to $7011
	DEFB	$05,$03,$04,$0C,$7C,$F7,$6F	; Block 3x4 tiles from 7C0C to $6FF7
	DEFB	$05,$03,$03,$18,$7C,$18,$71	; Block 3x3 tiles from 7C18 to $7118
	DEFB	$00,$B5,$70		; Barrel 3x3 tiles at $70B5
	DEFB	$00,$0E,$71		; Barrel 3x3 tiles at $710E
	DEFB	$00,$11,$71		; Barrel 3x3 tiles at $7111
	DEFB	$00,$C4,$70		; Barrel 3x3 tiles at $70C4
	DEFB	$00,$C8,$70		; Barrel 3x3 tiles at $70C8
	DEFB	$00,$CB,$70		; Barrel 3x3 tiles at $70CB
	DEFB	$00,$1C,$71		; Barrel 3x3 tiles at $711C
	DEFB	$00,$1F,$71		; Barrel 3x3 tiles at $711F
	DEFB	$00,$22,$71		; Barrel 3x3 tiles at $7122
	DEFB	$00,$25,$71		; Barrel 3x3 tiles at $7125
	DEFB	$FF	; End of sequence

; Room 8689
L8689:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L86FD	; Room to Left
	DEFW	$0000
	DEFW	$0000
	DEFW	L85BD	; Room Down
	DEFB	$02,$39,$FF,$BC,$66	; Fill horz 57 tiles with $FF at $66BC
	DEFB	$03,$FF,$03,$11,$AB,$65	; Rectangle 3x17 tiles with $FF at $65AB
	DEFB	$05,$02,$02,$84,$79,$C9,$66	; Block 2x2 tiles from 7984 to $66C9
	DEFB	$0C,$48,$73,$02,$05,$05,$67	; Block 2 tiles from 7348 to $6705 copy 5 times
	DEFB	$05,$03,$03,$18,$7C,$67,$70	; Block 3x3 tiles from 7C18 to $7067
	DEFB	$05,$04,$02,$F5,$86,$21,$70	; Block 4x2 tiles from 86F5 to $7021
	DEFB	$05,$04,$03,$7B,$7E,$5B,$70	; Block 4x3 tiles from 7E7B to $705B
	DEFB	$05,$03,$03,$A0,$71,$60,$70	; Block 3x3 tiles from 71A0 to $7060
	DEFB	$05,$03,$01,$87,$7E,$96,$70	; Block 3x1 tiles from 7E87 to $7096
	DEFB	$05,$05,$03,$DF,$84,$B9,$6F	; Block 5x3 tiles from 84DF to $6FB9
	DEFB	$05,$03,$03,$A0,$71,$12,$70	; Block 3x3 tiles from 71A0 to $7012
	DEFB	$05,$04,$03,$7B,$7E,$15,$70	; Block 4x3 tiles from 7E7B to $7015
	DEFB	$05,$04,$03,$7B,$7E,$6B,$70	; Block 4x3 tiles from 7E7B to $706B
	DEFB	$05,$04,$03,$7B,$7E,$6F,$70	; Block 4x3 tiles from 7E7B to $706F
	DEFB	$FF	; End of sequence

; Blocks for rooms
L86F5:	DEFB	$00,$01,$01,$02	; Front block 4x2 - box
	DEFB	$06,$07,$07,$08

; Room 86FD
L86FD:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L8608	; Room to Left
	DEFW	L8689	; Room to Right
	DEFW	L8739	; Room Up
	DEFW	$0000
	DEFB	$06,$FF,$04,$16,$67	; Triangle with $FF, count=4 at $6716
	DEFB	$02,$41,$FF,$BC,$66	; Fill horz 65 tiles with $FF at $66BC
	DEFB	$07,$FF,$02,$87,$66	; Triangle with $FF, count=2 at $6687
	DEFB	$03,$FF,$07,$03,$62,$66	; Rectangle 7x3 tiles with $FF at $6662
	DEFB	$0C,$48,$73,$02,$07,$93,$65	; Block 2 tiles from 7348 to $6593 copy 7 times
	DEFB	$05,$04,$07,$AA,$79,$E6,$6F	; Block 4x7 tiles from 79AA to $6FE6
	DEFB	$00,$0E,$70		; Barrel 3x3 tiles at $700E
	DEFB	$00,$66,$70		; Barrel 3x3 tiles at $7066
	DEFB	$00,$69,$70		; Barrel 3x3 tiles at $7069
	DEFB	$00,$6F,$70		; Barrel 3x3 tiles at $706F
	DEFB	$FF	; End of sequence

; Room 8739
L8739:	DEFW	L7918	; Room procedure
	DEFW	LA101	; Initialization
	DEFW	L8799	; Room to Left
	DEFW	L8802	; Room to Right
	DEFW	$0000
	DEFW	L86FD	; Room Down
	DEFB	$01,$09,$3A,$94,$65	; Fill vert 9 tiles with $3A at $6594
	DEFB	$01,$09,$3A,$9E,$65	; Fill vert 9 tiles with $3A at $659E
	DEFB	$01,$09,$3A,$A1,$65	; Fill vert 9 tiles with $3A at $65A1
	DEFB	$01,$05,$3A,$A8,$65	; Fill vert 5 tiles with $3A at $65A8
	DEFB	$02,$78,$FF,$9E,$66	; Fill horz 120 tiles with $FF at $669E
	DEFB	$05,$02,$04,$84,$79,$A1,$66	; Block 2x4 tiles from 7984 to $66A1
	DEFB	$0C,$48,$73,$02,$04,$19,$67	; Block 2 tiles from 7348 to $6719 copy 4 times
	DEFB	$05,$02,$04,$BB,$71,$2E,$70	; Block 2x4 tiles from 71BB to $702E
	DEFB	$05,$03,$03,$18,$7C,$44,$70	; Block 3x3 tiles from 7C18 to $7044
	DEFB	$05,$03,$04,$0C,$7C,$23,$70	; Block 3x4 tiles from 7C0C to $7023
	DEFB	$05,$03,$04,$0C,$7C,$33,$70	; Block 3x4 tiles from 7C0C to $7033
	DEFB	$FF	; End of sequence

; Blocks for rooms
L8789:	DEFB	$00,$01,$01,$02	; Front block 4x4
	DEFB	$03,$04,$04,$05
	DEFB	$03,$04,$04,$05
	DEFB	$06,$07,$07,$08

; Room 8799
L8799:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	L8739	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$01,$0F,$3A,$98,$65	; Fill vert 15 tiles with $3A at $6598
	DEFB	$01,$0B,$3A,$9D,$65	; Fill vert 11 tiles with $3A at $659D
	DEFB	$01,$09,$3A,$A1,$65	; Fill vert 9 tiles with $3A at $65A1
	DEFB	$01,$09,$3A,$A4,$65	; Fill vert 9 tiles with $3A at $65A4
	DEFB	$01,$09,$3A,$A7,$65	; Fill vert 9 tiles with $3A at $65A7
	DEFB	$01,$09,$3A,$AB,$65	; Fill vert 9 tiles with $3A at $65AB
	DEFB	$0C,$E3,$81,$02,$0F,$90,$65	; Block 2 tiles from 81E3 to $6590 copy 15 times
	DEFB	$03,$FF,$10,$02,$52,$67	; Rectangle 16x2 tiles with $FF at $6752
	DEFB	$03,$FF,$0E,$04,$AE,$66	; Rectangle 14x4 tiles with $FF at $66AE
	DEFB	$08,$FF,$06,$AD,$66	; Triangle with $FF, count=6 at $66AD
	DEFB	$06,$FF,$04,$26,$67	; Triangle with $FF, count=4 at $6726
	DEFB	$02,$08,$FA,$CE,$65	; Fill horz 8 tiles with $FA at $65CE
	DEFB	$05,$03,$03,$A0,$71,$78,$70	; Block 3x3 tiles from 71A0 to $7078
	DEFB	$05,$04,$04,$89,$87,$D2,$70	; Block 4x4 tiles from 8789 to $70D2
	DEFB	$05,$04,$07,$8E,$79,$7F,$70	; Block 4x7 tiles from 798E to $707F
	DEFB	$05,$04,$07,$8E,$79,$28,$70	; Block 4x7 tiles from 798E to $7028
	DEFB	$FF	; End of sequence

; Room 8802
L8802:	DEFW	LB452	; Room procedure
	DEFW	LA375	; Initialization
	DEFW	L8739	; Room to Left
	DEFW	$0000
	DEFW	L8834	; Room Up
	DEFW	$0000
	DEFB	$01,$09,$3A,$9D,$65	; Fill vert 9 tiles with $3A at $659D
	DEFB	$01,$08,$3A,$A2,$65	; Fill vert 8 tiles with $3A at $65A2
	DEFB	$03,$FF,$03,$11,$AB,$65	; Rectangle 3x17 tiles with $FF at $65AB
	DEFB	$02,$84,$FF,$92,$66	; Fill horz 132 tiles with $FF at $6692
	DEFB	$00,$42,$70		; Barrel 3x3 tiles at $7042
	DEFB	$00,$46,$70		; Barrel 3x3 tiles at $7046
	DEFB	$00,$2F,$70		; Barrel 3x3 tiles at $702F
	DEFB	$0C,$48,$73,$02,$08,$A7,$65	; Block 2 tiles from 7348 to $65A7 copy 8 times
	DEFB	$FF	; End of sequence

; Room 8834
L8834:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L889F	; Room to Left
	DEFW	L890E	; Room to Right
	DEFW	L8A81	; Room Up
	DEFW	L8802	; Room Down
	DEFB	$01,$0B,$3A,$EC,$65	; Fill vert 11 tiles with $3A at $65EC
	DEFB	$01,$0E,$3A,$97,$65	; Fill vert 14 tiles with $3A at $6597
	DEFB	$01,$10,$3A,$9D,$65	; Fill vert 16 tiles with $3A at $659D
	DEFB	$01,$11,$3A,$A2,$65	; Fill vert 17 tiles with $3A at $65A2
	DEFB	$02,$0A,$FF,$84,$67	; Fill horz 10 tiles with $FF at $6784
	DEFB	$0C,$48,$73,$02,$10,$A7,$65	; Block 2 tiles from 7348 to $65A7 copy 16 times
	DEFB	$0E,$3A,$5C,$67		; Put tile $3A at $675C
	DEFB	$05,$02,$01,$9D,$88,$D3,$66	; Block 2x1 tiles from 889D to $66D3
	DEFB	$05,$02,$01,$84,$79,$87,$67	; Block 2x1 tiles from 7984 to $6787
	DEFB	$02,$07,$FA,$7A,$67	; Fill horz 7 tiles with $FA at $677A
	DEFB	$05,$01,$02,$98,$88,$5E,$67	; Block 1x2 tiles from 8898 to $675E
	DEFB	$02,$0C,$FA,$34,$67	; Fill horz 12 tiles with $FA at $6734
	DEFB	$02,$04,$FA,$80,$66	; Fill horz 4 tiles with $FA at $6680
	DEFB	$02,$04,$FA,$E0,$66	; Fill horz 4 tiles with $FA at $66E0
	DEFB	$02,$06,$FA,$CD,$66	; Fill horz 6 tiles with $FA at $66CD
	DEFB	$01,$03,$28,$88,$6F	; Fill vert 3 tiles with $28 at $6F88
	DEFB	$FF	; End of sequence

; Blocks for rooms
L8898:	DEFB	$F9	; Back block 1x1
L8899:	DEFB	$F8	; Back block 1x4
	DEFB	$F9
	DEFB	$F9
	DEFB	$F9
L889D:	DEFB	$EF,$EE	; Back block 2x1 - ladder on yellow

; Room 889F
L889F:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L8953	; Room to Left
	DEFW	L8834	; Room to Right
	DEFW	L89B9	; Room Up
	DEFW	L8739	; Room Down
	DEFB	$01,$11,$3A,$94,$65	; Fill vert 17 tiles with $3A at $6594
	DEFB	$01,$11,$3A,$A8,$65	; Fill vert 17 tiles with $3A at $65A8
	DEFB	$01,$0C,$3A,$9C,$65	; Fill vert 12 tiles with $3A at $659C
	DEFB	$01,$06,$3A,$9F,$65	; Fill vert 6 tiles with $3A at $659F
	DEFB	$01,$06,$3A,$A3,$65	; Fill vert 6 tiles with $3A at $65A3
	DEFB	$01,$04,$3A,$24,$67	; Fill vert 4 tiles with $3A at $6724
	DEFB	$01,$06,$3A,$EB,$66	; Fill vert 6 tiles with $3A at $66EB
	DEFB	$02,$07,$63,$53,$66	; Fill horz 7 tiles with $63 at $6653
	DEFB	$01,$07,$3A,$19,$66	; Fill vert 7 tiles with $3A at $6619
	DEFB	$0E,$63,$55,$66		; Put tile $63 at $6655
	DEFB	$02,$04,$FA,$A2,$66	; Fill horz 4 tiles with $FA at $66A2
	DEFB	$02,$0A,$FA,$DA,$66	; Fill horz 10 tiles with $FA at $66DA
	DEFB	$02,$03,$FA,$04,$67	; Fill horz 3 tiles with $FA at $6704
L88EB:	DEFB	$02,$0B,$FA,$5F,$67	; Fill horz 11 tiles with $FA at $675F
	DEFB	$02,$06,$FA,$98,$66	; Fill horz 6 tiles with $FA at $6698
	DEFB	$02,$03,$FA,$4F,$67	; Fill horz 3 tiles with $FA at $674F
	DEFB	$02,$06,$FA,$6A,$67	; Fill horz 6 tiles with $FA at $676A
	DEFB	$05,$01,$01,$99,$88,$A4,$66	; Block 1x1 tiles from 8899 to $66A4
	DEFB	$05,$01,$04,$98,$88,$C2,$66	; Block 1x4 tiles from 8898 to $66C2
	DEFB	$FF	; End of sequence

; Room 890E
L890E:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L8834	; Room to Left
	DEFW	L8BF0	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$01,$10,$3A,$99,$65	; Fill vert 16 tiles with $3A at $6599
	DEFB	$01,$10,$3A,$A1,$65	; Fill vert 16 tiles with $3A at $65A1
	DEFB	$01,$07,$3A,$B6,$66	; Fill vert 7 tiles with $3A at $66B6
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$05,$03,$03,$18,$7C,$12,$71	; Block 3x3 tiles from 7C18 to $7112
	DEFB	$02,$05,$63,$19,$66	; Fill horz 5 tiles with $63 at $6619
	DEFB	$02,$03,$FA,$AE,$66	; Fill horz 3 tiles with $FA at $66AE
	DEFB	$02,$07,$FA,$97,$66	; Fill horz 7 tiles with $FA at $6697
	DEFB	$02,$09,$FA,$84,$66	; Fill horz 9 tiles with $FA at $6684
	DEFB	$01,$07,$F9,$F3,$65	; Fill vert 7 tiles with $F9 at $65F3
	DEFB	$0E,$F8,$89,$66		; Put tile $F8 at $6689
	DEFB	$FF	; End of sequence

; Room 8953
L8953:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	L889F	; Room to Right
	DEFW	L89B9	; Room Up
	DEFW	L8799	; Room Down
	DEFB	$01,$11,$3A,$98,$65	; Fill vert 17 tiles with $3A at $6598
	DEFB	$01,$10,$3A,$9D,$65	; Fill vert 16 tiles with $3A at $659D
	DEFB	$01,$05,$3A,$A0,$65	; Fill vert 5 tiles with $3A at $65A0
	DEFB	$01,$09,$3A,$A3,$65	; Fill vert 9 tiles with $3A at $65A3
	DEFB	$01,$11,$3A,$AB,$65	; Fill vert 17 tiles with $3A at $65AB
	DEFB	$01,$07,$3A,$CD,$66	; Fill vert 7 tiles with $3A at $66CD
	DEFB	$01,$07,$3A,$D0,$66	; Fill vert 7 tiles with $3A at $66D0
	DEFB	$01,$02,$3A,$69,$67	; Fill vert 2 tiles with $3A at $6769
	DEFB	$0C,$E3,$81,$02,$11,$90,$65	; Block 2 tiles from 81E3 to $6590 copy 17 times
	DEFB	$0C,$48,$73,$02,$09,$95,$65	; Block 2 tiles from 7348 to $6595 copy 9 times
	DEFB	$02,$05,$63,$33,$66	; Fill horz 5 tiles with $63 at $6633
	DEFB	$02,$07,$FA,$A0,$66	; Fill horz 7 tiles with $FA at $66A0
	DEFB	$02,$08,$FA,$54,$67	; Fill horz 8 tiles with $FA at $6754
	DEFB	$02,$03,$FA,$7C,$67	; Fill horz 3 tiles with $FA at $677C
	DEFB	$02,$05,$FA,$AE,$66	; Fill horz 5 tiles with $FA at $66AE
	DEFB	$02,$06,$FA,$47,$67	; Fill horz 6 tiles with $FA at $6747
L89B3:	DEFB	$02,$17,$FA,$E1,$66	; Fill horz 23 tiles with $FA at $66E1
	DEFB	$FF	; End of sequence

; Room 89B9
L89B9:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	L8A2D	; Room to Right
	DEFW	$0000
	DEFW	L8953	; Room Down
	DEFB	$0E,$3A,$B6,$66		; Put tile $3A at $66B6
	DEFB	$0E,$3A,$2A,$67		; Put tile $3A at $672A
	DEFB	$01,$08,$3A,$AB,$66	; Fill vert 8 tiles with $3A at $66AB
	DEFB	$01,$08,$3A,$B9,$66	; Fill vert 8 tiles with $3A at $66B9
	DEFB	$01,$02,$3A,$62,$67	; Fill vert 2 tiles with $3A at $6762
	DEFB	$01,$02,$3A,$65,$67	; Fill vert 2 tiles with $3A at $6765
	DEFB	$06,$FF,$0B,$90,$65	; Triangle with $FF, count=11 at $6590
	DEFB	$02,$13,$FF,$9B,$65	; Fill horz 19 tiles with $FF at $659B
	DEFB	$0C,$E3,$81,$02,$08,$9E,$66	; Block 2 tiles from 81E3 to $669E copy 8 times
	DEFB	$0C,$48,$73,$02,$0B,$2B,$66	; Block 2 tiles from 7348 to $662B copy 11 times
	DEFB	$05,$02,$01,$9D,$88,$75,$67	; Block 2x1 tiles from 889D to $6775
L8A00:	DEFB	$02,$0B,$FA,$77,$67	; Fill horz 11 tiles with $FA at $6777
	DEFB	$02,$04,$FA,$8B,$66	; Fill horz 4 tiles with $FA at $668B
	DEFB	$02,$05,$FA,$44,$67	; Fill horz 5 tiles with $FA at $6744
	DEFB	$02,$08,$FA,$96,$66	; Fill horz 8 tiles with $FA at $6696
	DEFB	$05,$01,$04,$98,$88,$F0,$66	; Block 1x4 tiles from 8898 to $66F0
	DEFB	$05,$01,$03,$98,$88,$D4,$66	; Block 1x3 tiles from 8898 to $66D4
	DEFB	$02,$02,$FA,$F0,$66	; Fill horz 2 tiles with $FA at $66F0
	DEFB	$02,$03,$FA,$0B,$67	; Fill horz 3 tiles with $FA at $670B
	DEFB	$FF	; End of sequence

; Room 8A2D
L8A2D:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L89B9	; Room to Left
	DEFW	L8A81	; Room to Right
	DEFW	L8B25	; Room Up
	DEFW	L889F	; Room Down
	DEFB	$01,$08,$3A,$A2,$66	; Fill vert 8 tiles with $3A at $66A2
	DEFB	$01,$08,$3A,$AD,$66	; Fill vert 8 tiles with $3A at $66AD
	DEFB	$01,$08,$3A,$B1,$66	; Fill vert 8 tiles with $3A at $66B1
	DEFB	$01,$05,$3A,$04,$67	; Fill vert 5 tiles with $3A at $6704
	DEFB	$02,$03,$FF,$90,$65	; Fill horz 3 tiles with $FF at $6590
L8A52:	DEFB	$02,$0F,$FA,$80,$66	; Fill horz 15 tiles with $FA at $6680
	DEFB	$02,$05,$FA,$8F,$66	; Fill horz 5 tiles with $FA at $668F
	DEFB	$0C,$48,$73,$02,$08,$A1,$65	; Block 2 tiles from 7348 to $65A1 copy 8 times
	DEFB	$02,$08,$FA,$55,$67	; Fill horz 8 tiles with $FA at $6755
	DEFB	$02,$05,$FA,$E2,$66	; Fill horz 5 tiles with $FA at $66E2
	DEFB	$02,$04,$FA,$86,$67	; Fill horz 4 tiles with $FA at $6786
	DEFB	$05,$01,$03,$99,$88,$E3,$66	; Block 1x3 tiles from 8899 to $66E3
	DEFB	$05,$01,$03,$98,$88,$3D,$67	; Block 1x3 tiles from 8898 to $673D
	DEFB	$FF	; End of sequence

; Room 8A81
L8A81:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L8A2D	; Room to Left
	DEFW	L8AF4	; Room to Right
	DEFW	$0000
	DEFW	L8834	; Room Down
	DEFB	$01,$06,$3A,$E1,$66	; Fill vert 6 tiles with $3A at $66E1
	DEFB	$01,$0C,$3A,$33,$66	; Fill vert 12 tiles with $3A at $6633
	DEFB	$01,$05,$3A,$0A,$67	; Fill vert 5 tiles with $3A at $670A
	DEFB	$09,$FF,$04,$A7,$65	; Triangle with $FF, count=4 at $65A7
	DEFB	$06,$FF,$04,$A8,$65	; Triangle with $FF, count=4 at $65A8
	DEFB	$0C,$48,$73,$02,$0E,$01,$66	; Block 2 tiles from 7348 to $6601 copy 14 times
	DEFB	$05,$02,$01,$9D,$88,$F1,$66	; Block 2x1 tiles from 889D to $66F1
	DEFB	$05,$02,$01,$9D,$88,$4B,$67	; Block 2x1 tiles from 889D to $674B
	DEFB	$02,$05,$FA,$4D,$67	; Fill horz 5 tiles with $FA at $674D
	DEFB	$02,$06,$FA,$EB,$66	; Fill horz 6 tiles with $FA at $66EB
	DEFB	$02,$03,$FA,$C1,$66	; Fill horz 3 tiles with $FA at $66C1
	DEFB	$01,$04,$28,$0E,$71	; Fill vert 4 tiles with $28 at $710E
	DEFB	$02,$0B,$FA,$B8,$65	; Fill horz 11 tiles with $FA at $65B8
	DEFB	$05,$01,$05,$98,$88,$9D,$65	; Block 1x5 tiles from 8898 to $659D
	DEFB	$02,$03,$FA,$FF,$66	; Fill horz 3 tiles with $FA at $66FF
	DEFB	$02,$06,$FA,$1F,$67	; Fill horz 6 tiles with $FA at $671F
	DEFB	$05,$01,$04,$99,$88,$1E,$67	; Block 1x4 tiles from 8899 to $671E
	DEFB	$05,$01,$02,$98,$88,$E2,$66	; Block 1x2 tiles from 8898 to $66E2
	DEFB	$FF	; End of sequence

; Room 8AF4
L8AF4:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L8A81	; Room to Left
	DEFW	L8C5A	; Room to Right
	DEFW	L8BAB	; Room Up
	DEFW	L890E	; Room Down
	DEFB	$01,$08,$3A,$A7,$66	; Fill vert 8 tiles with $3A at $66A7
	DEFB	$01,$08,$3A,$AF,$66	; Fill vert 8 tiles with $3A at $66AF
	DEFB	$02,$0B,$FA,$34,$67	; Fill horz 11 tiles with $FA at $6734
	DEFB	$02,$13,$FA,$88,$66	; Fill horz 19 tiles with $FA at $6688
	DEFB	$0C,$48,$73,$02,$08,$A4,$65	; Block 2 tiles from 7348 to $65A4 copy 8 times
	DEFB	$01,$06,$F9,$8E,$66	; Fill vert 6 tiles with $F9 at $668E
	DEFB	$0E,$F8,$8E,$66		; Put tile $F8 at $668E
	DEFB	$FF	; End of sequence

; Room 8B25
L8B25:	DEFW	LB483	; Room procedure
	DEFW	LA174	; Initialization
	DEFW	$0000
	DEFW	L8B71	; Room to Right
	DEFW	$0000
	DEFW	L8A2D	; Room Down
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$02,$48,$FF,$90,$65	; Fill horz 72 tiles with $FF at $6590
	DEFB	$0C,$48,$73,$02,$0E,$DD,$65	; Block 2 tiles from 7348 to $65DD copy 14 times
	DEFB	$05,$02,$01,$84,$79,$81,$67	; Block 2x1 tiles from 7984 to $6781
	DEFB	$05,$04,$04,$A9,$71,$F7,$70	; Block 4x4 tiles from 71A9 to $70F7
	DEFB	$05,$04,$04,$A9,$71,$F5,$70	; Block 4x4 tiles from 71A9 to $70F5
	DEFB	$05,$04,$04,$A9,$71,$F0,$70	; Block 4x4 tiles from 71A9 to $70F0
	DEFB	$05,$04,$04,$A9,$71,$07,$71	; Block 4x4 tiles from 71A9 to $7107
	DEFB	$06,$FF,$0B,$EA,$65	; Triangle with $FF, count=11 at $65EA
	DEFB	$03,$FF,$03,$04,$F8,$66	; Rectangle 3x4 tiles with $FF at $66F8
	DEFB	$FF	; End of sequence

; Room 8B71
L8B71:	DEFW	L7918	; Room procedure
	DEFW	LA0FC	; Initialization
	DEFW	L8B25	; Room to Left
	DEFW	L8BAB	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$02,$3C,$FF,$90,$65	; Fill horz 60 tiles with $FF at $6590
	DEFB	$05,$04,$04,$A9,$71,$EF,$70	; Block 4x4 tiles from 71A9 to $70EF
	DEFB	$05,$04,$04,$A9,$71,$F5,$70	; Block 4x4 tiles from 71A9 to $70F5
	DEFB	$05,$04,$04,$A9,$71,$FB,$70	; Block 4x4 tiles from 71A9 to $70FB
	DEFB	$05,$04,$04,$A9,$71,$00,$71	; Block 4x4 tiles from 71A9 to $7100
	DEFB	$05,$04,$04,$A9,$71,$07,$71	; Block 4x4 tiles from 71A9 to $7107
	DEFB	$FF	; End of sequence

; Room 8BAB
L8BAB:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L8B71	; Room to Left
	DEFW	$0000
	DEFW	$0000
	DEFW	L8AF4	; Room Down
	DEFB	$02,$3C,$FF,$90,$65	; Fill horz 60 tiles with $FF at $6590
	DEFB	$03,$FF,$02,$0E,$E8,$65	; Rectangle 2x14 tiles with $FF at $65E8
	DEFB	$02,$09,$FF,$70,$67	; Fill horz 9 tiles with $FF at $6770
	DEFB	$02,$10,$FF,$7E,$67	; Fill horz 16 tiles with $FF at $677E
	DEFB	$0C,$48,$73,$02,$0E,$E0,$65	; Block 2 tiles from 7348 to $65E0 copy 14 times
	DEFB	$05,$02,$01,$9D,$88,$84,$67	; Block 2x1 tiles from 889D to $6784
	DEFB	$05,$03,$03,$A0,$71,$1B,$71	; Block 3x3 tiles from 71A0 to $711B
	DEFB	$05,$04,$04,$A9,$71,$F2,$70	; Block 4x4 tiles from 71A9 to $70F2
	DEFB	$05,$04,$04,$A9,$71,$06,$71	; Block 4x4 tiles from 71A9 to $7106
	DEFB	$FF	; End of sequence

; Room 8BF0
L8BF0:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L890E	; Room to Left
	DEFW	L8CC8	; Room to Right
	DEFW	$0000
	DEFW	L9005	; Room Down
	DEFB	$01,$10,$3A,$93,$65	; Fill vert 16 tiles with $3A at $6593
	DEFB	$01,$08,$3A,$98,$65	; Fill vert 8 tiles with $3A at $6598
	DEFB	$01,$08,$3A,$9C,$65	; Fill vert 8 tiles with $3A at $659C
	DEFB	$01,$08,$3A,$A0,$65	; Fill vert 8 tiles with $3A at $65A0
	DEFB	$01,$08,$3A,$A3,$65	; Fill vert 8 tiles with $3A at $65A3
	DEFB	$01,$08,$3A,$A7,$65	; Fill vert 8 tiles with $3A at $65A7
	DEFB	$01,$08,$3A,$AB,$65	; Fill vert 8 tiles with $3A at $65AB
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$03,$FF,$04,$07,$B8,$66	; Rectangle 4x7 tiles with $FF at $66B8
	DEFB	$02,$17,$FF,$87,$66	; Fill horz 23 tiles with $FF at $6687
	DEFB	$0C,$48,$73,$02,$07,$B0,$66	; Block 2 tiles from 7348 to $66B0 copy 7 times
	DEFB	$05,$02,$01,$84,$79,$82,$67	; Block 2x1 tiles from 7984 to $6782
	DEFB	$02,$04,$FA,$80,$66	; Fill horz 4 tiles with $FA at $6680
	DEFB	$0E,$F9,$95,$65		; Put tile $F9 at $6595
	DEFB	$02,$06,$63,$31,$66	; Fill horz 6 tiles with $63 at $6631
	DEFB	$0E,$2A,$9D,$70		; Put tile $2A at $709D
	DEFB	$01,$06,$2B,$BB,$70	; Fill vert 6 tiles with $2B at $70BB
	DEFB	$01,$01,$FF,$89,$66	; Fill vert 1 tiles with $FF at $6689
	DEFB	$FF	; End of sequence

; Room 8C5A
L8C5A:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L8AF4	; Room to Left
	DEFW	L8D18	; Room to Right
	DEFW	$0000
	DEFW	L8BF0	; Room Down
	DEFB	$01,$05,$3A,$DD,$66	; Fill vert 5 tiles with $3A at $66DD
	DEFB	$01,$0D,$3A,$F2,$65	; Fill vert 13 tiles with $3A at $65F2
	DEFB	$01,$0F,$3A,$D8,$65	; Fill vert 15 tiles with $3A at $65D8
	DEFB	$01,$07,$3A,$CC,$66	; Fill vert 7 tiles with $3A at $66CC
	DEFB	$01,$07,$3A,$CF,$66	; Fill vert 7 tiles with $3A at $66CF
	DEFB	$01,$0D,$3A,$1F,$66	; Fill vert 13 tiles with $3A at $661F
	DEFB	$01,$0D,$3A,$23,$66	; Fill vert 13 tiles with $3A at $6623
	DEFB	$09,$FF,$03,$A6,$65	; Triangle with $FF, count=3 at $65A6
	DEFB	$03,$FF,$07,$04,$A7,$65	; Rectangle 7x4 tiles with $FF at $65A7
	DEFB	$02,$0A,$FA,$B3,$65	; Fill horz 10 tiles with $FA at $65B3
	DEFB	$05,$01,$03,$98,$88,$98,$65	; Block 1x3 tiles from 8898 to $6598
	DEFB	$01,$03,$F9,$1B,$67	; Fill vert 3 tiles with $F9 at $671B
	DEFB	$02,$07,$FA,$73,$67	; Fill horz 7 tiles with $FA at $6773
	DEFB	$0E,$F8,$75,$67		; Put tile $F8 at $6775
L8CAE:	DEFB	$02,$0A,$FA,$BD,$66	; Fill horz 10 tiles with $FA at $66BD
	DEFB	$02,$04,$FA,$E5,$66	; Fill horz 4 tiles with $FA at $66E5
	DEFB	$02,$04,$FA,$AE,$66	; Fill horz 4 tiles with $FA at $66AE
	DEFB	$02,$03,$FA,$EF,$66	; Fill horz 3 tiles with $FA at $66EF
	DEFB	$02,$05,$FA,$2F,$67	; Fill horz 5 tiles with $FA at $672F
	DEFB	$FF	; End of sequence

; Room 8CC8
L8CC8:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L8BF0	; Room to Left
	DEFW	L8E9C	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$01,$0C,$3A,$96,$65	; Fill vert 12 tiles with $3A at $6596
	DEFB	$01,$10,$3A,$9E,$65	; Fill vert 16 tiles with $3A at $659E
	DEFB	$01,$10,$3A,$A3,$65	; Fill vert 16 tiles with $3A at $65A3
	DEFB	$01,$10,$3A,$AA,$65	; Fill vert 16 tiles with $3A at $65AA
	DEFB	$07,$FF,$07,$A1,$66	; Triangle with $FF, count=7 at $66A1
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$03,$FF,$03,$08,$80,$66	; Rectangle 3x8 tiles with $FF at $6680
	DEFB	$02,$06,$63,$F5,$65	; Fill horz 6 tiles with $63 at $65F5
	DEFB	$02,$0A,$FA,$92,$66	; Fill horz 10 tiles with $FA at $6692
	DEFB	$05,$04,$07,$AA,$79,$9B,$70	; Block 4x7 tiles from 79AA to $709B
	DEFB	$05,$04,$07,$AA,$79,$3E,$70	; Block 4x7 tiles from 79AA to $703E
	DEFB	$05,$04,$07,$AA,$79,$00,$70	; Block 4x7 tiles from 79AA to $7000
	DEFB	$FF	; End of sequence

; Room 8D18
L8D18:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L8C5A	; Room to Left
	DEFW	L8EE1	; Room to Right
	DEFW	L8D5C	; Room Up
	DEFW	L8CC8	; Room Down
	DEFB	$01,$03,$3A,$3A,$67	; Fill vert 3 tiles with $3A at $673A
	DEFB	$01,$03,$3A,$42,$67	; Fill vert 3 tiles with $3A at $6742
	DEFB	$01,$03,$3A,$4E,$67	; Fill vert 3 tiles with $3A at $674E
	DEFB	$01,$11,$3A,$A3,$65	; Fill vert 17 tiles with $3A at $65A3
	DEFB	$03,$FF,$0A,$04,$90,$65	; Rectangle 10x4 tiles with $FF at $6590
	DEFB	$0C,$48,$73,$02,$0D,$9A,$65	; Block 2 tiles from 7348 to $659A copy 13 times
L8D45:	DEFB	$02,$12,$FA,$16,$67	; Fill horz 18 tiles with $FA at $6716
	DEFB	$02,$06,$FA,$2E,$67	; Fill horz 6 tiles with $FA at $672E
	DEFB	$02,$05,$63,$74,$66	; Fill horz 5 tiles with $63 at $6674
	DEFB	$05,$02,$04,$BB,$71,$A1,$70	; Block 2x4 tiles from 71BB to $70A1
	DEFB	$FF	; End of sequence

; Room 8D5C
L8D5C:	DEFW	LB483	; Room procedure
	DEFW	LA1A1	; Initialization
	DEFW	L8DCA	; Room to Left
	DEFW	$0000
	DEFW	$0000
	DEFW	L8D18	; Room Down
	DEFB	$04,$01	; Fill entire screen with $01
	DEFB	$02,$3E,$FF,$90,$65	; Fill horz 62 tiles with $FF at $6590
	DEFB	$03,$FF,$02,$04,$EA,$65	; Rectangle 2x4 tiles with $FF at $65EA
	DEFB	$02,$04,$FF,$62,$66	; Fill horz 4 tiles with $FF at $6662
	DEFB	$09,$FF,$07,$E4,$65	; Triangle with $FF, count=7 at $65E4
	DEFB	$03,$FF,$05,$0C,$E5,$65	; Rectangle 5x12 tiles with $FF at $65E5
	DEFB	$02,$41,$FF,$4D,$67	; Fill horz 65 tiles with $FF at $674D
	DEFB	$05,$02,$02,$84,$79,$5C,$67	; Block 2x2 tiles from 7984 to $675C
	DEFB	$05,$03,$03,$A0,$71,$F2,$70	; Block 3x3 tiles from 71A0 to $70F2
	DEFB	$05,$03,$03,$A0,$71,$A3,$70	; Block 3x3 tiles from 71A0 to $70A3
	DEFB	$05,$03,$03,$A0,$71,$A7,$70	; Block 3x3 tiles from 71A0 to $70A7
	DEFB	$05,$03,$03,$A0,$71,$FC,$70	; Block 3x3 tiles from 71A0 to $70FC
	DEFB	$05,$03,$03,$A0,$71,$FF,$70	; Block 3x3 tiles from 71A0 to $70FF
	DEFB	$05,$03,$03,$A0,$71,$03,$71	; Block 3x3 tiles from 71A0 to $7103
L8DBB:	DEFB	$01,$01,$FF,$64,$66	; Fill vert 1 tiles with $FF at $6664
	DEFB	$0E,$2A,$78,$70		; Put tile $2A at $7078
	DEFB	$01,$06,$2B,$96,$70	; Fill vert 6 tiles with $2B at $7096
	DEFB	$FF	; End of sequence

; Room 8DCA (helicopter)
L8DCA:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	L8D5C	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$04,$01	; Fill entire screen with $01
	DEFB	$02,$3F,$FF,$90,$65	; Fill horz 63 tiles with $FF at $6590
	DEFB	$03,$FF,$02,$0D,$EA,$65	; Rectangle 2x13 tiles with $FF at $65EA
	DEFB	$02,$25,$FF,$69,$67	; Fill horz 37 tiles with $FF at $6769
	DEFB	$02,$0A,$91,$5A,$67	; Fill horz 10 tiles with $91 at $675A
	DEFB	$02,$17,$01,$93,$65	; Fill horz 23 tiles with $01 at $6593
	DEFB	$02,$1B,$E2,$AF,$65	; Fill horz 27 tiles with $E2 at $65AF
	DEFB	$0E,$FF,$E6,$65		; Put tile $FF at $65E6
	DEFB	$03,$FF,$03,$06,$E7,$65	; Rectangle 3x6 tiles with $FF at $65E7
	DEFB	$0E,$2A,$91,$70		; Put tile $2A at $7091
	DEFB	$01,$06,$2B,$AF,$70	; Fill vert 6 tiles with $2B at $70AF
	DEFB	$05,$04,$07,$47,$8E,$63,$70	; Block 4x7 tiles from 8E47 to $7063
	DEFB	$05,$02,$06,$6C,$8E,$89,$66	; Block 2x6 tiles from 8E6C to $6689
	DEFB	$05,$05,$01,$67,$8E,$3E,$67	; Block 5x1 tiles from 8E67 to $673E
	DEFB	$05,$01,$02,$63,$8E,$06,$67	; Block 1x2 tiles from 8E63 to $6706
	DEFB	$05,$03,$08,$78,$8E,$71,$66	; Block 3x8 tiles from 8E78 to $6671
	DEFB	$02,$11,$D4,$2C,$66	; Fill horz 17 tiles with $D4 at $662C
	DEFB	$05,$01,$02,$65,$8E,$34,$66	; Block 1x2 tiles from 8E65 to $6634
	DEFB	$05,$03,$04,$90,$8E,$56,$66	; Block 3x4 tiles from 8E90 to $6656
	DEFB	$03,$1B,$04,$04,$8B,$66	; Rectangle 4x4 tiles with $1B at $668B
	DEFB	$FF	; End of sequence

; Blocks for rooms
L8E47:	DEFB	$64,$65,$5A,$5A	; Front block 4x7
	DEFB	$5B,$FF,$5C,$63
	DEFB	$FF,$FF,$FF,$62
	DEFB	$5A,$5A,$61,$62
	DEFB	$5A,$5A,$5A,$60
	DEFB	$5A,$5A,$5A,$5F
	DEFB	$5D,$5A,$5A,$5E
L8E63:	DEFB	$23		; Block 1x2
	DEFB	$24
L8E65:	DEFB	$D3		; Block 1x2
	DEFB	$D2
L8E67:	DEFB	$E0,$D9,$D8,$D5,$E0	; Back block 5x1
L8E6C:	DEFB	$01,$DA		; Back block 2x6
	DEFB	$DC,$DB
	DEFB	$DD,$D7
	DEFB	$DE,$D6
	DEFB	$DF,$D6
	DEFB	$01,$E1
L8E78:	DEFB	$2F,$30,$01	; Back block 3x8
	DEFB	$2E,$28,$31
	DEFB	$2D,$28,$28
	DEFB	$2B,$28,$2C
	DEFB	$28,$28,$2A
	DEFB	$28,$29,$01
	DEFB	$27,$01,$01
	DEFB	$25,$26,$01
L8E90:	DEFB	$36,$01,$01	; Back block 3x4
	DEFB	$34,$35,$37
	DEFB	$28,$28,$01
	DEFB	$32,$33,$01

; Room 8E9C
L8E9C:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L8CC8	; Room to Left
	DEFW	$0000
	DEFW	L8EE1	; Room Up
	DEFW	L8F20	; Room Down
	DEFB	$01,$10,$3A,$91,$65	; Fill vert 16 tiles with $3A at $6591
	DEFB	$01,$10,$3A,$99,$65	; Fill vert 16 tiles with $3A at $6599
	DEFB	$01,$10,$3A,$9C,$65	; Fill vert 16 tiles with $3A at $659C
	DEFB	$01,$06,$3A,$C1,$66	; Fill vert 6 tiles with $3A at $66C1
	DEFB	$01,$07,$3A,$CF,$66	; Fill vert 7 tiles with $3A at $66CF
	DEFB	$01,$07,$3A,$D3,$66	; Fill vert 7 tiles with $3A at $66D3
	DEFB	$02,$0E,$FF,$70,$67	; Fill horz 14 tiles with $FF at $6770
	DEFB	$02,$08,$FA,$A1,$66	; Fill horz 8 tiles with $FA at $66A1
	DEFB	$02,$06,$FA,$B1,$66	; Fill horz 6 tiles with $FA at $66B1
	DEFB	$02,$04,$FA,$45,$67	; Fill horz 4 tiles with $FA at $6745
	DEFB	$03,$FF,$02,$11,$AC,$65	; Rectangle 2x17 tiles with $FF at $65AC
	DEFB	$FF	; End of sequence

; Room 8EE1
L8EE1:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L8D18	; Room to Left
	DEFW	$0000
	DEFW	$0000
	DEFW	L8E9C	; Room Down
	DEFB	$01,$03,$3A,$35,$67	; Fill vert 3 tiles with $3A at $6735
	DEFB	$01,$0F,$3A,$D5,$65	; Fill vert 15 tiles with $3A at $65D5
	DEFB	$0E,$3A,$7C,$67		; Put tile $3A at $677C
	DEFB	$0E,$FF,$93,$65		; Put tile $FF at $6593
	DEFB	$03,$FF,$1A,$02,$94,$65	; Rectangle 26x2 tiles with $FF at $6594
	DEFB	$03,$FF,$02,$0F,$E8,$65	; Rectangle 2x15 tiles with $FF at $65E8
	DEFB	$09,$FF,$07,$E7,$65	; Triangle with $FF, count=7 at $65E7
	DEFB	$02,$04,$FA,$16,$67	; Fill horz 4 tiles with $FA at $6716
	DEFB	$02,$07,$FA,$5B,$67	; Fill horz 7 tiles with $FA at $675B
	DEFB	$02,$04,$63,$E0,$66	; Fill horz 4 tiles with $63 at $66E0
	DEFB	$FF	; End of sequence

; Room 8F20
L8F20:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L8FBD	; Room to Left
	DEFW	$0000
	DEFW	L8E9C	; Room Up
	DEFW	L8F84	; Room Down
	DEFB	$02,$0E,$FF,$90,$65	; Fill horz 14 tiles with $FF at $6590
L8F31:	DEFB	$01,$01,$FF,$96,$65	; Fill vert 1 tiles with $FF at $6596
	DEFB	$0E,$2A,$AA,$6F		; Put tile $2A at $6FAA
	DEFB	$0E,$2A,$AF,$6F		; Put tile $2A at $6FAF
	DEFB	$01,$07,$2B,$C8,$6F	; Fill vert 7 tiles with $2B at $6FC8
	DEFB	$01,$07,$2B,$CD,$6F	; Fill vert 7 tiles with $2B at $6FCD
	DEFB	$03,$FF,$02,$09,$AC,$65	; Rectangle 2x9 tiles with $FF at $65AC
	DEFB	$03,$FF,$1E,$08,$9E,$66	; Rectangle 30x8 tiles with $FF at $669E
	DEFB	$05,$02,$02,$84,$79,$6A,$67	; Block 2x2 tiles from 7984 to $676A
	DEFB	$03,$00,$08,$06,$B2,$66	; Rectangle 8x6 tiles with $00 at $66B2
	DEFB	$09,$00,$05,$B1,$66	; Triangle with $00, count=5 at $66B1
	DEFB	$05,$04,$07,$AA,$79,$87,$70	; Block 4x7 tiles from 79AA to $7087
	DEFB	$05,$04,$07,$AA,$79,$2A,$70	; Block 4x7 tiles from 79AA to $702A
	DEFB	$01,$0E,$3A,$A3,$65	; Fill vert 14 tiles with $3A at $65A3
	DEFB	$01,$0F,$3A,$A7,$65	; Fill vert 15 tiles with $3A at $65A7
	DEFB	$02,$05,$FA,$97,$66	; Fill horz 5 tiles with $FA at $6697
	DEFB	$FF	; End of sequence

; Room 8F84
L8F84:	DEFW	L7918	; Room procedure
	DEFW	LA0F7	; Initialization
	DEFW	L9053	; Room to Left
	DEFW	$0000
	DEFW	L8F20	; Room Up
	DEFW	L91BA	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$00,$1C,$08,$26,$66	; Rectangle 28x8 tiles with $00 at $6626
	DEFB	$08,$00,$04,$C5,$65	; Triangle with $00, count=4 at $65C5
	DEFB	$03,$00,$02,$03,$E6,$65	; Rectangle 2x3 tiles with $00 at $65E6
	DEFB	$0E,$00,$C8,$65		; Put tile $00 at $65C8
	DEFB	$05,$02,$04,$BB,$71,$A2,$70	; Block 2x4 tiles from 71BB to $70A2
	DEFB	$0C,$48,$73,$02,$0D,$A8,$65	; Block 2 tiles from 7348 to $65A8 copy 13 times
	DEFB	$05,$02,$04,$84,$79,$2A,$67	; Block 2x4 tiles from 7984 to $672A
	DEFB	$FF	; End of sequence

; Room 8FBD
L8FBD:	DEFW	LB483	; Room procedure
	DEFW	LA16A	; Initialization
	DEFW	L9005	; Room to Left
	DEFW	L8F20	; Room to Right
	DEFW	$0000
	DEFW	L9053	; Room Down
	DEFB	$03,$FF,$1E,$08,$9E,$66	; Rectangle 30x8 tiles with $FF at $669E
	DEFB	$03,$39,$07,$07,$C5,$66	; Rectangle 7x7 tiles with $39 at $66C5
	DEFB	$02,$05,$38,$A8,$66	; Fill horz 5 tiles with $38 at $66A8
	DEFB	$02,$06,$FF,$90,$65	; Fill horz 6 tiles with $FF at $6590
	DEFB	$02,$04,$FF,$AA,$65	; Fill horz 4 tiles with $FF at $65AA
	DEFB	$0E,$2A,$A5,$6F		; Put tile $2A at $6FA5
	DEFB	$0E,$2A,$BF,$6F		; Put tile $2A at $6FBF
	DEFB	$01,$07,$2B,$C3,$6F	; Fill vert 7 tiles with $2B at $6FC3
	DEFB	$01,$07,$2B,$DD,$6F	; Fill vert 7 tiles with $2B at $6FDD
	DEFB	$05,$02,$04,$BB,$71,$1F,$70	; Block 2x4 tiles from 71BB to $701F
	DEFB	$05,$02,$04,$BB,$71,$31,$70	; Block 2x4 tiles from 71BB to $7031
	DEFB	$FF	; End of sequence

; Room 9005
L9005:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L92A7	; Room to Left
	DEFW	L8FBD	; Room to Right
	DEFW	L8BF0	; Room Up
	DEFW	$0000
	DEFB	$02,$1E,$FF,$90,$65	; Fill horz 30 tiles with $FF at $6590
	DEFB	$05,$02,$04,$BB,$71,$33,$70	; Block 2x4 tiles from 71BB to $7033
	DEFB	$0C,$48,$73,$02,$08,$C0,$65	; Block 2 tiles from 7348 to $65C0 copy 8 times
	DEFB	$05,$02,$01,$84,$79,$A2,$65	; Block 2x1 tiles from 7984 to $65A2
	DEFB	$0E,$2A,$B1,$6F		; Put tile $2A at $6FB1
	DEFB	$01,$07,$2B,$CF,$6F	; Fill vert 7 tiles with $2B at $6FCF
	DEFB	$03,$FF,$13,$05,$A9,$66	; Rectangle 19x5 tiles with $FF at $66A9
	DEFB	$02,$4F,$FF,$3F,$67	; Fill horz 79 tiles with $FF at $673F
	DEFB	$08,$FF,$05,$C6,$66	; Triangle with $FF, count=5 at $66C6
	DEFB	$05,$04,$07,$8E,$79,$7B,$70	; Block 4x7 tiles from 798E to $707B
	DEFB	$05,$04,$07,$8E,$79,$24,$70	; Block 4x7 tiles from 798E to $7024
	DEFB	$FF	; End of sequence

; Room 9053
L9053:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L909F	; Room to Left
	DEFW	L8F84	; Room to Right
	DEFW	L8FBD	; Room Up
	DEFW	L90DB	; Room Down
	DEFB	$03,$FF,$1E,$09,$90,$65	; Rectangle 30x9 tiles with $FF at $6590
	DEFB	$03,$00,$0A,$04,$3A,$66	; Rectangle 10x4 tiles with $00 at $663A
	DEFB	$02,$27,$FF,$67,$67	; Fill horz 39 tiles with $FF at $6767
	DEFB	$02,$04,$FF,$30,$67	; Fill horz 4 tiles with $FF at $6730
	DEFB	$02,$06,$FF,$4C,$67	; Fill horz 6 tiles with $FF at $674C
L907A:	DEFB	$05,$02,$04,$BB,$71,$F1,$70	; Block 2x4 tiles from 71BB to $70F1
	DEFB	$05,$02,$04,$BB,$71,$E5,$70	; Block 2x4 tiles from 71BB to $70E5
	DEFB	$03,$39,$07,$08,$99,$65	; Rectangle 7x8 tiles with $39 at $6599
	DEFB	$03,$39,$04,$07,$A7,$66	; Rectangle 4x7 tiles with $39 at $66A7
	DEFB	$02,$04,$38,$79,$67	; Fill horz 4 tiles with $38 at $6779
	DEFB	$02,$04,$38,$89,$66	; Fill horz 4 tiles with $38 at $6689
	DEFB	$FF	; End of sequence

; Room 909F
L909F:	DEFW	LB47A	; Room procedure
	DEFW	LA15F	; Initialization
	DEFW	L92EF	; Room to Left
	DEFW	L9053	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$02,$1E,$FF,$90,$65	; Fill horz 30 tiles with $FF at $6590
	DEFB	$09,$FF,$08,$CB,$65	; Triangle with $FF, count=8 at $65CB
	DEFB	$03,$FF,$05,$09,$62,$66	; Rectangle 5x9 tiles with $FF at $6662
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$07,$FF,$08,$85,$66	; Triangle with $FF, count=8 at $6685
	DEFB	$05,$04,$07,$AA,$79,$9E,$70	; Block 4x7 tiles from 79AA to $709E
	DEFB	$05,$04,$07,$AA,$79,$41,$70	; Block 4x7 tiles from 79AA to $7041
	DEFB	$05,$04,$07,$AA,$79,$E4,$6F	; Block 4x7 tiles from 79AA to $6FE4
	DEFB	$FF	; End of sequence

; Room 90DB
L90DB:	DEFW	LB452	; Room procedure
	DEFW	LA370	; Initialization
	DEFW	L913F	; Room to Left
	DEFW	L91BA	; Room to Right
	DEFW	L9053	; Room Up
	DEFW	$0000
	DEFB	$04,$FF	; Fill entire screen with $FF
	DEFB	$03,$00,$16,$06,$D4,$65	; Rectangle 22x6 tiles with $00 at $65D4
	DEFB	$02,$0C,$00,$C0,$65	; Fill horz 12 tiles with $00 at $65C0
	DEFB	$06,$00,$07,$92,$66	; Triangle with $00, count=7 at $6692
	DEFB	$03,$00,$12,$06,$9E,$66	; Rectangle 18x6 tiles with $00 at $669E
	DEFB	$02,$04,$39,$99,$65	; Fill horz 4 tiles with $39 at $6599
	DEFB	$02,$04,$38,$B7,$65	; Fill horz 4 tiles with $38 at $65B7
	DEFB	$05,$03,$03,$18,$7C,$F5,$70	; Block 3x3 tiles from 7C18 to $70F5
	DEFB	$05,$03,$03,$18,$7C,$F9,$70	; Block 3x3 tiles from 7C18 to $70F9
	DEFB	$0E,$2A,$95,$70		; Put tile $2A at $7095
	DEFB	$01,$05,$2B,$B3,$70	; Fill vert 5 tiles with $2B at $70B3
	DEFB	$0E,$2A,$A4,$70		; Put tile $2A at $70A4
	DEFB	$01,$05,$2B,$C2,$70	; Fill vert 5 tiles with $2B at $70C2
	DEFB	$05,$04,$07,$8E,$79,$88,$70	; Block 4x7 tiles from 798E to $7088
	DEFB	$05,$04,$07,$8E,$79,$31,$70	; Block 4x7 tiles from 798E to $7031
	DEFB	$05,$04,$07,$8E,$79,$14,$70	; Block 4x7 tiles from 798E to $7014
	DEFB	$FF	; End of sequence

; Room 913F
L913F:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	L90DB	; Room to Right
	DEFW	$0000
	DEFW	L83ED	; Room Down
	DEFB	$09,$FF,$09,$AD,$65	; Triangle with $FF, count=9 at $65AD
	DEFB	$02,$27,$FF,$67,$67	; Fill horz 39 tiles with $FF at $6767
	DEFB	$02,$05,$FF,$90,$65	; Fill horz 5 tiles with $FF at $6590
	DEFB	$03,$FF,$03,$03,$AE,$65	; Rectangle 3x3 tiles with $FF at $65AE
	DEFB	$01,$0C,$EB,$09,$66	; Fill vert 12 tiles with $EB at $6609
	DEFB	$05,$02,$01,$84,$79,$79,$67	; Block 2x1 tiles from 7984 to $6779
	DEFB	$05,$03,$03,$A0,$71,$0E,$71	; Block 3x3 tiles from 71A0 to $710E
	DEFB	$05,$03,$03,$18,$7C,$11,$71	; Block 3x3 tiles from 7C18 to $7111
	DEFB	$05,$02,$01,$8A,$7E,$4E,$71	; Block 2x1 tiles from 7E8A to $714E
	DEFB	$05,$03,$04,$0C,$7C,$FE,$70	; Block 3x4 tiles from 7C0C to $70FE
	DEFB	$05,$03,$01,$87,$7E,$3A,$71	; Block 3x1 tiles from 7E87 to $713A
	DEFB	$05,$03,$01,$87,$7E,$56,$71	; Block 3x1 tiles from 7E87 to $7156
	DEFB	$05,$02,$01,$8A,$7E,$37,$71	; Block 2x1 tiles from 7E8A to $7137
	DEFB	$05,$02,$01,$8A,$7E,$54,$71	; Block 2x1 tiles from 7E8A to $7154
	DEFB	$05,$02,$01,$8A,$7E,$5A,$71	; Block 2x1 tiles from 7E8A to $715A
	DEFB	$05,$02,$01,$8A,$7E,$40,$71	; Block 2x1 tiles from 7E8A to $7140
	DEFB	$05,$02,$01,$8A,$7E,$43,$71	; Block 2x1 tiles from 7E8A to $7143
	DEFB	$FF	; End of sequence

; Room 91BA
L91BA:	DEFW	LB452	; Room procedure
	DEFW	LA36B	; Initialization
	DEFW	L90DB	; Room to Left
	DEFW	$0000
	DEFW	L8F84	; Room Up
	DEFW	L924E	; Room Down
	DEFB	$02,$04,$FF,$90,$65	; Fill horz 4 tiles with $FF at $6590
	DEFB	$0E,$2A,$A5,$6F		; Put tile $2A at $6FA5
	DEFB	$01,$07,$2B,$C3,$6F	; Fill vert 7 tiles with $2B at $6FC3
	DEFB	$03,$FF,$04,$03,$9E,$66	; Rectangle 4x3 tiles with $FF at $669E
	DEFB	$02,$98,$FF,$F6,$66	; Fill horz 152 tiles with $FF at $66F6
	DEFB	$0C,$E3,$81,$02,$0B,$AC,$65	; Block 2 tiles from 81E3 to $65AC copy 11 times
	DEFB	$07,$FF,$02,$C0,$66	; Triangle with $FF, count=2 at $66C0
	DEFB	$0C,$48,$73,$02,$0C,$A4,$65	; Block 2 tiles from 7348 to $65A4 copy 12 times
	DEFB	$05,$02,$05,$84,$79,$0C,$67	; Block 2x5 tiles from 7984 to $670C
	DEFB	$05,$03,$03,$18,$7C,$9B,$70	; Block 3x3 tiles from 7C18 to $709B
	DEFB	$00,$9F,$70		; Barrel 3x3 tiles at $709F
	DEFB	$00,$A2,$70		; Barrel 3x3 tiles at $70A2
	DEFB	$00,$AD,$70		; Barrel 3x3 tiles at $70AD
	DEFB	$FF	; End of sequence

; Room 920A
L920A:	DEFW	L7918	; Room procedure
	DEFW	LA0F2	; Initialization
	DEFW	L83ED	; Room to Left
	DEFW	L924E	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$05,$03,$04,$0C,$7C,$F1,$70	; Block 3x4 tiles from 7C0C to $70F1
	DEFB	$05,$03,$03,$A0,$71,$13,$71	; Block 3x3 tiles from 71A0 to $7113
	DEFB	$00,$17,$71		; Barrel 3x3 tiles at $7117
	DEFB	$00,$1A,$71		; Barrel 3x3 tiles at $711A
	DEFB	$00,$BE,$70		; Barrel 3x3 tiles at $70BE
	DEFB	$00,$C1,$70		; Barrel 3x3 tiles at $70C1
	DEFB	$00,$26,$71		; Barrel 3x3 tiles at $7126
	DEFB	$05,$04,$03,$7B,$7E,$C4,$70	; Block 4x3 tiles from 7E7B to $70C4
	DEFB	$05,$04,$03,$7B,$7E,$1B,$71	; Block 4x3 tiles from 7E7B to $711B
	DEFB	$05,$04,$03,$7B,$7E,$20,$71	; Block 4x3 tiles from 7E7B to $7120
	DEFB	$FF	; End of sequence

; Room 924E
L924E:	DEFW	LB452	; Room procedure
	DEFW	LA366	; Initialization
	DEFW	L920A	; Room to Left
	DEFW	$0000
	DEFW	L91BA	; Room Up
	DEFW	$0000
	DEFB	$02,$10,$FF,$9E,$65	; Fill horz 16 tiles with $FF at $659E
	DEFB	$0C,$E3,$81,$02,$0E,$CA,$65	; Block 2 tiles from 81E3 to $65CA copy 14 times
	DEFB	$02,$20,$FF,$6E,$67	; Fill horz 32 tiles with $FF at $676E
	DEFB	$0C,$48,$73,$02,$0F,$C2,$65	; Block 2 tiles from 7348 to $65C2 copy 15 times
	DEFB	$05,$02,$01,$B9,$71,$A4,$65	; Block 2x1 tiles from 71B9 to $65A4
	DEFB	$05,$03,$03,$A0,$71,$1C,$71	; Block 3x3 tiles from 71A0 to $711C
	DEFB	$05,$03,$03,$A0,$71,$CB,$70	; Block 3x3 tiles from 71A0 to $70CB
	DEFB	$05,$04,$03,$7B,$7E,$24,$71	; Block 4x3 tiles from 7E7B to $7124
	DEFB	$00,$5D,$70		; Barrel 3x3 tiles at $705D
	DEFB	$00,$B5,$70		; Barrel 3x3 tiles at $70B5
	DEFB	$00,$B9,$70		; Barrel 3x3 tiles at $70B9
	DEFB	$00,$BC,$70		; Barrel 3x3 tiles at $70BC
	DEFB	$00,$0E,$71		; Barrel 3x3 tiles at $710E
	DEFB	$00,$11,$71		; Barrel 3x3 tiles at $7111
	DEFB	$00,$14,$71		; Barrel 3x3 tiles at $7114
	DEFB	$00,$18,$71		; Barrel 3x3 tiles at $7118
	DEFB	$FF	; End of sequence

; Room 92A7
L92A7:	DEFW	LB483	; Room procedure
	DEFW	LA16F	; Initialization
	DEFW	$0000
	DEFW	L9005	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$02,$20,$FF,$90,$65	; Fill horz 32 tiles with $FF at $6590
	DEFB	$0C,$E3,$81,$02,$0D,$CC,$65	; Block 2 tiles from 81E3 to $65CC copy 13 times
	DEFB	$02,$3C,$FF,$52,$67	; Fill horz 60 tiles with $FF at $6752
	DEFB	$05,$04,$04,$A9,$71,$D1,$70	; Block 4x4 tiles from 71A9 to $70D1
	DEFB	$05,$04,$04,$A9,$71,$E1,$70	; Block 4x4 tiles from 71A9 to $70E1
	DEFB	$05,$02,$04,$BB,$71,$D6,$70	; Block 2x4 tiles from 71BB to $70D6
	DEFB	$05,$02,$04,$BB,$71,$D8,$70	; Block 2x4 tiles from 71BB to $70D8
	DEFB	$05,$02,$04,$BB,$71,$DB,$70	; Block 2x4 tiles from 71BB to $70DB
	DEFB	$05,$02,$04,$BB,$71,$DE,$70	; Block 2x4 tiles from 71BB to $70DE
	DEFB	$FF	; End of sequence

; Room 92EF
L92EF:	DEFW	L7918	; Room procedure
	DEFW	L791B	; Initialization
	DEFW	$0000
	DEFW	L909F	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$04,$FF	; Fill entire screen with $FF
	DEFB	$03,$00,$1A,$06,$B2,$65	; Rectangle 26x6 tiles with $00 at $65B2
	DEFB	$03,$02,$16,$06,$DE,$66	; Rectangle 22x6 tiles with $02 at $66DE
	DEFB	$03,$CC,$06,$04,$1C,$67	; Rectangle 6x4 tiles with $CC at $671C
	DEFB	$02,$07,$D1,$38,$67	; Fill horz 7 tiles with $D1 at $6738
	DEFB	$0E,$D0,$3D,$67		; Put tile $D0 at $673D
	DEFB	$02,$0C,$CD,$22,$67	; Fill horz 12 tiles with $CD at $6722
	DEFB	$05,$01,$04,$72,$93,$24,$67	; Block 1x4 tiles from 9372 to $6724
	DEFB	$05,$01,$04,$72,$93,$26,$67	; Block 1x4 tiles from 9372 to $6726
	DEFB	$05,$01,$04,$72,$93,$28,$67	; Block 1x4 tiles from 9372 to $6728
	DEFB	$05,$01,$04,$72,$93,$2A,$67	; Block 1x4 tiles from 9372 to $672A
	DEFB	$05,$01,$04,$72,$93,$2C,$67	; Block 1x4 tiles from 9372 to $672C
	DEFB	$05,$01,$04,$72,$93,$2E,$67	; Block 1x4 tiles from 9372 to $672E
	DEFB	$05,$04,$04,$A9,$71,$E1,$6F	; Block 4x4 tiles from 71A9 to $6FE1
	DEFB	$05,$02,$04,$BB,$71,$E6,$6F	; Block 2x4 tiles from 71BB to $6FE6
	DEFB	$05,$02,$04,$BB,$71,$E9,$6F	; Block 2x4 tiles from 71BB to $6FE9
	DEFB	$05,$02,$04,$BB,$71,$EC,$6F	; Block 2x4 tiles from 71BB to $6FEC
	DEFB	$05,$02,$04,$BB,$71,$EF,$6F	; Block 2x4 tiles from 71BB to $6FEF
	DEFB	$05,$02,$04,$BB,$71,$F2,$6F	; Block 2x4 tiles from 71BB to $6FF2
	DEFB	$FF	; End of sequence

; Blocks for rooms
L9372:	DEFB	$CE	; Back block 1x4
	DEFB	$CF
	DEFB	$CF
	DEFB	$CF

; Room 9376
L9376:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L93DF	; Room to Left
	DEFW	$0000
	DEFW	L8384	; Room Up
	DEFW	$0000
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$02,$0C,$06,$80,$66	; Rectangle 12x6 tiles with $02 at $6680
	DEFB	$03,$02,$0B,$06,$90,$66	; Rectangle 11x6 tiles with $02 at $6690
	DEFB	$02,$0C,$03,$62,$66	; Fill horz 12 tiles with $03 at $6662
	DEFB	$02,$0B,$03,$72,$66	; Fill horz 11 tiles with $03 at $6672
	DEFB	$03,$0C,$0B,$02,$FE,$70	; Rectangle 11x2 tiles with $0C at $70FE
	DEFB	$02,$0B,$0B,$E0,$70	; Fill horz 11 tiles with $0B at $70E0
	DEFB	$0C,$B9,$71,$02,$0E,$94,$65	; Block 2 tiles from 71B9 to $6594 copy 14 times
	DEFB	$0C,$B9,$71,$02,$0E,$A4,$65	; Block 2 tiles from 71B9 to $65A4 copy 14 times
	DEFB	$05,$06,$02,$88,$71,$F3,$70	; Block 6x2 tiles from 7188 to $70F3
	DEFB	$01,$07,$FD,$9A,$65	; Fill vert 7 tiles with $FD at $659A
	DEFB	$01,$07,$FD,$A2,$65	; Fill vert 7 tiles with $FD at $65A2
	DEFB	$01,$07,$FD,$A9,$65	; Fill vert 7 tiles with $FD at $65A9
	DEFB	$05,$01,$03,$4F,$7B,$36,$67	; Block 1x3 tiles from 7B4F to $6736
	DEFB	$05,$01,$03,$4F,$7B,$3A,$67	; Block 1x3 tiles from 7B4F to $673A
	DEFB	$05,$01,$03,$4F,$7B,$3E,$67	; Block 1x3 tiles from 7B4F to $673E
	DEFB	$FF	; End of sequence

; Room 93DF
L93DF:	DEFW	LB41F	; Room procedure
L93E1:	DEFW	LC671	; Initialization
	DEFW	L7C9C	; Room to Left
	DEFW	L9376	; Room to Right
	DEFW	L9431	; Room Up
	DEFW	$0000
	DEFB	$04,$02			; Fill entire screen with $02
	DEFB	$03,$21,$05,$02,$16,$67	; Rectangle 5x2 tiles with $21 at $6716
	DEFB	$02,$04,$03,$7C,$66	; Fill horz 4 tiles with $03 at $667C
	DEFB	$02,$99,$FF,$90,$65	; Fill horz 153 tiles with $FF at $6590
	DEFB	$02,$10,$FF,$36,$66	; Fill horz 16 tiles with $FF at $6636
	DEFB	$02,$04,$FF,$5E,$66	; Fill horz 4 tiles with $FF at $665E
	DEFB	$02,$11,$FF,$1B,$67	; Fill horz 17 tiles with $FF at $671B
	DEFB	$02,$56,$FF,$38,$67	; Fill horz 86 tiles with $FF at $6738
	DEFB	$0C,$B9,$71,$02,$0D,$96,$65	; Block 2 tiles from 71B9 to $6596 copy 13 times
	DEFB	$01,$05,$FD,$9E,$65	; Fill vert 5 tiles with $FD at $659E
	DEFB	$01,$06,$FD,$A7,$65	; Fill vert 6 tiles with $FD at $65A7
	DEFB	$05,$01,$04,$4F,$7B,$24,$67	; Block 1x4 tiles from 7B4F to $6724
	DEFB	$05,$01,$03,$4F,$7B,$4B,$67	; Block 1x3 tiles from 7B4F to $674B
	DEFB	$FF	; End of sequence

; Room 9431
L9431:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	$0000
	DEFW	L9451	; Room Up
	DEFW	L93DF	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$0C,$B9,$71,$02,$11,$96,$65	; Block 2 tiles from 71B9 to $6596 copy 17 times
	DEFB	$01,$11,$FD,$9E,$65	; Fill vert 17 tiles with $FD at $659E
	DEFB	$01,$11,$FD,$A7,$65	; Fill vert 17 tiles with $FD at $65A7
	DEFB	$FF	; End of sequence

; Room 9451
L9451:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	$0000
	DEFW	$0000
	DEFW	L9431	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$05,$02,$04,$84,$79,$1C,$67	; Block 2x4 tiles from 7984 to $671C
	DEFB	$01,$11,$FD,$9E,$65	; Fill vert 17 tiles with $FD at $659E
	DEFB	$01,$11,$FD,$A7,$65	; Fill vert 17 tiles with $FD at $65A7
	DEFB	$03,$02,$18,$06,$65,$66	; Rectangle 24x6 tiles with $02 at $6665
	DEFB	$02,$18,$03,$47,$66	; Fill horz 24 tiles with $03 at $6647
	DEFB	$FF	; End of sequence

; Room 947C
L947C:	DEFW	LB41F	; Room procedure
L947E:	DEFW	LC671	; Initialization
	DEFW	L94AB	; Room to Left
	DEFW	L7C9C	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$02,$15,$07,$26,$66	; Rectangle 21x7 tiles with $02 at $6626
	DEFB	$03,$02,$07,$06,$79,$66	; Rectangle 7x6 tiles with $02 at $6679
	DEFB	$01,$08,$02,$3B,$66	; Fill vert 8 tiles with $02 at $663B
	DEFB	$01,$07,$02,$5A,$66	; Fill vert 7 tiles with $02 at $665A
	DEFB	$02,$08,$21,$2C,$67	; Fill horz 8 tiles with $21 at $672C
	DEFB	$02,$07,$21,$4B,$67	; Fill horz 7 tiles with $21 at $674B
	DEFB	$FF	; End of sequence

; Room 94AB
L94AB:	DEFW	L7918	; Room procedure
	DEFW	LA0DF	; Initialization
	DEFW	L95D6	; Room to Left
	DEFW	L947C	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$00,$1E,$07,$26,$66	; Rectangle 30x7 tiles with $00 at $6626
	DEFB	$03,$02,$02,$07,$42,$66	; Rectangle 2x7 tiles with $02 at $6642
	DEFB	$0E,$2A,$37,$70		; Put tile $2A at $7037
	DEFB	$01,$06,$2B,$55,$70	; Fill vert 6 tiles with $2B at $7055
	DEFB	$FF	; End of sequence

; Room 94CF
L94CF:	DEFW	L7918	; Room procedure
	DEFW	LA11A	; Initialization
	DEFW	L9552	; Room to Left
	DEFW	L9A9A	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$02,$3C,$FF,$52,$67	; Fill horz 60 tiles with $FF at $6752
	DEFB	$03,$0D,$12,$07,$80,$66	; Rectangle 18x7 tiles with $0D at $6680
	DEFB	$03,$A3,$1B,$02,$90,$65	; Rectangle 27x2 tiles with $A3 at $6590
	DEFB	$0E,$9C,$AB,$65		; Put tile $9C at $65AB
	DEFB	$0E,$9B,$C9,$65		; Put tile $9B at $65C9
	DEFB	$03,$BF,$12,$06,$CC,$65	; Rectangle 18x6 tiles with $BF at $65CC
	DEFB	$05,$02,$04,$BB,$71,$E8,$70	; Block 2x4 tiles from 71BB to $70E8
	DEFB	$02,$12,$BA,$CC,$65	; Fill horz 18 tiles with $BA at $65CC
	DEFB	$02,$12,$B3,$62,$66	; Fill horz 18 tiles with $B3 at $6662
	DEFB	$05,$01,$06,$28,$95,$CD,$65	; Block 1x6 tiles from 9528 to $65CD
	DEFB	$05,$01,$06,$2E,$95,$D4,$65	; Block 1x6 tiles from 952E to $65D4
	DEFB	$05,$02,$06,$34,$95,$DA,$65	; Block 2x6 tiles from 9534 to $65DA
	DEFB	$05,$03,$06,$40,$95,$DE,$65	; Block 3x6 tiles from 9540 to $65DE
	DEFB	$FF	; End of sequence

; Blocks for rooms
L9528:	DEFB	$A9	; Back block 1x6
	DEFB	$A8
	DEFB	$A8
	DEFB	$A8
	DEFB	$A8
	DEFB	$A7
L952E:	DEFB	$A6	; Back block 1x6
	DEFB	$A5
	DEFB	$A4
	DEFB	$A8
	DEFB	$A2
	DEFB	$A1
L9534:	DEFB	$BA,$CB	; Back block 2x6
	DEFB	$BF,$CA
	DEFB	$C9,$C8
	DEFB	$C7,$C6
	DEFB	$CA,$BF
	DEFB	$C4,$B3
L9540:	DEFB	$BA,$BA,$C3	; Back block 3x6
	DEFB	$BF,$C2,$C1
	DEFB	$BF,$C0,$00
	DEFB	$C2,$C1,$00
	DEFB	$C0,$00,$00
	DEFB	$C1,$00,$00

; Room 9552
L9552:	DEFW	LB483	; Room procedure
	DEFW	LA197	; Initialization
	DEFW	L9A5A	; Room to Left
	DEFW	L94CF	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$02,$3C,$FF,$52,$67	; Fill horz 60 tiles with $FF at $6752
	DEFB	$03,$0D,$12,$07,$8C,$66	; Rectangle 18x7 tiles with $0D at $668C
	DEFB	$03,$A3,$1B,$02,$93,$65	; Rectangle 27x2 tiles with $A3 at $6593
	DEFB	$0E,$9E,$92,$65		; Put tile $9E at $6592
	DEFB	$0E,$9D,$B0,$65		; Put tile $9D at $65B0
	DEFB	$03,$BF,$12,$06,$D8,$65	; Rectangle 18x6 tiles with $BF at $65D8
	DEFB	$05,$02,$04,$BB,$71,$DD,$70	; Block 2x4 tiles from 71BB to $70DD
	DEFB	$05,$02,$04,$BB,$71,$E3,$70	; Block 2x4 tiles from 71BB to $70E3
	DEFB	$02,$12,$BA,$D8,$65	; Fill horz 18 tiles with $BA at $65D8
	DEFB	$02,$12,$B3,$6E,$66	; Fill horz 18 tiles with $B3 at $666E
	DEFB	$05,$01,$06,$28,$95,$E8,$65	; Block 1x6 tiles from 9528 to $65E8
	DEFB	$05,$01,$06,$B2,$95,$E1,$65	; Block 1x6 tiles from 95B2 to $65E1
	DEFB	$05,$02,$06,$B8,$95,$DA,$65	; Block 2x6 tiles from 95B8 to $65DA
	DEFB	$05,$03,$06,$C4,$95,$D5,$65	; Block 3x6 tiles from 95C4 to $65D5
	DEFB	$FF	; End of sequence

; Blocks for rooms
L95B2:	DEFB	$A0		; Back block 1x6
	DEFB	$A2
	DEFB	$A8
	DEFB	$A4
	DEFB	$A5
	DEFB	$9F
L95B8:	DEFB	$BB,$BA		; Back block 2x6
	DEFB	$B9,$BF
	DEFB	$B8,$B7
	DEFB	$B6,$B5
	DEFB	$BF,$B9
	DEFB	$B3,$B2
L95C4:	DEFB	$B1,$BA,$BA	; Back block 3x6
	DEFB	$B0,$AF,$BF
	DEFB	$00,$AE,$BF
	DEFB	$00,$B0,$AF
	DEFB	$00,$00,$AE
	DEFB	$00,$00,$B0

; Room 95D6
L95D6:	DEFW	LB483	; Room procedure
	DEFW	LA183	; Initialization
	DEFW	L95F8	; Room to Left
	DEFW	L94AB	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$02,$96,$FF,$90,$65	; Fill horz 150 tiles with $FF at $6590
	DEFB	$03,$FF,$10,$05,$06,$67	; Rectangle 16x5 tiles with $FF at $6706
	DEFB	$02,$07,$00,$06,$67	; Fill horz 7 tiles with $00 at $6706
	DEFB	$02,$10,$FA,$16,$67	; Fill horz 16 tiles with $FA at $6716
	DEFB	$FF	; End of sequence

; Room 95F8
L95F8:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	L95D6	; Room to Right
	DEFW	$0000
	DEFW	L9634	; Room Down
	DEFB	$04,$FF	; Fill entire screen with $FF
	DEFB	$03,$00,$17,$08,$2D,$66	; Rectangle 23x8 tiles with $00 at $662D
	DEFB	$06,$FF,$03,$2D,$66	; Triangle with $FF, count=3 at $662D
	DEFB	$02,$0C,$FA,$28,$67	; Fill horz 12 tiles with $FA at $6728
	DEFB	$02,$0A,$00,$48,$67	; Fill horz 10 tiles with $00 at $6748
	DEFB	$02,$16,$00,$5A,$67	; Fill horz 22 tiles with $00 at $675A
	DEFB	$02,$18,$00,$76,$67	; Fill horz 24 tiles with $00 at $6776
	DEFB	$0C,$48,$73,$02,$0C,$34,$66	; Block 2 tiles from 7348 to $6634 copy 12 times
	DEFB	$05,$02,$01,$9D,$88,$24,$67	; Block 2x1 tiles from 889D to $6724
	DEFB	$FF	; End of sequence

; Room 9634
L9634:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	L968A	; Room to Right
	DEFW	L95F8	; Room Up
	DEFW	L990D	; Room Down
	DEFB	$03,$FF,$04,$0D,$90,$65	; Rectangle 4x13 tiles with $FF at $6590
	DEFB	$03,$FF,$18,$04,$1C,$67	; Rectangle 24x4 tiles with $FF at $671C
	DEFB	$07,$FF,$05,$84,$66	; Triangle with $FF, count=5 at $6684
	DEFB	$0E,$00,$84,$66		; Put tile $00 at $6684
	DEFB	$09,$FF,$03,$1B,$67	; Triangle with $FF, count=3 at $671B
	DEFB	$05,$02,$02,$86,$96,$52,$67	; Block 2x2 tiles from 9686 to $6752
	DEFB	$0C,$48,$73,$02,$0D,$9E,$65	; Block 2 tiles from 7348 to $659E copy 13 times
	DEFB	$02,$0C,$00,$28,$67	; Fill horz 12 tiles with $00 at $6728
	DEFB	$02,$0C,$00,$62,$67	; Fill horz 12 tiles with $00 at $6762
	DEFB	$02,$10,$00,$7C,$67	; Fill horz 16 tiles with $00 at $677C
	DEFB	$0C,$48,$73,$02,$02,$6B,$67	; Block 2 tiles from 7348 to $676B copy 2 times
	DEFB	$05,$02,$01,$9D,$88,$4D,$67	; Block 2x1 tiles from 889D to $674D
	DEFB	$FF	; End of sequence

; Blocks for rooms
L9686:	DEFB	$B4,$AA	; Back block 2x2
	DEFB	$AD,$AB

; Room 968A
L968A:	DEFW	LB483	; Room procedure
	DEFW	LA188	; Initialization
	DEFW	L9634	; Room to Left
	DEFW	L96CC	; Room to Right
	DEFW	$0000
	DEFW	L9715	; Room Down
	DEFB	$03,$FF,$10,$05,$9E,$65	; Rectangle 16x5 tiles with $FF at $659E
	DEFB	$01,$0C,$3A,$40,$66	; Fill vert 12 tiles with $3A at $6640
	DEFB	$03,$FF,$0B,$02,$52,$67	; Rectangle 11x2 tiles with $FF at $6752
	DEFB	$02,$10,$FF,$34,$67	; Fill horz 16 tiles with $FF at $6734
	DEFB	$02,$09,$FA,$44,$67	; Fill horz 9 tiles with $FA at $6744
	DEFB	$02,$06,$FA,$6A,$67	; Fill horz 6 tiles with $FA at $676A
	DEFB	$05,$02,$04,$BB,$71,$B6,$70	; Block 2x4 tiles from 71BB to $70B6
	DEFB	$0C,$48,$73,$02,$02,$5E,$67	; Block 2 tiles from 7348 to $675E copy 2 times
	DEFB	$05,$02,$01,$9D,$88,$40,$67	; Block 2x1 tiles from 889D to $6740
	DEFB	$FF	; End of sequence

; Room 96CC
L96CC:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L968A	; Room to Left
	DEFW	$0000
	DEFW	$0000
	DEFW	L96F3	; Room Down
	DEFB	$02,$96,$FF,$90,$65	; Fill horz 150 tiles with $FF at $6590
	DEFB	$03,$FF,$0F,$0C,$35,$66	; Rectangle 15x12 tiles with $FF at $6635
	DEFB	$09,$FF,$09,$34,$66	; Triangle with $FF, count=9 at $6634
	DEFB	$01,$0C,$3A,$27,$66	; Fill vert 12 tiles with $3A at $6627
	DEFB	$02,$04,$FA,$52,$67	; Fill horz 4 tiles with $FA at $6752
	DEFB	$FF	; End of sequence

; Room 96F3
L96F3:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L9715	; Room to Left
	DEFW	$0000
	DEFW	$0000
	DEFW	L976E	; Room Down
	DEFB	$03,$FF,$0F,$11,$9F,$65	; Rectangle 15x17 tiles with $FF at $659F
	DEFB	$01,$11,$3A,$91,$65	; Fill vert 17 tiles with $3A at $6591
	DEFB	$01,$0A,$3A,$68,$66	; Fill vert 10 tiles with $3A at $6668
	DEFB	$02,$09,$FA,$80,$66	; Fill horz 9 tiles with $FA at $6680
	DEFB	$FF	; End of sequence

; Room 9715
L9715:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	L96F3	; Room to Right
	DEFW	L968A	; Room Up
	DEFW	L9739	; Room Down
	DEFB	$03,$FF,$0B,$11,$90,$65	; Rectangle 11x17 tiles with $FF at $6590
	DEFB	$0C,$48,$73,$02,$11,$9C,$65	; Block 2 tiles from 7348 to $659C copy 17 times
	DEFB	$01,$11,$3A,$AA,$65	; Fill vert 17 tiles with $3A at $65AA
	DEFB	$02,$08,$FA,$96,$66	; Fill horz 8 tiles with $FA at $6696
	DEFB	$FF	; End of sequence

; Room 9739
L9739:	DEFW	LB452	; Room procedure
	DEFW	LA384	; Initialization
	DEFW	L99A6	; Room to Left
	DEFW	L976E	; Room to Right
	DEFW	L9715	; Room Up
	DEFW	L97A6	; Room Down
	DEFB	$03,$FF,$0B,$0A,$90,$65	; Rectangle 11x10 tiles with $FF at $6590
	DEFB	$08,$00,$06,$12,$66	; Triangle with $00, count=6 at $6612
	DEFB	$02,$22,$FF,$6C,$67	; Fill horz 34 tiles with $FF at $676C
L9755:	DEFB	$01,$01,$E4,$A0,$66	; Fill vert 1 tiles with $E4 at $66A0
	DEFB	$01,$0F,$3A,$AA,$65	; Fill vert 15 tiles with $3A at $65AA
	DEFB	$05,$02,$01,$9D,$88,$76,$67	; Block 2x1 tiles from 889D to $6776
	DEFB	$0C,$48,$73,$02,$10,$9C,$65	; Block 2 tiles from 7348 to $659C copy 16 times
	DEFB	$FF	; End of sequence

; Room 976E
L976E:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L9739	; Room to Left
	DEFW	$0000
	DEFW	$0000
	DEFW	$0000
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$00,$0F,$08,$90,$65	; Rectangle 15x8 tiles with $00 at $6590
	DEFB	$03,$00,$07,$07,$80,$66	; Rectangle 7x7 tiles with $00 at $6680
	DEFB	$02,$06,$00,$87,$66	; Fill horz 6 tiles with $00 at $6687
	DEFB	$02,$04,$00,$A5,$66	; Fill horz 4 tiles with $00 at $66A5
	DEFB	$02,$02,$00,$C3,$66	; Fill horz 2 tiles with $00 at $66C3
	DEFB	$01,$0F,$3A,$91,$65	; Fill vert 15 tiles with $3A at $6591
	DEFB	$01,$0F,$3A,$96,$65	; Fill vert 15 tiles with $3A at $6596
	DEFB	$0E,$FA,$E0,$66	; Put tile $FA at $66E0
	DEFB	$FF	; End of sequence

; Room 97A6
L97A6:	DEFW	LB483	; Room procedure
	DEFW	LB368	; Initialization
	DEFW	L9876	; Room to Left
	DEFW	L97F8	; Room to Right
	DEFW	L9739	; Room Up
	DEFW	$0000
	DEFB	$03,$FF,$09,$07,$80,$66	; Rectangle 9x7 tiles with $FF at $6680
	DEFB	$02,$3C,$FF,$52,$67	; Fill horz 60 tiles with $FF at $6752
	DEFB	$07,$FF,$06,$A7,$66	; Triangle with $FF, count=6 at $66A7
	DEFB	$0C,$48,$73,$02,$08,$96,$65	; Block 2 tiles from 7348 to $6596 copy 8 times
	DEFB	$03,$FF,$04,$08,$AA,$65	; Rectangle 4x8 tiles with $FF at $65AA
L97CF:	DEFB	$0E,$00,$31,$67		; Put tile $00 at $6731
	DEFB	$0E,$2A,$91,$70		; Put tile $2A at $7091
	DEFB	$01,$06,$2B,$AF,$70	; Fill vert 6 tiles with $2B at $70AF
	DEFB	$05,$04,$07,$AA,$79,$82,$70	; Block 4x7 tiles from 79AA to $7082
	DEFB	$05,$04,$07,$AA,$79,$25,$70	; Block 4x7 tiles from 79AA to $7025
	DEFB	$05,$04,$07,$AA,$79,$06,$70	; Block 4x7 tiles from 79AA to $7006
	DEFB	$03,$02,$02,$07,$9C,$66	; Rectangle 2x7 tiles with $02 at $669C
	DEFB	$FF	; End of sequence

; Room 97F8
L97F8:	DEFW	L7918	; Room procedure
	DEFW	LA115	; Initialization
	DEFW	L97A6	; Room to Left
	DEFW	$0000
	DEFW	$0000
	DEFW	L982B	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$02,$1C,$07,$80,$66	; Rectangle 28x7 tiles with $02 at $6680
	DEFB	$03,$02,$10,$04,$0E,$66	; Rectangle 16x4 tiles with $02 at $660E
	DEFB	$08,$02,$03,$2B,$66	; Triangle with $02, count=3 at $662B
	DEFB	$07,$02,$03,$3C,$66	; Triangle with $02, count=3 at $663C
	DEFB	$0C,$B9,$71,$02,$09,$99,$66	; Block 2 tiles from 71B9 to $6699 copy 9 times
	DEFB	$05,$02,$01,$84,$79,$6B,$67	; Block 2x1 tiles from 7984 to $676B
	DEFB	$FF	; End of sequence

; Room 982B
L982B:	DEFW	LB41F	; Room procedure
L982D:	DEFW	LC681	; Initialization
	DEFW	L7C9C	; Room to Left
	DEFW	$0000
	DEFW	L97F8	; Room Up
	DEFW	$0000
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$02,$13,$06,$B7,$65	; Rectangle 19x6 tiles with $02 at $65B7
	DEFB	$03,$02,$13,$06,$62,$66	; Rectangle 19x6 tiles with $02 at $6662
	DEFB	$08,$02,$05,$D4,$65	; Triangle with $02, count=5 at $65D4
	DEFB	$06,$02,$05,$75,$66	; Triangle with $02, count=5 at $6675
	DEFB	$02,$12,$21,$16,$67	; Fill horz 18 tiles with $21 at $6716
	DEFB	$02,$11,$21,$34,$67	; Fill horz 17 tiles with $21 at $6734
	DEFB	$0C,$B9,$71,$02,$07,$A9,$65	; Block 2 tiles from 71B9 to $65A9 copy 7 times
	DEFB	$05,$04,$07,$8E,$79,$86,$70	; Block 4x7 tiles from 798E to $7086
	DEFB	$05,$04,$07,$8E,$79,$2F,$70	; Block 4x7 tiles from 798E to $702F
	DEFB	$05,$04,$07,$8E,$79,$F5,$6F	; Block 4x7 tiles from 798E to $6FF5
	DEFB	$FF	; End of sequence

; Room 9876
L9876:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L98C0	; Room to Left
	DEFW	L97A6	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$00,$0A,$07,$80,$66	; Rectangle 10x7 tiles with $00 at $6680
	DEFB	$03,$00,$0E,$07,$2E,$66	; Rectangle 14x7 tiles with $00 at $662E
	DEFB	$03,$00,$0A,$07,$C2,$65	; Rectangle 10x7 tiles with $00 at $65C2
	DEFB	$08,$00,$02,$4B,$66	; Triangle with $00, count=2 at $664B
	DEFB	$08,$00,$03,$DF,$65	; Triangle with $00, count=3 at $65DF
	DEFB	$06,$00,$02,$02,$67	; Triangle with $00, count=2 at $6702
	DEFB	$06,$00,$03,$96,$66	; Triangle with $00, count=3 at $6696
	DEFB	$05,$04,$07,$8E,$79,$7F,$70	; Block 4x7 tiles from 798E to $707F
	DEFB	$05,$04,$07,$8E,$79,$31,$70	; Block 4x7 tiles from 798E to $7031
	DEFB	$05,$04,$07,$8E,$79,$14,$70	; Block 4x7 tiles from 798E to $7014
	DEFB	$FF	; End of sequence

; Room 98C0 (think door)
L98C0:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	L9A9A	; Room to Left
	DEFW	L9876	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$02,$F0,$FF,$90,$65	; Fill horz 240 tiles with $FF at $6590
	DEFB	$02,$3C,$FF,$52,$67	; Fill horz 60 tiles with $FF at $6752
	DEFB	$05,$04,$03,$7B,$7E,$EF,$70	; Block 4x3 tiles from 7E7B to $70EF
	DEFB	$05,$03,$03,$A0,$71,$98,$70	; Block 3x3 tiles from 71A0 to $7098
	DEFB	$05,$03,$03,$A0,$71,$F4,$70	; Block 3x3 tiles from 71A0 to $70F4
	DEFB	$05,$01,$05,$03,$99,$AB,$66	; Block 1x5 tiles from 9903 to $66AB
	DEFB	$05,$01,$05,$08,$99,$AE,$66	; Block 1x5 tiles from 9908 to $66AE
	DEFB	$0C,$01,$99,$02,$07,$8E,$66	; Block 2 tiles from 9901 to $668E copy 7 times
	DEFB	$FF	; End of sequence

; Blocks for rooms
L9901:	DEFB	$9A,$99	; Back block 2x1
L9903:	DEFB	$C5	; Back block 1x5
	DEFB	$C5
	DEFB	$BC
	DEFB	$C5
	DEFB	$C5
L9908:	DEFB	$C5	; Back block 1x5
	DEFB	$C5
	DEFB	$BD
	DEFB	$C5
	DEFB	$C5

; Room 990D
L990D:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	$0000
	DEFW	L9634	; Room Up
	DEFW	$0000
	DEFB	$03,$FF,$14,$11,$9A,$65	; Rectangle 20x17 tiles with $FF at $659A
	DEFB	$03,$00,$11,$0C,$9B,$65	; Rectangle 17x12 tiles with $00 at $659B
	DEFB	$03,$00,$08,$04,$0C,$67	; Rectangle 8x4 tiles with $00 at $670C
	DEFB	$09,$00,$03,$0B,$67	; Triangle with $00, count=3 at $670B
	DEFB	$0C,$48,$73,$02,$10,$A9,$65	; Block 2 tiles from 7348 to $65A9 copy 16 times
	DEFB	$05,$04,$07,$AA,$79,$A5,$70	; Block 4x7 tiles from 79AA to $70A5
	DEFB	$05,$04,$07,$AA,$79,$86,$70	; Block 4x7 tiles from 79AA to $7086
	DEFB	$03,$0D,$02,$11,$94,$65	; Rectangle 2x17 tiles with $0D at $6594
	DEFB	$01,$07,$2B,$26,$70	; Fill vert 7 tiles with $2B at $7026
	DEFB	$05,$03,$01,$97,$99,$B2,$65	; Block 3x1 tiles from 9997 to $65B2
	DEFB	$05,$03,$01,$97,$99,$2A,$66	; Block 3x1 tiles from 9997 to $662A
	DEFB	$05,$03,$01,$97,$99,$C0,$66	; Block 3x1 tiles from 9997 to $66C0
	DEFB	$05,$03,$01,$97,$99,$38,$67	; Block 3x1 tiles from 9997 to $6738
	DEFB	$05,$04,$03,$9A,$99,$CC,$65	; Block 4x3 tiles from 999A to $65CC
	DEFB	$05,$04,$03,$9A,$99,$26,$66	; Block 4x3 tiles from 999A to $6626
	DEFB	$05,$04,$03,$9A,$99,$80,$66	; Block 4x3 tiles from 999A to $6680
	DEFB	$05,$04,$03,$9A,$99,$DA,$66	; Block 4x3 tiles from 999A to $66DA
	DEFB	$05,$04,$03,$9A,$99,$34,$67	; Block 4x3 tiles from 999A to $6734
	DEFB	$05,$04,$02,$9E,$99,$90,$65	; Block 4x2 tiles from 999E to $6590
	DEFB	$FF	; End of sequence

; Blocks for rooms
L9997:	DEFB	$1A,$1A,$16	; Back block 3x1
L999A:	DEFB	$B4,$AA,$B4,$AA	; Back block 4x1
L999E:	DEFB	$AC,$BE,$AC,$BE	; Back block 4x2
	DEFB	$AD,$AB,$AD,$AB

; Room 99A6
L99A6:	DEFW	L7918	; Room procedure
	DEFW	LA110	; Initialization
	DEFW	$0000
	DEFW	L9739	; Room to Right
	DEFW	$0000
	DEFW	$0000
	DEFB	$02,$1E,$FF,$70,$67	; Fill horz 30 tiles with $FF at $6770
	DEFB	$01,$0E,$FF,$D6,$65	; Fill vert 14 tiles with $FF at $65D6
	DEFB	$01,$07,$2B,$9E,$70	; Fill vert 7 tiles with $2B at $709E
	DEFB	$03,$FF,$14,$02,$9A,$65	; Rectangle 20x2 tiles with $FF at $659A
	DEFB	$03,$FF,$03,$08,$E7,$65	; Rectangle 3x8 tiles with $FF at $65E7
	DEFB	$0E,$00,$B9,$66		; Put tile $00 at $66B9
	DEFB	$05,$02,$04,$BB,$71,$01,$71	; Block 2x4 tiles from 71BB to $7101
	DEFB	$03,$0D,$02,$10,$94,$65	; Rectangle 2x16 tiles with $0D at $6594
	DEFB	$05,$04,$03,$9A,$99,$CC,$65	; Block 4x3 tiles from 999A to $65CC
	DEFB	$05,$04,$03,$9A,$99,$26,$66	; Block 4x3 tiles from 999A to $6626
	DEFB	$05,$04,$03,$9A,$99,$80,$66	; Block 4x3 tiles from 999A to $6680
	DEFB	$05,$04,$03,$9A,$99,$DA,$66	; Block 4x3 tiles from 999A to $66DA
	DEFB	$05,$04,$02,$9A,$99,$34,$67	; Block 4x2 tiles from 999A to $6734
	DEFB	$05,$03,$01,$97,$99,$EE,$65	; Block 3x1 tiles from 9997 to $65EE
	DEFB	$05,$03,$01,$97,$99,$48,$66	; Block 3x1 tiles from 9997 to $6648
	DEFB	$05,$03,$01,$97,$99,$C0,$66	; Block 3x1 tiles from 9997 to $66C0
	DEFB	$05,$04,$02,$9E,$99,$90,$65	; Block 4x2 tiles from 999E to $6590
	DEFB	$FF	; End of sequence

; Room 9A1E
L9A1E:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	L7C9C	; Room to Right
	DEFW	L9A5A	; Room Up
	DEFW	$0000
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$02,$06,$08,$92,$65	; Rectangle 6x8 tiles with $02 at $6592
	DEFB	$03,$02,$08,$06,$D4,$65	; Rectangle 8x6 tiles with $02 at $65D4
	DEFB	$09,$02,$06,$8F,$66	; Triangle with $02, count=6 at $668F
	DEFB	$03,$02,$0E,$06,$72,$66	; Rectangle 14x6 tiles with $02 at $6672
	DEFB	$07,$02,$04,$FA,$65	; Triangle with $02, count=4 at $65FA
	DEFB	$0C,$B9,$71,$02,$08,$94,$65	; Block 2 tiles from 71B9 to $6594 copy 8 times
	DEFB	$02,$0F,$21,$25,$67	; Fill horz 15 tiles with $21 at $6725
	DEFB	$02,$0E,$21,$44,$67	; Fill horz 14 tiles with $21 at $6744
	DEFB	$FF	; End of sequence

; Room 9A5A
L9A5A:	DEFW	LB452	; Room procedure
	DEFW	LA389	; Initialization
	DEFW	$0000
	DEFW	L9552	; Room to Right
	DEFW	L9B51	; Room Up
	DEFW	L9A1E	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$00,$1C,$0B,$92,$65	; Rectangle 28x11 tiles with $00 at $6592
	DEFB	$03,$00,$07,$04,$F1,$66	; Rectangle 7x4 tiles with $00 at $66F1
	DEFB	$09,$00,$03,$F0,$66	; Triangle with $00, count=3 at $66F0
	DEFB	$03,$02,$06,$02,$54,$67	; Rectangle 6x2 tiles with $02 at $6754
	DEFB	$02,$04,$02,$37,$67	; Fill horz 4 tiles with $02 at $6737
	DEFB	$0C,$B9,$71,$02,$05,$FC,$66	; Block 2 tiles from 71B9 to $66FC copy 5 times
	DEFB	$05,$02,$01,$84,$79,$DE,$66	; Block 2x1 tiles from 7984 to $66DE
	DEFB	$0C,$48,$73,$02,$0B,$99,$65	; Block 2 tiles from 7348 to $6599 copy 11 times
	DEFB	$FF	; End of sequence

; Room 9A9A
L9A9A:	DEFW	LB483	; Room procedure
	DEFW	LA192	; Initialization
	DEFW	L94CF	; Room to Left
	DEFW	L98C0	; Room to Right
	DEFW	L9ADC	; Room Up
	DEFW	$0000
	DEFB	$02,$0A,$FF,$91,$65	; Fill horz 10 tiles with $FF at $6591
	DEFB	$02,$3C,$FF,$52,$67	; Fill horz 60 tiles with $FF at $6752
	DEFB	$03,$FF,$04,$08,$AA,$65	; Rectangle 4x8 tiles with $FF at $65AA
	DEFB	$0E,$2A,$90,$70		; Put tile $2A at $7090
	DEFB	$01,$06,$2B,$AE,$70	; Fill vert 6 tiles with $2B at $70AE
	DEFB	$0C,$48,$73,$02,$0F,$A5,$65	; Block 2 tiles from 7348 to $65A5 copy 15 times
	DEFB	$05,$04,$04,$A9,$71,$D4,$70	; Block 4x4 tiles from 71A9 to $70D4
	DEFB	$05,$04,$04,$A9,$71,$DB,$70	; Block 4x4 tiles from 71A9 to $70DB
	DEFB	$05,$04,$04,$A9,$71,$E0,$70	; Block 4x4 tiles from 71A9 to $70E0
	DEFB	$FF	; End of sequence

; Room 9ADC
L9ADC:	DEFW	LB41F	; Room procedure
	DEFW	LB422	; Initialization
	DEFW	$0000
	DEFW	$0000
	DEFW	L9B19	; Room Up
	DEFW	L9A9A	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$00,$18,$08,$92,$65	; Rectangle 24x8 tiles with $00 at $6592
	DEFB	$03,$00,$0F,$07,$8B,$66	; Rectangle 15x7 tiles with $00 at $668B
	DEFB	$09,$00,$06,$8A,$66	; Triangle with $00, count=6 at $668A
	DEFB	$0C,$48,$73,$02,$11,$A5,$65	; Block 2 tiles from 7348 to $65A5 copy 17 times
	DEFB	$01,$0F,$3A,$A0,$65	; Fill vert 15 tiles with $3A at $65A0
	DEFB	$02,$0D,$FF,$70,$66	; Fill horz 13 tiles with $FF at $6670
	DEFB	$02,$0D,$27,$66,$70	; Fill horz 13 tiles with $27 at $7066
	DEFB	$05,$02,$01,$9D,$88,$67,$67	; Block 2x1 tiles from 889D to $6767
	DEFB	$FF	; End of sequence

; Room 9B19
L9B19:	DEFW	L7918	; Room procedure
	DEFW	LA133	; Initialization
	DEFW	$0000
	DEFW	$0000
	DEFW	L9BE7	; Room Up
	DEFW	L9ADC	; Room Down
	DEFB	$03,$FF,$02,$11,$90,$65	; Rectangle 2x17 tiles with $FF at $6590
	DEFB	$03,$FF,$04,$11,$AA,$65	; Rectangle 4x17 tiles with $FF at $65AA
	DEFB	$0C,$48,$73,$02,$11,$A5,$65	; Block 2 tiles from 7348 to $65A5 copy 17 times
	DEFB	$01,$11,$3A,$A0,$65	; Fill vert 17 tiles with $3A at $65A0
	DEFB	$02,$1A,$FA,$F9,$66	; Fill horz 26 tiles with $FA at $66F9
	DEFB	$05,$03,$03,$A0,$71,$96,$70	; Block 3x3 tiles from 71A0 to $7096
	DEFB	$05,$02,$01,$9D,$88,$0D,$67	; Block 2x1 tiles from 889D to $670D
	DEFB	$FF	; End of sequence

; Room 9B51
L9B51:	DEFW	L7918	; Room procedure
	DEFW	LA11F	; Initialization
	DEFW	$0000
	DEFW	$0000
	DEFW	L9B9D	; Room Up
	DEFW	L9A5A	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$00,$1A,$0E,$92,$65	; Rectangle 26x14 tiles with $00 at $6592
	DEFB	$01,$07,$00,$7F,$66	; Fill vert 7 tiles with $00 at $667F
	DEFB	$01,$07,$2B,$74,$70	; Fill vert 7 tiles with $2B at $7074
	DEFB	$0C,$48,$73,$02,$02,$5B,$67	; Block 2 tiles from 7348 to $675B copy 2 times
	DEFB	$0C,$48,$73,$02,$0E,$A5,$65	; Block 2 tiles from 7348 to $65A5 copy 14 times
	DEFB	$05,$02,$01,$9D,$88,$3D,$67	; Block 2x1 tiles from 889D to $673D
	DEFB	$00,$D5,$70		; Barrel 3x3 tiles at $70D5
	DEFB	$05,$04,$04,$89,$87,$B4,$70	; Block 4x4 tiles from 8789 to $70B4
	DEFB	$05,$04,$04,$89,$87,$C0,$70	; Block 4x4 tiles from 8789 to $70C0
	DEFB	$05,$03,$03,$A0,$71,$E9,$70	; Block 3x3 tiles from 71A0 to $70E9
	DEFB	$FF	; End of sequence

; Room 9B9D
L9B9D:	DEFW	LB458	; Room procedure
	DEFW	LA1D6	; Initialization
	DEFW	$0000
	DEFW	$0000
	DEFW	L9F3A	; Room Up
	DEFW	L9B51	; Room Down
	DEFB	$04,$FF			; Fill entire screen with $FF
	DEFB	$03,$00,$1A,$07,$A0,$66	; Rectangle 26x7 tiles with $00 at $66A0
	DEFB	$03,$00,$18,$08,$94,$65	; Rectangle 24x8 tiles with $00 at $6594
	DEFB	$05,$02,$01,$9D,$88,$85,$67	; Block 2x1 tiles from 889D to $6785
	DEFB	$05,$02,$01,$9D,$88,$8A,$66	; Block 2x1 tiles from 889D to $668A
	DEFB	$0C,$48,$73,$02,$07,$A8,$66	; Block 2 tiles from 7348 to $66A8 copy 7 times
	DEFB	$0C,$48,$73,$02,$08,$A6,$65	; Block 2 tiles from 7348 to $65A6 copy 8 times
	DEFB	$05,$03,$03,$A0,$71,$24,$71	; Block 3x3 tiles from 71A0 to $7124
	DEFB	$00,$B5,$70		; Barrel 3x3 tiles at $70B5
	DEFB	$00,$0F,$71		; Barrel 3x3 tiles at $710F
	DEFB	$00,$12,$71		; Barrel 3x3 tiles at $7112
	DEFB	$00,$19,$71		; Barrel 3x3 tiles at $7119
	DEFB	$FF	; End of sequence

; Room 9BE7
L9BE7:	DEFW	LB483	; Room procedure
	DEFW	LA19C	; Initialization
	DEFW	$0000
	DEFW	L9DF5	; Room to Right
	DEFW	L9E73	; Room Up
	DEFW	L9B19	; Room Down
	DEFB	$03,$FF,$02,$0C,$26,$66	; Rectangle 2x12 tiles with $FF at $6626
	DEFB	$03,$FF,$09,$05,$96,$65	; Rectangle 9x5 tiles with $FF at $6596
	DEFB	$08,$FF,$05,$95,$65	; Triangle with $FF, count=5 at $6595
	DEFB	$06,$FF,$09,$28,$66	; Triangle with $FF, count=9 at $6628
	DEFB	$02,$04,$FF,$AA,$65	; Fill horz 4 tiles with $FF at $65AA
	DEFB	$03,$FF,$04,$04,$30,$67	; Rectangle 4x4 tiles with $FF at $6730
	DEFB	$01,$11,$3A,$A0,$65	; Fill vert 17 tiles with $3A at $65A0
	DEFB	$0C,$48,$73,$02,$0D,$A2,$65	; Block 2 tiles from 7348 to $65A2 copy 13 times
	DEFB	$0C,$48,$73,$02,$03,$49,$67	; Block 2 tiles from 7348 to $6749 copy 3 times
	DEFB	$02,$1A,$FA,$17,$67	; Fill horz 26 tiles with $FA at $6717
	DEFB	$05,$02,$01,$9D,$88,$2B,$67	; Block 2x1 tiles from 889D to $672B
	DEFB	$01,$04,$F9,$A5,$66	; Fill vert 4 tiles with $F9 at $66A5
	DEFB	$FF	; End of sequence

L9C39:	DEFB	$00,$00,$00,$00,$00,$00,$00
L9C40:	DEFB	$08	; Ninja Y within the room, 0 at the top
L9C41:	DEFB	$06	; Ninja X within the room
L9C42:	DEFW	$00F6	; Ninja position in tilemap: Y * 30 + X

; Process a dog
L9C44:	LD HL,L71D3	; dog Y position address
	LD A,(L9C40)	; get Ninja Y
	SUB (HL)
	CP $07
	JR NC,L9C80
	LD HL,L7345
	XOR A
	CP (HL)
	JR NZ,L9C5A
L9C56:	LD (HL),$19	; !!MUT-ARG!! Dog counter value
	JR L9C80
L9C5A:	DEC (HL)
	CP (HL)
	JR NZ,L9C80
	LD A,(L71CD)	; get Dog direction
	CP $00		; left?
	JR NZ,L9C71	; right =>
	LD A,(L9C41)	; get Ninja X
	INC A
	LD HL,L71CE	; Dog X position address
	CP (HL)
	JR C,L9C80
	JR L9C7B
L9C71:	LD A,(L9C41)	; get Ninja X
	INC A
	LD HL,L71CE	; Dog X position address
	CP (HL)
	JR NC,L9C80
L9C7B:	LD A,$01
	LD (L7344),A	; set "Dog ignore left/right limit" flag
L9C80:	LD A,(L71CD)	; !!MUT-ARG!! get Dog direction
	LD (L71CD),A
	LD HL,L71CD
	LD (L9C80+1),HL
	CALL L9D5C	; Set update flags for Dog
	LD A,(L71CF)
	CP $42
	JR C,L9CA8
	LD HL,L9C9C	; Sprite Dog dead
	JP L9D31	; => Set Dog sprite = HL, Draw Dog in tilemap

; Sprite Dog dead
L9C9C:	DEFB	$FF,$FF,$FF,$FF
	DEFB	$FF,$FF,$FF,$FF
	DEFB	$5D,$5E,$5F,$60

; Part of Dog processing
L9CA8:	CP $00
	JP NZ,L9D8B
	LD HL,(L71CB)	; get Dog position in tilemap
	LD DE,L698C+33	; $69AD = $698C (Tile screen 2) + 33: for right direction
	LD A,(L71CD)	; get Dog direction
	CP $01		; right?
	JR Z,L9CBD	; right =>
	LD DE,L698C+30	; $69AA = $698C (Tile screen 2) + 30: for left direction
L9CBD:	ADD HL,DE	; now HL = Dog position in Ninja tile screen
	LD A,(HL)	; get tile from Ninja tile screen
	INC A		; $FF?
	LD B,$05
	CALL NZ,L9DD9	; not $FF => Dog bites, decrease Energy by 5
	LD A,(L71CD)	; get Dog direction
	CP $00		; left?
	JR Z,L9CF1	; left =>

; Dog runs right
L9CCC:	LD HL,(L71CB)	; get Dog position in tilemap
	INC HL		; one tile right
	LD (L71CB),HL	; update Dog position in tilemap
	LD HL,L71CE	; Dog X position address
	INC (HL)	; one tile right
	LD A,(L7344)
	CP $01
	JR Z,L9CE4
	LD A,(L71D1)	; get Dog's right limit
	CP (HL)
	JR NZ,L9D14
L9CE4:	XOR A
	LD (L7344),A
	LD (L71D2),A
	INC A
	LD (L71CF),A	; ?? = 1
	JR L9D14

; Dog runs left
L9CF1:	LD HL,(L71CB)	; get Dog position in tilemap
	DEC HL		; one tile left
	LD (L71CB),HL	; update Dog position in tilemap
	LD HL,L71CE	; Dog X position address
	DEC (HL)	; one tile left
	LD A,(L7344)
	CP $01
	JR Z,L9D09
	LD A,(L71D0)	; get Dog's left limit
	CP (HL)
	JR NZ,L9D14
L9D09:	XOR A
	LD (L7344),A
	INC A
	LD (L71D2),A
	LD (L71CF),A	; ?? = 1
L9D14:	LD HL,L71D5
	INC (HL)
	LD A,$03
	CP (HL)
	JR NZ,L9D1F
	LD (HL),$00
L9D1F:	LD A,(HL)
	LD HL,L71F2	; Sprite Dog 1
	CP $00
	JR Z,L9D31	; => Set Dog sprite = HL, Draw Dog in tilemap
	LD HL,L71FE	; Sprite Dog 2
	CP $01
	JR Z,L9D31	; => Set Dog sprite = HL, Draw Dog in tilemap
	LD HL,L720A	; Sprite Dog 3

; Set Dog sprite = HL, Draw Dog in tilemap
L9D31:	LD (L9D3B+1),HL	; set Dog sprite = HL

; Draw Dog in tilemap
L9D34:	LD HL,(L71CB)
	LD DE,L6B8A	; Tile screen 3 start address
	ADD HL,DE
L9D3B:	LD DE,L71FE	; !!MUT-ARG!! current Dog sprite address
	LD B,$03	; 3 rows
	LD A,(L71CD)	; get Dog direction
	CP $00		; left?
	JR Z,L9D75	; left => draw Dog facing left

; Draw Dog facing right in tilemap
L9D47:	LD C,$04	; 4 columns
L9D49:	LD A,(DE)
	LD (HL),A
	INC HL
	INC DE
	DEC C
	JR NZ,L9D49
	PUSH DE
	LD DE,$001A	; 26
	ADD HL,DE	; next row
	POP DE
	DJNZ L9D47
L9D58:	CALL L9D5C	;Set update flags for Dog, 4x3 tiles
	RET

; Set update flags for Dog, 4x3 tiles
L9D5C:	LD C,$03	; 3 rows
	LD HL,(L71CB)
	LD DE,L678E	; Tile screen 1 start address
	ADD HL,DE
	LD A,$01	; "need to update" flag
	LD DE,$001A	; 26
L9D6A:	LD B,$04	; 4 columns
L9D6C:	LD (HL),A	; set the flag
	INC HL		; next column
	DJNZ L9D6C
	ADD HL,DE	; next row
	DEC C
	JR NZ,L9D6A	; continue loop by rows
	RET

; Draw Dog facing left in tilemap
L9D75:	INC HL
	INC HL
	INC HL
L9D78:	LD C,$04	; 4 rows
L9D7A:	LD A,(DE)
	LD (HL),A
	DEC HL
	INC DE
	DEC C
	JR NZ,L9D7A
	PUSH DE
	LD DE,$0022	; 34
	ADD HL,DE
	POP DE
	DJNZ L9D78
	JR L9D58	; => Set update flags for Dog, and RET

; ?? something about Dog
L9D8B:	LD HL,L7216	; Sprite Dog 4
	LD (L9D3B+1),HL
	LD A,(L71D2)
	CP $00
	JR Z,L9DB3
	LD A,(L71CD)	; get Dog direction
	CP $00		; left?
	JR Z,L9DA6	; left =>
	DEC A
	LD (L71CF),A
	JP L9D34
L9DA6:	INC A
	LD (L71D4),A
	LD HL,L71D4
	LD (L9C80+1),HL
	JP L9D34
L9DB3:	LD A,(L71CD)	; get Dog direction
	CP $00		; left?
	JR Z,L9DC7	; left =>
	DEC A
	LD (L71D4),A
	LD HL,L71D4
	LD (L9C80+1),HL
	JP L9D34
L9DC7:	LD (L71CF),A
	JP L9D34

; Initialize a dog
; HL = dog data address
L9DCD:	LD DE,L71CB	; current dog data address
L9DD0:	LD (LB673+1),HL	; save current Dog data address
	LD BC,$0009	; 9 = size of Dog data
	LDIR		; Copy Dog data
	RET

; Decrease Energy by B
L9DD9:	RET		; !!MUT-CMD!! $C5 PUSH BC or $C9 RET
	CALL L749E	; Decrease Energy
	POP BC
	LD A,(L749C)	; get Energy
	CP $04		; Energy = MIN ?
	JR NZ,L9DF1
	LD A,(L749D)	; get Energy lower
	CP $01
	JR NZ,L9DF1
L9DEC:	JP LBEAA	; Energy is out => Saboteur dead
	DI		; !!UNUSED!!
	RET
L9DF1:	DJNZ L9DD9	; continue loop by B
	DI
	RET

; Room 9DF5
L9DF5:	DEFW L7918	; Room procedure
	DEFW LA138	; Initialization
	DEFW L9BE7	; Room to Left
	DEFW $0000
	DEFW L9E22	; Room Up
	DEFW $0000
	DEFB $02,$07,$FF,$90,$65	; Fill horz 7 tiles with $FF at $6590
	DEFB $03,$FF,$02,$0C,$AC,$65	; Rectangle 2x12 tiles with $FF at $65AC
	DEFB $02,$7A,$FF,$14,$67	; Fill horz 122 tiles with $FF at $6714
	DEFB $0C,$48,$73,$02,$0D,$A4,$65	; Block 2 tiles from 7348 to $65A4 copy 13 times
	DEFB $0E,$2A,$A7,$6F		; Put tile $2A at $6FA7
	DEFB $01,$0B,$2B,$C5,$6F	; Fill vert 11 tiles with $2B at $6FC5
	DEFB $FF	; End of sequence

; Room 9E22
L9E22:	DEFW LB41F	; Room procedure
	DEFW LB422	; Initialization
	DEFW $0000
	DEFW $0000
	DEFW $0000
	DEFW L9DF5	; Room Down
	DEFB $04,$FF	; Fill entire screen with $FF
	DEFB $03,$00,$14,$02,$5A,$67	; Rectangle 20x2 tiles with $00 at $675A
	DEFB $03,$02,$1A,$0C,$B0,$65	; Rectangle 26x12 tiles with $02 at $65B0
	DEFB $09,$FF,$05,$C9,$65	; Triangle with $FF, count=5 at $65C9
	DEFB $0C,$48,$73,$02,$03,$48,$67	; Block 2 tiles from 7348 to $6748 copy 3 times
	DEFB $05,$02,$01,$9D,$88,$2A,$67	; Block 2x1 tiles from 889D to $672A
	DEFB $05,$02,$04,$BB,$71,$A5,$70	; Block 2x4 tiles from 71BB to $70A5
	DEFB $05,$03,$03,$A0,$71,$B7,$70	; Block 3x3 tiles from 71A0 to $70B7
	DEFB $05,$03,$03,$A0,$71,$BD,$70	; Block 3x3 tiles from 71A0 to $70BD
	DEFB $05,$03,$03,$A0,$71,$CA,$70	; Block 3x3 tiles from 71A0 to $70CA
	DEFB $05,$03,$04,$9C,$84,$96,$70	; Block 3x4 tiles from 849C to $7096
	DEFB $FF	; End of sequence

; Room 9E73
L9E73:	DEFW LB41F	; Room procedure
	DEFW LB422	; Initialization
	DEFW L9EB8	; Room to Left
	DEFW $0000
	DEFW $0000
	DEFW L9BE7	; Room Down
	DEFB $02,$78,$FF,$90,$65	; Fill horz 120 tiles with $FF at $6590
	DEFB $03,$FF,$06,$0D,$20,$66	; Rectangle 6x13 tiles with $FF at $6620
	DEFB $03,$FF,$06,$06,$E4,$66	; Rectangle 6x6 tiles with $FF at $66E4
	DEFB $08,$FF,$04,$1F,$67	; Triangle with $FF, count=4 at $671F
	DEFB $02,$0C,$FA,$DA,$66	; Fill horz 12 tiles with $FA at $66DA
	DEFB $01,$0D,$3A,$18,$66	; Fill vert 13 tiles with $3A at $6618
	DEFB $01,$07,$3A,$0C,$66	; Fill vert 7 tiles with $3A at $660C
	DEFB $02,$0A,$FA,$E9,$66	; Fill horz 10 tiles with $FA at $66E9
	DEFB $0C,$48,$73,$02,$0D,$1A,$66	; Block 2 tiles from 7348 to $661A copy 13 times
	DEFB $05,$02,$01,$9D,$88,$EC,$66	; Block 2x1 tiles from 889D to $66EC
	DEFB $FF	; End of sequence

; Room 9EB8
L9EB8:	DEFW L7918	; Room procedure
	DEFW LA12E	; Initialization
	DEFW L9ED9	; Room to Left
	DEFW L9E73	; Room to Right
	DEFW $0000
	DEFW $0000
	DEFB $02,$78,$FF,$90,$65	; Fill horz 120 tiles with $FF at $6590
	DEFB $02,$1E,$FA,$DA,$66	; Fill horz 30 tiles with $FA at $66DA
	DEFB $01,$07,$28,$03,$70	; Fill vert 7 tiles with $28 at $7003
	DEFB $01,$07,$28,$13,$70	; Fill vert 7 tiles with $28 at $7013
	DEFB $FF	; End of sequence

; Room 9ED9
L9ED9:	DEFW LB41F	; Room procedure
	DEFW LB422	; Initialization
	DEFW L9EFA	; Room to Left
	DEFW L9EB8	; Room to Right
	DEFW $0000
	DEFW $0000
	DEFB $02,$78,$FF,$90,$65	; Fill horz 120 tiles with $FF at $6590
	DEFB $02,$1E,$FA,$DA,$66	; Fill horz 30 tiles with $FA at $66DA
	DEFB $01,$07,$28,$05,$70	; Fill vert 7 tiles with $28 at $7005
	DEFB $01,$07,$28,$11,$70	; Fill vert 7 tiles with $28 at $7011
	DEFB $FF	; End of sequence

; Room 9EFA
L9EFA:	DEFW LB41F	; Room procedure
	DEFW LB422	; Initialization
	DEFW $0000
	DEFW L9ED9	; Room to Right
	DEFW $0000
	DEFW L9F3A	; Room Down
	DEFB $02,$7D,$FF,$90,$65	; Fill horz 125 tiles with $FF at $6590
	DEFB $03,$FF,$05,$0C,$26,$66	; Rectangle 5x12 tiles with $FF at $6626
	DEFB $03,$FF,$14,$05,$01,$67	; Rectangle 20x5 tiles with $FF at $6701
	DEFB $02,$13,$FF,$DF,$66	; Fill horz 19 tiles with $FF at $66DF
	DEFB $02,$06,$FA,$F2,$66	; Fill horz 6 tiles with $FA at $66F2
	DEFB $01,$07,$3A,$16,$66	; Fill vert 7 tiles with $3A at $6616
	DEFB $01,$07,$28,$17,$70	; Fill vert 7 tiles with $28 at $7017
	DEFB $0C,$48,$73,$02,$0D,$0E,$66	; Block 2 tiles from 7348 to $660E copy 13 times
	DEFB $05,$02,$01,$9D,$88,$E0,$66	; Block 2x1 tiles from 889D to $66E0
	DEFB $FF	; End of sequence

; Room 9F3A
L9F3A:	DEFW L7918	; Room procedure
	DEFW LA124	; Initialization
	DEFW $0000
	DEFW L9F7E	; Room to Right
	DEFW L9EFA	; Room Up
	DEFW L9B9D	; Room Down
	DEFB $03,$FF,$05,$0F,$90,$65	; Rectangle 5x15 tiles with $FF at $6590
	DEFB $02,$3C,$FF,$52,$67	; Fill horz 60 tiles with $FF at $6752
	DEFB $03,$FF,$14,$02,$99,$65	; Rectangle 20x2 tiles with $FF at $6599
	DEFB $0C,$48,$73,$02,$0F,$96,$65	; Block 2 tiles from 7348 to $6596 copy 15 times
	DEFB $05,$02,$04,$BB,$71,$E3,$70	; Block 2x4 tiles from 71BB to $70E3
	DEFB $01,$0D,$3A,$DA,$65	; Fill vert 13 tiles with $3A at $65DA
	DEFB $01,$0D,$3A,$E5,$65	; Fill vert 13 tiles with $3A at $65E5
	DEFB $05,$02,$01,$9D,$88,$68,$67	; Block 2x1 tiles from 889D to $6768
	DEFB $05,$02,$01,$48,$73,$86,$67	; Block 2x1 tiles from 7348 to $6786
	DEFB $FF	; End of sequence

; Room 9F7E
L9F7E:	DEFW L7918	; Room procedure
	DEFW LA129	; Initialization
	DEFW L9F3A	; Room to Left
	DEFW LA022	; Room to Right
	DEFW $0000
	DEFW $0000
	DEFB $03,$FF,$02,$02,$52,$67	; Rectangle 2x2 tiles with $FF at $6752
	DEFB $03,$A3,$1B,$02,$55,$67	; Rectangle 27x2 tiles with $A3 at $6755
	DEFB $05,$01,$02,$08,$A0,$54,$67	; Block 1x2 tiles from A008 to $6754
	DEFB $03,$F5,$1A,$0A,$20,$70	; Rectangle 26x10 tiles with $F5 at $7020
	DEFB $03,$FF,$02,$02,$20,$70	; Rectangle 2x2 tiles with $FF at $7020
	DEFB $05,$02,$02,$04,$A0,$2A,$66	; Block 2x2 tiles from A004 to $662A
	DEFB $05,$04,$04,$0A,$A0,$7C,$70	; Block 4x4 tiles from A00A to $707C
	DEFB $05,$04,$04,$0A,$A0,$80,$70	; Block 4x4 tiles from A00A to $7080
	DEFB $05,$04,$04,$0A,$A0,$84,$70	; Block 4x4 tiles from A00A to $7084
	DEFB $05,$04,$04,$0A,$A0,$88,$70	; Block 4x4 tiles from A00A to $7088
	DEFB $05,$04,$04,$0A,$A0,$8C,$70	; Block 4x4 tiles from A00A to $708C
	DEFB $05,$04,$04,$0A,$A0,$90,$70	; Block 4x4 tiles from A00A to $7090
	DEFB $03,$1B,$18,$04,$86,$66	; Rectangle 24x4 tiles with $1B at $6686
	DEFB $03,$A3,$18,$02,$F0,$65	; Rectangle 24x2 tiles with $A3 at $65F0
	DEFB $05,$01,$02,$08,$A0,$EF,$65	; Block 1x2 tiles from A008 to $65EF
	DEFB $0E,$98,$D3,$65		; Put tile $98 at $65D3
	DEFB $02,$16,$0D,$D4,$65	; Fill horz 22 tiles with $0D at $65D4
	DEFB $05,$04,$02,$1A,$A0,$A6,$65	; Block 4x2 tiles from A01A to $65A6
	DEFB $03,$0D,$04,$02,$AA,$65	; Rectangle 4x2 tiles with $0D at $65AA
	DEFB $FF	; End of sequence

; Blocks for rooms
LA004:	DEFB $00,$98	; Back block 2x2
	DEFB $98,$95
LA008:	DEFB $9E	; Back block 1x2
	DEFB $9D
LA00A:	DEFB $FE,$FB,$FB,$F8	; Front block 4x4
	DEFB $FD,$FF,$FF,$F7
	DEFB $FD,$FF,$FF,$F7
	DEFB $FC,$F9,$F9,$F6
LA01A:	DEFB $00,$00,$97,$96	; Back block 4x2
	DEFB $97,$96,$0D,$0D

; Room A022
LA022:	DEFW LB41F	; Room procedure
	DEFW LB422	; Initialization
	DEFW L9F7E	; Room to Left
	DEFW $0000
	DEFW $0000
	DEFW $0000
	DEFB $03,$A3,$1B,$02,$52,$67	; Rectangle 27x2 tiles with $A3 at $6752
	DEFB $03,$F5,$1A,$0A,$1C,$70	; Rectangle 26x10 tiles with $F5 at $701C
	DEFB $03,$FF,$02,$02,$34,$70	; Rectangle 2x2 tiles with $FF at $7034
	DEFB $05,$02,$02,$A7,$A0,$3E,$66	; Block 2x2 tiles from A0A7 to $663E
	DEFB $05,$04,$04,$0A,$A0,$76,$70	; Block 4x4 tiles from A00A to $7076
	DEFB $05,$04,$04,$0A,$A0,$7A,$70	; Block 4x4 tiles from A00A to $707A
	DEFB $05,$04,$04,$0A,$A0,$7E,$70	; Block 4x4 tiles from A00A to $707E
	DEFB $05,$04,$04,$0A,$A0,$82,$70	; Block 4x4 tiles from A00A to $7082
	DEFB $05,$04,$04,$0A,$A0,$86,$70	; Block 4x4 tiles from A00A to $7086
	DEFB $05,$04,$04,$0A,$A0,$8A,$70	; Block 4x4 tiles from A00A to $708A
	DEFB $03,$1B,$18,$04,$80,$66	; Rectangle 24x4 tiles with $1B at $6680
	DEFB $03,$A3,$18,$02,$EA,$65	; Rectangle 24x2 tiles with $A3 at $65EA
	DEFB $05,$01,$02,$AB,$A0,$02,$66	; Block 1x2 tiles from A0AB to $6602
	DEFB $0E,$94,$E2,$65		; Put tile $94 at $65E2
	DEFB $02,$16,$0D,$CC,$65	; Fill horz 22 tiles with $0D at $65CC
	DEFB $05,$04,$02,$AD,$A0,$94,$65	; Block 4x2 tiles from A0AD to $6594
	DEFB $03,$0D,$04,$02,$90,$65	; Rectangle 4x2 tiles with $0D at $6590
	DEFB $01,$08,$FF,$7B,$66	; Fill vert 8 tiles with $FF at $667B
	DEFB $05,$01,$02,$AB,$A0,$6D,$67	; Block 1x2 tiles from A0AB to $676D
	DEFB $FF	; End of sequence

; Blocks for rooms
LA0A7:	DEFB $94,$00	; Back block 2x2
	DEFB $0D,$94
LA0AB:	DEFB $9C	; Back block 1x2
	DEFB $9B
LA0AD:	DEFB $93,$92,$00,$00	; Back block 4x2
	DEFB $0D,$0D,$93,$92

; Sprite Ninja/Guard dead, 6x7 tiles
LA0B5:	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$ED,$EC,$EB,$FF
	DEFB $F3,$F2,$F1,$F0,$EF,$EE

; Room 94AB initialization
LA0DF:	LD HL,LA1E1	; Guard data address
; Initialize a guard, then Standard room initialization
LA0E2:	CALL LB40A	; Initialize a guard
;
LA0E5:	JP LB422	; Standard room initialization

; Room 7DA9 initialization
LA0E8:	LD HL,LA1E7	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 7E8C initialization
LA0ED:	LD HL,LA1ED	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 920A initialization
LA0F2:	LD HL,LA1F3	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 8F84 initialization
LA0F7:	LD HL,LA1F9	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 8B71 initialization
LA0FC:	LD HL,LA1FF	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 8739 initialization
LA101:	LD HL,LA205	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 858F initialization
LA106:	LD HL,LA20B	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 84EE initialization
LA10B:	LD HL,LA211	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 99A6 initialization
LA110:	LD HL,LA21D	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 97F8 initialization
LA115:	LD HL,LA223	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 94CF initialization
LA11A:	LD HL,LA229	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 9B51 initialization
LA11F:	LD HL,LA22F	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 9F3A initialization
LA124:	LD HL,LA235	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 9F7E initialization
LA129:	LD HL,LA23B	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 9EB8 initialization
LA12E:	LD HL,LA241	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 9B19 initialization
LA133:	LD HL,LA247	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 9DF5 initialization
LA138:	LD HL,LA24D	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; ?? UNUSED??
LA13D:	LD HL,LA217	; Guard data address
	JR LA0E2	; Initialize a guard, then Standard room initialization

; Room 7A17 initialization
LA142:	LD HL,LA33E	; Turret data address

; Initialize a turret, then Standard room initialization
LA145:	CALL LB461	; Initialize a turret
	JR LA0E5	; Standard room initialization

; Room 7D5A initialization
LA14A:	LD HL,LA32F	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; Room 7F48 initialization
LA14F:	LD HL,LA332	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; Room 7EF2 initialization
LA154:	LD HL,LA299	; Dog data address
	CALL L9DCD	; Initialize a dog
	LD HL,LA338	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; Room 909F initialization
LA15F:	LD HL,LA2E9	; Dog data address
	CALL L9DCD	; Initialize a dog
	LD HL,LA338	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; Room 8FBD initialization
LA16A:	LD HL,LA335	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; Room 92A7 initialization
LA16F:	LD HL,LA338	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; Room 8B25 initialization
LA174:	LD HL,LA33B	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; Room 8526 initialization
LA179:	LD HL,LA33E	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; ?? UNUSED??
LA17E:	LD HL,LA341	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; Room 95D6 initialization
LA183:	LD HL,LA344	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; Room 968A initialization
LA188:	LD HL,LA347	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; Finish Room 97A6 initialization
LA18D:	LD HL,LA34A	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; Room 9A9A initialization
LA192:	LD HL,LA332	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; Room 9552 initialization
LA197:	LD HL,LA34D	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; Room 9BE7 initialization
LA19C:	LD HL,LA350	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; Room 8D5C initialization
LA1A1:	LD HL,LA33B	; Turret data address
	JR LA145	; Initialize a turret, then Standard room initialization

; Room 7C2E initialization
LA1A6:	LD HL,LA271	; Dog data address
	CALL L9DCD	; Initialize a dog
	LD HL,LA253	; Guard data address

; Finish room initialization
LA1AF:	CALL LB40A	; Initialize a guard
	JP LB422	; Standard room initialization

; Room 7F9C initialization
LA1B5:	LD HL,LA27B	; Dog data address
	CALL L9DCD	; Initialize a dog
	LD HL,LA259	; Guard data address
	JR LA1AF	; Initialize a guard, then Standard room initialization

; Room 8162 initialization
LA1C0:	LD HL,LA28F	; Dog data address
	CALL L9DCD	; Initialize a dog
	LD HL,LA25F	; Guard data address
	JR LA1AF	; Initialize a guard, then Standard room initialization

; Room 80A7 initialization
LA1CB:	LD HL,LA2AD	; Dog data address
	CALL L9DCD	; Initialize a dog
	LD HL,LA265	; Guard data address
	JR LA1AF	; Initialize a guard, then Standard room initialization

; Room 9B9D initialization
LA1D6:	LD HL,LA325	; Dog data address
	CALL L9DCD	; Initialize a dog
	LD HL,LA26B	; Guard data address
	JR LA1AF	; Initialize a guard, then Standard room initialization

; Guards data, 24 records, 6 bytes each
; +$04: Guard state, initially $0A
; +$05: Guard direction
LA1E1:	DEFB $9D,$00,$07,$05,$0A,$01	; Room 94AB guard
LA1E7:	DEFB $18,$01,$0A,$09,$0A,$00	; Room 7DA9 guard
LA1ED:	DEFB $14,$01,$06,$09,$0A,$00	; Room 7E8C guard
LA1F3:	DEFB $13,$01,$05,$09,$0A,$00	; Room 920A guard
LA1F9:	DEFB $C8,$00,$14,$06,$0A,$00	; Room 8F84 guard
LA1FF:	DEFB $20,$01,$12,$09,$0A,$01	; Room 8B71 guard
LA205:	DEFB $50,$00,$14,$02,$0A,$01	; Room 8739 guard
LA20B:	DEFB $1E,$01,$10,$09,$0A,$00	; Room 858F guard
LA211:	DEFB $01,$01,$11,$08,$0A,$01	; Room 84EE guard
LA217:	DEFB $18,$01,$0A,$09,$0A,$00	; UNUSED, see A13D
LA21D:	DEFB $22,$01,$14,$09,$0A,$01	; Room 99A6 guard
LA223:	DEFB $F9,$00,$09,$08,$0A,$00	; Room 97F8 guard
LA229:	DEFB $02,$01,$12,$08,$0A,$01	; Room 94CF guard
LA22F:	DEFB $DF,$00,$0D,$07,$0A,$01	; Room 9B51 guard
LA235:	DEFB $F7,$00,$07,$08,$0A,$01	; Room 9F3A guard
LA23B:	DEFB $F8,$00,$08,$08,$0A,$00	; Room 9F7E guard
LA241:	DEFB $86,$00,$0E,$04,$0A,$01	; Room 9EB8 guard
LA247:	DEFB $A2,$00,$0C,$05,$0A,$00	; Room 9B19 guard
LA24D:	DEFB $BB,$00,$07,$06,$0A,$00	; Room 9DF5 guard
LA253:	DEFB $C2,$00,$0E,$06,$0A,$00	; Room 7C2E guard
LA259:	DEFB $D4,$00,$02,$07,$0A,$00	; Room 7F9C guard
LA25F:	DEFB $0B,$00,$0B,$00,$0A,$01	; Room 8162 guard
LA265:	DEFB $20,$01,$12,$09,$0A,$01	; Room 80A7 guard
LA26B:	DEFB $30,$00,$12,$01,$0A,$01	; Room 9B9D guard

; Dogs data, 19 records, 10 bytes each
; +$00/$01: Dog position in tilemap
; +$02: Dog direction
; +$03: Dog X position
; +$05: Dog left limit
; +$06: Dog right limit
; +$08: Dog Y position
LA271:	DEFB $3C,$01,$00,$10,$00,$03,$16,$00,$03,$01	; Room 7C2E dog
LA27B:	DEFB $5E,$01,$01,$14,$00,$03,$16,$01,$04,$01	; Room 7F9C dog
LA285:	DEFB $A5,$00,$00,$0F,$00,$05,$0F,$00,$FE,$01	; Room 81E5 dog
LA28F:	DEFB $7A,$00,$01,$02,$00,$00,$18,$01,$FD,$01	; Room 8162 dog
LA299:	DEFB $8F,$01,$01,$09,$00,$03,$18,$01,$06,$01	; Room 7EF2 dog
LA2A3:	DEFB $8A,$01,$01,$04,$00,$02,$1A,$01,$06,$01	; Room 7E05 dog
LA2AD:	DEFB $9A,$01,$00,$14,$01,$03,$15,$01,$06,$01	; Room 80A7 dog
LA2B7:	DEFB $92,$01,$00,$0C,$00,$05,$19,$00,$06,$01	; Room 83ED dog
LA2C1:	DEFB $8C,$01,$01,$06,$01,$01,$17,$00,$06,$01	; Room 80F6 dog
LA2CB:	DEFB $90,$01,$00,$0A,$00,$04,$17,$00,$06,$01	; Room 924E dog
LA2D5:	DEFB $1B,$01,$01,$0D,$00,$06,$18,$01,$02,$01	; Room 91BA dog
LA2DF:	DEFB $76,$01,$01,$0E,$00,$00,$0F,$01,$05,$01	; Room 90DB dog
LA2E9:	DEFB $97,$01,$01,$11,$00,$0D,$1A,$01,$06,$01	; Room 909F dog
LA2F3:	DEFB $BC,$00,$00,$08,$00,$01,$0E,$00,$FF,$01	; Room 8802 dog
LA2FD:	DEFB $A4,$00,$00,$0E,$00,$02,$0E,$00,$FE,$01	; Room 8608 dog
LA307:	DEFB $8E,$01,$00,$08,$00,$07,$17,$00,$06,$01	; Room 844E dog
LA311:	DEFB $8D,$01,$01,$07,$00,$03,$15,$01,$06,$01	; Room 9739 dog
LA31B:	DEFB $F6,$00,$00,$06,$00,$02,$0F,$00,$01,$01	; Room 9A5A dog
LA325:	DEFB $8C,$01,$01,$06,$00,$04,$18,$01,$06,$01	; Room 9B9D dog

; Turrets data, 12 records, 3 bytes each
LA32F:	DEFB $C4,$00,$0E	; Room 7A17 turret
LA332:	DEFB $27,$00,$07	; Room 7F48/9A9A turret
LA335:	DEFB $11,$00,$0F	; Room 8FBD turret
LA338:	DEFB $2B,$00,$0A	; Room 7EF2/909F/92A7 turret
LA33B:	DEFB $4B,$00,$0D	; Room 8B25/8D5C turret
LA33E:	DEFB $2F,$00,$0F	; Room 7A17/8526 turret
LA341:	DEFB $32,$00,$12	; UNUSED, see A17E
LA344:	DEFB $9D,$00,$05	; Room 95D6 turret
LA347:	DEFB $A6,$00,$0E	; Room 968A turret
LA34A:	DEFB $0A,$01,$18	; Room 97A6 turret
LA34D:	DEFB $3F,$00,$01	; Room 9552 turret
LA350:	DEFB $A3,$00,$0B	; Room 9BE7 turret

; Room 81E5 initialization
LA353:	LD HL,LA285	; Dog data address
; Initialize a dog, then Standard room initialization
LA356:	CALL L9DCD	; Initialize a dog
	JP LB422	; Standard room initialization

; Room 7E05 initialization
LA35C:	LD HL,LA2A3	; Dog data address
	JR LA356	; Initialize a dog, then Standard room initialization

; Room 83ED initialization
LA361:	LD HL,LA2B7	; Dog data address
	JR LA356	; Initialize a dog, then Standard room initialization

; Room 924E initialization
LA366:	LD HL,LA2CB	; Dog data address
	JR LA356	; Initialize a dog, then Standard room initialization

; Room 91BA initialization
LA36B:	LD HL,LA2D5	; Dog data address
	JR LA356	; Initialize a dog, then Standard room initialization

; Room 90DB initialization
LA370:	LD HL,LA2DF	; Dog data address
	JR LA356	; Initialize a dog, then Standard room initialization

; Room 8802 initialization
LA375:	LD HL,LA2F3	; Dog data address
	JR LA356	; Initialize a dog, then Standard room initialization

; Room 8608 initialization
LA37A:	LD HL,LA2FD	; Dog data address
	JR LA356	; Initialize a dog, then Standard room initialization

; Room 844E initialization
LA37F:	LD HL,LA307	; Dog data address
	JR LA356	; Initialize a dog, then Standard room initialization

; Room 9739 initialization
LA384:	LD HL,LA311	; Dog data address
	JR LA356	; Initialize a dog, then Standard room initialization

; Room 9A5A initialization
LA389:	LD HL,LA31B	; Dog data address
	JR LA356	; Initialize a dog, then Standard room initialization

; Room 80F6 initialization
LA38E:	LD HL,LA2C1	; Dog data address
	JR LA356	; Initialize a dog, then Standard room initialization

; Data block at A393
LA393:	DEFB $90,$01,$01,$0A,$42,$01,$17,$01
LA39B:	DEFB $06,$01,$00
LA39E:	DEFB $00
LA39F:	DEFB $00
LA3A0:	DEFB $C4,$00
LA3A2:	DEFB $00
LA3A3:	DEFB $03
LA3A4:	DEFB $06
LA3A5:	DEFB $10
LA3A6:	DEFB $00
LA3A7:	DEFB $45,$01,$05,$05
LA3AB:	DEFB $0A,$19
LA3AD:	DEFB $00
LA3AE:	DEFB $69,$00,$06,$06,$03
LA3B3:	DEFB $0F
LA3B4:	DEFB $01	; ?? Guard counter

; Ninja and Guard in 12 tiles by X
LA3B5:	LD A,(L9C40)	; get Ninja Y
	LD HL,L71C6	; Guard Y position address
	CP (HL)		; compare Ninja Y to Guard Y
	RET NZ
	POP HL
LA3BE:	LD A,$14	; !!MUT-ARG!! ??
	LD (LA3B4),A
	LD A,$0B
	LD (L7346),A	; set Guard state = $0B
	LD HL,LD504	; Sprite Ninja/Guard punching
	LD (LA70E+1),HL	; set Guard sprite
	JP LA6FF	; => Draw Guard on tilemap

; Ninja and Guard in 9 tiles by X
LA3D1:	LD A,(L9C40)	; get Ninja Y
	LD HL,L71C6	; Guard Y position address
	CP (HL)		; compare Ninja Y to Guard Y
	RET NZ
	LD A,(LA3A6)
	CP $00
	RET NZ
	POP HL
	LD A,$14
	LD (L7346),A	; set Guard state = $14
	LD HL,LD504	; Sprite Ninja/Guard punching
	LD (LA70E+1),HL	; set Guard sprite
	JP LA6FF	; => Draw Guard on tilemap

; Ninja and Guard in 3 tiles by X
LA3EE:	LD A,(L9C40)	; get Ninja Y
	LD HL,L71C6	; Guard Y position address
	CP (HL)		; compare Ninja Y to Guard Y
	RET NZ
	LD HL,(L71C3)	; get Guard position in tilemap
	LD DE,L6590+2	; $6592 = $6590 (Tile screen 0) + 2
	ADD HL,DE	; now HL in Back tile screen
	LD A,$64
	CP (HL)
	RET C
	INC HL
	CP (HL)
	RET C
	POP HL
	LD A,$05
	LD (L7346),A	; set Guard state = $05
	LD A,$02
	LD (LA3B4),A	; set Guard counter
	LD HL,LD4B0	; Sprite Ninja/Guard jumping
	LD (LA70E+1),HL	; set Guard sprite
	JP LA6FF	; => Draw Guard on tilemap

; Ninja and Guard are very close by X
LA418:	LD A,(L9C40)	; get Ninja Y
	LD HL,L71C6	; Guard Y position address
	CP (HL)		; compare Ninja Y to Guard Y
	RET NZ
	POP HL
	LD A,$08
	LD (L7346),A	; set Guard state = $08
	LD A,$03
	LD (LA3B4),A	; set Guard counter
	LD HL,LD504	; Sprite Ninja/Guard punching
	LD (LA70E+1),HL	; set Guard sprite
	JP LA6FF	; => Draw Guard on tilemap

; Process a Guard
LA434:	CALL LA75B	; Set update flags for Guard, 6x7 tiles
	LD HL,L7346	; Guard state address
	LD A,(HL)	; get Guard state

; Guard state = $0B ?
LA43B:	CP $0B
	JP NZ,LA4E7
	LD HL,LA3B4	; Guard counter address
	DEC (HL)	; decrease Guard counter
	LD A,(HL)	; get Guard counter
	CP $06
	JP NC,LA6FF	; => Draw Guard on tilemap
	LD A,$10
	OUT ($FE),A
	LD A,(L71C6)	; get Guard Y
	ADD A,A		; Guard Y * 2
	LD (LA45D+2),A
	INC A		; Guard Y * 2 + 1
	LD (LA460+2),A
	LD IX,LA747
LA45D:	LD L,(IX+$04)
LA460:	LD H,(IX+$05)
	LD A,(L71C5)	; get Guard X
	LD D,$00
	LD E,A
	ADD HL,DE
	LD DE,$003C
	LD A,(L71C5)	; get Guard X
	INC A
	PUSH HL
	LD HL,(L71C3)	; get Current Guard position in tilemap
	ADD HL,DE
	EX DE,HL
	POP HL
	LD B,A
	LD A,$2B	; "DEC HL" instruction
	LD (LA4D0),A	; set the instruction
	LD A,$1B	; "DEC DE" instruction
	LD (LA4D1),A	; set the instruction
	LD A,(L7347)	; get Guard direction
	CP $00		; left?
	JR Z,LA4A2	; yes =>
	LD A,$1A	; 26
	SUB B
	LD B,A
	INC DE
	INC DE
	INC DE
	INC DE
	INC DE		; +5
	INC HL
	INC HL
	INC HL
	INC HL
	INC HL		; +5
	LD A,$23	; "INC HL" instruction
	LD (LA4D0),A	; set the instruction
	LD A,$13	; "INC DE" instruction
	LD (LA4D1),A	; set the instruction
LA4A2:	PUSH HL
	LD HL,L6590	; Tile screen 0 start address
	ADD HL,DE
	LD A,$64
	CP (HL)
	JR C,LA4CD
	LD HL,L6F86	; Tile screen 5 start address
	ADD HL,DE
	LD A,(HL)
	INC A
	JR NZ,LA4C0
	LD HL,L678E	; Tile screen 1 start address
	ADD HL,DE
	LD (HL),$01
	POP HL
	PUSH HL
	LD A,$CC
	XOR (HL)
	LD (HL),A
LA4C0:	LD HL,L698C	; Tile screen 2 start address
	ADD HL,DE
	LD A,(HL)
	INC A
	JR Z,LA4CF
	LD B,$04
	CALL L9DD9	; Decrease Energy by B
LA4CD:	LD B,$01
LA4CF:	POP HL
LA4D0:	DEC HL		; !!MUT-CMD!! "DEC HL" or "INC HL" instruction
LA4D1:	DEC DE		; !!MUT-CMD!! "DEC DE" or "INC DE" instruction
	DJNZ LA4A2
	XOR A
	OUT ($FE),A
	LD A,(LA3B4)	; get Guard counter
	CP $00
	JP NZ,LA6FF	; => Draw Guard on tilemap
	LD A,$04
	LD (L7346),A	; set Guard state = $04
	JP LA6FF	; => Draw Guard on tilemap

; Guard state = $14 ?
LA4E7:	CP $14
	JR NZ,LA52F
	LD (HL),$04	; set Guard state = $04
	LD HL,LD486	; Sprite Ninja/Guard standing
	LD (LA70E+1),HL	; set Guard sprite
	LD HL,(L71C3)	; get Guard position in tilemap
	LD DE,$003C	; 60
	LD B,$00
	LD C,$03
	LD A,(L7347)	; get Guard direction
	CP $00		; left?
	JR Z,LA50B	; left =>
	LD C,$05
	LD B,$05
	LD DE,$0041	; 65
LA50B:	ADD HL,DE
	LD (LA3A7),HL
	LD A,(L71C5)	; get Guard X
	ADD A,B
	LD IX,LA3A6
	LD (IX+$00),$CA
	LD (IX+$03),C
	LD (IX+$04),C
	LD (IX+$06),A
	LD A,(L71C6)	; get Guard Y
	ADD A,$02	; Guard Y + 2
	LD (IX+$05),A
	JP LA6FF	; => Draw Guard on tilemap

; Guard state = $0A ?
LA52F:	CP $0A
	JR NZ,LA56D
	LD HL,LD486	; Sprite Ninja/Guard standing
	LD (LA70E+1),HL	; set Guard sprite
	LD HL,L9C40	; Ninja Y address
	LD A,(L71C6)	; get Guard Y
	ADD A,$03	; Guard Y + 3
	CP (HL)		; compare with Ninja Y
	JP C,LA6FF	; Guard above Ninja => Draw Guard on tilemap
	LD A,(LA39E)
	DEC A
	JR Z,LA565
	LD A,(L7347)	; get Guard direction: 0 / 1
	DEC A		; $FF left / 0 right
	LD A,(L71C5)	; get Guard X
	LD HL,L9C41	; Ninja X address
	JR Z,LA55F	; right =>
	ADD A,$02	; for left, Guard X + 2
	CP (HL)		; compare with Ninja X
	JP C,LA6FF	; Guard still behind Ninja => Draw Guard on tilemap
	JR LA565
LA55F:	SUB $03		; for right, Guard X - 3
	CP (HL)		; compare with Ninja X
	JP NC,LA6FF	; Guard not reached Ninja => Draw Guard on tilemap
LA565:	LD A,$04	; state $04
	LD (L7346),A	; set Guard state = $04
	JP LA6FF	; => Draw Guard on tilemap

; Guard state = $09 ? - Guard is dead
LA56D:	CP $09
	JR NZ,LA57A
	LD HL,LA0B5	; Sprite Ninja dead
	LD (LA70E+1),HL	; set Guard sprite
	JP LA6FF	; => Draw Guard on tilemap

; Guard state = $08 ?
LA57A:	CP $08
	JR NZ,LA5AA
	PUSH HL
	LD HL,LA3B4	; Guard counter address
	DEC (HL)	; decrease Guard counter
	POP HL
	JP NZ,LA6FF	; => Draw Guard on tilemap
	LD (HL),$03	; set Guard state = walking state 3
	LD HL,(L71C3)
	LD DE,L698C+64	; $69CC = $698C (Tile screen 2) + 64
	LD A,(L7347)	; get Guard direction
	CP $01		; right?
	JR Z,LA599	; yes =>
	LD DE,L698C+61	; $69C9 = $698C (Tile screen 2) + 61
LA599:	ADD HL,DE
	LD A,(HL)
	INC A
	LD B,$06
	CALL NZ,LFA31	; => Decrease Energy by B + Sound
	LD HL,LD486	; Sprite Ninja/Guard standing
	LD (LA70E+1),HL	; set Guard sprite
	JP LA6FF	; => Draw Guard on tilemap

; Guard state = $05 ? - Preparing for jump-kick
LA5AA:	CP $05
	JR NZ,LA5C7
	PUSH HL
	LD HL,LA3B4	; Guard counter address
	DEC (HL)	; decrease Guard counter
	POP HL
	JP NZ,LA6FF	; => Draw Guard on tilemap
	LD A,$03
	LD (LA3B4),A	; set Guard counter value
	LD (HL),$06	; set Guard state = $06: jump-kick
	LD HL,LD4DA	; Sprite Ninja/Guard jump-kick
	LD (LA70E+1),HL	; set Guard sprite
	JP LA6FF	; => Draw Guard on tilemap

; Guard state = $06 ?
LA5C7:	CP $06
	JR NZ,LA5FC
	PUSH HL
	LD HL,LA3B4	; Guard counter address
	DEC (HL)	; decrease Guard counter
	POP HL
	JP NZ,LA6FF	; => Draw Guard on tilemap
	LD A,$01
	LD (LA3B4),A	; set Guard counter value
	LD (HL),$07	; set Guard state = $07: back to standing
	LD HL,LD4B0	; Sprite Ninja/Guard jumping
	LD (LA70E+1),HL	; set Guard sprite
	LD HL,(L71C3)	; get Guard position in tilemap
	LD DE,L698C+65	; $69CD = $698C (Tile screen 2) + 65
	LD A,(L7347)	; get Guard direction
	CP $01		; right?
	JR Z,LA5F1	; right =>
	LD DE,L698C+60	; $69C8 = $698C (Tile screen 2) + 60
LA5F1:	ADD HL,DE	; now HL = address in Ninja tile screen
	LD A,(HL)	; get tile from Ninja screen
	INC A		; $FF ?
	LD B,$0A	; 10 damage
	CALL NZ,LFA31	; not $FF => Decrease Energy by 10 + Sound
	JP LA6FF	; => Draw Guard on tilemap

; Guard state = $07 ? - back to standing
LA5FC:	CP $07
	JR NZ,LA614
	PUSH HL
	LD HL,LA3B4	; Guard counter address
	DEC (HL)	; decrease Guard counter
	POP HL
	JP NZ,LA6FF	; counter not zero => Draw Guard on tilemap
	LD (HL),$03	; set Guard state = walking phase 3
	LD HL,LD486	; Sprite Ninja/Guard standing
	LD (LA70E+1),HL	; set Guard sprite
	JP LA6FF	; => Draw Guard on tilemap

; Guard state is none of the above
LA614:	LD HL,L9C41	; Ninja X address
	LD A,(L71C5)	; get Guard X
	SUB (HL)	; compare to Ninja X
	JR NZ,LA635	; not equal =>
	CALL LA418
	LD HL,L7346	; Guard state address
	LD A,$0A
	CP (HL)		; Guard state = $0A ?
	JP Z,LA6FF	; Guard state is $0A => Draw Guard on tilemap
	LD A,$04
	LD (HL),A	; set Guard state = $04
	LD HL,LD486	; Sprite Ninja/Guard standing
	LD (LA70E+1),HL	; set Guard sprite
	JP LA6FF	; => Draw Guard on tilemap

; Guard X != Ninja X
LA635:	JR C,LA68C	; Guard X < Ninja X =>

; Ninja X < Guard X
LA637:	LD B,A		; save value "Guard X - Ninja X"
	LD A,(L7347)	; get Guard direction
	CP $00		; left?
	JR Z,LA65B	; left =>
	LD A,(L7346)	; get Guard state
	CP $04		; Guard state = $04 ?
	JR Z,LA654
	LD A,$04
	LD (L7346),A	; set Guard state = $04
	LD HL,LD486	; Sprite Ninja/Guard standing
	LD (LA70E+1),HL	; set Guard sprite
	JP LA6FF	; => Draw Guard on tilemap
LA654:	XOR A
	LD (L7347),A	; set Guard direction = left
	JP LA6FF	; => Draw Guard on tilemap
LA65B:	LD A,B		; restore value "Guard X - Ninja X"
	CP $03		; 3
	CALL Z,LA3EE
	CP $01		; 1
	CALL Z,LA418
	CP $09		; 9
	CALL Z,LA3D1
	CP $0C		; 12
	CALL Z,LA3B5
	LD A,(L7346)	; get Guard state
	CP $04		; Guard state = $04 ?
	JR NZ,LA67F	; no =>
	LD A,$03	; walking phase 3
	LD (L7346),A	; set Guard state
	JP LA6FF	; => Draw Guard on tilemap
LA67F:	LD HL,L71C5	; Guard X address
	DEC (HL)	; decrease Guard X - move one tile left
	XOR A
	LD (L7347),A	; set Guard direction = left
	LD DE,$FFFF
	JR LA6DE

; Guard X < Ninja X
LA68C:	LD B,A
	LD A,(L7347)	; get Guard direction
	CP $01		; right?
	JR Z,LA6AF	; right =>
	LD A,(L7346)	; get Guard state
	CP $04		; Guard state = $04 ?
	JR Z,LA6A8
	LD A,$04
	LD (L7346),A	; set Guard state = $04
	LD HL,LD486	; Sprite Ninja/Guard standing
	LD (LA70E+1),HL	; set Guard sprite
	JR LA6FF	; => Draw Guard on tilemap
LA6A8:	LD A,$01
	LD (L7347),A	; set Guard direction = right
	JR LA6FF	; => Draw Guard on tilemap
LA6AF:	LD A,B
	CP $FD		; -3
	CALL Z,LA3EE
	CP $FF		; -1
	CALL Z,LA418
	CP $F7		; -9
	CALL Z,LA3D1
	CP $F4		; -12
	CALL Z,LA3B5
	LD A,(L7346)	; get Guard state
	CP $04		; Guard state = $04 ?
	JR NZ,LA6D2
	LD A,$03
	LD (L7346),A	; set Guard state = walking phase 3
	JR LA6FF	; => Draw Guard on tilemap
LA6D2:	LD HL,L71C5	; Guard X address
	INC (HL)	; increase Guard X - move one tile right
	LD A,$01
	LD (L7347),A	; set Guard direction = right
	LD DE,$0001
LA6DE:	LD HL,(L71C3)	; get Guard position in tilemap
	ADD HL,DE
	LD (L71C3),HL	; update Guard position in tilemap
	LD A,(L7346)	; get Guard state
	INC A		; next walking phase
	AND $03		; 0..3
	LD (L7346),A	; set Guard state
	ADD A,A		; * 2
	LD L,A
	LD H,$00
	LD DE,L733B	; Table of four Ninja/Guard walking sprites
	ADD HL,DE
	LD DE,LA70E+1	; Guard sprite address
	LD A,(HL)
	LD (DE),A
	INC HL
	INC DE
	LD A,(HL)
	LD (DE),A

; Draw Guard on tilemap
LA6FF:	LD DE,(L71C3)	; get Guard position in tilemap
	LD A,(L7347)	; get Guard direction
	CP $00		; left?
	JR NZ,LA728	; right =>
	LD HL,L6D88+5	; Tile screen 4 start address + 5
	ADD HL,DE
LA70E:	LD DE,LD432	; !!MUT-ARG!! current Ninja/Guard sprite address
	LD B,$07	; 7 rows
LA713:	LD C,$06	; 6 rows
LA715:	LD A,(DE)
	CALL LA775	; Translate Ninja tile A into Guard tile
	LD (HL),A
	DEC HL
	INC DE
	DEC C
	JR NZ,LA715
	PUSH DE
	LD DE,$0024	; 36
	ADD HL,DE	; next row
	POP DE
	DJNZ LA713	; continue loop by rows
	RET
LA728:	LD HL,L6D88	; Tile screen 4 start address
	ADD HL,DE
	LD DE,(LA70E+1)	; get Guard sprite address
	LD B,$07	; 7 rows
LA732:	LD C,$06	; 6 rows
LA734:	LD A,(DE)	; get tile
	CALL LA775	; Translate Ninja tile A into Guard tile
	LD (HL),A
	INC HL
	INC DE
	DEC C
	JR NZ,LA734
	PUSH DE
	LD DE,$0018	; 24
	ADD HL,DE	; next row
	POP DE
	DJNZ LA732	; continue loop by rows
	RET

LA747:	DEFB $61,$45,$81,$45,$A1,$45,$C1,$45
	DEFB $E1,$45,$01,$4D,$21,$4D,$41,$4D
	DEFB $61,$4D,$81,$4D

; Set update flags for Guard, 6x7 tiles
LA75B:	LD DE,(L71C3)	; get Current Guard position in tilemap
	LD HL,L678E	; Tile screen 1 start address
	ADD HL,DE	; now HL in update flags tilemap
	LD DE,$0018	; 24
	LD A,$01	; "need to update" flag
	LD B,$07	; 7 rows
LA76A:	LD C,$06	; 6 columns
LA76C:	LD (HL),A	; set the flag
	INC HL		; next column
	DEC C
	JR NZ,LA76C	; continue loop by columns
	ADD HL,DE	; next row
	DJNZ LA76A	; continue loop by rows
	RET

; Translate Ninja tile A into Guard tile, using A787 table
LA775:	EXX
	LD HL,LA787	; Translate table address
	LD B,$13	; 19 records
LA77B:	CP (HL)		; found the tile?
	INC HL
	JR NZ,LA782
	LD A,(HL)	; get the new tile
	EXX
	RET
LA782:	INC HL
	DJNZ LA77B	; continue the loop
	EXX
	RET

; Table used to translate Ninja tiles to Guard tiles, 19 records
LA787:	DEFB $50,$C7,$51,$DC,$54,$DD,$EA,$DE
	DEFB $13,$DF,$15,$E0,$16,$E1,$00,$E2
	DEFB $01,$E3,$03,$E4,$04,$E5,$4D,$E6
	DEFB $22,$E7,$2F,$E8,$30,$E9,$F4,$E2
	DEFB $F5,$E3,$E4,$E4,$F6,$E5

; Pictures of NEAR/HELD items, 32x24px each
LA7AD:	DEFB $00,$00,$00,$00,$00,$00,$00,$00	; Nothing
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$45,$DD,$54,$5E
	DEFB $65,$49,$56,$52,$65,$49,$56,$52
	DEFB $55,$49,$D5,$50,$55,$49,$55,$56
	DEFB $4D,$49,$54,$D2,$4D,$49,$54,$D2
	DEFB $45,$C9,$54,$5E,$00,$00,$00,$00
	DEFB $06,$06,$06,$06,$06,$06,$06,$06	; attributes
	DEFB $06,$06,$06,$06
LA819:	DEFB $00,$00,$00,$00,$00,$00,$80,$00	; Shuriken
	DEFB $00,$00,$80,$00,$00,$00,$80,$00
	DEFB $00,$01,$80,$00,$00,$01,$80,$00
	DEFB $00,$03,$C0,$00,$00,$7F,$F0,$00
	DEFB $00,$0F,$FE,$00,$00,$03,$C0,$00
	DEFB $00,$01,$80,$00,$00,$01,$80,$00
	DEFB $00,$01,$00,$00,$00,$01,$00,$00
	DEFB $00,$01,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $75,$56,$55,$D2,$45,$55,$55,$1A
	DEFB $77,$56,$59,$9E,$15,$55,$55,$16
	DEFB $75,$25,$55,$D2,$00,$00,$00,$00
	DEFB $0E,$0D,$4F,$0E,$0E,$4D,$0F,$4F	; attributes
	DEFB $06,$06,$06,$06
LA885:	DEFB $00,$00,$00,$0C,$00,$00,$00,$7C	; Knife
	DEFB $00,$00,$07,$D8,$00,$00,$0F,$B8
	DEFB $00,$00,$1F,$B0,$00,$00,$7F,$60
	DEFB $00,$00,$FE,$C0,$00,$01,$F9,$80
	DEFB $00,$07,$CF,$00,$00,$0F,$BE,$00
	DEFB $00,$BE,$78,$00,$00,$BD,$E0,$00
	DEFB $03,$5F,$80,$00,$0F,$AC,$00,$00
	DEFB $1F,$50,$00,$00,$DF,$48,$00,$00
	DEFB $EF,$84,$00,$00,$6F,$04,$00,$00
	DEFB $74,$00,$00,$00,$38,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $0A,$0F,$0F,$4F,$0A,$0F,$4F,$4F	; attributes
	DEFB $0A,$0A,$0A,$0A
LA8F1:	DEFB $00,$00,$00,$00,$00,$00,$00,$00	; ??
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$70,$00,$00,$00,$FC,$00
	DEFB $00,$01,$3E,$00,$00,$71,$3F,$00
	DEFB $00,$FE,$3F,$C0,$00,$BF,$1F,$E0
	DEFB $01,$3F,$9F,$F0,$01,$3F,$DF,$F0
	DEFB $01,$1F,$FF,$F0,$00,$9F,$FC,$F0
	DEFB $00,$8F,$F9,$F8,$00,$47,$F3,$F8
	DEFB $00,$31,$F3,$F0,$01,$88,$7F,$E0
	DEFB $01,$C7,$C3,$C0,$00,$00,$00,$06
	DEFB $18,$04,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E	; attributes
	DEFB $0E,$0E,$0E,$0E
LA95D:	DEFB $00,$00,$3E,$00,$00,$00,$F5,$C0	; Brick
	DEFB $00,$03,$FA,$B8,$00,$0F,$F5,$56
	DEFB $00,$3F,$FB,$AF,$00,$FF,$FE,$FF
	DEFB $03,$FF,$F5,$6B,$0F,$FF,$EA,$D5
	DEFB $3F,$FF,$57,$AB,$EA,$FE,$AD,$55
	DEFB $BD,$55,$7A,$AB,$D7,$BA,$F5,$55
	DEFB $AA,$EF,$AA,$AB,$D5,$5F,$55,$56
	DEFB $AA,$AA,$AA,$BE,$D5,$57,$55,$78
	DEFB $AA,$AA,$AA,$E0,$D5,$57,$57,$80
	DEFB $6A,$AA,$AE,$00,$1D,$57,$78,$00
	DEFB $03,$AB,$E0,$00,$00,$77,$80,$00
	DEFB $00,$0C,$00,$00,$00,$00,$00,$00
	DEFB $02,$02,$02,$02,$02,$02,$02,$02	; attributes
	DEFB $02,$02,$02,$02
LA9C9:	DEFB $00,$00,$00,$00,$00,$00,$00,$00	; Pipe
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $7F,$FF,$FF,$FE,$60,$00,$00,$02
	DEFB $71,$3E,$07,$CA,$7F,$FF,$FF,$FA
	DEFB $7F,$FF,$FF,$F2,$7F,$FF,$FF,$FE
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$3F,$3E,$7C,$FC
	DEFB $21,$08,$44,$80,$21,$08,$44,$FC
	DEFB $3F,$08,$7C,$80,$20,$08,$40,$80
	DEFB $20,$3E,$40,$FC,$00,$00,$00,$00
	DEFB $4F,$4F,$4F,$4F,$4D,$4D,$4D,$4D	; attributes
	DEFB $06,$06,$06,$06
LAA35:	DEFB $00,$00,$00,$00,$00,$00,$00,$00	; Granade
	DEFB $00,$00,$00,$E0,$00,$00,$39,$B0
	DEFB $00,$00,$0D,$18,$00,$0F,$F6,$18
	DEFB $00,$7E,$7B,$70,$00,$CF,$9D,$A0
	DEFB $01,$F2,$6D,$C0,$03,$FD,$F6,$C0
	DEFB $07,$72,$F6,$C0,$0F,$6F,$6A,$C0
	DEFB $0F,$5F,$AA,$C0,$1B,$BF,$BE,$C0
	DEFB $1B,$5F,$DC,$C0,$3A,$EF,$DC,$C0
	DEFB $3D,$F7,$AC,$C0,$3D,$FB,$69,$C0
	DEFB $16,$FD,$F9,$80,$1F,$62,$71,$80
	DEFB $0C,$9F,$E3,$00,$0F,$E7,$C7,$00
	DEFB $03,$FF,$8E,$00,$00,$FE,$00,$00
	DEFB $0C,$0C,$0C,$0C,$0C,$04,$04,$0C	; attributes
	DEFB $0C,$04,$0C,$0C
LAAA1:	DEFB $00,$00,$00,$00,$01,$FF,$FF,$F8	; Disk
	DEFB $01,$FF,$FF,$F8,$01,$FF,$FF,$F8
	DEFB $01,$FF,$FF,$F8,$01,$FF,$FF,$F8
	DEFB $01,$FF,$FF,$F8,$01,$FF,$FF,$F8
	DEFB $01,$FF,$0C,$F8,$01,$FE,$F7,$F8
	DEFB $01,$FD,$FB,$F8,$01,$85,$FB,$F8
	DEFB $01,$85,$FB,$F8,$01,$FD,$FB,$F8
	DEFB $01,$FE,$F7,$F8,$01,$FF,$0F,$F8
	DEFB $00,$00,$00,$00,$0F,$84,$FC,$84
	DEFB $08,$44,$8C,$84,$08,$44,$80,$84
	DEFB $08,$CC,$FC,$FC,$08,$CC,$0C,$98
	DEFB $08,$CC,$8C,$98,$0F,$8C,$FC,$98
	DEFB $0C,$08,$08,$08,$0A,$38,$38,$08	; attributes
	DEFB $46,$46,$46,$46
LAB0D:	DEFB $00,$00,$00,$00,$00,$06,$80,$00	; Bomb
	DEFB $00,$89,$40,$00,$01,$68,$20,$00
	DEFB $02,$10,$33,$00,$07,$77,$00,$00
	DEFB $07,$77,$FF,$C0,$07,$77,$FF,$C0
	DEFB $07,$77,$DD,$C0,$07,$77,$AA,$D0
	DEFB $07,$77,$AA,$D0,$07,$77,$AA,$D0
	DEFB $07,$77,$DD,$D0,$07,$77,$FF,$C0
	DEFB $07,$77,$FF,$C0,$07,$77,$FF,$C0
	DEFB $00,$00,$00,$00,$0F,$1C,$8B,$C0
	DEFB $08,$A2,$DA,$20,$0F,$22,$AB,$C0
	DEFB $08,$A2,$8A,$20,$08,$A2,$8A,$20
	DEFB $0F,$1C,$8B,$C0,$00,$00,$00,$00
	DEFB $0A,$0A,$08,$08,$0A,$02,$38,$08	; attributes
	DEFB $06,$06,$06,$06
LAB79:	DEFB $00,$00,$00,$00,$00,$00,$00,$00	; Console
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$03,$03,$40,$00,$03,$23,$40
	DEFB $00,$0F,$FF,$E0,$00,$0C,$00,$60
	DEFB $00,$0D,$FF,$FC,$01,$FA,$00,$0C
	DEFB $0F,$83,$FF,$EC,$0C,$7F,$E0,$2C
	DEFB $0C,$FF,$FF,$CC,$0F,$FC,$81,$3C
	DEFB $00,$00,$FF,$00,$00,$00,$FD,$00
	DEFB $00,$00,$FD,$00,$00,$00,$FD,$00
	DEFB $00,$00,$FD,$00,$00,$00,$FD,$00
	DEFB $00,$00,$FD,$00,$00,$00,$FF,$00
	DEFB $07,$46,$42,$44,$45,$45,$4D,$45	; attributes
	DEFB $07,$07,$0D,$07

; Explosion image, 3x3 tiles
LABE5:	DEFB $04,$66,$06,$03,$4B,$E3,$C3,$43
	DEFB $48,$08,$18,$18,$39,$BB,$FF,$FF
	DEFB $01,$04,$60,$C0,$86,$1C,$F8,$F1
LABFD:	DEFB $03,$7F,$1F,$03,$43,$C7,$0F,$AF
	DEFB $88,$01,$81,$01,$65,$E7,$EF,$E0
	DEFB $E0,$C8,$82,$86,$84,$C4,$E1,$F0
	DEFB $0F,$9E,$BC,$30,$61,$C3,$83,$10
	DEFB $7D,$38,$38,$30,$10,$11,$10,$50
	DEFB $F1,$F9,$38,$1C,$06,$03,$10,$41

; Data block at AC2D
LAC2D:	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00

; Reset Guard data and Dog data
LAC44:	LD HL,LAC72	; address for Table of Guard data addresses
	LD B,$18	; 24
LAC49:	LD E,(HL)
	INC HL
	LD D,(HL)	; now DE = Guard data address
	INC HL
	PUSH HL
	LD HL,$0004
	ADD HL,DE
	LD (HL),$0A	; set initial Guard energy = 10
	POP HL
	DJNZ LAC49
	LD HL,LACA2	; address for Table of Dog data addresses
	LD B,$14	; 20
LAC5C:	LD E,(HL)
	INC HL
	LD D,(HL)
	INC HL
	PUSH HL
	LD HL,$0004
	ADD HL,DE
	LD A,$41
	CP (HL)
	JR NC,LAC6E
	LD A,(HL)
	SUB $42
	LD (HL),A
LAC6E:	POP HL
	DJNZ LAC5C
	RET

; Table of Guard data addresses, 24 records
LAC72:	DEFW LA26B,LA265,LA25F,LA259
	DEFW LA253,LA217,LA24D,LA247
	DEFW LA241,LA23B,LA235,LA22F
	DEFW LA229,LA223,LA21D,LA211
	DEFW LA20B,LA205,LA1FF,LA1F9
	DEFW LA1F3,LA1ED,LA1E7,LA1E1

; Table of Dog data addresses, 20 records
LACA2:	DEFW LA31B,LA311,LA307,LA2FD
	DEFW LA2F3,LA2DF,LA2D5,LA2CB
	DEFW LA2C1,LA2B7,LA2A3,LA285
	DEFW LA325,LA2AD,LA28F,LA27B
	DEFW LA271,LA2E9,LA299,L71D6

; Draw game screen frames and indicator text
LACCA:	EXX
	LD DE,$5800
	EXX
	LD HL,$4000	; Screen start address
	LD DE,LAD65	; Game screen frames/indicators RLE encoded sequence
LACD5:	LD A,(DE)
	PUSH DE
	LD C,$01
	CP $FF
	JR Z,LAD1D
	CP $17
	JR C,LACE8
	SUB $14
	LD C,A
	POP DE
	INC DE
	LD A,(DE)
	PUSH DE
LACE8:	PUSH HL
	LD H,$00
	LD L,A
	PUSH HL
	POP DE
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL	; * 8
	ADD HL,DE	; * 9
	LD DE,LAE02	; Indicator tiles address
	ADD HL,DE
	POP DE
LACF7:	LD B,$08
	PUSH HL
	PUSH DE
LACFB:	LD A,(HL)
	LD (DE),A
	INC HL
	INC D
	DJNZ LACFB
	LD A,(HL)
	EXX
	LD (DE),A
	INC DE
	EXX
	POP DE
	POP HL
	RR D
	RR D
	RR D
	INC DE
	RL D
	RL D
	RL D
	DEC C
	JR NZ,LACF7
	EX DE,HL
	POP DE
	INC DE
	JR LACD5
LAD1D:	POP DE
	LD DE,$5067
	LD HL,LAD4A	; Indicator messages address
	LD C,$0D
	CALL LAED1	; Print string "PAY : $ XXXXX"
	LD DE,$5097
	LD C,$02
	CALL LAED1	; Print string "99"
	LD DE,$50C1
	LD C,$04
	CALL LAED1	; Print string "HELD"
	LD DE,$50D6
	LD C,$04
	CALL LAED1	; Print string "TIME"
	LD DE,$50DB
	LD C,$04
	CALL LAED1	; Print string "NEAR"
	RET

; Indicator messages
LAD4A:	DEFM "PAY : $ "
LAD52:	DEFM "00000"	; Pay value text
LAD57:	DEFM "99"	; Indicator time value
LAD59:	DEFM "HELDTIMENEAR"

; Game screen frames/indicators RLE encoded sequence
LAD65:	DEFB $00,$32,$01,$02,$03,$32,$0B,$04
	DEFB $03,$32,$0B,$04,$03,$32,$0B,$04
	DEFB $03,$32,$0B,$04,$03,$32,$0B,$04
	DEFB $03,$32,$0B,$04,$03,$32,$0B,$04
	DEFB $03,$32,$0B,$04,$03,$32,$0B,$04
	DEFB $03,$32,$0B,$04,$03,$32,$0B,$04
	DEFB $03,$32,$0B,$04,$03,$32,$0B,$04
	DEFB $03,$32,$0B,$04,$03,$32,$0B,$04
	DEFB $03,$32,$0B,$04,$03,$32,$0B,$04
	DEFB $05,$18,$06,$07,$23,$06,$07,$18
	DEFB $06,$07,$18,$06,$08,$03,$18,$0B
	DEFB $03,$23,$0B,$03,$0E,$0F,$0F,$10
	DEFB $03,$18,$0B,$04,$03,$18,$0B,$05
	DEFB $23,$06,$08,$11,$0B,$0B,$12,$03
	DEFB $18,$0B,$04,$03,$18,$0B,$03,$23
	DEFB $16,$03,$13,$14,$14,$15,$03,$18
	DEFB $0B,$04,$03,$18,$09,$03,$23,$16
	DEFB $03,$18,$09,$03,$18,$09,$04,$0A
	DEFB $18,$06,$0C,$23,$06,$0C,$18,$06
	DEFB $0C,$18,$06,$0D,$FF

; Tiles for game screen frames/indicators, 9 bytes each
LAE02:	DEFB $30,$08,$04,$05,$02,$8D,$70,$1C,$02
	DEFB $22,$22,$14,$E7,$3C,$24,$44,$00,$02
	DEFB $00,$10,$21,$22,$A4,$64,$A8,$30,$02
	DEFB $10,$50,$3C,$08,$08,$6A,$9C,$08,$02
	DEFB $10,$48,$39,$0E,$08,$78,$17,$10,$02
	DEFB $0A,$9C,$68,$04,$03,$4C,$38,$14,$02
	DEFB $00,$11,$22,$62,$BF,$44,$44,$42,$02
	DEFB $00,$24,$22,$22,$A7,$66,$5A,$89,$02
	DEFB $10,$78,$27,$20,$C0,$2E,$70,$10,$02
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$06
	DEFB $08,$0E,$08,$36,$43,$02,$04,$18,$02
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$0F
	DEFB $50,$72,$54,$CE,$25,$28,$28,$08,$02
	DEFB $10,$3C,$92,$61,$A0,$18,$04,$04,$02
	DEFB $7F,$80,$80,$87,$88,$88,$88,$88,$0F
	DEFB $FF,$00,$00,$FF,$00,$00,$00,$00,$0F
	DEFB $FE,$01,$01,$E1,$11,$11,$11,$11,$0F
	DEFB $88,$88,$88,$88,$88,$88,$88,$88,$0F
	DEFB $11,$11,$11,$11,$11,$11,$11,$11,$0F
	DEFB $88,$88,$88,$88,$87,$80,$80,$7F,$0F
	DEFB $00,$00,$00,$00,$FF,$00,$00,$FF,$0F
	DEFB $11,$11,$11,$11,$E1,$01,$01,$FE,$0F
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$0A

; Print string with standard font
; C  = Length
; HL = string address
; DE = screen address
LAED1:	LD A,(HL)
	PUSH HL
	LD H,$00
	LD L,A
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL	; * 8
	PUSH DE
LAEDA:	LD DE,$3C00	; !!MUT-ARG!! font address
	ADD HL,DE
	POP DE
	PUSH DE
	LD B,$08
LAEE2:	LD A,(HL)
	LD (DE),A
	INC HL
	INC D
	DJNZ LAEE2
	POP DE
	POP HL
	INC DE
	INC HL
	DEC C
	JR NZ,LAED1
	RET

; Routine at AEF0
LAEF0:	LD HL,$5800	; attributes screen address
	LD C,$10
LAEF5:	LD B,$0C
LAEF7:	LD (HL),$08
	INC HL
	DJNZ LAEF7
	LD B,$14
LAEFE:	LD (HL),$0E
	INC HL
	DJNZ LAEFE
	DEC C
	JR NZ,LAEF5
	LD B,$00
LAF08:	LD (HL),$20
	INC HL
	DJNZ LAF08
	LD HL,LB066
	LD B,$01
LAF12:	PUSH HL
	LD DE,LAD52	; Pay value text address
	LD C,$01
LAF18:	LD A,(DE)
	SUB (HL)
	JR Z,LAF22
	JP P,LAF38
	JP LAF2A
LAF22:	INC C
	INC HL
	INC DE
	LD A,C
	CP $04
	JR NZ,LAF18
LAF2A:	INC B
	POP HL
	LD DE,$000D
	ADD HL,DE
	LD A,B
	CP $0B
	JR NZ,LAF12
	JP LB005	; => Print table of records
LAF38:	PUSH BC
	LD DE,$402C
	LD HL,LB0F2
	LD C,$0F
	CALL LAED1	; Print string "EXCELLENT WORK."
	LD DE,$408C
	LD C,$0E
	CALL LAED1	; Print string "YOU ARE ONE OF"
	LD DE,$40AC
	LD C,$0D
	CALL LAED1	; Print string " OUR TEN BEST"
	LD DE,$40CC
	LD C,$10
	CALL LAED1	; Print string "NINJA SABOTEURS."
	LD DE,$480C
	LD C,$11
	CALL LAED1	; Print string "ENTER YOUR NAME..."
	POP BC
	LD C,$0A
	PUSH BC
	LD DE,$484D	; screen address
	LD HL,LB0E8	; address of string 10 spaces
	CALL LAED1	; Print string
	LD B,$01
	EXX
	LD DE,$594D
	EXX
	LD DE,$484D
	LD HL,LB0E8	; address of string 10 spaces

LAF7E:	PUSH BC
	EXX
	LD A,$E3
	LD (DE),A
	EXX

LAF84:	XOR A
	LD ($5C08),A	; clear LASTK
	RST $38
	LD A,($5C08)	; get LASTK
	CP $5B
	JP M,LAF93
	SUB $20
LAF93:	CP $20
	JR Z,LAFAA
	CP $0C
	JP LF968

; Routine at AF9C
LAF9C:	CP $0D
	JR Z,LAFCD
	CP $41
	JP M,LAF84
	CP $5C
	JP P,LAF84

LAFAA:	LD (HL),A
	LD C,$01
	CALL LAED1	; Print string
	EXX
	LD A,$0E
	LD (DE),A
	INC DE
	EXX
	POP BC
	INC B
	LD A,B
	CP $0B
	JR Z,LAFD3
	PUSH BC

LAFBE:	PUSH DE
	PUSH HL
LAFC0:	CALL $028E	; KEY-SCAN
	INC DE
	LD A,D
	OR E
	JR NZ,LAFC0
	POP HL
	POP DE
	POP BC
	JR LAF7E
LAFCD:	POP BC
	EXX
	LD A,$0E
	LD (DE),A
	EXX
LAFD3:	POP BC
	LD A,$0A
	SUB B
	JR Z,LAFEC
	LD B,A
	LD HL,LB0E8-1
	LD DE,LB0DB-1
LAFE0:	LD C,$0D
LAFE2:	LD A,(DE)
	LD (HL),A
	DEC HL
	DEC DE
	DEC C
	JR NZ,LAFE2
	DEC B
	JR NZ,LAFE0
LAFEC:	POP HL
	LD DE,LAD52	; Pay value text address
	LD C,$03
LAFF2:	LD A,(DE)
	LD (HL),A
	INC HL
	INC DE
	DEC C
	JR NZ,LAFF2
	LD DE,LB0E8	; address of string 10 spaces
	LD C,$0A
LAFFE:	LD A,(DE)
	LD (HL),A
	INC HL
	INC DE
	DEC C
	JR NZ,LAFFE

; Print table of records
LB005:	LD B,$0A
	LD HL,LB066
	LD DE,$402C
LB00D:	PUSH BC
	PUSH HL
	LD HL,LB061+4
	LD C,$01
	CALL LAED1	; Print string
	POP HL
	LD C,$03
	CALL LAED1	; Print string
	PUSH HL
	LD HL,LB061
	LD C,$04
	CALL LAED1	; Print string
	POP HL
	LD C,$0A
	CALL LAED1	; Print string
	EX DE,HL
	PUSH DE
	LD DE,$000E	; +14
	ADD HL,DE
	POP DE
	EX DE,HL
	POP BC
	LD A,B
	CP $04
	JR NZ,LB03D
	LD DE,$480C
LB03D:	DJNZ LB00D
	RET

; Routine at B040
LB040:	POP BC
	LD A,B
	CP $01
	JR Z,LB05D
	DEC B
	PUSH BC
	LD A,$20
	LD (HL),A
	LD C,$01
	CALL LAED1	; Print string
	DEC HL
	DEC HL
	DEC DE
	DEC DE
	EXX
	LD A,$0E
	LD (DE),A
	DEC DE
	EXX
	JP LAFBE
LB05D:	PUSH BC
	JP LAFBE

LB061:	DEFM "00  $"

; Table of records
LB066:	DEFM "020 THE CAT  "
LB073:	DEFM "018JOOLZ     "
LB080:	DEFM "016MICKY     "
LB08D:	DEFM "014DAVE      "
LB09A:	DEFM "012GEOFF P   "
LB0A7:	DEFM "010SHARFACE  "
LB0B4:	DEFM "008HOLLY     "
LB0C1:	DEFM "006BRAD      "
LB0CE:	DEFM "004TOZZY     "
LB0DB:	DEFM "002MAT LE FAT"

; String 10 spaces
LB0E8:	DEFM "          "

LB0F2:	DEFM "EXCELLENT WORK."
LB101:	DEFM "YOU ARE ONE OF"
LB10F:	DEFM " OUR TEN BEST"
LB11C:	DEFM "NINJA SABOTEURS."
LB12C:	DEFM "ENTER YOUR NAME..."

; Tile buffer
LB13E:	DEFB $FE,$82,$A2,$00,$FE,$FF,$FF,$7E	; Pixel bytes
LB146:	DEFB $32	; Attribute byte
LB147:	DEFB $30	; Background attribute byte

; Draw tile map on the screen
LB148:	LD HL,$5821	; Screen attributes address
	LD B,$11	; 17 rows
	LD (L7233),HL
	LD HL,L6F86	; Tile screen 5 start address
	LD (L7235),HL
	LD HL,L6D88	; Tile screen 4 start address
	LD (L7237),HL
	LD HL,L678E	; Tile screen 1 start address
	LD DE,$4021	; screen address where game screen starts
	EXX
	LD HL,L6590	; Tile screen 0 start address
	LD DE,L698C	; Tile screen 2 start address
	LD BC,L6B8A	; Tile screen 3 start address
	EXX

; Loop start
LB16D:	LD C,$1E	; 30 column
LB16F:	XOR A
	CP (HL)		; Check "need update" flag in Tile screen 1
	JP Z,LB2A9	; zero => Skip this tile rendering
	PUSH HL
	PUSH BC
	PUSH DE

; Process Tile screen 0 - background tile
LB177:	EXX
	LD A,(HL)	; get byte from Tile screen 0 tile
	EXX
	LD HL,LB1A3	; for non-$FF, don't skip Ninja tile processing
	CP $FF		; $FF - "earth" background?
	JR NZ,LB184	; byte <> $FF =>
	LD HL,LB1F9	; for $FF, skip Ninja tile processing
LB184:	LD (LB1A0+1),HL	; save the chosen jump address ($B1A3 or $B1F9)
	LD H,$00
	LD L,A
	PUSH HL
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
	POP DE
	ADD HL,DE	; * 9
	LD DE,LF700	; Background tiles start address
	ADD HL,DE	; now HL = tile data address
	LD DE,LB13E	; Tile buffer address
	LD B,$09	; 8 pixel bytes + attribute byte
LB199:	LD A,(HL)	; get byte from tile data
	LD (DE),A	; store the byte to tile buffer
	INC HL		; move to next byte in tile data
	INC DE		; move to next byte in tile buffer
	DJNZ LB199	; loop for 9 bytes
	LD (DE),A	; save attribute byte once more
LB1A0:	JP LB1A3	; !!MUT-ARG!! $B1A3 or $B1F9

; Process Tile screen 2 tile - Ninja
LB1A3:	EXX
	LD A,(DE)	; get tile from Tile Screen 2 tile
	EXX
	CP $FF		; $FF - transparent?
	JR Z,LB1F9	; $FF => skip Ninja tile drawing
	LD L,A
	CP $C8
	JR C,LB1D5
	CP $F4
	JR NC,LB1D5
	LD H,$02
	CP $DA
	JR NC,LB1CC
	LD H,$05
	CP $D8
	JR NC,LB1CC
	LD H,$07
	LD A,(LB146)	; get attribute byte from the tile buffer
	AND $38
	CP $20
	JR C,LB1CC
	LD H,$01
LB1CC:	LD A,(LB146)	; get attribute byte from the tile buffer
	AND $F8
	OR H
	LD (LB146),A	; set attribute byte
LB1D5:	LD H,$00
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL	; * 16
	LD DE,LE700	; Ninja tiles base address
	ADD HL,DE	; now HL = tile data address
	LD B,$08	; 8 bytes
	LD DE,LB13E	; Tile buffer address
LB1E4:	INC HL
	LD A,(DE)	; get byte from tile buffer
	LD C,A
	LD A,(HL)	; get byte from tile data (mask)
	CALL LB2E8	; Mirror byte if needed
	AND C		; AND with byte from the buffer - apply the mask
	LD C,A
	DEC HL
	LD A,(HL)	; get byte from tile data (pixels)
	CALL LB2E8	; Mirror byte if needed
	OR C		; OR with the byte from buffer - apply pixels
	INC HL
	INC HL
	LD (DE),A
	INC DE
	DJNZ LB1E4	; loop for all 8 bytes
LB1F9:	JP LB1FC

; Process Tile screen 3 tile - Dog
LB1FC:	EXX
	PUSH BC
	EXX
	POP BC
	LD A,(BC)	; get tile from Tile screen 3
	CP $FF		; $FF - transparent?
	JR Z,LB230	; $FF => skip Dog tile drawing
	CALL LB2FE	; Exchange $7239 (Ninja direction) and $71CD (Dog direction)
	LD H,$00
	LD L,A
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL	; * 16
	LD DE,LF0F0	; Dog tiles base address
	ADD HL,DE	; now HL = tile data address
	LD B,$08
	LD DE,LB13E	; Tile buffer address
LB218:	INC HL
	LD A,(DE)	; get byte from tile buffer
	LD C,A
	LD A,(HL)
	CALL LB2E8	; Mirror byte if needed
	AND C
	LD C,A
	DEC HL
	LD A,(HL)
	CALL LB2E8	; Mirror byte if needed
	OR C
	INC HL
	INC HL
	LD (DE),A
	INC DE
	DJNZ LB218
	CALL LB2FE	; Exchange $7239 (Ninja direction) and $71CD (Dog direction)

; Process Tile screen 4 tile - Guard
LB230:	LD HL,(L7237)	; get address in Tile screen 4
	LD A,(HL)	; get tile from the tilemap
	CP $FF		; $FF - transparent?
	JR Z,LB263	; $FF => skip Guard tile drawing
	LD H,$00
	LD L,A
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL	; * 16
	LD DE,LE700	; tiles base address
	ADD HL,DE	; now HL = tile data address
	LD B,$08
	LD DE,LB13E	; Tile buffer address
	CALL LB30F	; Exchange $7239 (Ninja direction) and $7347 (Guard direction)
LB24B:	INC HL
	LD A,(DE)	; get byte from tile buffer
	LD C,A
	LD A,(HL)	; get byte from tile data (mask)
	CALL LB2E8	; Mirror byte if needed
	AND C		; AND with byte from buffer - masking
	LD C,A
	DEC HL
	LD A,(HL)	; get byte from tile data (pixels)
	CALL LB2E8	; Mirror byte if needed
	OR C		; OR with byte from buffer
	INC HL
	INC HL
	LD (DE),A	; save result byte to tile buffer
	INC DE
	DJNZ LB24B	; loop for all 8 bytes
	CALL LB30F	; Exchange $7239 (Ninja direction) and $7347 (Guard direction)

; Process Tile screen 5 tile - front
LB263:	LD HL,(L7235)	; get address in Tile screen 5
	LD A,(HL)	; get tile from the tilemap
	CP $FF		; $FF - transparent?
	JR Z,LB293	; $FF => skip front tile drawing
	LD H,$00
	LD L,A
	LD A,(LB147)	; get Background tile attribute
	LD (LB146),A	; set it as current tile attribute
	PUSH HL
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL	; * 16
	POP DE
	ADD HL,DE	; * 17
	LD DE,LD600	; Front tiles base address
	ADD HL,DE	; now HL = address of tile data
	LD B,$08
	LD DE,LB13E	; Tile buffer address
LB284:	LD A,(DE)	; get byte from buffer
	AND (HL)	; AND with mask byte
	INC HL		; move to next byte in tile data
	OR (HL)		; OR with pixel byte
	LD (DE),A	; store result back to tile buffer
	INC HL		; move to next byte in tile data
	INC DE		; move to next buffer byte
	DJNZ LB284	; loop for all 8 bytes
	LD A,(HL)	; get attribute byte from the tile data
	CP $FF		; $FF?
	JR Z,LB293	; $FF => skip
	LD (DE),A	; set as current attribute

; Draw prepared tile on the screen
LB293:	NOP
	POP DE
	PUSH DE
	LD HL,LB13E	; Tile buffer address
	LD B,$08	; 8 bytes
LB29B:	LD A,(HL)	; get byte from the buffer
	LD (DE),A	; put byte on the screen
	INC HL
	INC D
	DJNZ LB29B	; loop for all 8 bytes
	LD A,(HL)	; get attribute byte from the buffer
	LD HL,(L7233)	; get address in screen attributes
	LD (HL),A	; put the attribute

; Next column
LB2A6:	POP DE
	POP BC
	POP HL
LB2A9:	INC DE		; Next address in screen
	INC HL		; Next address in Tile screen 1
	EXX
	INC DE
	INC HL		; Next address in Tile screen 0
	INC BC
	EXX
	PUSH HL
	LD HL,(L7233)
	INC HL		; Next address in screen attributes
	LD (L7233),HL
	LD HL,(L7235)
	INC HL		; Next address in Tile screen 5
	LD (L7235),HL
	LD HL,(L7237)
	INC HL		; Next address in Tile screen 4
	LD (L7237),HL
	POP HL
	DEC C		; Decrease column counter
	JP NZ,LB16F	; Continue loop by columns

; Next tile row
LB2CB:	RR D
	RR D
	RR D
	INC DE
	INC DE
	RL D
	RL D
	RL D
	PUSH HL
	LD HL,(L7233)	; get screen attributes address
	INC HL
	INC HL		; increase address by 2 - next row
	LD (L7233),HL	; set screen attributes address
	POP HL
	DEC B		; Decrease line counter
	JP NZ,LB16D	; Continue loop by lines
	RET

; Mirror byte if needed
LB2E8:	PUSH BC
	LD B,A
	LD A,(L7239)	; get Ninja direction
	CP $00		; left?
	LD A,B
	POP BC
	RET NZ		; right - no need to mirror => return
	LD IX,L72BA	; Mirror table half address
	LD (LB2F9+2),A
LB2F9:	LD A,(IX+$7E)
	RET

LB2FD:	DEFB $C3	; Counter for Ninja/Guard head tile change

; Exchange $7239 (Ninja direction) and $71CD (dog direction)
LB2FE:	PUSH AF
	LD A,(L7239)	; get Ninja direction
	PUSH AF
	LD A,(L71CD)	; get Dog direction
	LD (L7239),A
	POP AF
	LD (L71CD),A
	POP AF
	RET

; Exchange $7239 (Ninja direction) and $7347 (Guard direction)
LB30F:	PUSH AF
	LD A,(L7239)	; get Ninja direction
	PUSH AF
	LD A,(L7347)	; get Guard direction
	LD (L7239),A
	POP AF
	LD (L7347),A
	POP AF
	RET

; Object procedure: flip trigger "D": set/remove wall in room 9739
LB320:	LD A,(L9755+1)
	XOR $06
	LD (L9755+1),A
	JR LB350	; => Change Console color in NEAR

; Object procedure: flip trigger "E": set/remove wall in room 97A6
LB32A:	LD A,(L97CF+1)
	XOR $FF
	LD (L97CF+1),A
	JR LB350	; => Change Console color in NEAR

; Object procedure: flip trigger "C": set/remove wall in room 8D5C
LB334:	LD A,(L8DBB+1)
	XOR $06
	LD (L8DBB+1),A
	JR LB350	; => Change Console color in NEAR

; Object procedure: flip trigger "B": set/remove wall in room 8F20
LB33E:	LD A,(L8F31+1)
	XOR $08
	LD (L8F31+1),A
	JR LB350	; => Change Console color in NEAR

; Object procedure: flip trigger "A": set/remove wall in room 7F48
LB348:	LD A,(L7F7A+1)
	XOR $09
	LD (L7F7A+1),A

; Change Console color in NEAR, so we see that console action worked
LB350:	LD HL,$5A7B	; address in screen attributes
	LD DE,$001C	; 28
	LD C,$03	; 3 rows
LB358:	LD B,$04	; 4 columns
LB35A:	LD A,(HL)
	XOR $06
	LD (HL),A
	INC HL
	DJNZ LB35A
	ADD HL,DE	; next row
	DEC C
	JR NZ,LB358
LB365:	JP LB8D0	; => Update Ninja on tilemap

; Room 97A6 initialization
LB368:	LD A,(L97CF+1)	; get trigger "E" value
	LD (L6590+357),A	; $66F5 = $6590 + 357
	JP LA18D	; => Finish Room 97A6 initialization

; Play melody ??; HL = melody address
LB371:	DI
	LD C,$C8
LB374:	LD A,(HL)
	AND $07
	LD B,A
	INC HL
LB379:	LD A,$10
	OUT ($FE),A
	PUSH BC
	LD A,(HL)
	AND $3F
	LD B,A
LB382:	DJNZ LB382
	POP BC
	XOR A
	OUT ($FE),A
	DJNZ LB379
	INC HL
	DEC C
	JR NZ,LB374
	RET

; Room token #00: Barrel, 3x3 tiles 7C21; params: 2 bytes (address)
LB38F:	POP HL
	INC HL
	LD A,(HL)
	INC HL
	PUSH HL
	LD H,(HL)
	LD L,A
	LD DE,L7C21	; Tile block address
	LD C,$03
LB39B:	LD B,$03
LB39D:	LD A,(DE)
	LD (HL),A
	INC DE
	INC HL
	DJNZ LB39D
	PUSH DE
	LD DE,$001B
	ADD HL,DE
	POP DE
	DEC C
	JR NZ,LB39B
	JP L734A	; => B702 Proceed to the next room token

LB3AF:	DEFS $01

; Routine at B3B0
LB3B0:	LD HL,LC681
	LD (L982D),HL
	LD HL,LB673+1	; current dog data address
	LD (L9DD0+1),HL
	LD HL,LC6A5
	LD (L7C9C),HL
	LD HL,LC671
	LD (L947E),HL
	LD (L93E1),HL
	LD HL,LB422
	LD (L7BD4),HL
	LD HL,LC64C
	LD (L7920),HL
	LD HL,LB702
	LD (L734A+1),HL
	LD B,$00
	LD D,$80
	LD HL,L723A	; Mirror table address
LB3E4:	LD C,$08
	LD A,D
LB3E7:	RR A
	RL E
	DEC C
	JR NZ,LB3E7
	LD (HL),E	; store reversed byte
	INC HL
	INC D
	DJNZ LB3E4
	EXX
	PUSH HL
	EXX
	LD A,$01
	LD ($5C09),A	; set REPDEL = 1
	LD ($5C0A),A	; set REPPER = 1
	JP LB5C7

LB401:	DEFS $09	; UNUSED

; Initialize a guard
; HL = Guard data address, see A1E1
LB40A:	LD DE,L71C3	; address to store guard data
	LD (LB695+1),HL	; Save Guard data address
	LD BC,$0004
	LDIR
	LD A,(HL)
	LD (L7346),A	; set Guard state
	INC HL
	LD A,(HL)	; get Guard direction from Guard data
	LD (L7347),A	; set Guard direction
	RET

; Standard room procedure (for 63 rooms)
LB41F:	JP LB937

; Standard room initialization (for 60 rooms)
LB422:	JP LB724	; => Finish room initialization

; Rooms 7C9C/92EF initialization (redirect from 791B)
LB425:	LD HL,LC66B	; Guard data address
	CALL LB40A	; Initialize a guard
	JP LB724	; => Finish room initialization

; Room 79C6 initialization
LB42E:	LD HL,L71D6	; Dog data address
	CALL L9DCD	; Initialize a dog
	JP LB724	; => Finish room initialization

; UNUSED: Room XXXX initialization
LB437:	LD HL,L71D6
	CALL L9DCD	; Initialize a dog
	LD HL,LC66B
	CALL LB40A	; Initialize a guard
	JP LB724	; => Finish room initialization

; Room B513 procedure (initial Room)
LB446:	CALL LB4FA	; Processing in the initial room
	JP LB937	; Standard room procedure

; Room procedure (for 19 rooms with a guard) (redirect from 7918)
LB44C:	CALL LA434	; Process a guard
	JP LB937	; Standard room procedure

; Room procedure (for 18 rooms with a dog)
LB452:	CALL L9C44	; Process a dog
	JP LB937	; Standard room procedure

; Room procedure (for 5 rooms with a guard and a dog)
LB458:	CALL L9C44	; Process a dog
	CALL LA434	; Process a guard
	JP LB937	; Standard room procedure

; Turret initialization
; HL = turret data address
LB461:	LD E,(HL)	; get Turret offset low byte
	INC HL
	LD D,(HL)	; get Turret offset high byte
	PUSH HL		; save offset
	LD HL,L678E	; Tile screen 1 start address
	ADD HL,DE
	LD (LB4CB+1),HL	; set Turret address on Tile Screen 1
	LD DE,$07F8
	ADD HL,DE
	LD (LB48D+1),HL	; set Turret address on Tile Screen 5
	POP HL		; restore offset
	INC HL
	LD A,(HL)
	LD (LB4D3+1),A
	RET

; Room procedure (for 2 rooms with a turret and a dog)
LB47A:	CALL L9C44	; Process a dog
	CALL LB489	; Process turret
	JP LB937	; Standard room procedure

; Room procedure (for 14 rooms with a turret)
LB483:	CALL LB489	; Process turret
	JP LB937	; Standard room procedure

; Process turret
LB489:	LD A,(LB4DD)	; get Turret counter
	DEC A		; decrease counter
LB48D:	LD HL,L6F86+47	; !!MUT-ARG!! Turret address on Tile Screen 5
	JR NZ,LB4C6
	LD A,(HL)
	PUSH HL
	LD DE,L907A
	ADD HL,DE
	SUB $26
	LD IX,LA3AD
	LD (IX+$03),A
	LD (IX+$04),A
	LD (LA3AE),HL
	LD (IX+$00),$DA
	LD DE,$FFE2	; -30
	LD B,$00
LB4B0:	XOR A
	CP H
	JR Z,LB4B8
LB4B4:	ADD HL,DE
	INC B
	JR LB4B0
LB4B8:	LD A,$1E
	CP L
	JR C,LB4B4
	LD (IX+$06),L
	LD (IX+$05),B
LB4C3:	LD A,$32	; !!MUT-ARG!! ??
	POP HL
LB4C6:	LD (LB4DD),A	; update Turret counter
	LD A,$01
LB4CB:	LD (L678E+47),A	; !!MUT-ARG!! set "need update" mark for Turret on Tile Screen 1
	LD (HL),$2D
	LD A,(L9C41)	; get Ninja X
LB4D3:	LD B,$0F	; !!MUT-ARG!! Turret counter value
	CP B
	RET Z
	DEC (HL)
	CP B
	RET M
	INC (HL)
	INC (HL)
	RET

LB4DD:	DEFB $32	; Turret counter 50..0

; Increase PAY value by B * 100
LB4DE:	LD HL,LAD52+2	; PAY value 3rd digit address
	LD A,$3A	; ':' = '9' + 1
LB4E3:	INC (HL)
	CP (HL)
	JP NZ,LB4ED
	LD (HL),$30	; '0'
	DEC HL		; previous digit
	JR LB4E3
LB4ED:	DJNZ LB4DE
	LD HL,LAD52	; Pay value text address
	LD C,$05	; five digits
	LD DE,$506F	; Screen address
	JP LAED1	; => Print string, and RET

; Processing in initial room - the boat moving
LB4FA:	LD B,$06
	LD HL,LD6BB
LB4FF:	LD A,(HL)
	RR A
	RR (HL)
	INC HL
	DJNZ LB4FF
	LD HL,L678E+360
	LD B,$1E
	LD A,$01
LB50E:	LD (HL),A
	INC HL
	DJNZ LB50E
	RET

; Room B513: Initial Room
LB513:	DEFW LB446	; Room procedure
	DEFW LB422	; Initialization
	DEFW $0000
	DEFW L791E	; Room to Right
	DEFW $0000
	DEFW $0000
	DEFB $04,$0D		; Fill entire screen with $0D
	DEFB $02,$1E,$F5,$70,$67	; Fill horz 30 tiles with $F5 at $6770
	DEFB $02,$1E,$0B,$EE,$70	; Fill horz 30 tiles with $0B at $70EE
	DEFB $03,$0C,$1E,$03,$0C,$71	; Rectangle 30x3 tiles with $0C at $710C
	DEFB $FF	; End of sequence

; Movement handler for initial room (B8CE handler)
LB532:	LD HL,(L9C42)
	INC HL		; increase Ninja position in tilemap
	LD (L9C42),HL
	LD HL,L9C41	; Ninja X address
	INC (HL)
LB53D:	LD DE,L6F86+349
	LD HL,LB5A7	; Boat sprite address
	LD BC,$0009
	LDIR		; copy Boat sprite
	LD HL,$F807	; -2041
	ADD HL,DE
	LD (HL),$01
	LD DE,$FFF8	; -8
	ADD HL,DE
	LD (HL),$01
	LD HL,(LB53D+1)
	INC HL
	LD (LB53D+1),HL
	LD A,(LB5A8)
	XOR $01
	LD (LB5A8),A
	LD C,$FE
	LD B,$05
	LD A,$10
	OUT (C),A
LB56B:	DJNZ LB56B	; delay
	XOR A
	OUT (C),A
	LD HL,L7343	; counter address
	DEC (HL)	; decrease counter
	JP NZ,LB8D0	; => Update Ninja on tilemap
	LD HL,L9C41	; Ninja X address
	INC (HL)	; Moving right one tile
	LD HL,(L9C42)
	INC HL		; increase Ninja position in tilemap
	LD (L9C42),HL
	LD HL,L6F86+349
	LD (HL),$FF
	LD DE,LD5AC	; Sprite Ninja jumping 3
	LD HL,LC4F6	; Movement handler address
	LD A,$04
	LD (L7343),A	; set counter = 4
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE

LB595:	DEFB $00

; Routine at B596
LB596:	LD B,$14
LB598:	JP LF9A1

LB59B:	DEFB $FE,$0E,$2D

; Routine at B59E
LB59E:	DEC C
	JR NZ,LB59E
	XOR A
	OUT ($FE),A
	DJNZ LB598
	RET

; Boat sprite for initial room
LB5A7:	DEFB $FF
LB5A8:	DEFB $67,$68,$6A,$6A,$6A,$6A,$6A,$6B

; Table of items: addresses for NEAR/HELD items
LB5B0:	DEFW LA7AD	; #0 Nothing
	DEFW LA819	; #1 Shuriken
	DEFW LA885	; #2 Knife
	DEFW LA8F1	; #3 ??
	DEFW LA95D	; #4 Brick
	DEFW LA9C9	; #5 Pipe
	DEFW LAA35	; #6 Granade
	DEFW LAAA1	; #7 Disk
	DEFW LAB0D	; #8 Bomb
	DEFW LAB79	; #9 Console

LB5C4:	DEFB $15	; Time fast counter 50..0
LB5C5:	DEFB $01	; Ninja standing counter
LB5C6:	DEFB $00	; Time mode: $00 = time ticking; $01 = Time stopped; $02 = BOMB ticking mode

; Routine at B5C7
LB5C7:	CALL LAC44	; Reset Guard data and Dog data
	LD (LBC0D+1),SP
	LD HL,LB7CA+1
	LD (LE343+2),HL
	LD HL,LBC3B
	LD (LDFD1+1),HL
	LD A,$C5	; command = $C5 PUSH BC
	LD (L9DD9),A	; set command = PUSH BC = enable Energy decrease
	LD HL,LBEAA
	LD (L9DEC+1),HL
	LD HL,LB8D0	; Object procedure address for "Update Ninja on tilemap"
	LD (LD285),HL	; set Object procedure for object #6 in Table of objects D256
	LD (LB365+1),HL
	LD A,$30
	LD HL,LAD52	; Pay value text address
	LD B,$03
LB5F5:	LD (HL),A
	INC HL
	DJNZ LB5F5
	CALL LACCA	; Draw game screen frames and indicator text
	XOR A
	LD ($5C48),A	; set BORDCR = 0
	LD (LB5C6),A	; set Time mode = time ticking
	LD (LB850),A	; clear HELD tile
	LD (LD486+8),A	; set tile in Ninja sprite
	OUT ($FE),A	; set border black, sound off
	INC A
	LD (LD486+9),A	; set head tile for Ninja/Guard standing sprite
	LD (L7239),A	; set Ninja direction = 1 = right
	LD (LB84F),A	; set NEAR item = 1
	LD HL,L6F86+330
	LD (LB53D+1),HL
	LD HL,LB5B0	; address for Table of items
	LD (L74D3+1),HL
	CALL LB851	; Set initial data in Table of Objects
	LD HL,$0000
	LD (LB673+1),HL	; set current Dog data address = no dog
	LD (LB695+1),HL	; set current Guard data address = no guard
	LD A,$04
	LD (LC66B+4),A
	LD (LD486+15),A
	LD A,$FA
	LD (LB2FD),A
	LD A,$C8
	LD (LBD79+1),A
	CALL L7472
	DI
	LD HL,LB513	; Initial room address
	LD (L7184),HL	; set Current Room address
	LD HL,LB532	; movement handler for initial room
	LD (LB8CD+1),HL	; set movement handler address
	LD HL,LD558	; Sprite Ninja sitting
	LD (L7186),HL	; set Ninja sprite address
	LD A,$01
	LD (L9C41),A	; set Ninja X = 1
	LD A,$05
	LD (L9C40),A	; set Ninja Y = 5
	LD HL,$0097
	LD (L9C42),HL	; set Ninja position in tilemap: Y * 30 + X
	LD A,$13
	LD (L7343),A	; set counter = 19

; Current Room changed, entering the new Room
LB66A:	LD A,(L71D4)
LB66D:	LD ($0000),A	; !!MUT-ARG!! address for current Dog flag
	LD HL,L71CB
LB673:	LD DE,$0000	; !!MUT-ARG!! current Dog data address
	LD BC,$0009
	LDIR
	LD HL,LB263	; For first drawing entering the room, skip Dog and Guard tiles drawing
	LD (LB1F9+1),HL
	CALL LDE68	; Find record for the current room in DE84 table
	CP $00
	JR NZ,LB68B	; found =>
	LD HL,$0000
LB68B:	LD A,(HL)	; get flag
	LD (L71D4),A
	LD (LB66D+1),HL
	LD HL,L71C3
LB695:	LD DE,$0000	; !!MUT-ARG!! current Guard data address
	LD BC,$0004
	LDIR
	LD A,(L7346)	; get Guard state
	LD (DE),A
	INC DE
	LD A,(L7347)	; get Guard direction
	LD (DE),A
	LD HL,$0000
	LD (LB673+1),HL	; set current Dog data address = no dog
	LD (LB695+1),HL	; set current Guard data address = no guard
	XOR A
	LD (LBAB2),A
	LD HL,LA39F
	LD B,$03
	LD DE,$0007
LB6BB:	LD (HL),A
	ADD HL,DE
	DJNZ LB6BB
	LD HL,L6590	; Tile screen 0 start address
	LD (HL),A	; fill with $00
	INC A
	LD (LA3B4),A
	LD BC,$01FD	; 510 - 1
	LD DE,L6590+1	; Tile screen 0 start address + 1
	LDIR		; Fill Tile screen 0
	LD HL,L6D88	; Tile screen 4 start address
	LD (HL),$FF	; fill with transparent tile
	LD BC,$03FB	; 510 + 510 - 1
	LD DE,L6D88+1	; Tile screen 4 start address + 1
	LDIR		; Fill Tile screen 4 and Tile screen 5
	LD HL,(L7184)	; get Current Room address
	INC HL
	INC HL
	LD A,(HL)	; get Room init address low byte
	INC HL
	PUSH HL
	LD H,(HL)	; get Room init address high byte
	LD L,A
	LD (LB6F1+1),HL	; set Room init address
	POP HL
	LD DE,$0009
	ADD HL,DE	; now HL = room sequence start address

LB6EE:	LD A,(HL)	; get next token
	CP $FF		; End of sequence?
LB6F1:	JP Z,LF973	; !!MUT-ARG!! yes => run Room initialization code
	PUSH HL		; Save address in the room sequence
	LD L,A
	LD H,$00
	ADD HL,HL	; * 2
	LD DE,LB706	; Table of Room tokens
	ADD HL,DE	; now HL = address in the table
	LD A,(HL)	; get address low byte
	INC HL
	LD H,(HL)	; get address high byte
	LD L,A		; now HL = room token procedure address
	JP (HL)		; => run token procedure

; Proceed to the next room token
LB702:	POP HL		; Restore address in the room sequence
	INC HL		; to next token
	JR LB6EE	; => continue room sequence processing

; Table of Room tokens
LB706:	DEFW LB38F	; #00: Put 3x3 tiles L7C21; params: 2 bytes (address)
	DEFW L7381	; #01: Fill to down; params: 4 bytes (count, filler, address)
	DEFW L739F	; #02: Fill to right; params: 4 bytes (count, filler, address)
	DEFW L7452	; #03: Fill rectangle; params: 5 bytes (filler, width, height, address)
	DEFW L73F3	; #04: Fill whole Tile screen 0 with one tile; params: 1 byte (filler)
	DEFW L7406	; #05: Copy block of tiles; params: 6 bytes (width, height, srcaddr, address)
	DEFW L73A4	; #06: Fill triangle from wide top; params: 4 bytes (filler, count, address)
	DEFW L73C5	; #07: Fill triangle from wide bottom; params: 4 bytes (filler, count, address)
	DEFW L73EB	; #08: Fill triangle from wide bottom; params: 4 bytes (filler, count, address)
	DEFW L73EF	; #09: Fill triangle from wide top; params: 4 bytes (filler, count, address)
	DEFW L7395	; #0A: Fill to down-right; params: 4 bytes (count, filler, address)
	DEFW L739A	; #0B: Fill to down-left; params: 4 bytes (count, filler, address)
	DEFW L742B	; #0C: Copy block of tiles N times; params: 6 bytes (srcaddr, width, count, address)
	DEFW L7359	; #0D: Set border color; params: 1 byte
	DEFW L734D	; #0E: Put one tile at the given address; params: 3 bytes (tile, address)

; Finish room initialization
; Called to finish room initialization from room initialization procedure
LB724:	LD HL,L678E	; Tile screen 1 start address
	LD (HL),$01	; Filler = $01 = "need update" mark
	LD BC,$01FD	; 510 - 1
	LD DE,L678E+1	; Tile screen 1 start address + 1
	LDIR
	LD HL,L698C	; Tile screen 2 start address
	LD (HL),$FF	; Filler = transparent tile
	LD BC,$01FD	; 510 - 1
	LD DE,L698C+1	; Tile screen 2 start address + 1
	LDIR
	LD HL,L6B8A	; Tile screen 3 start address
	LD (HL),$FF	; Filler = transparent tile
	LD BC,$01FD	; 510 - 1
	LD DE,L6B8A+1	; Tile screen 3 start address + 1
	LDIR
	CALL LB148	; Draw tile map on the screen
	LD HL,LD34D	; Table of objects address
	LD B,$23	; 35 objects
LB753:	PUSH HL		; save address in Table of objects
	LD A,(L7184)	; get Current Room address, low byte
	CP (HL)
	JR NZ,LB768
	INC HL
	LD A,(L7184+1)	; get Current Room address, high byte
	CP (HL)
	JR NZ,LB768
	INC HL
	LD E,(HL)	; get address in Tile screen 0, low byte
	INC HL
	LD D,(HL)	; get address in Tile screen 0, high byte
	INC HL
	LD A,(HL)	; get tile byte
	LD (DE),A	; set tile byte in Tile screen 0
LB768:	POP HL		; restore address in Table of objects
	LD DE,$0005
	ADD HL,DE	; next object
	DJNZ LB753	; continue loop by objects
	LD A,(L7346)	; get Guard state
	CP $09
	JR Z,LB77B
	LD A,$0A
	LD (L7346),A	; set Guard state = $0A

; Game loop start
LB77B:	XOR A
	LD ($5C08),A	; clear LASTK
	RST $38
	DI
	LD A,($5C08)	; get LASTK
	LD A,(LB5C6)	; get Time mode
	CP $01		; time stopped?
	JR Z,LB7AF	; yes =>
; Decrease Time, check if Time is out
LB78B:	LD HL,LB5C4	; address for Time fast counter
	DEC (HL)	; decrease the counter
	JR NZ,LB7AF	; not zero => skip Time decrease
	LD (HL),$28	; reset fast counter to 50
	LD HL,LAD57+1	; address for Time lower digit
	DEC (HL)	; Decrease Time lower digit
	LD A,$2F
	CP (HL)
	JR NZ,LB7A4
	LD (HL),$39	; '9'
	DEC HL		; go to higher digit
	DEC (HL)	; decrease Time higher digit
	CP (HL)
	JP Z,LBE71	; time is out =>
LB7A4:	LD DE,$5097	; screen address for timer value
	LD HL,LAD57	; Indicator Time value address
	LD C,$02	; Two digits
	CALL LAED1	; Print string
; Check for BOMB
LB7AF:	LD A,(LD287+4)	; check Object #7 in Table of objects D256
	CP $D6		; BOMB tile in the place of Diskette?
	JR NZ,LB7ED	; no => skip
; BOMB ticking mode
LB7B6:	LD HL,LB5C6	; Time mode address
	LD A,$02
	CP (HL)		; already in BOMB ticking mode?
	JR Z,LB7ED
	LD (HL),A	; set Time mode = BOMB ticking mode
	LD HL,LBD2F	; "BOMB"
	LD DE,$50D6	; screen address under timer value
	LD C,$04
	CALL LAED1	; Print string "BOMB"
LB7CA:	LD HL,$3939	; !!MUT-ARG!! "99" bomb timer initial value
	LD (LAD57),HL	; set Indicator Time value
	LD A,$01
	LD (LB5C4),A
	LD HL,$5A76
	LD DE,$001C	; 28
	LD C,$03
LB7DD:	LD B,$04
LB7DF:	LD (HL),$D6
	INC HL
	DJNZ LB7DF
	ADD HL,DE
	DEC C
	JR NZ,LB7DD
	LD B,$32
	CALL LB4DE	; Increase PAY value by 5000
LB7ED:	LD HL,L678E	; Tile screen 1 start address
	LD (HL),$00	; "no need to update" value
	LD BC,$01FD	; 510 - 1
	LD DE,L678E+1	; Tile screen 1 start address + 1
	LDIR
	CALL LBBBB	; Set update flags for Ninja, 6x7 tiles
	LD HL,L698C	; Tile screen 2 start address
	LD (HL),$FF
	LD BC,$01FD	; 510 - 1
	LD DE,L698C+1	; Tile screen 2 start address + 1
	LDIR		; Fill the Tile screen 2
	XOR A
	LD (LB84C),A	; clear Object tile
	LD C,A
	LD B,$23	; 35 = number of records in D256
	LD DE,LD256	; Table address

; Loop through the table
LB814:	LD A,(DE)	; get byte +$00
	LD L,A
	INC DE
	LD A,(DE)	; get byte +$01
	LD H,A
	INC DE
	PUSH DE		; save address in the table
	LD DE,(L9C42)
	ADD HL,DE	; add Ninja position in tilemap
	POP DE		; restore address in the table
	LD A,(DE)	; get byte +$02
	INC DE
	CP (HL)
	JP NZ,LB889
	LD A,(DE)	; get byte +$03
	LD C,A
	LD B,$03
	LD HL,LB84C	; address to store Object tile and Object procedure address
	INC DE
	LD (LB84A),DE	; store Object address + 4
LB833:	LD A,(DE)	; get byte +$04/$05/$06
	LD (HL),A
	INC HL
	INC DE
	DJNZ LB833
	JP LB891

; Increase Energy a bit
LB83C:	LD A,(L749D)	; get Energy lower
	RRC A
	LD (L749D),A	; set Energy lower
	RET NC
	LD HL,L749C	; Energy address
	INC (HL)	; increase Energy
	RET

LB84A:	DEFW LD2F7+4	; Object address + 4, in table LD256
LB84C:	DEFB $00	; Object tile
LB84D:	DEFW $0000	; Object procedure address
LB84F:	DEFB $00	; NEAR item
LB850:	DEFB $C8	; HELD tile

; Set initial data in Table of Objects
LB851:	LD B,$23	; 35 objects
	LD DE,$0007	; 7 = size of record in Table of Objects
	LD IX,LD256+3	; = D256 (address for Table of Objects) + 3
	LD HL,LD210	; address for table with initial data
LB85D:	LD A,(HL)
	LD (IX+$00),A	; set byte +$03 in the record
	INC HL
	LD A,(HL)
	LD (IX+$01),A	; set byte +$04 in the record
	INC HL
	ADD IX,DE	; next record
	DJNZ LB85D	; continue the loop
	RET

; ?? Adjust table 751B by DE
LB86C:	LD B,$18
	LD (L74F3+1),A
	LD IX,L751B
LB875:	LD L,(IX+$00)
	LD H,(IX+$01)
	ADD HL,DE
	LD (IX+$00),L
	LD (IX+$01),H
	INC IX
	INC IX
	DJNZ LB875
	RET

; Routine at B889
LB889:	INC DE
	INC DE
	INC DE
	INC DE
	DEC B
	JP NZ,LB814	; continue the loop through the table

LB891:	LD HL,LB84F	; NEAR item address
	LD A,C
	CP (HL)
	JR Z,LB8B0
	LD (HL),A
	LD (L74CD+1),A
	LD DE,$001A
	LD A,$7B
	CALL LB86C
	CALL L74CD	; Draw NEAR/HELD item
	DI
	LD DE,$FFE6	; -26
	LD A,$61
	CALL LB86C
LB8B0:	LD HL,LB850	; HELD tile address
	LD A,(LBD79+1)
	CP (HL)
	JR Z,LB8C9
	LD (HL),A
	CP $00
	JR Z,LB8C2
	SUB $C6
	SRL A
LB8C2:	LD (L74CD+1),A
	CALL L74CD	; Draw NEAR/HELD item
	DI
LB8C9:	XOR A
	LD (LA39E),A
LB8CD:	JP LBEB3	; !!MUT-ARG!! => run handler

; Update Ninja on tilemap
LB8D0:	CALL LBBBB	; Set update flags for Ninja, 6x7 tiles
	LD HL,L6D88	; Tile screen 4 start address
	LD (HL),$FF
	LD BC,$01FD	; 510 - 1
	LD DE,L6D88+1
	LDIR

; Draw Ninja on tilemap
LB8E0:	LD HL,(L9C42)	; get Ninja position in tilemap
	LD A,(L7239)	; get Ninja direction
	CP $00		; left?
	JR NZ,LB907
	LD DE,L698C+5
	ADD HL,DE
	LD DE,(L7186)	; get Ninja sprite address
	LD B,$07
LB8F4:	LD C,$06
LB8F6:	LD A,(DE)
	LD (HL),A
	DEC HL
	INC DE
	DEC C
	JR NZ,LB8F6
	PUSH DE
	LD DE,$0024
	ADD HL,DE
	POP DE
	DJNZ LB8F4
	JR LB922
LB907:	LD DE,L698C	; Tile screen 2 start address
	ADD HL,DE
	LD DE,(L7186)	; get Ninja sprite address
	LD B,$07
LB911:	LD C,$06
LB913:	LD A,(DE)
	LD (HL),A
	INC HL
	INC DE
	DEC C
	JR NZ,LB913
	PUSH DE
	LD DE,$0018
	ADD HL,DE
	POP DE
	DJNZ LB911
LB922:	LD HL,L6B8A	; Tile screen 3 start address
	LD (HL),$FF
	LD DE,L6B8A+1	; Tile screen 3 start address + 1
	LD BC,$01FD	; 510 - 1
	LDIR
	LD HL,(L7184)	; get Current Room address
	LD A,(HL)
	INC HL
	LD H,(HL)
	LD L,A
	JP (HL)

; Standard room procedure (redirect from B41F)
LB937:	LD IX,LA39F
	LD B,$03
LB93D:	LD A,$03
	LD (LB94F+2),A
	XOR A
	CP (IX+$00)
	PUSH BC
	JP Z,LBA20
	CALL LBBAE
	LD B,$02
LB94F:	LD A,(IX+$03)	; !!MUT-ARG!!
	LD DE,$0000
	CP $03
	JR NC,LB95F
	LD DE,$FFE2	; -30
	DEC (IX+$05)
LB95F:	CP $06
	JR C,LB969
	LD DE,$001E	; +30
	INC (IX+$05)
LB969:	CP $01
	JR Z,LB98D
	CP $04
	JR Z,LB98D
	CP $07
	JR Z,LB98D
	DEC DE
	DEC (IX+$06)
	CP $03
	JR Z,LB98D
	CP $00
	JR Z,LB98D
	CP $06
	JR Z,LB98D
	INC DE
	INC DE
	INC (IX+$06)
	INC (IX+$06)
LB98D:	LD L,(IX+$01)
	LD H,(IX+$02)
	ADD HL,DE
	LD (IX+$01),L
	LD (IX+$02),H
	LD A,(IX+$05)
	CP $FF
	JP Z,LBBA7
	CP $11
	JP Z,LBBA7
	LD A,(IX+$06)
	CP $1E
	JP Z,LBBA7
	CP $FF
	JP Z,LBBA7
	PUSH HL
	LD DE,L6590	; Tile screen 0 start address
	ADD HL,DE
	LD A,$64
	CP (HL)
	POP HL
	JP C,LBAD5
	PUSH HL
	LD DE,L6B8A	; Tile screen 3 start address
	ADD HL,DE
	LD A,(HL)
	POP HL
	INC A
	JR Z,LB9DA
	LD A,(L71CF)
	CP $42
	JP NC,LBAD5
	ADD A,$42
	LD (L71CF),A
	JP LBAD5
LB9DA:	PUSH HL
	LD DE,L6D88	; Tile screen 4 start address
	ADD HL,DE
	LD A,(HL)
	POP HL
	INC A
	JR Z,LB9F9
	LD A,(L7346)	; get Guard state
	CP $09
	JP Z,LBAD5
	LD A,$09
	LD (L7346),A	; set Guard state = $09
	LD B,$01
	CALL LB4DE	; Increase PAY value by 100 - Guard killed by weapon
	JP LBAD5
LB9F9:	PUSH HL
	LD HL,LB94F+2
	INC (HL)
	POP HL
	DEC B
	JP NZ,LB94F
	LD DE,L698C	; Tile screen 2 start address
	ADD HL,DE
	LD A,(HL)
	CP $C8
	JR NC,LBA14
	LD B,$14
	CALL L9DD9	; Decrease Energy by B = 20
	JP LBAD5
LBA14:	LD A,(IX+$00)
	LD (HL),A
	XOR $01
	LD (IX+$00),A
	CALL LBBAE

LBA20:	POP BC
	LD DE,$0007
	ADD IX,DE
	DEC B
	JP NZ,LB93D
LBA2A:	LD HL,L678E+165	; !!MUT-ARG!!
LBA2D:	LD B,$03
LBA2F:	LD C,$03
	PUSH HL
LBA32:	LD (HL),$01
	INC HL
	DEC C
	JR NZ,LBA32
	POP HL
	PUSH DE
	LD DE,$001E	; +30
	ADD HL,DE
	POP DE
	DJNZ LBA2F
	CALL LB148	; Draw tile map on the screen
	LD HL,LB1FC	; Restore drawing of Dog and Guard tiles
	LD (LB1F9+1),HL
	LD HL,LBAB2
	XOR A
	CP (HL)
	JP Z,LB77B	; => Game loop start

; Draw Explosion image on the screen and make some noise
LBA52:	LD A,$10
	OUT ($FE),A
	DEC (HL)
LBA57:	LD HL,$40D0	; !!MUT-ARG!! address on the screen
LBA5A:	LD DE,LABE5	; !!MUT-ARG!! Explosion image address
LBA5D:	LD B,$03	; !!MUT-ARG!!
LBA5F:	LD C,$03	; !!MUT-ARG!!
	PUSH HL
	PUSH DE
LBA63:	PUSH HL
	PUSH BC
	LD B,$08
LBA67:	LD A,(DE)
	LD (HL),A
	INC DE
	INC H
	DJNZ LBA67
	POP BC
	POP HL
	INC HL
	DEC C
	JR NZ,LBA63
	POP DE
	LD HL,$0018
	ADD HL,DE
	EX DE,HL
	POP HL
	PUSH DE
	LD DE,$0020
	RR H
	RR H
	RR H
	ADD HL,DE
	RL H
	RL H
	RL H
	POP DE
	DJNZ LBA5F
LBA8E:	LD HL,$58D0	; !!MUT-ARG!!
LBA91:	LD B,$03
	LD DE,$0020
LBA96:	LD C,$03	; !!MUT-ARG!!
	PUSH HL
LBA99:	LD A,(HL)
	AND $F8
	OR $42
	LD (HL),A
	INC HL
	DEC C
	JR NZ,LBA99
	POP HL
	ADD HL,DE
	DJNZ LBA96
	LD A,$72
LBAA9:	LD ($58F1),A	; !!MUT-ARG!!
	XOR A
	OUT ($FE),A
	JP LB77B	; => Game loop start

LBAB2:	DEFB $00	; ??
LBAB3:	DEFW $4000,$4020,$4040,$4060	; Screen addresses for every 17 rows
LBABB:	DEFW $4080,$40A0,$40C0,$40E0
LBAC3:	DEFW $4800,$4820,$4840,$4860
LBACB:	DEFW $4880,$48A0,$48C0,$48E0
LBAD3:	DEFW $5000

; Routine at BAD5
LBAD5:	CALL LFA28
	CP $CA		; current room address low byte = $CA ?
	JR NZ,LBAE4
	LD A,(L7184+1)
	CP $8D		; current room address high byte = $8D ?
	JP Z,LBBA7	; room 8DCA (room with helicopter) =>
LBAE4:	LD A,(IX+$00)
	CP $D2
	JR Z,LBAF0
	CP $D3
	JP NZ,LBBA7
LBAF0:	LD HL,LBAB2
	XOR A
	CP (HL)
	JP NZ,LBBA7
	LD (HL),$0A
	LD L,(IX+$01)
	LD H,(IX+$02)
	LD DE,L6590+479
	ADD HL,DE
	LD (LBA2A+1),HL
	LD H,$00
	LD A,(IX+$05)
	ADD A,A		; * 2
	LD L,A
	LD DE,$5800
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL	; * 32
	ADD HL,DE	; now HL = address in screen attributes
	LD D,$00
	LD E,(IX+$06)
	ADD HL,DE
	LD (LBA8E+1),HL
	LD (LBB2C+2),A
	INC A
	LD (LBB2F+2),A
	PUSH IX
	LD IX,LBAB3	; Address for table of screen addresses for 17 rows
LBB2C:	LD L,(IX+$0C)	; !!MUT-ARG!!
LBB2F:	LD H,(IX+$0D)	; !!MUT-ARG!!
	POP IX
	ADD HL,DE
	LD (LBA57+1),HL
	LD HL,(LBA8E+1)
	LD DE,$0021
	ADD HL,DE
	LD (LBAA9+1),HL
	LD B,$03
	LD C,$03
	EXX
	LD DE,LABE5	; Explosion image address
	EXX
	LD HL,(LBA2A+1)
	LD DE,$0000
	LD A,(IX+$05)
	CP $10
	JR NZ,LBB59
	DEC B
LBB59:	CP $00
	JR NZ,LBB6A
	DEC B
	LD DE,$001E	; 30
	ADD HL,DE
	LD DE,$0020
	EXX
	LD DE,LABFD
	EXX
LBB6A:	LD A,(IX+$06)
	CP $1D
	JR NZ,LBB72
	DEC C
LBB72:	CP $00
	JR NZ,LBB7C
	DEC C
	INC HL
	INC DE
	EXX
	INC DE
	EXX
LBB7C:	LD A,B
	LD (LBA2D+1),A
	LD (LBA5D+1),A
	LD (LBA91+1),A
	LD A,C
	LD (LBA2F+1),A
	LD (LBA5F+1),A
	LD (LBA96+1),A
	LD (LBA2A+1),HL
	LD HL,(LBA57+1)
	ADD HL,DE
	LD (LBA57+1),HL
	LD HL,(LBA8E+1)
	ADD HL,DE
	LD (LBA8E+1),HL
	EXX
	LD (LBA5A+1),DE
	EXX

LBBA7:	XOR A
	LD (IX+$00),A
	JP LBA20

; Routine at BBAE
LBBAE:	LD L,(IX+$01)
	LD H,(IX+$02)
	LD DE,L678E	; Tile screen 1 start address
	ADD HL,DE
	LD (HL),$01	; set "need update" mark
	RET

; Set update flags for Ninja, 6x7 tiles
LBBBB:	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,L678E	; Tile screen 1 start address
	ADD HL,DE
	LD DE,$0018	; 24
	LD A,$01	; "need to update" mark
	LD B,$07	; 7 rows
LBBC9:	LD C,$06	; 6 columns
LBBCB:	LD (HL),A	; set the flag
	INC HL
	DEC C
	JR NZ,LBBCB	; continue by columns
	ADD HL,DE	; next row
	DJNZ LBBC9	; continue by rows
	RET

; Movement handler: Ninja punching
LBBD4:	CALL LBBDF	; Read Input
	BIT 4,A		; check FIRE bit
	JP NZ,LB8D0	; => Update Ninja on tilemap
	JP LC226	; => Ninja standing

; Read Input
LBBDF:	PUSH HL
	LD HL,L7222
	XOR A
	CP (HL)		; Input method = Keyboard/Protek?
	JR Z,LBBEE
	IN A,($1F)	; read joystick port
LBBE9:	LD (L7232),A	; store input bits
	POP HL
	RET
LBBEE:	PUSH BC
	LD B,$05
	LD C,$00
LBBF3:	INC HL
	LD A,(HL)
	IN A,($FE)
	INC HL
	AND (HL)
	INC HL
	JR NZ,LBC07
	LD A,(HL)
	ADD A,A
	ADD A,A
	ADD A,A		; * 8
	ADD A,$C1
	LD (LBC05+1),A
LBC05:	SET 1,C
LBC07:	DJNZ LBBF3
	LD A,C
	POP BC
	JR LBBE9	; => store input bits and RET

; Routine at BC0D
; Prepare screen background for title picture
LBC0D:	LD SP,$6257	; !!MUT-ARG!!
	EXX
	POP HL
	EXX
; Entry point
LBC13:	LD HL,LE5DC	; Melody start address
	LD (LE440+2),HL	; set melody current address
	LD HL,$4000
	LD BC,$1000
	LD DE,$4001
	LD (HL),$00
	LDIR		; clear screen
	LD C,$00
LBC28:	PUSH HL
	LD B,$04
LBC2B:	LD (HL),$AA
	INC H
	LD (HL),$55
	INC H
	DJNZ LBC2B
	POP HL
	INC HL
	DEC C
	JR NZ,LBC28
; Show the title picture
LBC38:	CALL L6289	; Show title picture (two ninjas)
; Entry point
LBC3B:	CALL LAEF0
	LD HL,LAD52
	LD B,$03
LBC43:	LD (HL),$30
	INC HL
	DJNZ LBC43
	LD HL,LB0E8	; address of string 10 spaces
	LD B,$0A
LBC4D:	LD (HL),$20
	INC HL
	DJNZ LBC4D
	JP LDF37

; Movement handler: Ninja standing

; Increase Energy if needed
LBC55:	LD HL,LB5C5	; Ninja standing counter address
	DEC (HL)	; decrease counter
	JR NZ,LBC76
	LD (HL),$02	; reload the counter
	LD A,(L749C)	; get Energy
	CP $13		; energy at MAX?
	JR NZ,LBC6B
	LD A,(L749D)	; get Energy lower
	CP $01
	JR Z,LBC76
LBC6B:	CALL LB83C	; Increase Energy a bit
	LD B,$01
	CALL L9DD9	; Decrease Energy by B
	CALL LB83C	; Increase Energy a bit

; Move the head (idle animation)
LBC76:	LD HL,LB2FD	; address for head movement counter
	INC (HL)	; increase counter
	JR NZ,LBC98	; not zero => skip head animation
	LD (HL),$BE	; reset counter (how often head moves)
LBC7E:	LD A,(LD486+8)
	XOR $F4		; toggle tile
	LD (LD486+8),A	; set head tile
	LD A,(LD486+9)
	XOR $F4		; toggle between $01 and $F5 tiles
	LD (LD486+9),A	; set head tile for Ninja/Guard standing sprite
	LD A,(LD486+15)
	XOR $F2		; toggle tile
	LD (LD486+15),A	; update the tile
	JR LBC9D
LBC98:	LD A,$D2
	CP (HL)
	JR Z,LBC7E

; Check for suicide key combination
LBC9D:	LD A,$FE
	IN A,($FE)
	BIT 0,A		; check for CAPS SHIFT key
	JR NZ,LBCB6	; not pressed => skip suicide
	LD A,$7F
	IN A,($FE)
	BIT 0,A		; check for "1" key
	JR NZ,LBCB6	; not pressed => skip suicide
	LD HL,LBEEF	; "SEPUKU" / "MISSION ABORTED"
	LD (LBEB3+1),HL	; set two-line Game Over message
	JP LBE5A	; => Ninja sit, and then fall and DIE
LBCB6:	CALL LC5A3	; Check for falling
	JP Z,LC643	; => Ninja falling
	LD HL,LB595
	XOR A
	CP (HL)
	JR Z,LBCC4
	DEC (HL)
LBCC4:	CALL LBBDF	; Read Input
	BIT 4,A		; check FIRE bit
	JP Z,LBDDD

; FIRE pressed, ninja standing
LBCCC:	LD HL,LB595	; action cooldown counter
	XOR A
	CP (HL)		; check if counter is 0
	JP NZ,LBDB2	; not zero =>
	LD (HL),$05	; reset cooldown (5 ticks until next action)
	LD A,(LB84C)	; get Object tile
	CP $63
	JR Z,LBD33	; => execute the object procedure
	LD B,A
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,L6590+217	; $6669 = $6590 (Tile screen 0) + 217
	ADD HL,DE
	LD A,$9C
	CP (HL)
	JR NZ,LBCF3
	LD A,(LB5C6)	; get Time mode
	CP $02		; BOMB ticking mode?
	JR Z,LBD37	; yes =>
	JR LBCF7
LBCF3:	XOR A
	CP B		; Object tile = nothing?
	JR Z,LBD37	; nothing =>
LBCF7:	LD A,(LB850)	; get HELD tile
	LD DE,(LB84A)	; get Object address + 4
	LD (DE),A	; set Object tile
	DEC DE
	CP $00		; held nothing?
	JR Z,LBD08	; nothing =>
	SUB $C6
	SRL A
LBD08:	LD (DE),A
	LD A,$09
	LD (LD287+3),A	; set ?? in Object #7 in Table of objects D256
	LD A,B
	LD (LBD79+1),A
	CP $D4
	JP NZ,LB8D0	; => Update Ninja on tilemap
	LD HL,LB5C6	; Time mode address
	XOR A		; 0 = time ticking
	CP (HL)
	JP NZ,LB8D0	; => Update Ninja on tilemap
	LD (HL),$01	; set Time mode = time stopped
	LD HL,$0190
	CALL LB371	; Play melody
	LD B,$32	; 50
	CALL LB4DE	; Increase PAY value by 5000
	JP LB8D0	; => Update Ninja on tilemap

LBD2F:	DEFM "BOMB"

; Routine at BD33
LBD33:	LD HL,(LB84D)	; get object procedure address
	JP (HL)		; execute the object procedure

; Fire pressed, Ninja standing, no object nearby
LBD37:	LD HL,LA39F
	XOR A
	CP (HL)
	JP NZ,LBDB2
	LD A,(LB850)	; get HELD tile
	CP $00		; nothing?
	JP Z,LBDB2
	CP $D4
	JP Z,LBDB2
	CP $D6		; BOMB?
	JP Z,LBDB2
	LD (HL),A
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,$003D	; 61
	ADD HL,DE
	LD A,(L9C41)	; get Ninja X
	INC A
	LD B,A
	LD A,(L7239)	; get Ninja direction
	DEC A
	JR NZ,LBD6A
	INC B
	INC B
	INC B
	INC HL
	INC HL
	INC HL
LBD6A:	LD A,B
	LD (LA3A5),A
	LD (LA3A0),HL
	LD A,(L9C40)	; get Ninja Y
	ADD A,$02
	LD (LA3A4),A
LBD79:	LD A,$C8	; !!MUT-ARG!!
	LD (LA39F),A
	XOR A
	LD (LBD79+1),A
	LD B,$03
	LD A,(L7239)	; get Ninja direction
	CP $00		; left?
	JR Z,LBD8D	; left =>
	INC B
	INC B
LBD8D:	LD A,B
	LD (LA3A3),A
	LD A,(L7232)	; get Input bits
	BIT 3,A		; check UP bit
	JR Z,LBD9B
	DEC B
	DEC B
	DEC B
LBD9B:	BIT 2,A		; check DOWN bit
	JR Z,LBDA2
	INC B
	INC B
	INC B
LBDA2:	LD A,B
	LD (LA3A2),A
	CALL LF9F9
	LD DE,LD504	; Sprite Ninja/Guard punching
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE

; Ninja standing (redirect)
LBDAF:	JP LC226	; => Ninja standing

; Routine at BDB2
LBDB2:	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,L6D88+34	; $6DAA = $6D88 (Tile screen 4) + 34 for right
	LD A,(L7239)	; get Ninja direction
	CP $01		; right?
	JR Z,LBDC2	; right =>
	LD DE,L6D88+31	; $6DA7 = $6D88 (Tile screen 4) + 31 for left
LBDC2:	ADD HL,DE	; now HL = address in Guard tilemap
	LD A,(HL)	; get tile
	INC A		; empty tile?
	JR Z,LBDD4	; empty =>
	LD A,$09
	LD (L7346),A	; set Guard state = $09 dead
	CALL LB596
	LD B,$05	; 5 hundreds
	CALL LB4DE	; Increase PAY value by 500 - Guard killed by punch/kick
LBDD4:	LD HL,LBBD4	; Movement handler address
	LD DE,LD504	; Sprite Ninja/Guard punching
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE

; Routine at BDDD
LBDDD:	BIT 3,A
	JP Z,LBFBA
	LD HL,L6590+30
	LD DE,(L9C42)	; get Ninja position in tilemap
	ADD HL,DE
	LD A,$DA
	CP (HL)
	JP NZ,LBF7B
	LD A,$0B
	LD (L7343),A	; set counter = 11
	LD HL,L6590+44
	LD (LBE0D+1),HL
	LD (LBE1C+1),HL
	LD HL,L678E+302
	LD (LBA2A+1),HL
	LD HL,LBE0D	; Movement handler
	LD DE,LD486	; Sprite Ninja/Guard standing
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE

; ?? Movement handler
LBE0D:	LD HL,$65B1	; !!MUT-ARG!!
	LD A,$01
	LD (HL),A
	DEC HL
	LD (LBE0D+1),HL
	LD DE,$01FF	; 511
	ADD HL,DE
	LD (HL),A
LBE1C:	LD HL,L6590+55	; !!MUT-ARG!!
	LD (HL),A
	INC HL
	LD (LBE1C+1),HL
	LD DE,$01FD	; 509
	ADD HL,DE
	LD (HL),A
	LD HL,L7343	; counter address
	DEC (HL)	; decrease counter
	JP NZ,LB8D0	; => Update Ninja on tilemap
	LD (HL),$14	; reset the counter
	LD HL,L6590+458
	LD DE,L678E+458
	LD B,$0A	; 10
LBE3A:	LD (HL),A
	LD (DE),A
	INC DE
	INC HL
	DJNZ LBE3A
	LD HL,$0110
	LD (L9C42),HL	; set Ninja position in tilemap
	LD HL,L678E+210
	LD DE,L678E+211
	LD BC,$00D1	; 210 - 1 = 7 rows
	LDIR
	LD HL,LC094	; Movement handler (helicopter?)
	LD DE,LC0E6	; Empty sprite
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE

; Ninja sit, and then fall and DIE
LBE5A:	LD HL,LBE63	; Movement handler: Ninja dead
	LD DE,LD558	; Sprite Ninja sitting
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE

; Movement handler (B8CE handler): Ninja dead
LBE63:	LD A,$C9	; command = $C9 RET
	LD (L9DD9),A	; set command = RET = disable Energy decrease
	LD HL,LBEB3	; Movement handler: Game Over
	LD DE,LA0B5	; Sprite Ninja dead
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE

; Time is out
LBE71:	LD A,(LB5C6)	; get Time mode
	CP $02		; BOMB ticking mode?
	JR Z,LBE80	; yes =>
	LD HL,LBF35	; "TIME OUT" / "MISSION TERMINATED"
	LD (LBEB3+1),HL	; set two-line Game Over message
	JR LBE63	; => Ninja dead

; BOMB time is out, BOMB explodes
LBE80:	LD B,$06
	LD IX,$0000
LBE86:	LD C,$00
LBE88:	LD HL,$5821
	LD A,(IX+$00)
	OUT ($FE),A
	INC IX
	PUSH BC
	LD C,$11	; 17
LBE95:	LD B,$1E	; 30
LBE97:	INC (HL)
	INC HL
	DJNZ LBE97
	INC HL
	INC HL
	DEC C
	JR NZ,LBE95
	POP BC
	DEC C
	JR NZ,LBE88
	DJNZ LBE86
	XOR A
	OUT ($FE),A
	PUSH HL

; Saboteur is dead
LBEAA:	POP HL
	LD HL,LBF58	; "SABOTEUR DEAD" / "MISSION FAILURE"
	LD (LBEB3+1),HL	; set two-line Game Over message
	JR LBE63	; => Ninja dead

; Movement handler: Game Over
LBEB3:	LD HL,LBEEF	; !!MUT-ARG!! two-line message address
	LD DE,$4068
	LD C,$0F
	CALL LAED1	; Print string 1st line
	LD DE,$40A6
	LD C,$14
	CALL LAED1	; Print string 2nd line
	LD HL,$5868
	LD B,$0F
LBECB:	LD (HL),$0F
	INC HL
	DJNZ LBECB
	LD HL,$58A6
	LD B,$14
LBED5:	LD (HL),$0F
	INC HL
	DJNZ LBED5
	CALL LF9B9	; Pause, then wait for any key pressed
	NOP
	NOP
LBEDF:	NOP		; !!MUT-CMD!!
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	LD A,$0A	; "LD A,(BC)" instruction code
	LD (LBEDF),A
	JP LBC0D	; => Title picture and music, then go to Main menu

; Game over two-line messages
LBEEF:	DEFM "     SEPUKU    "
LBEFE:	DEFM "  MISSION ABORTED   "
LBF12:	DEFM "     ESCAPE    "
LBF21:	DEFM " MISSION SUCCESSFUL "
LBF35:	DEFM "    TIME OUT   "
LBF44:	DEFM " MISSION TERMINATED "
LBF58:	DEFM " SABOTEUR DEAD "
LBF67:	DEFM "  MISSION FAILURE   "

; Routine at BF7B
LBF7B:	LD HL,L6590+2	; $6592 = $6590 (Tile screen 0) + 2
	ADD HL,DE
	LD A,$64
	CP (HL)
	JP C,LC16E	; => Object procedure
	INC HL
	CP (HL)
	JP C,LC16E	; => Update Ninja on tilemap
	LD A,$03
	LD (L7343),A	; set counter = 3
	LD A,(L7239)	; get Ninja direction
	CP $00		; left?
	LD A,(L7232)	; get Input bits
	JR Z,LBFA0
	BIT 0,A		; check RIGHT bit
	CALL NZ,LC4E8
	JR LBFA5
LBFA0:	BIT 1,A		; check LEFT bit
	CALL NZ,LC4E8
LBFA5:	LD HL,LC339	; Movement handler: Ninja jumping
	LD A,$02
	LD (L7343),A	; set counter = 2
	LD DE,LD4B0	; Sprite Ninja/Guard jumping

; Set movement handler = HL, set Ninja sprite = DE
LBFB0:	LD (LB8CD+1),HL
	LD (L7186),DE	; set Ninja sprite address = DE
	JP LB8D0	; => Update Ninja on tilemap

; Routine at BFBA
LBFBA:	BIT 2,A
	JP Z,LC13D
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,L65E7+125
	ADD HL,DE
	CALL LC392
	JP Z,LC12E	; => Ninja on ladder
; Entry point
LBFCC:	LD HL,LC22F	; Movement handler: Ninja sitting
	LD DE,LD558	; Sprite Ninja sitting
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE

; Escaped; clear screen, show final messages, then Game Over
LBFD5:	LD B,$0A
	CALL LB4DE	; Increase PAY value by 1000 - Escape by Helicopter
	LD A,(LBD79+1)
	CP $D4
	JR NZ,LC04A
	LD B,$32
	CALL LB4DE	; Increase PAY value by 5000
	LD HL,$4000	; Screen start address
	LD DE,$4001
	LD BC,$1800
	LD (HL),$00
	LDIR		; Clear whole screen
	LD BC,$02FF
	LD (HL),$0F
	LDIR		; Clear all attributes
	LD HL,LC062	; Messages address
	LD DE,$4089	; Screen address
	LD C,$0E
	CALL LAED1	; Print string "DISK RETRIEVED"
	LD DE,$4828
	LD C,$12
	CALL LAED1	; Print string "DISK BONUS: $05000"
	LD DE,$4865
	LD C,$05
	CALL LAED1	; Print string "LEVEL"
	LD DE,$5062
	LD C,$0D
	CALL LAED1	; Print string "TOTAL PAY : $"
	LD DE,$486D
	LD HL,LC075	; Messages address
	LD C,$0D
	CALL LAED1	; Print string "BONUS: $05000"
	LD DE,$4875
	LD HL,LE388
	LD C,$03
	CALL LAED1	; Print string
	LD A,(LE38B)
	LD B,A
	CALL LB4DE	; Increase PAY value by B * 100
	LD DE,$486B
	LD HL,LE1EC	; Skill level address
	LD C,$01
	CALL LAED1	; Print skill level digit
	LD A,$14	; "INC D" instruction code
	LD (LBEDF),A
LC04A:	LD A,(LB5C6)	; get Time mode
	CP $02		; BOMB ticking mode?
	JR NZ,LC056	; no =>
	LD B,$64	; 100
	CALL LB4DE	; Increase PAY value by 10000 - Escape with Disk and Bomb
LC056:	LD HL,LBF12	; "ESCAPE" / "MISSION SUCCESSFUL"
	LD (LBEB3+1),HL	; set two-line Game Over message
	NOP
	NOP
	NOP
	JP LBEB3	; => Game Over

LC062:	DEFM "DISK RETRIEVED"
LC070:	DEFM "DISK "
LC075:	DEFM "BONUS: $05000"
LC082:	DEFM "LEVEL"
LC087:	DEFM "TOTAL PAY : $"

; ?? Movement handler (helicopter?)
LC094:	LD HL,L7343	; counter address
	DEC (HL)	; decrease counter
	JP Z,LBFD5	; zero => Escaped; final messages, then Game Over
	LD A,$10
	OUT ($FE),A
	LD HL,$4047
	LD DE,$4027
	LD C,$0F
LC0A7:	PUSH HL
	PUSH DE
	LD B,$08
LC0AB:	PUSH HL
	PUSH DE
	PUSH BC
	LD BC,$0011
	LDIR
	POP BC
	POP DE
	POP HL
	INC D
	INC H
	DJNZ LC0AB
	POP DE
	POP HL
	PUSH BC
	LD BC,$0020
	RR H
	RR H
	RR H
	ADD HL,BC
	RL H
	RL H
	RL H
	EX DE,HL
	RR H
	RR H
	RR H
	ADD HL,BC
	RL H
	RL H
	RL H
	EX DE,HL
	POP BC
	DEC C
	JR NZ,LC0A7
	XOR A
	OUT ($FE),A
	JP LB8D0	; => Update Ninja on tilemap

; Empty sprite
LC0E6:	DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

; Ninja on ladder
LC12E:	LD HL,LC3D9	; Movement handler for Ninja on ladder
	LD (LB8CD+1),HL
	LD HL,LD52E	; Sprite Ninja on ladder
	LD (L7186),HL	; set Ninja sprite address
	JP LC498	; => Move down one tile

; Routine at C13D
LC13D:	BIT 1,A
	JR Z,LC154
	LD HL,L7239	; Ninja direction address
	XOR A
	CP (HL)		; left?
	JR Z,LC14B
	DEC (HL)
	JR LC16E	; => Update Ninja on tilemap
; Entry point
LC14B:	LD HL,LC24B	; Movement handler address
	LD DE,LD3DE	; Sprite Ninja/Guard walking 1
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE
LC154:	BIT 0,A
	JR Z,LC16E
	LD HL,L7239	; Ninja direction address
	XOR A
	CP (HL)		; left?
	JR NZ,LC162
	INC (HL)
	JR LC16E	; => Update Ninja on tilemap
; Entry point
LC162:	LD HL,LC1B6	; Movement handler address
	LD (LB8CD+1),HL
	LD HL,LD3DE	; Sprite Ninja/Guard walking 1
	LD (L7186),HL	; set Ninja sprite address
; Entry point
LC16E:	JP LB8D0	; => Update Ninja on tilemap

; Data block at C171
LC171:	DEFB $3A,$40,$9C,$FE,$00,$CA,$26,$C2
	DEFB $3A,$40,$9C,$3D,$32,$40,$9C,$2A
	DEFB $42,$9C,$11,$E2,$FF,$19,$22,$42
	DEFB $9C,$CD,$DF,$BB,$CB,$5F,$20,$DD
	DEFB $C3,$26,$C2,$3A,$40,$9C,$FE,$0A
	DEFB $CA,$26,$C2,$3A,$40,$9C,$3C,$32
	DEFB $40,$9C,$2A,$42,$9C,$11,$1E,$00
	DEFB $19,$22,$42,$9C,$CD,$DF,$BB,$CB
	DEFB $57,$20,$BA,$18,$70

LC1B6:	LD A,(L9C41)	; get Ninja X
	CP $18		; 24 ?
	JP Z,LC2FA	; => Going to room at Right
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,L6590+184
	ADD HL,DE
	LD A,$64
	CP (HL)
	JR NC,LC1DA
	LD HL,L9C40	; Ninja Y address
	DEC (HL)	; one row up
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,$FFE2	; -30
	ADD HL,DE
	LD (L9C42),HL	; set Ninja position in tilemap
	JR LC20D
LC1DA:	LD DE,$FFE3	; -29
	ADD HL,DE
	LD A,$64
	CP (HL)
	JR NC,LC1EE
	CALL LBBDF	; Read Input
	BIT 0,A		; check RIGHT bit
	JP Z,LC226	; => Ninja standing
	JP LB8D0	; => Update Ninja on tilemap
LC1EE:	LD DE,$003B	; +59
	ADD HL,DE
	CP (HL)
	JR C,LC20D
	DEC HL
	CP (HL)
	JR C,LC20D
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,$001E	; +30
	ADD HL,DE
	LD (L9C42),HL	; set Ninja position in tilemap
	LD HL,L9C40	; Ninja Y address
	INC (HL)	; one row down
	LD A,(HL)
	CP $0A		; at the room bottom?
	JP Z,LC604	; yes => Going to room Down from current
LC20D:	LD HL,L9C41	; Ninja X address
	INC (HL)
	LD HL,(L9C42)	; get Ninja position in tilemap
	INC HL		; move one tile to right
	LD (L9C42),HL	; set Ninja position in tilemap
	CALL LC5A3	; Check for falling
	JP Z,LC643	; => Ninja falling
	CALL LBBDF	; Read Input
	BIT 0,A		; check RIGHT bit
	JP NZ,LC2BB

; Ninja standing
LC226:	LD HL,LBC55	; Movement handler: Ninja standing
	LD DE,LD486	; Sprite Ninja/Guard standing
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE

; Movement handler (B8CE handler): Ninja sitting
LC22F:	CALL LBBDF	; Read Input
	BIT 2,A		; check DOWN bit
	JR NZ,LC239	; still pressed =>
	JP LC226	; DOWN key released => stand up
LC239:	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,L6F86+182
	ADD HL,DE
	LD A,$0C
	CP (HL)
	LD B,$02
	CALL Z,L9DD9	; => Decrease Energy by B
	JP LC16E	; => Object procedure

; Movement handler (B8CE handler): Ninja walking
LC24B:	LD A,(L9C41)	; get Ninja X
	CP $00		; at very left?
	JP Z,LC319	; => Going to room at Left
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,L6590+181	; = $6590 (Tile screen 0) + 181
	ADD HL,DE
	LD A,$64
	CP (HL)
	JR NC,LC26F
	LD HL,L9C40	; Ninja Y address
	DEC (HL)	; moving one row up
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,$FFE2	; -30
	ADD HL,DE	; one row up
	LD (L9C42),HL	; set Ninja position in tilemap
	JR LC2A2
LC26F:	LD DE,$FFE1	; -31
	ADD HL,DE
	LD A,$64
	CP (HL)
	JR NC,LC283
	CALL LBBDF	; Read Input
	BIT 1,A		; check LEFT bit
	JP Z,LC226	; => Ninja standing
	JP LB8D0	; => Update Ninja on tilemap
LC283:	LD DE,$003D	; +61
	ADD HL,DE
	CP (HL)
	JR C,LC2A2
	INC HL
	CP (HL)
	JR C,LC2A2
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,$001E	; +30
	ADD HL,DE
	LD (L9C42),HL	; set Ninja position in tilemap
	LD HL,L9C40	; Ninja Y address
	INC (HL)	; moving one row down
	LD A,(HL)
	CP $0A		; at room bottom?
	JP Z,LC604	; => Going to room Down from current
LC2A2:	LD HL,L9C41	; Ninja X address
	DEC (HL)	; moving one tile left
	LD HL,(L9C42)	; get Ninja position in tilemap
	DEC HL		; moving one tile left
	LD (L9C42),HL	; set Ninja position in tilemap
	CALL LC5A3	; Check for falling
	JP Z,LC643	; => Ninja falling
	CALL LBBDF	; Read Input
	BIT 1,A		; check LEFT bit
	JP Z,LC226	; => Ninja standing

; LEFT or RIGHT key pressed
LC2BB:	BIT 3,A		; check for UP bit
	LD A,$07
	LD (L7343),A	; set counter = 7
	CALL NZ,LC4E8
	LD A,(L733A)
	INC A		; next walking phase
	AND $03		; 0..3
	LD (L733A),A
	ADD A,A		; * 2
	LD L,A
	LD A,$00
	LD (LA39E),A
	JR NZ,LC2E8
	INC A
	LD (LA39E),A
	LD C,$FE
	XOR A
	LD D,$10
	LD B,$32
LC2E2:	OUT (C),D
	OUT (C),A
	DJNZ LC2E2
LC2E8:	LD H,$00
	LD DE,L733B	; Table of four Ninja/Guard walking sprites
	ADD HL,DE
	LD DE,L7186	; address for Ninja sprite address
	LD A,(HL)
	LD (DE),A
	INC HL
	INC DE
	LD A,(HL)
	LD (DE),A
	JP LC16E	; => Object procedure

; Going to room at Right
LC2FA:	XOR A
	LD (L9C41),A	; set Ninja X = 0
	LD DE,$FFE8	; -24
	LD HL,(L9C42)
	ADD HL,DE	; update Ninja position in tilemap
	LD (L9C42),HL
	LD HL,(L7184)	; get Current Room address
	LD DE,$0006	; offset in Room description
	ADD HL,DE
	LD A,(HL)	; get Room Right address low byte
	INC HL
	LD H,(HL)	; get Room Right address high byte
	LD L,A
	LD (L7184),HL	; set Current Room address
	JP LB66A	; => Current Room changed

; Going to room at Left
LC319:	LD A,$18
	LD (L9C41),A	; set Ninja X = 24
	LD DE,$0018	; +24
	LD HL,(L9C42)
	ADD HL,DE	; update Ninja position in tilemap
	LD (L9C42),HL
	LD HL,(L7184)	; get Current Room address
	LD DE,$0004	; offset in Room description
	ADD HL,DE
	LD A,(HL)	; get Room Left address low byte
	INC HL
	LD H,(HL)	; get Room Left address high byte
	LD L,A
	LD (L7184),HL	; set Current Room address
	JP LB66A	; => Current Room changed

; Movement handler (B8CE handler): Ninja jumping
LC339:	LD HL,L7343	; counter address
	DEC (HL)	; decrease counter
	JP NZ,LB8D0	; => Update Ninja on tilemap
	LD A,(L7239)	; get Ninja direction
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,L6590+2	; $6592 = $6590 (Tile screen 0) + 2
	ADD HL,DE
	CP $00		; direction = left ?
	JR NZ,LC361	; no =>
	LD A,(HL)
	CP $0C
	JR Z,LC3BB
	CP $0A
	JR Z,LC3BB
	CP $08
	JR Z,LC3BB
	CP $09
	JR Z,LC3BB
	JR LC368
LC361:	INC HL
	CALL LC392
	JR Z,LC3CF
	DEC HL
LC368:	CALL LC392
	JR Z,LC3C6	; => Ninja on ladder
	LD DE,L6590+60
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD A,(L7239)	; get Ninja direction
	CP $00		; left ?
	JR Z,LC37D
	LD DE,L6590+65
LC37D:	ADD HL,DE
	LD A,$64
	CP (HL)
	JP C,LC4D0
	LD HL,LC4A7	; Movement handler
	LD DE,LD4DA	; Sprite Ninja/Guard jump-kick
	LD A,$03
	LD (L7343),A	; set counter = 3
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE

; Check if tile is a ladder
LC392:	LD A,(HL)
	LD B,$01
	CP $05
	JR Z,LC3B7
	CP $06
	JR Z,LC3B7
	CP $07
	JR Z,LC3B7
	CP $F6
	JR Z,LC3B7
	CP $F1
	JR Z,LC3B7
	CP $EF
	JR Z,LC3B7
	CP $ED
	JR Z,LC3B7
	CP $0C
	JR Z,LC3B7
	LD B,$00
LC3B7:	LD A,$01
	CP B
	RET

; Move LEFT one tile
LC3BB:	LD HL,L9C41	; Ninja X address
	DEC (HL)	; one tile to left
	LD HL,(L9C42)	; get Ninja position in tilemap
	DEC HL		; move one tile left
; Entry point
LC3C3:	LD (L9C42),HL	; set Ninja position in tilemap
; Ninja on ladder now
LC3C6:	LD HL,LC3D9	; Movement handler for Ninja on ladder
	LD DE,LD52E	; Sprite Ninja on ladder
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE

; Move RIGHT one tile
LC3CF:	LD HL,L9C41	; Ninja X address
	INC (HL)	; one tile to right
	LD HL,(L9C42)	; get Ninja position in tilemap
	INC HL		; move one tile right
	JR LC3C3	; => Set Ninja position in tilemap; Ninja on ladder

; Movement handler (B8CE handler): Ninja on ladder
LC3D9:	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,L6590+183	; = $6590 (Tile screen 0) + 183
	ADD HL,DE
	LD A,$0C
	CP (HL)		; ladder?
	JR Z,LC3EC	; yes => Read and process Input
	DEC HL
	CALL LC392
	JP NZ,LC226	; not ladder => Ninja standing

; Read and process Input
LC3EC:	CALL LBBDF	; Read Input
	BIT 0,A		; check RIGHT bit
	JR Z,LC40E

; Pressed RIGHT
LC3F3:	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,L6590+184	; = $6590 (Tile screen 0) + 184
	ADD HL,DE
	LD A,$64
	CP (HL)
	JR C,LC42C
	LD DE,$001E	; +30
	ADD HL,DE
	CP (HL)
	JR NC,LC42C
	LD A,$01
	LD (L7239),A	; set Ninja direction = 1 = right
	JP LC162

; Check if LEFT pressed
LC40E:	BIT 1,A		; check LEFT bit
	JR Z,LC42C

; Pressed LEFT
LC412:	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,L6590+181	; = $6590 (Tile screen 0) + 181
	ADD HL,DE
	LD A,$64
	CP (HL)
	JR C,LC42C
	LD DE,$001E	; +30
	ADD HL,DE
	CP (HL)
	JR NC,LC42C
	XOR A
	LD (L7239),A	; set Ninja direction = 0 = left
	JP LC14B

; Check if UP pressed
LC42C:	LD A,(L7232)	; get Input bits
	BIT 3,A		; check UP bit
	JR Z,LC477

; Pressed UP
LC433:	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,L6590+183
	ADD HL,DE
	LD A,$0C
	CP (HL)
	JR Z,LC447
	DEC HL
	CALL LC392
	JR Z,LC447
	JR LC495	; => Update Ninja on tilemap
LC447:	LD A,(L9C40)	; get Ninja Y
	CP $00		; top row?
	JP Z,LC623	; yes => Going to room Up from current
	LD DE,$FF2E	; -210 = 7 rows higher
	ADD HL,DE
	LD A,$EA
	CP (HL)
	JR Z,LC495	; => Update Ninja on tilemap
	LD A,$FF
	CP (HL)
	JR Z,LC495	; => Update Ninja on tilemap
	LD HL,L9C40	; Ninja Y address
	DEC (HL)	; one row up
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,$FFE2	; -30
; Entry point
LC467:	ADD HL,DE
	LD (L9C42),HL	; set Ninja position in tilemap
	LD A,(L7239)	; get Ninja direction
	INC A		; invert direction
	AND $01
	LD (L7239),A	; set Ninja direction
	JP LB8D0	; => Update Ninja on tilemap

; Check if DOWN pressed
LC477:	BIT 2,A		; check DOWN bit
	JR Z,LC495	; => Update Ninja on tilemap

; Pressed DOWN
LC47B:	LD A,(L9C40)	; get Ninja Y
	CP $0A
	JP Z,LC604	; => Going to room Down from current
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,L6590+213
	ADD HL,DE
	LD A,$0C
	CP (HL)
	JR Z,LC498	; => Move down one tile
	DEC HL
	CALL LC392
	JR Z,LC498	; => Move down one tile
LC495:	JP LB8D0	; => Update Ninja on tilemap

; Move DOWN one tile
LC498:	LD HL,L9C40	; Ninja Y address
	INC (HL)	; one tile down
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,$001E	; +30
	JR LC467	; => set Ninja position = HL, invert direction, Object procedure

; Routine at C4A4
LC4A4:	LD A,(L7239)	;get Ninja direction

; ?? Movement handler
LC4A7:	LD HL,L7343	; counter address
	DEC (HL)	; decrease counter
	JP NZ,LB8D0	; => Update Ninja on tilemap
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,L6D88+65	; value for right dir = $6D88 (Tile screen 4) + 65
	LD A,(L7239)	; get Ninja direction
	CP $01		; direction = right?
	JR Z,LC4BE
	LD DE,L6D88+60	; value for left dir = $6D88 (Tile screen 4) + 60
LC4BE:	ADD HL,DE
	LD A,(HL)
	INC A		; = $FF ?
	JR Z,LC4D0
	LD A,$09
	LD (L7346),A	; set Guard state = $09 dead
	CALL LB596
	LD B,$05
	CALL LB4DE	; Increase PAY value by 500 - Guard killed by punch/kick
; Entry point
LC4D0:	LD HL,LC4DE	; Movement handler address
	LD DE,LD4B0	; Sprite Ninja/Guard jumping
	LD A,$01
	LD (L7343),A	; set counter = 1
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE

; ?? Movement handler
LC4DE:	LD HL,L7343	; counter address
	DEC (HL)	; decrease counter
	JP NZ,LB8D0	; => Update Ninja on tilemap
	JP LC226	; => Ninja standing

; Routine at C4E8
LC4E8:	CALL LC57B	; Check for ??
	RET NZ
	POP HL
	LD HL,LC4F6	; Movement handler address
	LD DE,LD5AC	; Sprite Ninja jumping 3
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE

; Movement handler (used in initial room)
LC4F6:	CALL LC57B	; Check for ??
	JP Z,LC504
	LD B,$03
	CALL L9DD9	; Decrease Energy by B
	JP LC226	; => Ninja standing
LC504:	LD HL,LC50D	; Movement handler address
	LD DE,LD5D6	; Sprite Ninja jumping 4
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE

; Movement handler ??
LC50D:	LD A,(L7239)	; get Ninja direction
	CP $00		; left?
	LD HL,L9C41	; Ninja X address
	LD A,(HL)
	JR NZ,LC56C
	CP $00
	JP Z,LC319	; => Going to room at Left
	DEC (HL)
	LD HL,(L9C42)	; get Ninja position in tilemap
	DEC HL
	LD (L9C42),HL	; set Ninja position in tilemap
LC525:	CALL LC57B	; Check for ??
	JR NZ,LC533
	LD HL,L7343	; counter address
	DEC (HL)	; decrease counter
	JP NZ,LC16E
	JR LC538
LC533:	LD B,$04
	CALL L9DD9	; Decrease Energy by B
LC538:	LD DE,L6590+122
	LD B,$03
LC53D:	LD HL,(L9C42)	; get Ninja position in tilemap
	ADD HL,DE
	LD A,$64
	CP (HL)
	JR NC,LC558
LC546:	LD HL,L9C40	; Ninja Y address
	DEC (HL)
	LD HL,(L9C42)	; get Ninja position in tilemap
	PUSH DE
	LD DE,$FFE2	; -30
	ADD HL,DE
	POP DE
	LD (L9C42),HL	; set Ninja position in tilemap
	JR LC53D
LC558:	INC HL
	CP (HL)
	JR C,LC546
	LD HL,$001E	; +30
	ADD HL,DE
	EX DE,HL
	DJNZ LC53D
	LD HL,LC5A0	; Movement handler: switch Ninja to standing
	LD DE,LD5AC	; Sprite Ninja jumping 3
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE
LC56C:	CP $18
	JP Z,LC2FA	; => Going to room at Right
	INC (HL)
	LD HL,(L9C42)	; get Ninja position in tilemap
	INC HL
	LD (L9C42),HL	; set Ninja position in tilemap
	JR LC525

; Routine at C57B
LC57B:	LD A,(L7239)	; get Ninja direction
	LD L,A
	ADD A,A
	ADD A,A
	ADD A,L		; * 5
	LD L,A
	LD H,$00
	LD DE,(L9C42)	; get Ninja position in tilemap
	ADD HL,DE
	LD DE,L6590	; Tile screen 0 start address
	ADD HL,DE
	LD BC,$0400
	LD DE,$001E	; +30
	LD A,$64
LC596:	CP (HL)
	JR NC,LC59A
	INC C
LC59A:	ADD HL,DE
	DJNZ LC596
	XOR A
	CP C		; now Z=0: falling, Z=1: not falling
	RET

; Switch Ninja to standing (redirect)
LC5A0:	JP LC226	; => Ninja standing

; Check for falling
LC5A3:	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,$00D3
	ADD HL,DE
	LD DE,L6590	; Tile screen 0 start address
	ADD HL,DE
	LD A,(L7239)	; get Ninja direction
	LD D,$00	; left?
	LD E,A
	ADD HL,DE
	LD B,$03
	LD C,$00
	LD A,$64
LC5BB:	CP (HL)
	JR NC,LC5C0
	LD C,$01
LC5C0:	INC HL
	DJNZ LC5BB
	XOR A
	CP C
	RET

; Movement handler: Ninja falling down
LC5C6:	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,$001E	; +30
	ADD HL,DE	; one row lower
	LD (L9C42),HL	; set Ninja position in tilemap
	LD HL,L755B	; falling counter address
	INC (HL)	; increase falling counter
	LD HL,L9C40	; Ninja Y address
	INC (HL)	; increase Ninja Y
	LD A,(HL)	; get Ninja Y
	CP $0A		; at room bottom?
	JR Z,LC604	; => Going to room Down from current
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,L6590+212
	ADD HL,DE
	LD A,$64
	CP (HL)
	JR C,LC5EE
	INC HL
	CP (HL)
	JP NC,LB8D0	; => Update Ninja on tilemap
; Ninja hit somehting after falling
LC5EE:	LD A,$01
	LD (LA39E),A
	LD HL,L755B	; falling counter address
	LD B,(HL)	; get counter value
	LD (HL),$00	; clear falling counter
	CALL L9DD9	; Decrease Energy by B
	LD B,$32
	CALL LB59E
	JP LBFCC	; => Ninja sitting now

; Going to room Down from current
LC604:	XOR A
	LD (L9C40),A	; set Ninja Y = 0
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,$FED4	; -300
	ADD HL,DE	; 10 rows higher
	LD (L9C42),HL	; set Ninja position in tilemap
	LD HL,(L7184)	; get Current Room address
	LD DE,$000A	; offset in room description
	ADD HL,DE	; now HL = room address + 10
	LD A,(HL)	; get Room Down address low byte
	INC HL
	LD H,(HL)	; get Room Down address high byte
	LD L,A
	LD (L7184),HL	; set Current Room address
	JP LB66A	; => Current Room changed

; Going to room Up from current
LC623:	LD A,$0A
	LD (L9C40),A	; set Ninja Y = 10
	LD HL,(L9C42)	; get Ninja position in tilemap
	LD DE,$012C	; +300
	ADD HL,DE	; 10 rows lower
	LD (L9C42),HL	; set Ninja position in tilemap
	LD HL,(L7184)	; get Current Room address
	LD DE,$0008	; offset in room description
	ADD HL,DE	; now HL = room address + 8
	LD A,(HL)	; get Room Up address low byte
	INC HL
	LD H,(HL)	; get Room Up address high byte
	LD L,A
	LD (L7184),HL	; set Current Room address
	JP LB66A	; => Current Room changed

; Ninja falling
LC643:	LD HL,LC5C6	; Movement handler address: Ninja falling
	LD DE,LD582	; Sprite Ninja falling
	JP LBFB0	; Set movement handler = HL, Ninja sprite = DE

; Room 791E (room with pier) initialization
LC64C:	LD HL,LC65A
	LD DE,L6590+220	; = $6590 (Tile screen 0) + 220
	LD BC,$0011	; 17
	LDIR		; copy bytes to Background
	JP LB724	; => Finish room initialization

; Data for room with pier
LC65A:	DEFB $E3,$E3,$E3,$F6,$F6,$E3,$E3,$E3
	DEFB $F6,$F6,$E3,$E3,$E3,$E3,$E3,$E3
	DEFB $E3

; Guard data for rooms 7C9C/92EF
LC66B:	DEFB $0E,$00,$0E,$00,$04,$00

; Room 93DF/947C (room right from Train) initialization
LC671:	LD HL,L947C	; room 947C at left of Train 1
	LD (L7CA0),HL	; set "room to left" for room 7C9C
	LD HL,L93DF	; room 93DF at right of Train 1
	LD (L7CA2),HL	; set "room to right" for room 7C9C
	LD A,$6C	; tile for "1" sign
	JR LC68F

; Room 982B initialization
LC681:	LD HL,L9A1E	; room 9A1E at left of Train 2
	LD (L7CA0),HL	; set "room to left" for room 7C9C
	LD HL,L982B	; room 982B at right of Train 2
	LD (L7CA2),HL	; set "room to right" for room 7C9C
	LD A,$75	; tile for "2" sign

; Fill 3x3 block with tile for "1"/"2" sign
LC68F:	LD HL,L7D0D+19
	LD DE,$0003
	LD C,$03
LC697:	LD B,$03
LC699:	LD (HL),A
	INC HL
	INC A
	DJNZ LC699
	ADD HL,DE
	DEC C
	JR NZ,LC697
	JP LB724	; => Finish room initialization

; Room 7C9C procedure (tunnel Train)
LC6A5:	LD A,(L9C41)	; get Ninja X
	CP $0C
	JP NZ,LB937	; => Standard room procedure
	LD A,$4B
	LD (L7343),A	; set counter = 75
	LD DE,(L9C42)	; get Ninja position in tilemap
	LD A,(L9C41)	; get Ninja X
	INC A
	LD B,A
	INC DE
	LD HL,LC70C	; Movement handler: Train moving right
	LD A,(L7239)	; get Ninja direction
	CP $00		; left?
	JR NZ,LC6CD	; right =>
	LD HL,LC6E2	; Movement handler: Train moving left
	DEC B
	DEC B
	DEC DE
	DEC DE
LC6CD:	LD A,B
	LD (L9C41),A	; set Ninja X
	LD (L9C42),DE	; set Ninja position in tilemap
	LD DE,LD486	; Sprite Ninja/Guard standing
	LD (L7186),DE	; set Ninja sprite
	LD (LB8CD+1),HL	; set Movement handler
	JP LB937	; => Standard room procedure

; Movement handler (B8CE handler): Train moving left
LC6E2:	LD B,$02
LC6E4:	LD DE,L6590+479
	LD HL,L6590+478
	PUSH BC
	LD BC,$001D
	LD A,(DE)
	LDDR
	LD (DE),A
	POP BC
	DJNZ LC6E4
; Entry point
LC6F5:	LD HL,L678E+450
	LD DE,L678E+451
	LD (HL),$01
	LD BC,$001D
	LDIR
	LD HL,L7343	; counter address
	DEC (HL)	; decrease counter
	JP Z,LC226	; => Ninja standing
	JP LB8D0	; => Update Ninja on tilemap

; Movement handler (B8CE handler): Train moving right
LC70C:	LD B,$02
LC70E:	LD DE,L6590+450
	LD HL,L6590+451
	PUSH BC
	LD BC,$001D
	LD A,(DE)
	LDIR
	LD (DE),A
	POP BC
	DJNZ LC70E
	JR LC6F5

; Font
LC721:	DEFB $00,$00,$00,$00,$00,$00,$00,$00	; ' '
	DEFB $00,$10,$10,$10,$10,$00,$10,$00	; '!'
	DEFB $00,$24,$24,$00,$00,$00,$00,$00	; '"'
	DEFB $00,$24,$7E,$24,$24,$7E,$24,$00	; '#'
	DEFB $00,$08,$3E,$28,$3E,$0A,$3E,$08	; '$'
	DEFB $00,$62,$64,$08,$10,$26,$46,$00	; '%'
	DEFB $00,$10,$28,$10,$2A,$44,$3A,$00	; '&'
	DEFB $00,$08,$10,$00,$00,$00,$00,$00	; '''
	DEFB $00,$04,$08,$08,$08,$08,$04,$00	; '('
	DEFB $00,$20,$10,$10,$10,$10,$20,$00	; ')'
	DEFB $00,$00,$14,$08,$3E,$08,$14,$00	; '*'
	DEFB $00,$00,$08,$08,$3E,$08,$08,$00	; '+'
	DEFB $00,$00,$00,$00,$00,$08,$08,$10	; ','
	DEFB $00,$00,$00,$00,$3E,$00,$00,$00	; '-'
	DEFB $00,$00,$00,$00,$00,$18,$18,$00	; '.'
	DEFB $00,$00,$02,$04,$08,$10,$20,$00	; '/'
	DEFB $00,$7E,$42,$42,$46,$46,$7E,$00	; '0'
	DEFB $00,$08,$08,$08,$18,$18,$18,$00	; '1'
	DEFB $00,$7E,$02,$02,$7E,$60,$7E,$00	; '2'
	DEFB $00,$7E,$02,$1E,$06,$06,$7E,$00	; '3'
	DEFB $00,$42,$42,$7E,$06,$06,$06,$00	; '4'
	DEFB $00,$7E,$40,$7E,$06,$06,$7E,$00	; '5'
	DEFB $00,$7E,$40,$7E,$46,$46,$7E,$00	; '6'
	DEFB $00,$7E,$02,$02,$06,$06,$06,$00	; '7'
	DEFB $00,$7E,$42,$7E,$46,$46,$7E,$00	; '8'
	DEFB $00,$7E,$42,$7E,$06,$06,$06,$00	; '9'
	DEFB $00,$00,$00,$10,$00,$00,$10,$00	; ':'
	DEFB $00,$00,$10,$00,$00,$10,$10,$20	; ';'
	DEFB $00,$00,$04,$08,$10,$08,$04,$00	; '<'
	DEFB $00,$00,$00,$3E,$00,$3E,$00,$00	; '='
	DEFB $00,$00,$10,$08,$04,$08,$10,$00	; '>'
	DEFB $00,$3C,$42,$04,$08,$00,$08,$00	; '?'
	DEFB $00,$3C,$4A,$56,$5E,$40,$3C,$00	; '@'
	DEFB $00,$7E,$42,$42,$7E,$46,$46,$00	; 'A'
	DEFB $00,$7C,$42,$7C,$46,$46,$7C,$00	; 'B'
	DEFB $00,$7E,$40,$40,$60,$60,$7E,$00	; 'C'
	DEFB $00,$7C,$42,$42,$46,$46,$7C,$00	; 'D'
	DEFB $00,$7E,$40,$7E,$60,$60,$7E,$00	; 'E'
	DEFB $00,$7E,$40,$7E,$60,$60,$60,$00	; 'F'
	DEFB $00,$7E,$42,$40,$4E,$46,$7E,$00	; 'G'
	DEFB $00,$42,$42,$7E,$46,$46,$46,$00	; 'H'
	DEFB $00,$08,$08,$08,$18,$18,$18,$00	; 'I'
	DEFB $00,$02,$02,$02,$46,$46,$7E,$00	; 'J'
	DEFB $00,$42,$42,$7E,$4C,$4C,$4C,$00	; 'K'
	DEFB $00,$40,$40,$40,$40,$40,$7E,$00	; 'L'
	DEFB $00,$7E,$52,$52,$56,$56,$56,$00	; 'M'
	DEFB $00,$72,$52,$52,$56,$56,$5E,$00	; 'N'
	DEFB $00,$7E,$42,$42,$46,$46,$7E,$00	; 'O'
	DEFB $00,$7E,$42,$42,$7E,$60,$60,$00	; 'P'
	DEFB $00,$7E,$42,$42,$4E,$4E,$7F,$07	; 'Q'
	DEFB $00,$7E,$42,$42,$7E,$4C,$4C,$00	; 'R'
	DEFB $00,$7E,$40,$7E,$06,$06,$7E,$00	; 'S'
	DEFB $00,$7E,$08,$08,$18,$18,$18,$00	; 'T'
	DEFB $00,$42,$42,$42,$46,$46,$7E,$00	; 'U'
	DEFB $00,$42,$42,$42,$2C,$2C,$18,$00	; 'V'
	DEFB $00,$52,$52,$52,$56,$56,$7E,$00	; 'W'
	DEFB $00,$42,$24,$18,$18,$2C,$46,$00	; 'X'
	DEFB $00,$42,$42,$7E,$18,$18,$18,$00	; 'Y'
	DEFB $00,$7E,$02,$7E,$60,$60,$7E,$00	; 'Z'

; Data block at C8F9
LC8F9:	DEFM " "
	DEFB $6D,$C2,$CE
	DEFM "X2LD         "
	DEFB $44,$C2,$CE
	DEFM "DLDC         "
	DEFB $38,$C2,$CB
	DEFM "ICKP         "
	DEFB $28,$C3,$CE
	DEFM "DEDG         "
	DEFB $4E,$C3,$CE
	DEFM "KICR         "
	DEFB $FE,$C1,$CC
	DEFM "ADUP         "
	DEFB $47,$C2,$CC
	DEFM "AD2R         "
	DEFB $50,$C2,$CE
	DEFM "LADR         "
	DEFB $E9,$C1,$CC
	DEFM "AD2L         "
	DEFB $3C,$C2,$CE
	DEFM "LADL         "
	DEFB $E2,$C1,$C6
	DEFM "TFLL         "
	DEFB $63,$C1,$CE
	DEFM "FTFL         "
	DEFB $69,$C1,$CC
	DEFM "OIUT         "
	DEFB $04,$C1,$CA
	DEFM "AK           "
	DEFB $23,$C1,$CA
	DEFM "AKE2         "
	DEFB $F0,$C0,$CC
	DEFM "EFSC         "
	DEFB $9A,$C1,$D3
	DEFM "TCRH         "
	DEFB $C9,$C0,$CC
	DEFM "EGP          "
	DEFB $3C,$C1,$C4
	DEFM "NSCR         "
	DEFB $9D,$C4,$CC
	DEFM "OIUY         "
	DEFB $7E,$C0,$CA
	DEFM "AKSN         "
	DEFB $9D,$C0,$CA
	DEFM "AKS2         "
	DEFB $6A,$C0,$D2
	DEFM "ITSC         "
	DEFB $7B,$C1,$C4
	DEFM "OWNP         "
	DEFB $24,$C0,$D5
	DEFM "PP           "
	DEFB $01,$C0,$D2
	DEFM "ITEP         "
	DEFB $46,$C0,$CE
	DEFM "TRN2         "
	DEFB $F2,$BF,$CC
	DEFM "EFTP         "
	DEFB $CC,$C0,$CE
	DEFM "TRN1         "
	DEFB $DB,$BF,$CE
	DEFM "LEFT         "
	DEFB $E4,$BF,$CC
	DEFM "ADDD         "
	DEFB $19,$C3,$CC
	DEFM "ADDP         "
	DEFB $5A,$C2,$CE
	DEFM "             "
	DEFB $FF,$FF,$C3
	DEFM "PLP1         "
	DEFB $3B,$BF,$C3
	DEFM "PLP2         "
	DEFB $37,$BF,$C3
	DEFM "RUTP         "
	DEFB $BF,$C0,$D3
	DEFM "QUSH         "
	DEFB $16,$BF,$C4
	DEFM "NTPL         "
	DEFB $BE,$BF,$C3
	DEFM "MPLD         "
	DEFB $13,$C2,$CE
	DEFM "DOWN         "
	DEFB $CD,$BF,$CA
	DEFM "UMPP         "
	DEFB $BA,$C1,$CE
	DEFM "DRTY         "
	DEFB $EF,$BE,$CC
	DEFM "EAPR         "
	DEFB $66,$C3,$CE
	DEFM "BDEE         "
	DEFB $EA,$BE,$CE
	DEFM "RITE         "
	DEFB $FE,$BF,$CE
	DEFM "ONIN         "
	DEFB $76,$BF,$C6
	DEFM "LYP          "
	DEFB $24,$BF,$C3
	DEFM "OD98         "
	DEFB $A0,$BE,$C3
	DEFM "OD99         "
	DEFB $82,$BE,$C8
	DEFM "ANGR         "
	DEFB $73,$BE,$CE
	DEFM "COPT         "
	DEFB $C5,$BE,$CE
	DEFM "UP           "
	DEFB $04,$BF,$CE
	DEFM "DDG2         "
	DEFB $3B,$BE,$CE
	DEFM "PGRD         "
	DEFB $2C,$BE,$D4
	DEFM "HROP         "
	DEFB $19,$BE,$C2
	DEFM "UNGD         "
	DEFB $0C,$BE,$C2
	DEFM "UNGU         "
	DEFB $05,$BE,$CE
	DEFM "LFTH         "
	DEFB $F7,$BD,$C3
	DEFM "OD3          "
	DEFB $D4,$BD,$D0
	DEFM "UNCH         "
	DEFB $1C,$BE,$C3
	DEFM "OD22         "
	DEFB $8B,$BD,$CE
	DEFM "NEAR         "
	DEFB $A1,$BD,$D0
	DEFM "ROGO         "
	DEFB $93,$BD,$CE
	DEFM "FIRE         "
	DEFB $44,$BE,$C6
	DEFM "ALLN         "
	DEFB $DC,$C4,$C6
	DEFM "ALLQ         "
	DEFB $22,$C4,$CE
	DEFM "DGLN         "
	DEFB $60,$BD,$C7
	DEFM "LANS         "
	DEFB $41,$BD,$CE
	DEFM "GLAN         "
	DEFB $5B,$BD,$D3
	DEFM "TANP         "
	DEFB $39,$BD,$D4
	DEFM "BFST         "
	DEFB $34,$BD,$C3
	DEFM "HRLP         "
	DEFB $D6,$BC,$CC
	DEFM "LLP2         "
	DEFB $BF,$BC,$CE
	DEFM "BROT         "
	DEFB $CE,$BC,$CC
	DEFM "OIP2         "
	DEFB $86,$BC,$C7
	DEFM "DDIS         "
	DEFB $45,$C4,$D1
	DEFM "LLP1         "
	DEFB $53,$BC,$C4
	DEFM "GDIS         "
	DEFB $56,$C4,$D3
	DEFM "CRCB         "
	DEFB $6B,$BC,$D2
	DEFM "EVQ          "
	DEFB $23,$BD,$CC
	DEFM "LLP1         "
	DEFB $1F,$BC,$C3
	DEFM "OLOK         "
	DEFB $07,$BC,$CB
	DEFM "NOB          "
	DEFB $10,$BC,$C2
	DEFM "CLP1         "
	DEFB $D4,$BB,$C2
	DEFM "CHRS         "
	DEFB $00,$F7,$C6
	DEFM "TJMP         "
	DEFB $DB,$BB,$C8
	DEFM "IDFT         "
	DEFB $BF,$BB,$C6
	DEFM "OTS1         "
	DEFB $DE,$BB,$CE
	DEFM "DRAW         "
	DEFB $E4,$BC,$C4
	DEFM "LP2          "
	DEFB $AA,$BB,$C4
	DEFM "LP1          "
	DEFB $A8,$BB,$D3
	DEFM "ETIN         "
	DEFB $6C,$BB,$CE
	DEFM "TKEY         "
	DEFB $6E,$BB,$CC
	DEFM "OPQ1         "
	DEFB $5A,$BB,$CF
	DEFM "K            "
	DEFB $50,$BB,$CB
	DEFM "EYBD         "
	DEFB $55,$BB,$D3
	DEFM "TN           "
	DEFB $B6,$C0,$CB
	DEFM "EY           "
	DEFB $46,$BB,$D0
	DEFM "UNCP         "
	DEFB $3B,$BB,$CC
	DEFM "OPP2         "
	DEFB $32,$BB,$CC
	DEFM "OPP1         "
	DEFB $30,$BB,$CE
	DEFM "LEFE         "
	DEFB $E3,$BA,$CE
	DEFM "RTED         "
	DEFB $D9,$BA,$CE
	DEFM "TOPE         "
	DEFB $D1,$BA,$CE
	DEFM "BOTE         "
	DEFB $C0,$BA,$D0
	DEFM "IXX2         "
	DEFB $96,$BA,$D0
	DEFM "IXEX         "
	DEFB $93,$BA,$C3
	DEFM "OD31         "
	DEFB $57,$BA,$D0
	DEFM "IXTB         "
	DEFB $29,$BA,$C3
	DEFM "ENAT         "
	DEFB $1F,$BA,$C3
	DEFM "OD37         "
	DEFB $0F,$BA,$C3
	DEFM "OD36         "
	DEFB $0C,$BA,$C8
	DEFM "ITE3         "
	DEFB $07,$BA,$C1
	DEFM "TEXP         "
	DEFB $04,$BA,$C3
	DEFM "OD39         "
	DEFB $DD,$B9,$C3
	DEFM "OD33         "
	DEFB $D9,$B9,$C3
	DEFM "OD32         "
	DEFB $D5,$B9,$C8
	DEFM "ITE2         "
	DEFB $D3,$B9,$C4
	DEFM "ATAX         "
	DEFB $D0,$B9,$C5
	DEFM "XPLO         "
	DEFB $E5,$AB,$D0
	DEFM "XEXP         "
	DEFB $CD,$B9,$C3
	DEFM "OD35         "
	DEFB $AE,$B9,$C3
	DEFM "OD34         "
	DEFB $AB,$B9,$C8
	DEFM "ITE1         "
	DEFB $A9,$B9,$C4
	DEFM "REXP         "
	DEFB $A6,$B9,$C3
	DEFM "OD10         "
	DEFB $90,$B9,$CE
	DEFM "THGD         "
	DEFB $75,$B9,$CE
	DEFM "THDD         "
	DEFB $5E,$B9,$CF
	DEFM "BEXP         "
	DEFB $4B,$BA,$CF
	DEFM "BOFS         "
	DEFB $0E,$BB,$CE
	DEFM "DMV1         "
	DEFB $11,$B9,$CE
	DEFM "DNTH         "
	DEFB $ED,$B8,$CE
	DEFM "UPTH         "
	DEFB $E3,$B8,$D2
	DEFM "MDOB         "
	DEFB $15,$BB,$CE
	DEFM "DMVO         "
	DEFB $9C,$B9,$CE
	DEFM "XTHR         "
	DEFB $D3,$B8,$CC
	DEFM "OOPO         "
	DEFB $C1,$B8,$C4
	DEFM "ELAY         "
	DEFB $A1,$B8,$CC
	DEFM "PPP2         "
	DEFB $8F,$B8,$CC
	DEFM "PPP1         "
	DEFB $8D,$B8,$C5
	DEFM "NDRF   P         "
	DEFB $70,$B7,$C9
	DEFM "NITB         "
	DEFB $7F,$B7,$C3
	DEFM "LOSP         "
	DEFB $60,$B7,$C5
	DEFM "NDNR         "
	DEFB $D1,$B7,$C3
	DEFM "OD21         "
	DEFB $54,$B7

; Table of 35 records, 2 bytes each, see B851
LD210:	DEFB $04,$CE,$09,$63,$09,$63,$09,$63,$09,$63
	DEFB $09,$63,$09,$63,$09,$D4,$05,$D0,$05,$D0
	DEFB $05,$D0,$06,$D2,$08,$D6,$02,$CA,$03,$CC
	DEFB $05,$D0,$05,$D0,$05,$D0,$03,$CC,$02,$CA
	DEFB $02,$CA,$03,$CC,$02,$CA,$06,$D2,$02,$CA
	DEFB $06,$D2,$02,$CA,$03,$CC,$03,$CC,$03,$CC
	DEFB $04,$CE,$04,$CE,$04,$CE,$04,$CE,$04,$CE

; Table of objects, 35 records, 7 bytes each
; +$03: Object tile unique, to identify the object
; +$04: Object item, for NEAR indicator
; +$05: Object tile as object type
; +$05/$06: Object procedure, or $0000
LD256:	DEFW $6F02	; Object ?? 00
	DEFB $58,$04,$CE
	DEFW $0000
	DEFW $6664	; Object: Console in room 80F6
	DEFB $7C,$09,$63
	DEFW $B320	; Object procedure: flip trigger "D": set/remove wall in room 9739
	DEFW $6664	; Object: Console in room 99A6
	DEFB $7D,$09,$63
	DEFW $B32A	; Object procedure: flip trigger "E": set/remove wall in room 97A6
	DEFW $6664	; Object: Console in room 92A7
	DEFB $7E,$09,$63
	DEFW $B348	; Object procedure: flip trigger "A": set/remove wall in room 7F48
	DEFW $6664	; Object: Console in room 92EF
	DEFB $7F,$09,$63
	DEFW $B334	; Object procedure: flip trigger "C": set/remove wall in room 8D5C
	DEFW $6664	; Object: Console in room 9005
	DEFB $80,$09,$63
	DEFW $B33E	; Object procedure: flip trigger "B": set/remove wall in room 8F20
	DEFW $6FE2	; Object ?? 06
	DEFB $1F,$09,$63
LD285:	DEFW $B8D0	; Object procedure "Update Ninja on tilemap"
LD287:	DEFW $6669	; Object ?? 07 Diskette
	DEFB $9C,$09,$D4
	DEFW $0000
	DEFW $659B	; Object ?? 08
	DEFB $9A,$05,$D0
	DEFW $0000
	DEFW $6750	; Object ?? 09
	DEFB $38,$05,$D0
	DEFW $0000
	DEFW $6664	; Object ?? 10
	DEFB $81,$05,$D0
	DEFW $0000
	DEFW $6664	; Object ?? 11
	DEFB $65,$06,$D2
	DEFW $0000
	DEFW $6664	; Object ?? 12 BOMB ??
	DEFB $66,$08,$D6
	DEFW $0000
	DEFW $6664	; Object ?? 13
	DEFB $67,$02,$CA
	DEFW $0000
	DEFW $6664	; Object ?? 14
	DEFB $68,$03,$CC
	DEFW $0000
	DEFW $6664	; Object ?? 15
	DEFB $69,$05,$D0
	DEFW $0000
	DEFW $6664	; Object ?? 16
	DEFB $6A,$05,$D0
	DEFW $0000
	DEFW $6664	; Object ?? 17
	DEFB $6B,$05,$D0
	DEFW $0000
	DEFW $6664	; Object ?? 18
	DEFB $6C,$03,$CC
	DEFW $0000
	DEFW $6664	; Object ?? 19
	DEFB $6D,$02,$CA
	DEFW $0000
	DEFW $6664	; Object ?? 20
	DEFB $6D,$02,$CA
	DEFW $0000
	DEFW $6664	; Object ?? 21
	DEFB $6E,$03,$CC
	DEFW $0000
	DEFW $6664	; Object ?? 22
	DEFB $6F,$02,$CA
	DEFW $0000
LD2F7:	DEFW $6664	; Object ?? 23
	DEFB $70,$06,$D2
	DEFW $0000
	DEFW $6664	; Object ?? 24
	DEFB $71,$02,$CA
	DEFW $0000
	DEFW $6664	; Object ?? 25
	DEFB $72,$06,$D2
	DEFW $0000
	DEFW $6664	; Object ?? 26
	DEFB $73,$02,$CA
	DEFW $0000
	DEFW $6664	; Object ?? 27
	DEFB $74,$03,$CC
	DEFW $0000
	DEFW $6664	; Object ?? 28
	DEFB $75,$03,$CC
	DEFW $0000
	DEFW $6664	; Object ?? 29
	DEFB $76,$03,$CC
	DEFW $0000
	DEFW $6664	; Object ?? 30
	DEFB $77,$04,$CE
	DEFW $0000
	DEFW $6664	; Object ?? 31
	DEFB $78,$04,$CE
	DEFW $0000
	DEFW $6664	; Object ?? 32
	DEFB $79,$04,$CE
	DEFW $0000
	DEFW $6664	; Object ?? 33
	DEFB $7A,$04,$CE
	DEFW $0000
	DEFW $6664	; Object ?? 34
	DEFB $7B,$04,$CE
	DEFB $00,$00

LD34B:	DEFW $6664

; Table of objects, 29 records, 5 bytes each
; +$00/$01: room address
; +$02/$03: address in Tile screen 0
; +$04: tile byte
LD34D:	DEFW $9ED9,$66DF
	DEFB $81
	DEFW $9E22,$671C
	DEFB $65
LD357:	DEFW $9E22,$672E	; BOMB, placement depends on Level
	DEFB $66
	DEFW $990D,$6787
	DEFB $67
	DEFW $8D5C,$6767
	DEFB $68
	DEFW $8EE1,$675E
	DEFB $69
	DEFW $889F,$66DC
	DEFB $6A
	DEFW $890E,$6699
	DEFB $6B
	DEFW $8CC8,$6782
	DEFB $6C
	DEFW $8739,$66AA	; #10
	DEFB $6D
	DEFW $8799,$6757
	DEFB $6E
	DEFW $913F,$6782
	DEFB $6F
	DEFW $8321,$6777
	DEFB $70
	DEFW $8162,$6782
	DEFB $71
	DEFW $7EF2,$6788
	DEFB $72
	DEFW $7F48,$6744
	DEFB $73
	DEFW $7C6D,$6747
	DEFB $74
	DEFW $7A9E,$675D
	DEFB $75
	DEFW $7A9E,$6767
	DEFB $76
	DEFW $7A9E,$6769	; #20
	DEFB $77
	DEFW $7AF8,$6785
	DEFB $78
	DEFW $7AF8,$6786
	DEFB $79
	DEFW $9376,$673B
	DEFB $7A
	DEFW $79C6,$6785
	DEFB $7B
	DEFW $80F6,$6773	; Console in room 80F6
	DEFB $7C
	DEFW $99A6,$6783	; Console in room 99A6
	DEFB $7D
	DEFW $92A7,$675D	; Console in room 92A7, see D26B
	DEFB $7E
	DEFW $92EF,$6668	; Console in room 92EF
	DEFB $7F
	DEFW $9005,$66B5	; Console in room 9005
	DEFB $80

; Ninja/Guard sprites
; Most of Ninja sprites are also Guard sprites,
; A775 procedure and A787 table used to translate Ninja tiles into Guard tiles.
; Sprite Ninja/Guard walking 1
LD3DE:	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$4F,$50,$51,$FF
	DEFB $FF,$FF,$52,$53,$54,$FF
	DEFB $FF,$FF,$55,$56,$57,$FF
	DEFB $FF,$FF,$58,$59,$FF,$FF
	DEFB $FF,$5A,$5B,$5C,$FF,$FF
; Sprite Ninja/Guard walking 2
LD408:	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$4F,$50,$51,$FF
	DEFB $FF,$FF,$52,$53,$54,$FF
	DEFB $FF,$FF,$55,$5E,$5F,$FF
	DEFB $FF,$FF,$60,$61,$62,$FF
	DEFB $FF,$FF,$63,$64,$FF,$FF
; Sprite Ninja/Guard walking 3
LD432:	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$4F,$50,$51,$FF
	DEFB $FF,$FF,$52,$53,$54,$FF
	DEFB $FF,$FF,$5D,$65,$66,$FF
	DEFB $FF,$FF,$67,$68,$69,$FF
	DEFB $FF,$6A,$6B,$6C,$FF,$FF
; Sprite Ninja/Guard walking 4
LD45C:	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$4F,$50,$51,$FF
	DEFB $FF,$FF,$52,$53,$54,$FF
	DEFB $FF,$FF,$5D,$6D,$57,$FF
	DEFB $FF,$6F,$70,$71,$72,$FF
	DEFB $FF,$73,$74,$FF,$75,$FF
; Sprite Ninja/Guard standing
LD486:	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$F4,$F5,$FF,$FF
	DEFB $FF,$02,$03,$F6,$FF,$FF
	DEFB $FF,$05,$06,$07,$08,$FF
	DEFB $FF,$0A,$0B,$0C,$0D,$FF
	DEFB $FF,$FF,$0E,$0F,$10,$FF
	DEFB $FF,$FF,$11,$FF,$12,$FF
; Sprite Ninja/Guard jumping
LD4B0:	DEFB $FF,$FF,$13,$14,$FF,$FF
	DEFB $FF,$15,$16,$17,$FF,$FF
	DEFB $FF,$18,$19,$1A,$FF,$FF
	DEFB $FF,$1B,$1C,$1D,$FF,$FF
	DEFB $FF,$FF,$1E,$1F,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
; Sprite Ninja/Guard jump-kick
LD4DA:	DEFB $FF,$FF,$20,$21,$FF,$FF
	DEFB $4D,$22,$23,$FF,$FF,$FF
	DEFB $4E,$24,$25,$26,$27,$2C
	DEFB $FF,$28,$29,$2A,$2B,$FF
	DEFB $FF,$FF,$2D,$2E,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
; Sprite Ninja/Guard punching
LD504:	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$00,$01,$FF,$FF
	DEFB $FF,$FF,$2F,$30,$31,$FF
	DEFB $FF,$FF,$32,$33,$34,$FF
	DEFB $FF,$FF,$35,$0C,$0D,$FF
	DEFB $FF,$FF,$0E,$0F,$10,$FF
	DEFB $FF,$FF,$11,$FF,$12,$FF
; Sprite Ninja on ladder
LD52E:	DEFB $FF,$FF,$40,$FF,$FF,$FF
	DEFB $FF,$FF,$41,$42,$FF,$FF
	DEFB $FF,$FF,$43,$44,$FF,$FF
	DEFB $FF,$FF,$45,$46,$FF,$FF
	DEFB $FF,$FF,$47,$48,$FF,$FF
	DEFB $FF,$FF,$49,$4A,$FF,$FF
	DEFB $FF,$FF,$4B,$4C,$FF,$FF
; Sprite Ninja sitting
LD558:	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$36,$FF,$FF
	DEFB $FF,$FF,$37,$38,$39,$FF
	DEFB $FF,$FF,$3A,$3B,$3C,$FF
	DEFB $FF,$FF,$3D,$3E,$3F,$FF
; Sprite Ninja falling
LD582:	DEFB $FF,$FF,$6E,$7C,$FF,$FF
	DEFB $FF,$FF,$7D,$7E,$FF,$FF
	DEFB $FF,$FF,$7F,$80,$FF,$FF
	DEFB $FF,$FF,$81,$82,$FF,$FF
	DEFB $FF,$FF,$76,$77,$FF,$FF
	DEFB $FF,$FF,$78,$79,$FF,$FF
	DEFB $FF,$FF,$7A,$7B,$FF,$FF
; Sprite Ninja jumping 3
LD5AC:	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$8D,$8E,$FF,$FF
	DEFB $FF,$8F,$90,$91,$92,$FF
	DEFB $FF,$93,$94,$95,$96,$FF
	DEFB $FF,$97,$98,$99,$9A,$FF
	DEFB $FF,$9B,$9C,$9D,$FF,$FF
	DEFB $FF,$9E,$FF,$FF,$FF,$FF
; Sprite Ninja jumping 4
LD5D6:	DEFB $FF,$FF,$84,$88,$FF,$FF
	DEFB $FF,$8C,$85,$89,$FF,$FF
	DEFB $FF,$83,$86,$8A,$FF,$FF
	DEFB $FF,$FF,$87,$8B,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$FF,$FF

; Front tiles, 124 tiles, 17 bytes each
LD600:	DEFB $00,$FF,$00,$D8,$00,$A8,$00,$D8,$00,$FF,$00,$8A,$00,$8A,$00,$8A,$30
	DEFB $00,$FF,$00,$00,$00,$00,$00,$00,$00,$FF,$00,$AA,$00,$AA,$00,$AA,$30
	DEFB $00,$FF,$00,$15,$00,$1B,$00,$15,$00,$FF,$00,$B1,$00,$B1,$00,$B1,$30
	DEFB $00,$8A,$00,$8A,$00,$8F,$00,$A8,$00,$A8,$00,$88,$00,$8F,$00,$8A,$30
	DEFB $00,$AA,$00,$AA,$00,$FF,$00,$00,$00,$00,$00,$00,$00,$FF,$00,$AA,$30
	DEFB $00,$B1,$00,$B1,$00,$F1,$00,$15,$00,$15,$00,$11,$00,$F1,$00,$B1,$30
	DEFB $00,$8A,$00,$8A,$00,$8A,$00,$8F,$00,$A8,$00,$A8,$00,$88,$00,$FF,$30
	DEFB $00,$AA,$00,$AA,$00,$AA,$00,$FF,$00,$00,$00,$00,$00,$00,$00,$FF,$30
LD688:	DEFB $00,$B1,$00,$B1,$00,$B1,$00,$F1,$00,$15,$00,$15,$00,$11,$00,$FF,$30
	DEFB $00,$FF,$00,$80,$00,$FF,$00,$95,$00,$95,$00,$95,$00,$95,$00,$FF,$30
	DEFB $00,$FF,$00,$01,$00,$FF,$00,$59,$00,$59,$00,$59,$00,$59,$00,$FF,$30
LD6BB:	DEFB $9B,$64,$13,$AC,$01,$FE,$00,$FF,$00,$FF,$00,$BF,$00,$FF,$00,$FD,$0D
	DEFB $00,$5F,$00,$FB,$00,$BF,$00,$DF,$00,$FF,$00,$7D,$00,$EF,$00,$FF,$25
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00
	DEFB $00,$FF,$00,$FF,$00,$FB,$00,$DB,$00,$DF,$00,$FF,$00,$F7,$00,$F6,$50
	DEFB $00,$DF,$00,$FF,$00,$FF,$00,$FB,$00,$FF,$00,$FF,$00,$EF,$00,$FF,$70
LD710:	DEFB $00,$F3,$00,$C9,$00,$89,$00,$B6,$00,$C8,$00,$C9,$00,$E7,$00,$FF,$68
	DEFB $00,$FE,$00,$F7,$00,$F7,$00,$DF,$00,$DF,$00,$FD,$00,$FD,$00,$FF,$70
	DEFB $00,$FF,$00,$00,$00,$FF,$00,$00,$00,$00,$00,$00,$00,$24,$00,$00,$78
	DEFB $00,$FF,$00,$AF,$00,$AF,$00,$AF,$00,$AD,$00,$AD,$00,$FF,$00,$FF,$60
	DEFB $F0,$07,$E0,$08,$E0,$0F,$C0,$1D,$C0,$1B,$80,$3A,$80,$31,$80,$27,$32
	DEFB $00,$FF,$00,$00,$00,$FF,$00,$BB,$00,$7D,$00,$00,$00,$7D,$00,$7D,$32
	DEFB $07,$E0,$03,$10,$03,$F0,$01,$B8,$01,$D8,$00,$5C,$00,$8C,$00,$E4,$32
	DEFB $80,$36,$80,$36,$80,$2E,$80,$2E,$80,$22,$80,$2C,$80,$36,$80,$36,$32
LD798:	DEFB $00,$FE,$00,$FE,$00,$FE,$00,$FE,$00,$FE,$00,$00,$00,$FE,$00,$FE,$32
	DEFB $00,$EC,$00,$EC,$00,$F4,$00,$F4,$00,$84,$00,$74,$00,$EC,$00,$EC,$32
	DEFB $80,$27,$80,$31,$80,$3A,$C0,$1A,$C0,$1D,$E0,$0F,$E0,$08,$F0,$07,$32
	DEFB $00,$7D,$00,$7D,$00,$00,$00,$7C,$00,$BB,$00,$FF,$00,$00,$00,$FF,$32
	DEFB $00,$E4,$00,$8C,$00,$1C,$01,$18,$01,$B8,$03,$F0,$03,$10,$07,$E0,$32
	DEFB $00,$FF,$00,$00,$00,$FF,$00,$55,$00,$55,$00,$55,$00,$55,$00,$FF,$30
	DEFB $B3,$4C,$B2,$4D,$22,$DD,$02,$FD,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$0D
	DEFB $FF,$00,$FF,$00,$FF,$00,$FF,$00,$F8,$00,$F0,$07,$F0,$07,$F0,$00,$FF
LD820:	DEFB $FF,$00,$FF,$00,$FF,$00,$E7,$00,$C3,$18,$03,$18,$03,$58,$01,$00,$FF
	DEFB $E0,$0F,$C0,$1F,$80,$3F,$80,$3F,$C0,$00,$FE,$00,$FE,$00,$FE,$00,$FF
	DEFB $00,$FE,$00,$FE,$00,$FA,$00,$FE,$01,$B0,$07,$B0,$07,$B0,$07,$B0,$FF
	DEFB $FE,$00,$FE,$00,$FE,$00,$FE,$00,$FE,$00,$FE,$00,$FE,$00,$FE,$00,$FF
	DEFB $07,$B0,$07,$B0,$07,$B0,$07,$B0,$07,$B0,$07,$B0,$07,$B0,$07,$B0,$FF
	DEFB $FE,$00,$FE,$00,$FE,$00,$E6,$00,$C2,$18,$C0,$00,$80,$3F,$00,$7F,$FF
	DEFB $07,$B0,$07,$B0,$07,$B0,$07,$B0,$07,$B0,$03,$B0,$01,$FC,$00,$FE,$FF
	DEFB $00,$FF,$00,$00,$00,$00,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$10
LD8A8:	DEFB $00,$99,$00,$9D,$00,$99,$00,$9B,$00,$DB,$00,$D9,$00,$99,$00,$B9,$28
	DEFB $00,$FF,$00,$66,$00,$00,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$99,$10
	DEFB $00,$FF,$00,$FF,$00,$81,$00,$81,$00,$FF,$00,$81,$00,$81,$00,$81,$30
	DEFB $00,$FF,$00,$81,$00,$81,$00,$81,$00,$81,$00,$81,$00,$81,$00,$81,$30
	DEFB $81,$3C,$C3,$08,$E1,$0C,$C0,$0A,$81,$34,$03,$78,$07,$F0,$0F,$60,$FF
	DEFB $81,$3C,$C1,$08,$81,$3C,$81,$2C,$81,$34,$81,$3C,$81,$24,$81,$3C,$FF
	DEFB $81,$3C,$C3,$10,$87,$30,$03,$50,$81,$2C,$C0,$1E,$E0,$0F,$F0,$06,$FF
	DEFB $FF,$00,$FF,$00,$FF,$00,$F8,$00,$F0,$07,$F0,$04,$F0,$07,$C0,$00,$FF
LD930:	DEFB $FF,$00,$FF,$00,$F8,$00,$10,$07,$00,$E5,$00,$25,$00,$E7,$00,$1B,$FF
	DEFB $FF,$00,$FF,$00,$FF,$00,$7F,$00,$78,$00,$70,$07,$30,$04,$10,$C4,$FF
	DEFB $FF,$00,$FF,$00,$FF,$00,$FF,$00,$C7,$00,$03,$38,$03,$E8,$01,$34,$FF
	DEFB $FF,$00,$FF,$00,$FC,$00,$F0,$03,$00,$0C,$00,$F9,$00,$9E,$00,$F1,$FF
	DEFB $80,$31,$00,$4A,$00,$46,$00,$36,$00,$8A,$00,$FF,$00,$43,$00,$7E,$FF
	DEFB $00,$A3,$00,$C2,$00,$DC,$00,$61,$00,$42,$00,$7F,$00,$E1,$00,$BF,$FF
	DEFB $00,$23,$00,$FE,$00,$A2,$00,$7F,$00,$14,$00,$08,$00,$D9,$00,$26,$FF
	DEFB $01,$5C,$00,$BE,$00,$E2,$00,$7F,$00,$42,$00,$FC,$00,$87,$00,$FC,$FF
LD9B8	DEFB $FF,$00,$FF,$00,$FF,$00,$7F,$00,$01,$80,$00,$7E,$00,$22,$00,$FE,$FF
	DEFB $FC,$01,$F8,$02,$F0,$05,$E0,$0A,$40,$14,$02,$A8,$06,$D0,$0E,$E0,$FF
	DEFB $1E,$C0,$1E,$C0,$1E,$C0,$1E,$C0,$1E,$C0,$1E,$C0,$1E,$C0,$1C,$C0,$FF
	DEFB $18,$C3,$10,$C6,$01,$CC,$03,$D8,$07,$F0,$0F,$E0,$1F,$C0,$3F,$80,$FF
	DEFB $3F,$80,$1F,$40,$0F,$A0,$07,$50,$02,$28,$40,$15,$60,$0B,$70,$07,$FF
	DEFB $78,$03,$78,$03,$78,$03,$78,$03,$78,$03,$78,$03,$78,$03,$38,$03,$FF
	DEFB $18,$C3,$08,$63,$80,$33,$C0,$1B,$E0,$0F,$F0,$07,$F8,$03,$FC,$01,$FF
	DEFB $00,$FF,$00,$80,$00,$80,$00,$C0,$C0,$20,$C0,$20,$00,$FF,$00,$80,$FF
LDA40	DEFB $00,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FF,$00,$00,$FF
	DEFB $00,$FF,$00,$01,$00,$01,$00,$03,$03,$04,$03,$04,$00,$FF,$00,$01,$FF
	DEFB $00,$80,$00,$C0,$C0,$20,$C0,$20,$00,$FF,$00,$80,$00,$80,$00,$C0,$FF
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$FF,$00,$00,$00,$00,$00,$00,$FF
	DEFB $00,$01,$00,$03,$03,$04,$03,$04,$00,$FF,$00,$01,$00,$01,$00,$03,$FF
	DEFB $C0,$20,$C0,$20,$00,$FF,$00,$80,$00,$80,$00,$C0,$C0,$20,$C0,$20,$FF
	DEFB $00,$00,$00,$00,$00,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FF
	DEFB $03,$04,$03,$04,$00,$FF,$00,$01,$00,$01,$00,$03,$03,$04,$03,$04,$FF
LDAC8	DEFB $00,$FF,$00,$80,$00,$80,$00,$C0,$C0,$20,$C0,$20,$E0,$10,$E0,$10,$FF
	DEFB $00,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FF
	DEFB $00,$FF,$00,$01,$00,$01,$00,$03,$03,$04,$03,$04,$07,$08,$07,$08,$FF
	DEFB $FF,$00,$FF,$00,$FF,$00,$FF,$00,$00,$FF,$00,$80,$00,$80,$00,$C0,$FF
	DEFB $FF,$00,$FF,$00,$FF,$00,$FF,$00,$00,$FF,$00,$00,$00,$00,$00,$00,$FF
	DEFB $FF,$00,$FF,$00,$FF,$00,$FF,$00,$00,$FF,$00,$01,$00,$01,$00,$03,$FF
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$29
	DEFB $00,$83,$7C,$01,$7C,$01,$7C,$01,$7C,$01,$7C,$01,$00,$83,$00,$FF,$FF
LDB50	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$01
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$05
	DEFB $00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$08
	DEFB $00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$28
	DEFB $00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$08
	DEFB $00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$28
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$7F,$00,$7F,$00,$7F,$00,$7F,$29
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$FE,$00,$FE,$00,$FE,$00,$FE,$29
LDBD8	DEFB $1F,$C0,$1F,$C0,$1F,$C0,$1F,$C0,$1F,$C0,$1F,$C0,$1F,$C0,$1F,$C0,$FF
	DEFB $F8,$03,$F8,$03,$F8,$03,$F8,$03,$F8,$03,$F8,$03,$F8,$03,$F8,$03,$FF
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$FF
	DEFB $00,$F0,$0F,$C0,$3F,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	DEFB $00,$3F,$C0,$0F,$F0,$03,$FC,$01,$FE,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$3F,$C0,$03,$FF
	DEFB $00,$FB,$00,$FB,$00,$F7,$00,$F7,$00,$EF,$00,$EF,$00,$FF,$00,$E0,$FF
	DEFB $00,$FE,$00,$FE,$00,$FD,$00,$FD,$00,$FD,$00,$FD,$00,$FD,$00,$FB,$FF
LDC60	DEFB $00,$3E,$00,$3E,$00,$3E,$00,$7E,$00,$7E,$00,$FE,$00,$FE,$00,$FE,$FF
	DEFB $3F,$00,$0F,$C0,$07,$F0,$03,$F8,$01,$FC,$00,$FE,$00,$FE,$00,$FF,$FF
	DEFB $C0,$1F,$C0,$1F,$C0,$1F,$C0,$1F,$C0,$1F,$C0,$1F,$C0,$1F,$C0,$1F,$FF
	DEFB $00,$01,$0E,$C0,$07,$F0,$03,$F8,$01,$FC,$00,$7E,$80,$3E,$80,$3F,$FF
	DEFB $FF,$00,$FC,$00,$F0,$03,$C0,$0F,$80,$3F,$00,$7F,$00,$FF,$00,$FF,$FF
	DEFB $80,$0F,$00,$7F,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$FF
	DEFB $00,$00,$00,$04,$00,$42,$00,$00,$00,$00,$00,$24,$00,$12,$00,$02,$0D
	DEFB $00,$08,$00,$00,$00,$01,$00,$11,$00,$80,$00,$02,$00,$01,$00,$65,$0C
LDCE8	DEFB $00,$F1,$00,$E4,$00,$E8,$00,$E8,$00,$E0,$00,$F0,$00,$30,$00,$DC,$30
	DEFB $00,$70,$00,$DF,$00,$BF,$00,$BF,$00,$FF,$00,$7F,$00,$7F,$00,$1F,$0E
	DEFB $00,$9F,$00,$FF,$00,$DF,$00,$BF,$00,$BF,$00,$DF,$00,$FF,$00,$FD,$06
	DEFB $00,$6C,$00,$FE,$00,$BF,$00,$BF,$00,$BF,$00,$FE,$00,$FE,$00,$F8,$0E
	DEFB $00,$FF,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$0F
	DEFB $00,$FF,$00,$00,$00,$00,$00,$00,$00,$0C,$00,$0C,$00,$0C,$00,$0C,$0F
	DEFB $00,$FF,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$0F
	DEFB $00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$0F
LDD70	DEFB $00,$0C,$00,$0C,$00,$0C,$00,$0C,$00,$0C,$00,$3C,$00,$3C,$00,$3C,$0F
	DEFB $00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$0F
	DEFB $00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$FF,$0F
	DEFB $00,$3C,$00,$3C,$00,$3C,$00,$3C,$00,$3C,$00,$00,$00,$00,$00,$FF,$0F
	DEFB $00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$FF,$0F
	DEFB $00,$FF,$00,$80,$00,$80,$00,$80,$00,$83,$00,$83,$00,$83,$00,$80,$0F
	DEFB $00,$FF,$00,$00,$00,$00,$00,$00,$00,$FF,$00,$FF,$00,$E1,$00,$01,$0F
	DEFB $00,$FF,$00,$01,$00,$01,$00,$01,$00,$C1,$00,$C1,$00,$C1,$00,$C1,$0F
LDDF8:	DEFB $00,$80,$00,$80,$00,$80,$00,$83,$00,$83,$00,$83,$00,$83,$00,$83,$0F
	DEFB $00,$01,$00,$01,$00,$01,$00,$FF,$00,$FF,$00,$80,$00,$80,$00,$80,$0F
	DEFB $00,$C1,$00,$C1,$00,$C1,$00,$C1,$00,$C1,$00,$01,$00,$01,$00,$01,$0F
	DEFB $00,$83,$00,$83,$00,$83,$00,$83,$00,$83,$00,$80,$00,$80,$00,$FF,$0F
	DEFB $00,$80,$00,$80,$00,$83,$00,$FF,$00,$FF,$00,$00,$00,$00,$00,$FF,$0F
	DEFB $00,$01,$00,$01,$00,$C1,$00,$C1,$00,$C1,$00,$01,$00,$01,$00,$FF,$0F
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; Find record for the current room in DE84 table
LDE68:	LD B,$14	; 20 records
	LD HL,LDE84
LDE6D:	LD A,(L7184)	; get Current Room address low byte
	CP (HL)
	INC HL
	JR NZ,LDE7E
	LD A,(L7184+1)	; get Current Room address high byte
	CP (HL)
	INC HL
	JR NZ,LDE7F
	LD A,$01
	RET
LDE7E:	INC HL
LDE7F:	INC HL
	DJNZ LDE6D
	XOR A
	RET

; ?? Dog rooms/flags ?? 20 records, 3 bytes each
LDE84:	DEFW L79C6
	DEFB $00
	DEFW L7C2E
	DEFB $00
	DEFW L7F9C
	DEFB $01
	DEFW L81E5
	DEFB $00
	DEFW L8162
	DEFB $01
	DEFW L7EF2
	DEFB $01
	DEFW L7E05
	DEFB $01
	DEFW L80A7
	DEFB $00
	DEFW L83ED
	DEFB $00
	DEFW L80F6
	DEFB $00
	DEFW L924E
	DEFB $00
	DEFW L91BA
	DEFB $01
	DEFW L90DB
	DEFB $01
	DEFW L909F
	DEFB $00
	DEFW L8802
	DEFB $00
	DEFW L8608
	DEFB $00
	DEFW L844E
	DEFB $00
	DEFW L9739
	DEFB $01
	DEFW L9A5A
	DEFB $00
	DEFW L9B9D
	DEFB $01

LDEC0:	DEFB $00

; Clear strings on the screen
; Clears 10 strings, 18 characters each; used to clear table of scores, menu etc.
LDEC1:	LD B,$0A
	LD DE,$402C
LDEC6:	PUSH DE
	PUSH BC
	LD C,$12
	LD HL,LDEE6	; String 18 spaces
	CALL LAED1	; Print string
	POP BC
	POP DE
	RR D
	RR D
	RR D
	LD HL,$0020
	ADD HL,DE
	EX DE,HL
	RL D
	RL D
	RL D
	DJNZ LDEC6
	RET

; String 18 spaces
LDEE6:	DEFM "                  "

; Menu messages
LDEF8:	DEFM "J  KEMPSTON"
LDF03:	DEFM "K  KEYBOARD"
LDF0E:	DEFM "P  PROTEK"
LDF17:	DEFM "R  REDEFINE KEYS"
LDF27:	DEFM "S  START MISSION"

; Routine at DF37
LDF37:	LD A,$01	; blue
	OUT ($FE),A	; set border color, sound off
	LD ($5C09),A	; set REPDEL = 1
	LD ($5C0A),A	; set REPPER = 1
	LD A,$08
	LD ($5C48),A	; set BORDCR = $08
	CALL LE04D	; Clear key buffer playing melody
	LD DE,$00D4
LDF4C:	PUSH DE
	CALL LE440	; Play next note in melody
	CALL LDFD4	; Clear LASTK and do RST $38 once
	POP DE
	LD A,($5C08)	; get LASTK
	CP $00
	JR NZ,LDF60	; key pressed => Main menu
	DEC DE
	LD A,D
	OR E
	JR NZ,LDF4C

; Main menu
LDF60:	CALL LDEC1	; Clear strings on the screen
	LD HL,LDEF8	; Menu messages address
	LD DE,$402D
	LD C,$0B
	CALL LAED1	; Print string "J KEMPSTON"
	LD C,$0B
	LD DE,$406D
	CALL LAED1	; Print string "K KEYBOARD"
	LD C,$09
	LD DE,$40AD
	CALL LAED1	; Print string "P PROTEK"
	LD C,$10
	LD DE,$40ED
	CALL LAED1	; Print string "R REDEFINE KEYS"
	LD C,$10
	LD DE,$484D
	CALL LAED1	; Print string "S START MISSION"
	CALL LE04D	; Clear key buffer playing melody
	CALL LDFDB	; Highlight Menu item
	LD DE,$00D4
LDF97:	PUSH DE
	CALL LE440	; Play next note in melody
	CALL LDFD4	; Clear LASTK and do RST $38 once
	POP DE
	LD A,($5C08)	; get LASTK
	CP $61
	JR C,LDFA8
	SUB $20
LDFA8:	CP $53		; 'S' ?
	JP Z,LE2A7	; => Start Mission
	CP $4A		; 'J' ?
	JR Z,LDFF1	; => Joystick selected
	CP $4B		; 'K' ?
	JR Z,LE004	; => Keyboard selected
	CP $50		; 'P' ?
	JR Z,LE015	; => Protek selected
	CP $52		; 'R' ?
	JP Z,LE097	; => Redefine Keys
	LD A,(L7222)	; get Input method
	CP $01		; Joystick?
	JR NZ,LDFCC
	IN A,($1F)	; read joystick port
	BIT 4,A
	JP NZ,LE2A7	; => Start Mission
; Entry point
LDFCC:	DEC DE
	LD A,D
	OR E
	JR NZ,LDF97
LDFD1:	JP LBC3B

; Clear LASTK and do RST $38 once
LDFD4:	XOR A
	LD ($5C08),A	; clear LASTK
	RST $38
	NOP
	RET

; Highlight Menu item
LDFDB:	LD HL,$58AC
	LD B,$0D
LDFE0:	LD (HL),$B1
	INC HL
	DJNZ LDFE0
	RET

; Unhighlight Menu item
LDFE6:	LD HL,(LDFDB+1)
	LD B,$0D
LDFEB:	LD (HL),$0E
	INC HL
	DJNZ LDFEB
	RET

; Joystick selected in Main menu
LDFF1:	CALL LDFE6	; Unhighlight Menu item
	LD HL,$582C
	LD (LDFDB+1),HL
	CALL LDFDB	; Highlight Menu item
	LD A,$01
	LD (L7222),A
	JR LDFCC

; Keyboard selected in Main menu
LE004:	CALL LDFE6	; Unhighlight Menu item
	LD HL,$586C
	LD (LDFDB+1),HL
	CALL LDFDB	; Highlight Menu item
	LD HL,LE043
	JR LE024

; Protek selected in Main menu
LE015:	CALL LDFE6	; Unhighlight Menu item
	LD HL,$58AC
	LD (LDFDB+1),HL
	CALL LDFDB	; Highlight Menu item
	LD HL,LE039
; Entry point
LE024:	LD DE,L7222
	XOR A
	LD (DE),A
	INC DE
	LD B,$05
LE02C:	LD A,(HL)
	LD (DE),A
	INC DE
	INC HL
	LD A,(HL)
	LD (DE),A
	INC DE
	INC HL
	INC DE
	DJNZ LE02C
	JR LDFCC

; Ports/bits for Protek and Keyboard
LE039:	DEFB $EF,$01,$EF,$08,$EF,$10,$F7,$10,$EF,$04	; Protek ports/bits
LE043:	DEFB $7F,$01,$FD,$01,$FE,$02,$7F,$08,$7F,$04	; Keyboard input ports/bits

; Clear key buffer playing melody
LE04D:	CALL LE440	; Play next note in melody
	CALL LDFD4	; Clear LASTK and do RST $38 once
	LD A,($5C08)	; get LASTK
	CP $00
	RET Z
	JR LE04D

; Redefine keys messages
LE05B:	DEFM "REDEFINE KEYS"
LE068:	DEFM "PRESS THE KEYS"
LE076:	DEFM "OF YOUR CHOICE"
LE084:	DEFM "FIRE"
LE088:	DEFM "UP"
LE08A:	DEFM "DOWN"
LE08E:	DEFM "LEFT"
LE092:	DEFM "RIGHT"

; Redefine Keys
LE097:	CALL LDFE6	; Unhighlight Menu item
	CALL LDEC1	; Clear strings on the screen
	LD HL,LE05B	; Redefine keys messages
	LD DE,$402D
	LD C,$0D
	CALL LAED1	; Print string "REDEFINE KEYS"
	LD DE,$406D
	LD C,$0E
	CALL LAED1	; Print string "PRESS THE KEYS"
	LD DE,$408D
	LD C,$0E
	CALL LAED1	; Print string "OF YOUR CHOICE"
	LD DE,$40CF
	LD C,$04
	CALL LAED1	; Print string "FIRE"
	LD DE,$40EF
	LD C,$02
	CALL LAED1	; Print string "UP"
	LD DE,$480F
	LD C,$04
	CALL LAED1	; Print string "DOWN"
	LD DE,$482F
	LD C,$04
	CALL LAED1	; Print string "LEFT"
	LD DE,$484F
	LD C,$05
	CALL LAED1	; Print string "RIGHT"
	CALL LE04D	; Clear key buffer playing melody
	EXX
	LD DE,$58CD
	LD BC,L7223
	EXX
	LD DE,$40D5
	LD B,$05
	LD IX,LE043
LE0F4:	PUSH BC
	LD A,$B1
	LD B,$0A
LE0F9:	EXX
	LD (DE),A
	INC DE
	EXX
	DJNZ LE0F9
	PUSH DE
LE100:	PUSH IX
	CALL LDFD4	; Clear LASTK and do RST $38 once
	CALL LE440	; Play next note in melody
	POP IX
	LD A,($5C08)	; get LASTK
	CP $5B		; '['
	JR C,LE113
	SUB $20
LE113:	LD B,$25
	LD (LE17C),A
	LD HL,LE17D
LE11B:	CP (HL)
	JR Z,LE125
	INC HL
	INC HL
	INC HL
	DJNZ LE11B
	JR LE100
LE125:	LD B,$02
LE127:	INC HL
	LD A,(LDFDB+1)
	CP $6C
	LD A,(HL)
	LD (IX+$00),A
	JR NZ,LE137
	EXX
	LD (BC),A
	INC BC
	EXX
LE137:	INC IX
	DJNZ LE127
	EXX
	INC BC
	EXX
	POP DE
	PUSH DE
	LD C,$01
	LD HL,LE17C
	CALL LAED1	; Print string
	PUSH IX
	CALL LE04D	; Clear key buffer playing melody
	POP IX
	POP DE
	LD A,$0E
	LD B,$0A
LE154:	EXX
	DEC DE
	LD (DE),A
	EXX
	DJNZ LE154
	EXX
	PUSH HL
	LD HL,$0020	; 32
	ADD HL,DE
	EX DE,HL
	POP HL
	EXX
	LD HL,$0020	; 32
	RR D
	RR D
	RR D
	ADD HL,DE
	EX DE,HL
	RL D
	RL D
	RL D
	POP BC
	DEC B
	JP NZ,LE0F4
	JP LDF60	; => Main menu

LE17C:	DEFM "M"

; Data block at E17D
LE17D:	DEFB $30,$EF,$01
	DEFB $31,$F7,$01
	DEFB $32,$F7,$02
	DEFB $33,$F7,$04
	DEFB $34,$F7,$08
	DEFB $35,$F7,$10
	DEFB $36,$EF,$10
	DEFB $37,$EF,$08
	DEFB $38,$EF,$04
	DEFB $39,$EF,$02
	DEFB $41,$FD,$01
	DEFB $42,$7F,$10
	DEFB $43,$FE,$08
	DEFB $44,$FD,$04
	DEFB $45,$FB,$04
	DEFB $46,$FD,$08
	DEFB $47,$FD,$10
	DEFB $48,$BF,$10
	DEFB $49,$DF,$04
	DEFB $4A,$BF,$08
	DEFB $4B,$BF,$04
	DEFB $4C,$BF,$02
	DEFB $4D,$7F,$04
	DEFB $4E,$7F,$08
	DEFB $4F,$DF,$02
	DEFB $50,$DF,$01
	DEFB $51,$FB,$01
	DEFB $52,$FB,$08
	DEFB $53,$FD,$02
	DEFB $54,$FB,$10
	DEFB $55,$DF,$08
	DEFB $56,$FE,$10
	DEFB $57,$FB,$02
	DEFB $58,$FE,$04
	DEFB $59,$DF,$10
	DEFB $5A,$FE,$02
	DEFB $20,$7F,$01

LE1EC:	DEFM "1"	; Current Level digit
LE1ED:	DEFM "ENTER SKILL LEVEL"
LE1FE:	DEFM "1 TO 9"
LE204:	DEFM "YOUR MISSION"
LE210:	DEFM "WILL BE"

; Level descriptions and data addresses
LE217:	DEFM "EXTREMELY EASY"
	DEFW LE38C
	DEFM "  VERY  EASY  "
	DEFW LE3A0
	DEFM "     EASY     "
	DEFW LE3B4
	DEFM "SLIGHTLY  EASY"
	DEFW LE3C8
	DEFM "   MODERATE   "
	DEFW LE3DC
	DEFM "SLIGHTLY  HARD"
	DEFW LE3F0
	DEFM "     HARD     "
	DEFW LE404
	DEFM "  VERY HARD   "
	DEFW LE418
	DEFM "EXTREMELY HARD"
	DEFW LE42C

; Start Mission
LE2A7:	CALL LDFE6	; Unhighlight Menu item
	CALL LDEC1	; Clear strings on the screen
	LD HL,LE1ED	; "ENTER SKILL LEVEL"
	LD DE,$406D
	LD C,$11
	CALL LAED1	; Print string "ENTER SKILL LEVEL"
	LD DE,$4092
	LD C,$06
	CALL LAED1	; Print string "1 TO 9"
	CALL LE04D	; Clear key buffer playing melody
	LD HL,$58F3
	LD A,$B1
	LD (HL),A
	INC HL
	LD (HL),A
	INC HL
	LD (HL),A
LE2CD:	CALL LE440	; Play next note in melody
	CALL LDFD4	; Clear LASTK and do RST $38 once
	LD A,($5C08)	; get LASTK
	CP $31
	JR C,LE2CD
	CP $3A
	JR NC,LE2CD
	LD HL,LE1EC	; Skill level address
	LD (HL),A
	LD DE,$40F4
	LD C,$01
	CALL LAED1	; Print string
	CALL LE04D	; Clear key buffer playing melody
	LD HL,$58F3
	LD A,$0E
	LD (HL),A
	INC HL
	LD (HL),A
	INC HL
	LD (HL),A
	CALL LDEC1	; Clear strings on the screen
	LD HL,LE204	; "YOUR MISSION"
	LD DE,$406F
	LD C,$0C
	CALL LAED1	; Print string "YOUR MISSION"
	LD DE,$4091
	LD C,$07
	CALL LAED1	; Print string "WILL BE"
	LD A,(LE1EC)	; get Skill level
	SUB $31
	LD L,A
	LD H,$00
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL	; * 16
	LD DE,LE217	; Levels data base address
	ADD HL,DE
	LD DE,$40EE
	LD C,$0E
	CALL LAED1	; Print string - level description
	LD A,(HL)
	INC HL
	LD H,(HL)
	LD L,A
	LD A,(HL)
	LD (LA3BE+1),A	; set Guard counter value
	INC HL
	LD A,(HL)
	LD (L9C56+1),A	; set Dog counter value
	INC HL
	LD A,(HL)
	LD (LB4C3+1),A	; set Turret counter value
	INC HL
	LD E,(HL)
	INC HL
	LD D,(HL)
	LD (LAD57),DE	; set Indicator Time value
	INC HL
	LD E,(HL)
	INC HL
	LD D,(HL)
LE343:	LD (LB7CA+1),DE	; set Time value for BOMB
	INC HL
	LD A,(HL)
	LD (L97CF+1),A	; set flag for wall in room 97A6
	INC HL
	LD A,(HL)
	LD (L9755+1),A	; set count for wall in room 9739
	INC HL
	LD A,(HL)
	LD (L7F7A+1),A	; set count for wall in room 7F48
	INC HL
	LD A,(HL)
	LD (L8DBB+1),A	; set count for wall in room 8D5C
	INC HL
	LD A,(HL)
	LD (L8F31+1),A	; set count for wall in room 8F20
	INC HL
	LD BC,$0004
	LD DE,LE388
	LDIR
	LD BC,$0004
	LD DE,LD357	; address for BOMB in Table of objects D34D
	LDIR		; Copy last 4 bytes: BOMB placement
	LD DE,$0019
LE374:	PUSH DE
	CALL LDFD4	; Clear LASTK and do RST $38 once
	CALL LE440	; Play next note in melody
	POP DE
	LD A,($5C08)	; get LASTK
	CP $00
	RET NZ
	DEC DE
	LD A,D
	OR E
	JR NZ,LE374
	RET
;TODO

LE388:	DEFM " 10"
LE38B:	DEFB $0A

; Levels data
; +$00: Guard counter value
; +$01: Dog counter value
; +$02: Turret counter value
; +$03/$04: two digits for TIME value
; +$05/$06: two digits for BOMB timer
; +$07: flag for wall in room 97A6
; +$08: count for wall in room 9739: $01 = no wall, $07 = put wall
; +$09: count for wall in room 7F48
; +$0A: count for wall in room 8D5C
; +$0B: count for wall in room 8F20: $01 = no wall, $09 = put wall
; +$10/$11: room for BOMB placement
; +$12/$13: address in Tile screen 0 for BOMB placement
; Level 1 "EXTREMELY EASY"
LE38C:	DEFB $14,$19,$32
	DEFM "9999"
	DEFB $00,$01,$01,$01,$01
	DEFM " 10"
	DEFB $0A
	DEFW L9E22
	DEFW $672E
; Level 2 "VERY EASY"
LE3A0:	DEFB $12,$0F,$2D
	DEFM "9995"
	DEFB $00,$01,$01,$01,$01
	DEFM " 20"
	DEFB $14
	DEFW L9E22
	DEFW $672E
; Level 3 "EASY"
LE3B4	DEFB $10,$0C,$28
	DEFM "9590"
	DEFB $00,$07,$01,$01,$01
	DEFM " 30"
	DEFB $1E
	DEFW L924E
	DEFW $6788
; Level 4 "SLIGHTLY EASY"
LE3C8	DEFB $0E,$0A,$23
	DEFM "9080"
	DEFB $FF,$01,$01,$01,$09
	DEFM " 50"
	DEFB $32
	DEFW L8608
	DEFW $6787
; Level 5 "MODERATE"
LE3DC	DEFB $0C,$09,$1E
	DEFM "9070"
	DEFB $FF,$01,$01,$07,$01
	DEFM " 70"
	DEFB $46
	DEFW L8689
	DEFW $66D2
; Level 6 "SLIGHTLY HARD"
LE3F0	DEFB $0A,$07,$19
	DEFM "8560"
	DEFB $FF,$07,$01,$07,$01
	DEFM "100"
	DEFB $64
	DEFW L8BAB
	DEFW $6780
; Level 7 "HARD"
LE404	DEFB $08,$06,$14
	DEFM "8550"
	DEFB $FF,$07,$08,$07,$01
	DEFM "130"
	DEFB $82
	DEFW L8D5C
	DEFW $6757
; Level 8 "VERY HARD"
LE418	DEFB $05,$05,$0F
	DEFM "8050"
	DEFB $FF,$07,$08,$07,$09
	DEFM "170"
	DEFB $AA
	DEFW L8279
	DEFW $6763
; Level 9 "EXTREMELY HARD"
LE42C:	DEFB $02,$03,$0A
	DEFM "7040"
	DEFB $FF,$07,$08,$07,$09
	DEFM "250"
	DEFB $FA
	DEFW L8608
	DEFW $6787

; Play next note in melody
LE440:	LD IX,$E51C
	LD A,(IX+$01)
	CP $FF
	JR Z,LE487
	CP $FE
	JR Z,LE477
	CP $FD
	JR Z,LE46F
	LD L,(IX+$00)
	LD H,A
	LD E,(IX+$02)
	LD D,(IX+$03)
	PUSH IX
	CALL $03B5	; BEEPER
	NOP
	POP IX
	LD DE,$0004
LE468:	ADD IX,DE
	LD (LE440+2),IX
	RET
LE46F:	LD DE,LE4AE
	LD HL,LE496
	JR LE47E
LE477:	LD HL,LE49A
	LD E,(HL)
	INC HL
	LD D,(HL)
	INC HL
LE47E:	LD (LE477+1),HL
	LD (LE440+2),DE
	JR LE440
LE487:	LD BC,$4E20
LE48A:	DEC BC
	LD A,B
	OR C
	JR NZ,LE48A
	LD DE,$0002
	JR LE468

; Table for melodies
LE494:	DEFW LE4AE
LE496:	DEFW LE4AE
	DEFW LE508
LE49A:	DEFW LE53A
	DEFW LE508
	DEFW LE56C
	DEFW LE4AE
	DEFW LE4AE
	DEFW LE508
	DEFW LE53A
	DEFW LE508
	DEFW LE56C
	DEFW LE5CA

; Melodies
LE4AE:	DEFB $9A,$08,$19,$00	; Melody
	DEFB $9A,$08,$19,$00
	DEFB $9A,$08,$31,$00
	DEFB $8C,$03,$75,$00
	DEFB $9A,$08,$19,$00
	DEFB $8C,$03,$75,$00
	DEFB $9A,$08,$19,$00
	DEFB $8C,$03,$75,$00
	DEFB $3E,$04,$62,$00
	DEFB $C6,$04,$57,$00
	DEFB $9A,$08,$19,$00
	DEFB $9A,$08,$19,$00
	DEFB $9A,$08,$31,$00
	DEFB $8C,$03,$75,$00
	DEFB $9A,$08,$19,$00
	DEFB $8C,$03,$75,$00
	DEFB $9A,$08,$19,$00
	DEFB $8C,$03,$75,$00
	DEFB $3E,$04,$31,$00
	DEFB $C6,$04,$2C,$00
	DEFB $B3,$05,$25,$00
	DEFB $6A,$06,$21,$00
	DEFB $00,$FE
LE508:	DEFB $9A,$08,$19,$00	; Melody
	DEFB $9A,$08,$19,$00
	DEFB $9A,$08,$31,$00
	DEFB $CA,$02,$93,$00
	DEFB $9A,$08,$19,$00
	DEFB $CA,$02,$93,$00
	DEFB $9A,$08,$19,$00
	DEFB $CA,$02,$93,$00
	DEFB $9A,$08,$19,$00
	DEFB $CA,$02,$93,$00
	DEFB $26,$03,$83,$00
	DEFB $8C,$03,$75,$00
	DEFB $00,$FE
LE53A:	DEFB $9A,$08,$19,$00	; Melody
	DEFB $9A,$08,$19,$00
	DEFB $9A,$08,$31,$00
	DEFB $CA,$02,$93,$00
	DEFB $9A,$08,$19,$00
	DEFB $CA,$02,$93,$00
	DEFB $9A,$08,$19,$00
	DEFB $CA,$02,$93,$00
	DEFB $26,$03,$41,$00
	DEFB $8C,$03,$3A,$00
	DEFB $3E,$04,$31,$00
	DEFB $C6,$04,$2C,$00
	DEFB $00,$FE
LE56C:	DEFB $9A,$08,$19,$00	; Melody
	DEFB $9A,$08,$19,$00
	DEFB $9A,$08,$31,$00
	DEFB $CA,$02,$93,$00
	DEFB $9A,$08,$19,$00
	DEFB $CA,$02,$93,$00
	DEFB $9A,$08,$19,$00
	DEFB $CA,$02,$93,$00
	DEFB $54,$02,$57,$00
	DEFB $79,$02,$52,$00
	DEFB $CA,$02,$49,$00
	DEFB $26,$03,$41,$00
	DEFB $54,$02,$57,$00
	DEFB $C4,$03,$37,$00
	DEFB $3E,$04,$31,$00
	DEFB $C4,$03,$37,$00
	DEFB $57,$03,$3E,$00
	DEFB $C4,$03,$37,$00
	DEFB $3E,$04,$31,$00
	DEFB $C6,$04,$2C,$00
	DEFB $B3,$05,$25,$00
	DEFB $6A,$06,$21,$00
	DEFB $A6,$07,$1C,$00
	DEFB $00,$FE
LE5CA:	DEFB $9A,$08,$31,$00	; Melody
	DEFB $00,$FF,$00,$FF
	DEFB $00,$FF,$00,$FF
	DEFB $00,$FF,$00,$FF
	DEFB $00,$FF
LE5DC:	DEFB $00,$FD	; Melody end/restart

; Data block at E5DE
LE5DE:	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $FF,$00,$FF,$00,$FF,$00,$FF,$00
	DEFB $FF,$00,$FF,$00,$FF,$00,$FF,$01
	DEFB $FC,$01,$FC,$01,$FC,$01,$FC,$01
	DEFB $FC,$01,$00,$03,$00,$FF,$00,$FF
	DEFB $20,$FC,$01,$FC,$01,$FC,$01,$FC
	DEFB $01,$FC,$01,$FC,$01,$FC,$01,$FC
	DEFB $01,$20,$00,$FF,$00,$FF,$00,$03
	DEFB $FC,$01,$FC,$01,$FC,$01,$FC,$01
	DEFB $FC,$01,$20,$FF,$00,$FF,$00,$FF
	DEFB $00,$FF,$00,$FF,$00,$00,$00,$00
	DEFB $FF,$00,$FF,$20,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$FF,$00
	DEFB $FF,$00,$00,$FF,$00,$FF,$00,$FF
	DEFB $00,$FF,$00,$FF,$00,$20,$3F,$80
	DEFB $3F,$80,$3F,$80,$3F,$80,$3F,$80
	DEFB $00,$C0,$00,$FF,$00,$FF,$20,$3F
	DEFB $80,$3F,$80,$3F,$80,$3F,$80,$3F
	DEFB $80,$3F,$80,$3F,$80,$3F,$80,$20
	DEFB $00,$FF,$00,$FF,$00,$C0,$3F,$80
	DEFB $3F,$80,$3F,$80,$3F,$80,$3F,$80
	DEFB $20,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00

; Ninja/Guard tiles, tiles with mask, 159 tiles, 16 bytes each
; Used to draw Ninja tiles on Tile Screen 2 (see B1A3), and Guard tiles on Tile Screen 4 (see B230).
LE700:	DEFB $00,$FF,$00,$FE,$01,$FC,$03,$F8,$03,$F8,$07,$F0,$07,$F0,$07,$F0
	DEFB $00,$FF,$00,$3F,$C0,$1F,$E0,$0F,$F0,$07,$F0,$07,$50,$07,$20,$07
	DEFB $00,$FF,$00,$FE,$01,$FC,$01,$FC,$00,$FC,$01,$FC,$03,$F8,$07,$F0
	DEFB $77,$00,$E7,$00,$DF,$00,$3F,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00
	DEFB $F0,$07,$F0,$07,$F0,$03,$EC,$01,$9E,$00,$FE,$00,$FF,$00,$FF,$00
	DEFB $07,$F0,$0F,$E0,$0F,$E0,$0E,$E0,$0E,$E0,$0E,$E0,$0E,$E0,$07,$F0
	DEFB $DF,$00,$9F,$00,$2F,$00,$6F,$00,$6F,$00,$77,$00,$77,$00,$77,$00
	DEFB $EF,$00,$FF,$00,$FD,$00,$FD,$00,$FE,$00,$FE,$00,$FE,$00,$FE,$00
	DEFB $80,$3F,$C0,$04,$FB,$00,$FF,$00,$7F,$00,$0F,$80,$00,$F0,$00,$FF
	DEFB $00,$FF,$00,$FF,$00,$3F,$C0,$1F,$C0,$1F,$C0,$1F,$00,$3F,$00,$FF
	DEFB $07,$F0,$03,$F8,$03,$F8,$01,$FC,$00,$FE,$00,$FF,$00,$FF,$00,$FF
	DEFB $B4,$00,$C4,$00,$C7,$10,$07,$30,$0F,$E0,$0F,$E0,$1F,$C0,$1F,$C0
	DEFB $02,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$CF,$00
	DEFB $00,$FF,$00,$7F,$80,$3F,$80,$3F,$C0,$1F,$C0,$1F,$E0,$0F,$E0,$0F
	DEFB $1F,$C0,$3F,$80,$3E,$80,$3E,$80,$7E,$00,$7C,$01,$7C,$01,$7C,$01
	DEFB $07,$30,$03,$78,$03,$F8,$01,$FC,$01,$FC,$01,$FC,$00,$FE,$00,$FE
	DEFB $F0,$07,$F0,$07,$F0,$07,$F0,$07,$F0,$07,$F0,$07,$F0,$07,$E0,$0F
	DEFB $7C,$01,$44,$01,$3C,$81,$3C,$81,$38,$83,$38,$83,$7C,$01,$7C,$01
	DEFB $A0,$0F,$E0,$0F,$E0,$0F,$E0,$0F,$E0,$0F,$F0,$03,$FC,$01,$FE,$00
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$87,$78,$03,$FC,$01
	DEFB $00,$FF,$00,$FF,$00,$C7,$38,$83,$3C,$81,$3C,$81,$1C,$C1,$1C,$C1
	DEFB $00,$FE,$00,$FE,$00,$FE,$00,$FE,$00,$FE,$00,$F8,$06,$F0,$0C,$E0
	DEFB $FE,$00,$EA,$00,$E4,$00,$FE,$00,$FE,$00,$7E,$00,$FD,$00,$FF,$00
	DEFB $18,$C3,$1C,$C1,$1C,$C1,$1C,$C1,$3C,$81,$7C,$01,$FC,$01,$F8,$03
	DEFB $0B,$E0,$07,$F0,$07,$F0,$07,$F0,$0F,$E0,$0F,$E0,$0F,$E0,$0F,$E0
	DEFB $FF,$00,$FB,$00,$FB,$00,$FF,$00,$DF,$00,$BE,$00,$8E,$00,$76,$00
	DEFB $F0,$07,$E0,$0F,$E0,$0F,$80,$0F,$70,$07,$F8,$03,$F8,$03,$F8,$03
	DEFB $0F,$E0,$0F,$E0,$07,$F0,$00,$F8,$01,$FC,$00,$FE,$00,$FF,$00,$FF
	DEFB $F7,$00,$F1,$00,$EE,$00,$1F,$00,$BF,$00,$DF,$00,$1C,$00,$0B,$E0
	DEFB $48,$03,$78,$03,$F8,$03,$78,$03,$B4,$01,$AC,$01,$BC,$01,$B8,$03
	DEFB $0F,$E0,$0F,$E0,$07,$F0,$07,$F0,$07,$F0,$02,$F8,$03,$F8,$03,$F8
	DEFB $80,$07,$80,$3F,$80,$3F,$80,$3F,$40,$1F,$C0,$1F,$C0,$1F,$80,$3F
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FE,$01,$FC,$03,$F8,$07,$E0,$1F,$C0
	DEFB $00,$C7,$38,$83,$7C,$01,$FC,$01,$F8,$03,$C0,$07,$C0,$1F,$80,$3F
	DEFB $F0,$07,$F8,$03,$A8,$02,$91,$00,$FB,$00,$FF,$00,$FF,$00,$FF,$00
	DEFB $3F,$80,$7E,$00,$FC,$01,$F8,$03,$F0,$07,$E0,$0F,$D0,$07,$E8,$03
	DEFB $FE,$00,$FF,$00,$7F,$00,$C7,$00,$BB,$00,$BB,$00,$DD,$00,$5D,$00
	DEFB $E8,$03,$74,$01,$F4,$01,$F8,$00,$FB,$00,$FF,$00,$FB,$00,$F7,$00
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$60,$9F,$00,$FE,$00,$FE,$00,$FF,$00
	DEFB $6E,$00,$2F,$80,$37,$80,$1F,$C0,$0E,$E0,$00,$F1,$00,$FF,$00,$FF
	DEFB $E7,$00,$4F,$00,$5F,$00,$7E,$00,$7F,$00,$3F,$80,$3F,$80,$1F,$C0
	DEFB $FF,$00,$FC,$00,$C0,$00,$07,$30,$07,$70,$0F,$60,$9F,$00,$AE,$00
	DEFB $1E,$00,$00,$E1,$00,$0F,$F0,$07,$F0,$07,$E0,$0F,$00,$1F,$00,$FF
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$78,$87,$00,$FB,$00,$FB,$00,$FF,$00
	DEFB $0F,$E0,$07,$F0,$03,$F8,$01,$FC,$00,$FE,$00,$FF,$00,$FF,$00,$FF
	DEFB $E8,$01,$E8,$03,$F0,$07,$E0,$0F,$C0,$1F,$00,$3F,$00,$FF,$00,$FF
	DEFB $07,$80,$77,$00,$6F,$00,$DF,$00,$DE,$00,$DF,$00,$DF,$00,$CF,$00
	DEFB $F0,$07,$F0,$07,$F0,$03,$EC,$01,$3E,$00,$C0,$00,$FF,$00,$FF,$00
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$F8,$07,$C0,$3F,$00,$FF,$00,$FF,$00
	DEFB $D7,$00,$D9,$00,$6E,$00,$6F,$00,$6F,$00,$37,$80,$37,$80,$0F,$C0
	DEFB $FF,$00,$FC,$00,$02,$00,$FE,$00,$FE,$00,$FE,$00,$FE,$00,$FE,$00
	DEFB $F0,$00,$00,$0F,$00,$3F,$C0,$1F,$E0,$0F,$E0,$0F,$C0,$1F,$00,$3F
	DEFB $04,$F0,$04,$F0,$07,$F0,$07,$F0,$0F,$E0,$0F,$E0,$1F,$C0,$1F,$C0
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$83,$7C,$01
	DEFB $00,$FE,$00,$FE,$00,$FE,$00,$F8,$06,$F0,$0F,$E0,$1F,$C0,$1D,$C0
	DEFB $FE,$00,$FE,$00,$FE,$00,$AB,$00,$92,$00,$FE,$00,$7F,$00,$9F,$00
	DEFB $00,$7F,$00,$7F,$00,$3F,$C0,$1F,$E0,$0F,$E0,$0F,$E0,$0F,$E0,$0F
	DEFB $3D,$80,$38,$80,$37,$80,$2F,$80,$6F,$00,$6F,$00,$6F,$00,$6B,$00
	DEFB $FE,$00,$FE,$00,$FE,$00,$C3,$00,$FF,$00,$FF,$00,$FF,$00,$CF,$00
	DEFB $F0,$07,$F0,$07,$F0,$07,$70,$07,$70,$07,$B0,$07,$B8,$03,$B8,$03
	DEFB $6D,$00,$37,$80,$37,$80,$37,$80,$37,$80,$37,$80,$6F,$00,$6F,$00
	DEFB $07,$30,$07,$70,$07,$70,$07,$70,$07,$70,$07,$70,$07,$70,$03,$78
	DEFB $B8,$03,$B8,$03,$D8,$03,$D8,$03,$D8,$03,$D8,$03,$D8,$03,$B8,$03
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$E7,$18,$C3,$3C,$81,$3C,$81,$38,$83
	DEFB $70,$04,$73,$00,$E7,$00,$E7,$00,$E7,$00,$E7,$00,$F7,$00,$F7,$00
	DEFB $00,$3F,$C0,$1F,$E0,$0F,$E0,$0F,$E0,$0F,$E0,$09,$E6,$00,$E7,$00
	DEFB $E3,$00,$DC,$00,$BF,$00,$BF,$00,$BF,$00,$BF,$00,$BF,$00,$BF,$00
	DEFB $D7,$00,$33,$00,$FB,$00,$FB,$00,$FB,$00,$FB,$00,$FB,$00,$FE,$00
	DEFB $7F,$00,$3F,$80,$3F,$80,$3F,$80,$1F,$80,$20,$80,$20,$80,$3F,$80
	DEFB $FC,$01,$F8,$03,$F8,$03,$F8,$03,$F0,$07,$10,$07,$30,$07,$F8,$03
	DEFB $7F,$00,$FF,$00,$FF,$00,$DF,$00,$EF,$00,$F0,$00,$FC,$00,$7C,$01
	DEFB $F8,$03,$F8,$03,$F8,$03,$F8,$03,$FC,$01,$FC,$01,$FC,$01,$7E,$00
	DEFB $5C,$01,$64,$01,$3C,$81,$3C,$81,$3C,$81,$1E,$C0,$1E,$C0,$1E,$C0
	DEFB $7E,$00,$3E,$80,$3E,$80,$1E,$C0,$3E,$80,$3C,$81,$7C,$01,$58,$03
	DEFB $0E,$E0,$0E,$E0,$0D,$E0,$0D,$E0,$01,$F0,$03,$F8,$03,$F8,$03,$F8
	DEFB $E8,$03,$F0,$07,$E0,$0F,$E0,$0F,$C0,$1F,$C0,$1F,$E0,$0F,$F0,$07
	DEFB $01,$FC,$03,$F8,$03,$F8,$03,$F8,$03,$F8,$03,$F8,$01,$FC,$01,$FC
	DEFB $02,$F8,$02,$F8,$03,$F8,$02,$F8,$02,$F8,$00,$FC,$00,$FE,$00,$FF
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FE,$01,$FC,$03,$F8
	DEFB $00,$FE,$01,$FC,$01,$FC,$03,$F8,$03,$18,$E3,$00,$DF,$00,$B1,$00
	DEFB $F0,$07,$F8,$03,$F8,$03,$F8,$03,$C8,$03,$C8,$03,$F0,$07,$F0,$07
	DEFB $03,$F8,$06,$F0,$06,$F0,$0D,$E0,$0D,$E0,$0D,$E0,$0B,$E0,$0B,$E0
	DEFB $6E,$00,$EF,$00,$EF,$00,$F7,$00,$F7,$00,$FB,$00,$FB,$00,$FD,$00
	DEFB $E0,$0C,$83,$10,$4F,$00,$B8,$00,$D7,$00,$CF,$00,$FF,$00,$FE,$00
	DEFB $0A,$E0,$04,$F0,$07,$F0,$07,$F0,$07,$F0,$07,$F0,$03,$F8,$01,$FC
	DEFB $79,$00,$10,$06,$D0,$07,$F0,$07,$E0,$0F,$F0,$07,$F0,$07,$F0,$07
	DEFB $F8,$01,$E0,$07,$00,$1F,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	DEFB $01,$FC,$00,$FE,$00,$FE,$00,$FE,$00,$FE,$01,$F8,$07,$80,$7B,$00
	DEFB $F8,$03,$F8,$03,$FC,$01,$FC,$01,$FE,$00,$FE,$00,$FE,$00,$F8,$01
	DEFB $03,$F8,$03,$F8,$07,$F0,$07,$F0,$06,$F0,$04,$F1,$00,$FB,$00,$FF
	DEFB $FD,$00,$F8,$00,$80,$07,$00,$7F,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	DEFB $F0,$07,$70,$07,$50,$07,$70,$07,$70,$07,$30,$83,$3C,$81,$3E,$80
	DEFB $0A,$E0,$04,$F0,$07,$F0,$07,$F0,$07,$F0,$07,$F0,$03,$F8,$03,$F8
	DEFB $79,$00,$10,$06,$D0,$07,$E0,$07,$F0,$03,$FC,$00,$FF,$00,$FF,$00
	DEFB $F8,$01,$E0,$07,$00,$1F,$00,$FF,$00,$FF,$00,$FF,$00,$3F,$C0,$1F
	DEFB $01,$FC,$01,$FC,$01,$FC,$01,$FC,$01,$FC,$03,$F8,$03,$F8,$07,$F0
	DEFB $FF,$00,$FF,$00,$F3,$00,$E3,$08,$E7,$00,$C8,$00,$DF,$00,$BC,$00
	DEFB $E0,$0F,$F0,$07,$F0,$07,$E0,$0F,$C0,$1F,$80,$3F,$00,$7F,$00,$FF
	DEFB $07,$F0,$0A,$E0,$1E,$C0,$3C,$80,$78,$02,$70,$02,$7C,$01,$3E,$80
	DEFB $70,$03,$60,$0F,$E0,$0F,$C0,$1F,$C0,$1F,$80,$3F,$00,$7F,$00,$FF
	DEFB $79,$00,$10,$06,$D0,$07,$F0,$07,$F8,$01,$FE,$00,$FF,$00,$FF,$00
	DEFB $F8,$01,$E0,$07,$00,$1F,$00,$FF,$00,$FF,$00,$FF,$00,$7F,$80,$3F
	DEFB $01,$FC,$01,$FC,$03,$F8,$03,$F8,$07,$F0,$07,$F0,$0F,$C0,$3F,$00
	DEFB $FF,$00,$FF,$00,$E7,$00,$C3,$18,$C5,$10,$86,$30,$8F,$20,$0F,$60
	DEFB $C0,$1F,$C0,$1F,$C0,$1F,$C0,$1F,$80,$3F,$80,$3F,$00,$7F,$00,$7F
	DEFB $00,$FC,$03,$F0,$0F,$E0,$1F,$C0,$1C,$C0,$1C,$C1,$1C,$C1,$0E,$E0
	DEFB $DF,$00,$DC,$00,$E0,$03,$00,$1F,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	DEFB $1E,$C0,$1C,$C1,$18,$C3,$1C,$C1,$0C,$E1,$0E,$E0,$06,$F0,$00,$F9
	DEFB $79,$00,$10,$06,$D0,$07,$F0,$07,$F0,$07,$F8,$03,$F8,$03,$FC,$01
	DEFB $1C,$C1,$1C,$C1,$1C,$C1,$18,$C3,$18,$C3,$18,$C2,$39,$80,$3B,$80
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FC,$03,$F8
	DEFB $07,$F0,$07,$F0,$0F,$E0,$0F,$E0,$1F,$C0,$3E,$00,$FE,$00,$FC,$01
	DEFB $FE,$00,$FF,$00,$FF,$00,$BF,$00,$0F,$40,$03,$F0,$01,$FC,$00,$FE
	DEFB $00,$FF,$00,$7F,$80,$3F,$C0,$1F,$C0,$1F,$C0,$1F,$E0,$0F,$E0,$0F
	DEFB $0B,$C0,$3B,$80,$3C,$80,$70,$03,$60,$0F,$E0,$0F,$C0,$1F,$C0,$1F
	DEFB $F0,$03,$80,$0F,$00,$7F,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	DEFB $A0,$0F,$E0,$0F,$70,$07,$70,$07,$70,$07,$70,$03,$7C,$01,$3E,$80
	DEFB $1F,$C0,$11,$C0,$1E,$C0,$1F,$C0,$1F,$C0,$0F,$E0,$0F,$E0,$0F,$E0
	DEFB $FC,$01,$F8,$01,$64,$01,$9C,$01,$BC,$01,$BC,$01,$DC,$01,$DC,$01
	DEFB $0F,$E0,$07,$F0,$07,$F0,$07,$F0,$07,$F0,$07,$F0,$07,$F0,$03,$F8
	DEFB $DC,$01,$DC,$01,$DC,$01,$DC,$01,$DC,$01,$BC,$01,$DC,$01,$DC,$01
	DEFB $02,$F8,$03,$F8,$03,$F8,$03,$F8,$03,$F8,$03,$F8,$03,$F8,$01,$FC
	DEFB $58,$03,$C8,$03,$D8,$03,$D8,$03,$D8,$03,$D8,$03,$D8,$03,$B0,$07
	DEFB $1C,$C1,$1C,$C1,$1C,$C1,$0C,$E1,$0C,$E1,$0C,$01,$EC,$01,$F4,$01
	DEFB $3A,$80,$3A,$80,$3B,$80,$3D,$80,$3F,$80,$3D,$80,$5F,$00,$5F,$00
	DEFB $B6,$00,$56,$00,$F6,$00,$F6,$00,$F6,$00,$EE,$00,$9E,$00,$FE,$00
	DEFB $5F,$00,$5F,$00,$5F,$00,$5F,$00,$5F,$00,$6F,$00,$6F,$00,$77,$00
	DEFB $FE,$00,$FE,$00,$F6,$00,$F6,$00,$FE,$00,$FE,$00,$FC,$01,$FC,$01
	DEFB $77,$00,$77,$00,$37,$80,$08,$C0,$08,$E0,$0F,$E0,$0F,$E0,$1F,$C0
	DEFB $FC,$01,$FC,$01,$F8,$01,$04,$01,$04,$01,$FC,$01,$FC,$01,$FC,$01
	DEFB $02,$F8,$02,$F8,$00,$FC,$01,$FC,$01,$FC,$01,$FC,$01,$FC,$00,$FE
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FE,$01,$FC,$03,$F8
	DEFB $03,$F8,$06,$F0,$0F,$C0,$37,$80,$7B,$00,$7B,$00,$FB,$00,$F6,$00
	DEFB $ED,$00,$EF,$00,$F7,$00,$7B,$00,$BC,$00,$DF,$00,$C7,$00,$B8,$00
	DEFB $7D,$00,$73,$00,$66,$00,$00,$99,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$1F,$E0,$0F,$F0,$07
	DEFB $70,$07,$30,$07,$10,$07,$A0,$0F,$C0,$1F,$00,$3F,$C0,$07,$38,$03
	DEFB $9C,$01,$DC,$01,$FA,$00,$C6,$00,$36,$00,$F4,$01,$E0,$03,$00,$1F
	DEFB $80,$1F,$00,$7F,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	DEFB $00,$FF,$00,$FF,$00,$FE,$01,$FC,$01,$FC,$03,$F8,$03,$F8,$02,$F8
	DEFB $00,$FF,$00,$FF,$00,$FC,$03,$F8,$07,$F0,$07,$F0,$06,$F0,$07,$F0
	DEFB $00,$FF,$00,$FF,$00,$3F,$C0,$1F,$E0,$0F,$E0,$0F,$00,$0F,$00,$0F
	DEFB $00,$FF,$00,$FE,$01,$FC,$03,$F8,$02,$F8,$01,$FC,$03,$F8,$07,$F0
	DEFB $07,$30,$CF,$00,$BF,$00,$7F,$00,$FF,$00,$FF,$00,$FF,$00,$EF,$00
	DEFB $E0,$0F,$C0,$0F,$B0,$07,$F8,$03,$FC,$01,$FE,$00,$DF,$00,$DF,$00
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$7F,$80,$3F
	DEFB $07,$F0,$0F,$E0,$0F,$E0,$0E,$E0,$0F,$E0,$07,$E0,$0B,$E0,$0D,$E0
	DEFB $9F,$00,$7F,$00,$7F,$00,$FF,$00,$7F,$00,$7F,$00,$9F,$00,$EF,$00
	DEFB $B7,$00,$E3,$08,$E1,$0C,$E0,$0E,$C0,$00,$DE,$00,$FF,$00,$FF,$00
	DEFB $C0,$1F,$C0,$1F,$E0,$0F,$F0,$07,$70,$07,$78,$03,$38,$03,$78,$03
	DEFB $0E,$E0,$0D,$E0,$01,$F0,$01,$FC,$01,$FC,$01,$FC,$03,$F8,$03,$F8
	DEFB $F7,$00,$77,$00,$8F,$00,$FF,$00,$FB,$00,$F0,$04,$F0,$07,$E0,$0E
	DEFB $FF,$00,$FF,$00,$FE,$00,$DC,$01,$3C,$01,$78,$03,$70,$07,$E0,$0F
	DEFB $78,$03,$30,$07,$00,$CF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	DEFB $03,$F8,$03,$F8,$07,$F0,$07,$F0,$07,$F0,$07,$F0,$0F,$E0,$0E,$E0
	DEFB $C1,$1C,$C1,$1C,$C1,$1C,$81,$3C,$81,$3C,$00,$7E,$00,$7F,$00,$FF
	DEFB $C0,$1F,$80,$3F,$80,$3F,$80,$3F,$00,$7F,$00,$FF,$00,$FF,$00,$FF
	DEFB $0E,$E0,$1C,$C1,$1C,$C1,$18,$C3,$38,$83,$38,$83,$78,$03,$78,$03

; Dog tiles, tiles with mask, 61 tiles, 16 bytes each
; Used to draw tiles from Tile screen 3, see B1FC.
LF0F0:	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$F0
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$8F,$70,$03
	DEFB $00,$FF,$00,$FF,$00,$FE,$01,$FC,$03,$F8,$04,$70,$88,$03,$70,$07
	DEFB $0F,$C0,$3F,$80,$7F,$00,$FF,$00,$7F,$00,$FE,$00,$7F,$00,$0F,$80
	DEFB $00,$00,$FF,$00,$EF,$00,$EF,$00,$FF,$00,$FF,$00,$7F,$00,$7F,$00
	DEFB $EC,$01,$7E,$00,$BE,$00,$E8,$01,$86,$10,$80,$39,$80,$3F,$00,$7F
	DEFB $00,$8F,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	DEFB $06,$F0,$06,$F0,$0D,$E0,$0C,$E0,$05,$F0,$06,$F0,$03,$F8,$01,$FC
	DEFB $BC,$00,$86,$00,$73,$00,$C1,$0C,$80,$1E,$61,$0C,$32,$00,$00,$4D
	DEFB $00,$FF,$00,$FF,$00,$7F,$80,$3F,$80,$3F,$00,$7F,$00,$FF,$00,$FF
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FE,$01,$FC,$01,$FC,$03,$00
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$7F,$80,$07,$F8,$03,$F4,$01,$3E,$00
	DEFB $00,$F0,$0F,$E0,$17,$00,$EF,$00,$0F,$00,$1F,$C0,$1F,$C0,$0D,$E0
	DEFB $00,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$EF,$00,$F7,$00,$F4,$00
	DEFB $FE,$00,$F7,$00,$EF,$00,$EF,$00,$F7,$00,$FF,$00,$FF,$00,$FD,$00
	DEFB $FF,$00,$78,$00,$BE,$00,$C0,$01,$80,$3F,$80,$3F,$C0,$1F,$E0,$0F
	DEFB $0E,$E0,$0E,$E0,$1C,$C1,$30,$82,$60,$0E,$40,$1E,$60,$0E,$20,$8F
	DEFB $F0,$03,$E0,$0F,$60,$0F,$C0,$1F,$C0,$1F,$80,$3F,$C0,$0F,$70,$07
	DEFB $02,$00,$00,$FC,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	DEFB $F0,$07,$30,$07,$58,$03,$2C,$80,$37,$80,$03,$C8,$00,$FC,$00,$FF
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$E0
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$1F
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$8F,$70,$03
	DEFB $00,$FF,$00,$FE,$01,$FC,$02,$F8,$05,$80,$79,$00,$00,$80,$05,$F0
	DEFB $1F,$C0,$3F,$00,$FF,$00,$FF,$00,$FF,$00,$FC,$00,$E0,$03,$C0,$1F
	DEFB $E0,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$7F,$00,$1F,$80,$07,$E0
	DEFB $FC,$01,$F6,$00,$7F,$00,$BF,$00,$DC,$00,$C0,$03,$C0,$1F,$00,$1F
	DEFB $1D,$C0,$23,$80,$0E,$80,$78,$01,$C0,$07,$00,$3F,$00,$FF,$00,$FF
	DEFB $C0,$1F,$80,$3F,$00,$7F,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	DEFB $0E,$E0,$0C,$E1,$08,$E3,$18,$C3,$10,$C7,$30,$87,$30,$87,$18,$C3
	DEFB $E0,$0F,$60,$0F,$30,$87,$10,$C7,$18,$C0,$0F,$E0,$07,$F0,$00,$F8
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$F1,$0E,$80
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$91
	DEFB $00,$FF,$00,$FF,$00,$FE,$00,$FE,$00,$FE,$00,$FE,$00,$FE,$00,$FE
	DEFB $7F,$00,$7F,$00,$FF,$00,$FF,$00,$F7,$00,$F7,$00,$EB,$00,$ED,$00
	DEFB $6E,$00,$5F,$00,$6D,$00,$72,$00,$B6,$00,$BE,$00,$D2,$00,$ED,$00
	DEFB $00,$7F,$80,$3F,$80,$3F,$80,$3F,$00,$7F,$00,$FF,$00,$FF,$00,$7F
	DEFB $00,$FE,$01,$FC,$01,$FC,$01,$FC,$00,$FE,$00,$FE,$00,$FF,$00,$FF
	DEFB $C4,$10,$84,$30,$84,$30,$8C,$21,$CC,$01,$C4,$01,$66,$00,$66,$00
	DEFB $F2,$00,$C6,$00,$C6,$10,$42,$18,$42,$18,$62,$08,$66,$00,$66,$00
	DEFB $00,$FC,$03,$F8,$03,$F8,$01,$FC,$01,$1C,$E3,$00,$DF,$00,$B1,$00
	DEFB $02,$00,$C6,$00,$6C,$00,$38,$00,$1C,$00,$36,$00,$63,$00,$40,$00
	DEFB $10,$00,$18,$00,$18,$00,$7F,$00,$FE,$00,$18,$00,$18,$00,$08,$00
	DEFB $00,$00,$00,$00,$20,$00,$FC,$00,$FF,$00,$20,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$20,$00,$FC,$00,$FF,$00,$20,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$3C,$00,$32,$00,$6E,$00,$6E,$00,$7C,$00,$00,$00
	DEFB $00,$00,$18,$00,$3C,$00,$62,$00,$6E,$00,$3E,$00,$1C,$00,$00,$00
	DEFB $1E,$00,$3E,$00,$7A,$00,$86,$00,$F4,$00,$F8,$00,$F0,$00,$00,$00
	DEFB $1E,$00,$3E,$00,$7A,$00,$86,$00,$F4,$00,$F8,$00,$F0,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$FF,$00,$FF,$00,$00,$00,$00,$00,$00,$00
	DEFB $18,$00,$18,$00,$18,$00,$18,$00,$18,$00,$18,$00,$18,$00,$18,$00
	DEFB $00,$00,$0E,$00,$30,$00,$78,$00,$48,$00,$78,$00,$70,$00,$00,$00
	DEFB $00,$00,$1C,$00,$18,$00,$34,$00,$3C,$00,$3C,$00,$38,$00,$00,$00
	DEFB $1E,$C0,$3E,$80,$7A,$00,$86,$00,$F4,$01,$F8,$03,$F0,$07,$00,$0F
	DEFB $1E,$C0,$3E,$80,$7A,$00,$86,$00,$F4,$01,$F8,$03,$F0,$07,$00,$0F
	DEFB $FA,$00,$9E,$00,$BA,$00,$FA,$00,$FA,$00,$FE,$00,$FA,$00,$00,$00
	DEFB $BE,$00,$FE,$00,$BE,$00,$BE,$00,$BE,$00,$FE,$00,$BE,$00,$00,$00
	DEFB $08,$00,$18,$00,$38,$00,$7C,$00,$5E,$00,$5A,$00,$7E,$00,$3C,$00
	DEFB $08,$00,$08,$00,$1C,$00,$36,$00,$3A,$00,$3A,$00,$3E,$00,$1C,$00
	DEFB $3C,$00,$7A,$00,$DF,$00,$FF,$00,$FD,$00,$FF,$00,$76,$00,$3C,$00
	DEFB $3C,$00,$76,$00,$DF,$00,$FF,$00,$FF,$00,$FF,$00,$6E,$00,$3C,$00
	DEFB $7C,$01,$FC,$01,$FC,$01,$C8,$03,$98,$03,$08,$03,$38,$03,$90,$07
	DEFB $F0,$04,$83,$00,$0F,$00,$B8,$00,$D7,$00,$CF,$00,$FF,$00,$FE,$00
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FE,$01,$FC,$01,$FC
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$C1,$3E,$00,$FE,$00,$FE,$00
	DEFB $00,$FE,$00,$FE,$00,$FE,$00,$FE,$00,$FE,$00,$FA,$05,$F0,$0B,$E0
	DEFB $C4,$01,$AC,$01,$84,$01,$9C,$01,$E8,$01,$FE,$00,$FF,$00,$FF,$00
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FC,$03,$F8,$03,$F8,$01,$FC,$01,$FC
	DEFB $00,$FF,$00,$FF,$00,$83,$7C,$01,$FC,$01,$FC,$01,$88,$03,$58,$03
	DEFB $01,$FC,$03,$00,$DF,$00,$3F,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00
	DEFB $08,$03,$38,$03,$D0,$03,$FC,$01,$FE,$00,$FE,$00,$FF,$00,$FF,$00
	DEFB $00,$FE,$01,$F8,$07,$F0,$07,$F0,$07,$F0,$01,$F8,$01,$FC,$01,$FC
	DEFB $78,$03,$F8,$03,$E8,$02,$59,$00,$0B,$00,$BF,$00,$DF,$00,$FF,$00
	DEFB $01,$FC,$03,$C0,$2F,$80,$5F,$00,$DE,$00,$DF,$00,$DF,$00,$CF,$00
	DEFB $08,$03,$38,$03,$D0,$03,$FC,$01,$3E,$00,$C0,$00,$FF,$00,$FF,$00
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$3F,$C0,$1F,$E0,$07,$38,$00
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$C0,$3F,$00,$FF,$00,$FE,$00
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FC,$03,$80,$7F,$00
	DEFB $00,$1F,$E0,$0F,$F0,$07,$F0,$07,$F0,$01,$F6,$00,$EF,$00,$07,$10
	DEFB $DF,$00,$FF,$00,$FF,$00,$FF,$00,$3F,$00,$D7,$00,$D1,$00,$A0,$06
	DEFB $71,$00,$8F,$00,$BF,$00,$7F,$00,$73,$00,$7C,$00,$BF,$00,$4F,$00
	DEFB $F8,$00,$FF,$00,$FF,$00,$07,$00,$FF,$00,$FF,$00,$3F,$00,$CE,$00
	DEFB $00,$F0,$07,$C0,$3E,$00,$F9,$00,$E7,$00,$DF,$00,$BF,$00,$38,$00
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$80,$7F,$00,$FF,$00,$FF,$00,$7E,$00
	DEFB $00,$FF,$00,$FE,$01,$FC,$03,$F8,$07,$F0,$07,$F0,$06,$F0,$06,$F0
	DEFB $00,$FF,$00,$1F,$E0,$0F,$F0,$07,$F0,$07,$F0,$07,$B0,$07,$50,$07
	DEFB $F0,$07,$F0,$07,$F0,$01,$EC,$00,$1E,$00,$FE,$00,$FF,$00,$FF,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$FE,$00,$FE,$00,$98,$67,$00,$7F,$00
	DEFB $00,$F0,$0D,$C0,$2B,$00,$ED,$00,$EE,$00,$B6,$00,$5B,$00,$6B,$00
	DEFB $00,$0F,$B0,$03,$D4,$00,$B7,$00,$77,$00,$ED,$00,$DA,$00,$D6,$00
	DEFB $00,$FF,$00,$FF,$00,$FF,$00,$7F,$00,$7F,$00,$19,$E6,$00,$FE,$00

; Background tiles, 59 tiles, 9 bytes each
; Used to draw background level, see B177.
LF700:	DEFB $FE,$82,$A2,$A2,$BA,$82,$FE,$00,$30
	DEFB $7F,$41,$7F,$00,$7F,$41,$7F,$00,$20
	DEFB $FF,$80,$80,$80,$FF,$08,$08,$08,$08
	DEFB $FF,$FF,$08,$FF,$80,$FF,$08,$08,$08
	DEFB $02,$7A,$42,$52,$52,$5A,$42,$7A,$30
	DEFB $EF,$8C,$AC,$AF,$AF,$8C,$EC,$0F,$30
	DEFB $6F,$4C,$6C,$0F,$6F,$4C,$6C,$0F,$20
	DEFB $EF,$8C,$8C,$8F,$EF,$0C,$0C,$0F,$08
	DEFB $F6,$32,$32,$F2,$F2,$32,$36,$F0,$30
	DEFB $F7,$31,$37,$F0,$F7,$31,$37,$F0,$20
	DEFB $F7,$30,$30,$F0,$F7,$30,$30,$F0,$08
	DEFB $40,$5F,$41,$41,$41,$5D,$41,$5F,$30
	DEFB $D5,$95,$A5,$A5,$A9,$A5,$95,$D5,$10
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$08
	DEFB $E0,$E0,$F0,$DC,$C7,$C0,$C0,$C0,$08
	DEFB $00,$00,$00,$00,$80,$F8,$0F,$00,$08
	DEFB $00,$00,$00,$00,$00,$0F,$F8,$00,$08
	DEFB $01,$01,$07,$1C,$F0,$80,$00,$00,$08
	DEFB $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$08
	DEFB $FF,$80,$80,$00,$F7,$F0,$F0,$F0,$08
	DEFB $FF,$80,$80,$80,$EF,$0F,$0F,$0F,$08
	DEFB $83,$01,$01,$01,$01,$01,$83,$FF,$28
	DEFB $F0,$FC,$FE,$1F,$07,$FA,$FC,$F0,$22
	DEFB $FD,$82,$82,$84,$F4,$08,$08,$08,$08
	DEFB $D0,$90,$90,$90,$A0,$20,$20,$20,$08
	DEFB $40,$40,$40,$40,$80,$80,$80,$80,$08
	DEFB $FF,$FF,$FF,$00,$00,$00,$00,$00,$0A
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$20
	DEFB $BF,$40,$40,$20,$2F,$10,$10,$10,$08
	DEFB $0B,$08,$08,$08,$05,$04,$04,$04,$08
	DEFB $02,$02,$02,$02,$01,$01,$01,$01,$08
	DEFB $7F,$7F,$7F,$3F,$3F,$1F,$0F,$03,$39
	DEFB $FE,$FE,$FE,$FC,$FC,$F8,$F0,$C0,$39
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$38
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$28
	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$20
	DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$F0,$20
	DEFB $F7,$79,$7B,$3C,$BD,$9E,$12,$FF,$20
	DEFB $7F,$41,$7F,$00,$7F,$41,$00,$FF,$20
	DEFB $FF,$FE,$F9,$F0,$CF,$A1,$77,$F0,$20
	DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$20
	DEFB $FF,$FE,$FE,$FC,$FB,$F1,$CF,$80,$20
	DEFB $EF,$E1,$EF,$E0,$DF,$C1,$BF,$80,$20
	DEFB $01,$03,$07,$0F,$1F,$3F,$7F,$FF,$20
	DEFB $F6,$F6,$F6,$F4,$F5,$ED,$EB,$E8,$20
	DEFB $07,$07,$03,$03,$03,$01,$01,$01,$20
	DEFB $FF,$7F,$3F,$1F,$1F,$0F,$0F,$07,$20
	DEFB $F3,$FC,$FF,$FF,$FF,$FF,$FF,$FF,$20
	DEFB $7F,$41,$7F,$80,$CF,$F1,$FC,$FF,$20
	DEFB $41,$BF,$BF,$DF,$DF,$DF,$DF,$DF,$20
	DEFB $FF,$FF,$FF,$FF,$FF,$FF,$C3,$00,$20
	DEFB $FF,$FF,$FE,$FE,$FE,$FD,$FD,$F8,$20
	DEFB $79,$47,$6F,$1F,$5F,$3F,$3F,$7F,$20
	DEFB $FB,$FD,$FE,$E6,$DF,$DB,$E7,$FF,$20
	DEFB $73,$4D,$6E,$0E,$6E,$46,$77,$02,$20
	DEFB $47,$39,$FB,$C0,$3F,$41,$7F,$00,$20
	DEFB $FF,$00,$7F,$45,$51,$7F,$00,$FF,$28
	DEFB $82,$AA,$AA,$AA,$AA,$AA,$AA,$82,$28
	DEFB $99,$B9,$B9,$99,$9D,$99,$99,$99,$28

; Routine at F913
LF913:	LD A,$04
	LD (L89B3+1),A
	LD A,$F4
	LD (L89B3+3),A
	LD HL,$0D1B
	LD BC,$0505
	LD DE,$0506
	LD A,(LE1EC)
	CP $34
	JR NC,LF94D
	LD E,$0B
	LD A,$17
	LD (L89B3+1),A
	LD A,$E1
	LD (L89B3+3),A
	LD A,(LE1EC)
	CP $33
	JR Z,LF94D
	LD C,$0F
	LD D,$0B
	CP $32
	JR Z,LF94D
	LD B,$0A
	LD HL,$1216
LF94D:	LD A,H
	LD (L8D45+1),A
	LD A,B
	LD (L8CAE+1),A
	LD A,C
	LD (L8A52+1),A
	LD A,D
	LD (L8A00+1),A
	LD A,E
	LD (L88EB+1),A
	LD A,L
	LD (L8D45+3),A
	JP LB3B0
; Entry point
LF968:	JP Z,LB040
	CP $30
	JP Z,LB040
	JP LAF9C

; Room 84A8 initialization
LF973:	LD HL,L65DA	; tile screen address
	LD DE,LF98F	; block address
	LD C,$06	; 6 rows
LF97B:	LD B,$03	; 3 columns
LF97D:	LD A,(DE)
	LD (HL),A
	INC HL
	INC DE
	DJNZ LF97D
	PUSH DE
	LD DE,$001B
	ADD HL,DE
	POP DE
	DEC C
	JR NZ,LF97B
	JP LB422

; Block 3x6 tiles for room 84A8
LF98F:	DEFB $82,$83,$84	 ; Back block 3x6 - crane
	DEFB $85,$86,$87
	DEFB $85,$88,$89
	DEFB $8A,$8B,$89
	DEFB $82,$83,$84
	DEFB $00,$8C,$00

; Sound ??
LF9A1:	RL B
	RL B
	RL B
	RL B
	LD HL,$0000
LF9AC:	LD A,(HL)
	AND $F8
	OUT ($FE),A
	LD C,(HL)
	INC HL
LF9B3:	DEC C
	JR NZ,LF9B3
	DJNZ LF9AC
	RET

; Pause, then wait for any key pressed
LF9B9:	LD DE,$0000
LF9BC:	DEC DE
	LD B,$05
LF9BF:	DJNZ LF9BF
	LD A,D
	OR E
	JR NZ,LF9BC
LF9C5:	CALL LBBDF	; Read Input
	LD A,(L7222)
	CP $00
	LD A,(L7232)	; get Input bits
	JR Z,LF9D7
	BIT 4,A
	RET NZ
	JR LF9C5
LF9D7:	XOR A
	LD ($5C08),A	; clear LASTK
	RST $38
	LD A,($5C08)	; get LASTK
	CP $00
	RET NZ
	JR LF9C5

; Routine at F9E4
LF9E4:	CALL L6590	; Prepare screen, show anti-piracy message, and wait for any key

; Start point after loading
LF9E7:	LD A,$21
	LD (LAEDA+1),A
	LD A,$C6
	LD (LAEDA+2),A
	CALL LBC13
LF9F4:	CALL LF913
	JR LF9F4

; Routine at F9F9
LF9F9:	LD HL,$00B4
F9FC	LD B,$01
F9FE	CALL LFA11
FA01	LD HL,LBDAF
FA04	RET
FA05	LD HL,$018F
FA08	LD B,$10
FA0A	CALL LFA11
FA0D	LD A,(L71CF)
FA10	RET

; Routine at FA11
LFA11:	LD A,$10
	OUT ($FE),A
	LD A,B
LFA16:	DEC A
	JR NZ,LFA16
	INC B
	XOR A
	OUT ($FE),A
	LD A,L
	AND $F8
	OUT ($FE),A
	DEC HL
	LD A,H
	OR L
	JR NZ,LFA11
	RET

; Routine at FA28
LFA28:	LD B,$01
	CALL LF9A1
	LD A,(L7184)	; get current room address low byte
	RET

; Decrease Energy by B + Sound
LFA31:	CALL L9DD9	; Decrease Energy by B
	LD B,$01
	CALL LF9A1	; Sound
	RET

; Data block at FA3A
LFA3A:	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$FF,$60,$04,$FF,$FF,$10,$86
	DEFB $FF,$28,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$DF,$FB,$DF,$FF,$F7
	DEFB $FF,$DF,$FF,$08,$DF,$FB,$DF,$FF
	DEFB $F7,$FF,$DF,$FF,$08,$DF,$FB,$DF
	DEFB $FF,$F7,$FF,$DF,$FF,$08,$DF,$FB
	DEFB $DF,$FF,$F7,$FF,$DF,$FF,$08,$00
	DEFB $00,$00,$00,$FF,$FF,$00,$FF,$10
	DEFB $00,$00,$00,$00,$FF,$FF,$00,$FF
	DEFB $10,$00,$00,$00,$00,$FF,$FF,$00
	DEFB $FF,$10,$DF,$FB,$DF,$FF,$F7,$FF
	DEFB $DF,$FF,$08,$DF,$FB,$DF,$FF,$F7
	DEFB $FF,$DF,$FF,$08,$DF,$FB,$DF,$FF
	DEFB $F7,$FF,$DF,$FF,$08,$DF,$FB,$DF
	DEFB $FF,$F7,$FF,$DF,$FF,$08,$DF,$FB
	DEFB $DF,$FF,$F7,$FF,$DF,$FF,$08,$DF
	DEFB $FB,$DF,$FF,$F7,$FF,$DF,$FF,$08
	DEFB $DF,$FB,$DF,$FF,$F7,$FF,$DF,$FF
	DEFB $08,$DF,$FB,$DF,$FF,$F7,$FF,$DF
	DEFB $FF,$08,$DF,$FB,$DF,$FF,$F7,$FF
	DEFB $DF,$FF,$08,$DF,$FB,$DF,$FF,$F7
	DEFB $FF,$DF,$FF,$08,$DF,$FB,$DF,$FF
	DEFB $F7,$FF,$DF,$FF,$08,$DF,$FB,$DF
	DEFB $FF,$F7,$FF,$DF,$FF,$08,$DF,$FB
	DEFB $DF,$FF,$F7,$FF,$DF,$FF,$08,$DF
	DEFB $FB,$DF,$FF,$F7,$FF,$DF,$FF,$08
	DEFB $DF,$FB,$DF,$FF,$F7,$FF,$DF,$FF
	DEFB $08,$DF,$FB,$DF,$FF,$F7,$FF,$DF
	DEFB $FF,$08,$DF,$FB,$DF,$FF,$F7,$FF
	DEFB $DF,$FF,$08,$DF,$FB,$DF,$FF,$F7
	DEFB $FF,$DF,$FF,$08,$DF,$FB,$DF,$FF
	DEFB $F7,$FF,$DF,$FF,$08,$DF,$FB,$DF
	DEFB $FF,$F7,$FF,$DF,$FF,$08,$DF,$FB
	DEFB $DF,$FF,$F7,$FF,$DF,$FF,$08,$00
	DEFB $00,$00,$00,$FF,$FF,$00,$FF,$10
	DEFB $1F,$FA,$FF,$A0,$A0,$FF,$F5,$1F
	DEFB $28,$FF,$AA,$FF,$00,$00,$FF,$55
	DEFB $FF,$28,$F8,$AF,$FF,$05,$05,$FF
	DEFB $5F,$F8,$28,$6E,$62,$62,$62,$62
	DEFB $62,$6E,$60,$30,$96,$97,$DB,$19
	DEFB $DA,$9A,$9A,$9A,$30,$B4,$74,$EC
	DEFB $CC,$2C,$8C,$EC,$0C,$30,$DA,$9A
	DEFB $B2,$B2,$B2,$B2,$B6,$30,$30,$EC
	DEFB $8C,$AC,$AC,$AC,$8C,$EC,$0C,$30
	DEFB $62,$62,$6E,$60,$67,$6F,$5D,$5A
	DEFB $30,$B6,$B2,$B2,$B2,$32,$B2,$D6
	DEFB $D0,$30,$FB,$18,$9C,$2E,$86,$C6
	DEFB $FE,$7C,$30,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$00,$00,$FE
	DEFB $FE,$C6,$38,$28,$28,$28,$7C,$21
	DEFB $FE,$82,$A2,$22,$CA,$F2,$FC,$FF
	DEFB $31,$CE,$F2,$FC,$FF,$FF,$FF,$FF
	DEFB $FF,$31,$BE,$C2,$E2,$F2,$FA,$FC
	DEFB $FE,$FF,$31,$00,$00,$00,$00,$00
	DEFB $00,$00,$00,$08,$F3,$8F,$3F,$FF
	DEFB $FF,$FF,$FF,$FF,$31,$FE,$82,$A2
	DEFB $A0,$B3,$8F,$3F,$FF,$31,$FD,$83
	DEFB $A7,$AF,$9F,$BF,$7F,$FF,$31,$07
	DEFB $1B,$63,$87,$63,$1B,$07,$03,$28
	DEFB $F0,$CC,$C3,$E1,$C6,$D8,$E0,$C0
	DEFB $28,$FF,$FF,$FF,$FF,$FE,$FC,$F8
	DEFB $F0,$32,$F0,$F8,$FC,$FE,$FF,$FF
	DEFB $FF,$FF,$32,$FF,$FF,$FF,$FF,$7F
	DEFB $3F,$1F,$0F,$32,$0F,$1F,$3F,$7F
	DEFB $FF,$FF,$FF,$FF,$32,$07,$07,$07
	DEFB $07,$FF,$FF,$FF,$FF,$20,$FF,$FF
	DEFB $FF,$FF,$E0,$E0,$E0,$E0,$20,$E0
	DEFB $E0,$E0,$E0,$FF,$FF,$FF,$FF,$20
	DEFB $70,$70,$70,$70,$70,$70,$70,$70
	DEFB $20,$00,$00,$00,$00,$00,$00,$00
	DEFB $00,$10,$1C,$1C,$1C,$1C,$1C,$1C
	DEFB $1C,$1C,$20,$0E,$0E,$0E,$0E,$0E
	DEFB $0E,$0E,$0E,$20,$FF,$FF,$FF,$FF
	DEFB $07,$07,$07,$07,$20,$38,$38,$38
	DEFB $38,$FF,$FF,$FF,$FF,$20,$38,$38
	DEFB $38,$38,$38,$38,$38,$38,$20,$FF
	DEFB $FF,$FF,$FF,$38,$38,$38,$38,$20
	DEFB $00,$FE,$02,$02,$02,$0A,$02,$02
	DEFB $28,$02,$02,$02,$02,$02,$CA,$02
	DEFB $FE,$28,$A0,$A0,$A0,$A0,$A0,$A0
	DEFB $A0,$A0,$28,$A0,$A0,$A0,$A0,$A0
	DEFB $BF,$80,$FF,$28,$E0,$E0,$70,$70
	DEFB $B8,$B8,$DC,$1C,$20,$00,$00,$00
	DEFB $00,$80,$80,$C0,$C0,$20,$EE,$8E
	DEFB $A7,$A7,$BB,$83,$FD,$01,$30,$FF
	DEFB $FF,$7F,$7F,$B8,$B8,$DC,$1C,$20
	DEFB $0E,$0E,$07,$07,$FF,$FF,$FF,$FF
	DEFB $20,$00,$00,$00,$00,$FF,$FF,$FF
	DEFB $FF,$20,$00,$FF,$80,$A0,$A0,$A0
	DEFB $A0,$A0,$28,$C0,$C0,$C0,$E0,$E0
	DEFB $E0,$70,$70,$20,$01,$01,$01,$00
	DEFB $00,$00,$00,$00,$20,$00,$00,$00
	DEFB $00,$00,$80,$80,$80,$20,$0E,$0E
	DEFB $07,$07,$07,$03,$03,$03,$20,$70
	DEFB $38,$38,$38,$1C,$1C,$1C,$0E,$20
	DEFB $FF,$FF,$FF,$FF,$00,$00,$00,$00
	DEFB $20,$FF,$FF,$FF,$FF,$E0,$E0,$70
	DEFB $70,$20,$D8,$9C,$9D,$9F,$9F,$9D
	DEFB $DC,$18,$30,$1A,$3A,$BA,$FA,$FA
	DEFB $BA,$3A,$18,$30,$02,$02,$02,$02
	DEFB $02,$0A,$02,$02,$28,$00,$00,$00
	DEFB $00,$00,$00,$00,$00,$20,$07,$07
	DEFB $0E,$0E,$1C,$1C,$3A,$38,$20,$76
	DEFB $72,$E2,$E2,$DA,$C2,$BE,$80,$30
	DEFB $00,$00,$00,$00,$01,$01,$03,$03
	DEFB $20,$FF,$FF,$FE,$FE,$1C,$1C,$3A
	DEFB $38,$20,$70,$70,$E0,$E0,$FF,$FF
	DEFB $FF,$FF,$20,$BC,$BC,$9A,$9A,$9A
	DEFB $9A,$BC,$3C,$30,$80,$80,$80,$00
	DEFB $00,$00,$00,$00,$20,$03,$03,$03
	DEFB $07,$07,$07,$0E,$0E,$20,$70,$70
	DEFB $E0,$E0,$E0,$C0,$C0,$C0,$20,$00
	DEFB $00,$00,$00,$00,$01,$01,$01,$20
	DEFB $0E,$1C,$1C,$1C,$38,$38,$38,$70
	DEFB $20,$FF,$FF,$FF,$FF,$07,$07,$0E
	DEFB $0E,$20,$7F,$41,$55,$41,$55,$41
	DEFB $7F,$80,$28,$B6,$7D,$00,$00,$00
	DEFB $00,$00,$00,$0E,$D8,$BE,$46,$DB
	DEFB $A3,$B6,$CD,$7A,$0E,$03,$01,$02
	DEFB $03,$01,$02,$01,$02,$0E,$C3,$3D
	DEFB $66,$4E,$5E,$5E,$3C,$C3,$28,$FF
	DEFB $73,$00,$8C,$FF,$FF,$00,$FF,$28
	DEFB $3C,$7E,$BD,$BD,$BD,$A5,$7E,$C3
	DEFB $20,$7F,$41,$3C,$DB,$5A,$DB,$3C
	DEFB $3C,$20,$7F,$41,$00,$FF,$FF,$FF
	DEFB $00,$00,$20,$00,$41,$7F,$00,$7F
	DEFB $41,$7F,$00,$20,$FF,$FF,$FF,$FF
	DEFB $FF,$FF,$FF,$FF,$20,$0F,$3F,$7F
	DEFB $FF,$FF,$FF,$FF,$FF,$20,$00,$41
	DEFB $7F,$00,$7F,$41,$00,$FF,$20,$5D
	DEFB $5D,$5D,$3C,$3D,$3D,$24,$FF,$20
	DEFB $7B,$47,$6F,$1E,$3C,$78,$F0,$E0
	DEFB $20,$E0,$C0,$C0,$80,$80,$00,$00
	DEFB $00,$20,$7D,$41,$7B,$03,$77,$47
	DEFB $6F,$0F,$20,$6E,$4E,$5C,$1D,$5D
	DEFB $5D,$5D,$1F,$20,$5F,$4F,$6F,$0F
	DEFB $6F,$4F,$77,$07,$20,$77,$47,$7B
	DEFB $03,$7B,$41,$7D,$00,$20,$7F,$41
	DEFB $7F,$00,$03,$7C,$7F,$1F,$20,$FF
	DEFB $7F,$3F,$1F,$63,$40,$7F,$00,$20
	DEFB $66,$FF,$FF,$99,$66,$FF,$FF,$AA
	DEFB $0D,$FF,$80,$3E,$C1,$1C,$E3,$08
	DEFB $FF,$10,$42,$7E,$42,$52,$42,$52
	DEFB $42,$7E,$27,$FF,$00,$80,$60,$1B
	DEFB $04,$02,$01,$08,$01,$FE,$01,$00
	DEFB $00,$00,$00,$00,$08,$FF,$00,$00
	DEFB $00,$FF,$FF,$FF,$FF,$29,$80,$7F
	DEFB $80,$00,$00,$00,$00,$00,$08,$FF
	DEFB $80,$81,$86,$D8,$20,$40,$80,$08
	DEFB $00,$22,$FF,$00,$FF,$22,$00,$00
	DEFB $07,$32,$2E,$7B,$26,$32,$2E,$7B
	DEFB $26,$07,$F0,$31,$3F,$F1,$F0,$31
	DEFB $3F,$F1,$20,$0F,$8C,$FC,$8F,$0F
	DEFB $8C,$FC,$8F,$20,$F1,$31,$3F,$F1
	DEFB $F0,$31,$3F,$F1,$30,$0F,$8C,$FC
	DEFB $8F,$4F,$8C,$FC,$8F,$30,$F6,$31
	DEFB $3F,$F1,$F6,$31,$3F,$F1,$08,$6F
	DEFB $8C,$FC,$8F,$6F,$8C,$FC,$8F,$08
	DEFB $00,$00,$00,$00,$00,$00,$00,$00
	DEFB $08,$FF,$80,$80,$80,$EF,$0F,$0F
	DEFB $0F,$08,$FF,$80,$80,$00,$F7,$F0
	DEFB $F0,$F0,$08,$84,$5B,$88,$F7,$22
	DEFB $D5,$FF,$FF,$30,$FF,$80,$3E,$C1
	DEFB $1C,$E3,$08,$FF,$10,$44,$10,$FF
	DEFB $00,$FF,$FF,$FF,$FF,$30,$66,$00
	DEFB $00,$00,$FF,$FF,$99,$99,$10,$B9
	DEFB $B3,$B1,$BB,$B9,$B3,$B3,$B3,$20
	DEFB $00,$00,$00,$00,$FF,$FF,$00,$FF
	DEFB $10,$3C,$66,$42,$C3,$81,$81,$00
	DEFB $00,$07,$D3,$D3,$D3,$D3,$D3,$D3
	DEFB $FF,$81,$08,$D3,$D3,$D3,$D3,$D3
	DEFB $D3,$D3,$D3,$08,$81,$FF,$D3,$D3
	DEFB $D3,$D3,$D3,$D3,$08

; Background tile $FF
LFFF7:	DEFB $DF,$FB,$DF,$FF,$F7,$FF,$DF,$FF,$08
