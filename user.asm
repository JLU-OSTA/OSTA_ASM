user:
;Please input your code following this.



JMP go
msg db 0AH,0DH,'Hello OSTA!',0AH,0DH,00H
go:
MOV SI,msg
CALL putstr






;You should not write after here¡£
RET


