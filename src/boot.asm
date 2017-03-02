;本程序由OSTA学术部编辑完成，并开放源代码。
;程序汇编源码使用开源汇编器NASM的语法，针对32位CPU编写
;使用特别协议开放源代码。

ORG 7C00H  ;伪指令定义代码位置，BIOS控制CPU从7C00H处开始引导
CYLS equ 0AH
boot:      ;启动处标号，方便取址
MOV AX,0820H
MOV ES,AX
MOV CH,00H
MOV DH,00H
MOV CL,02H
readloop:
MOV SI,0000H
retry:
MOV AH,02H
MOV AL,01H
MOV BX,0000H
MOV DL,00H
INT 13H
JNC next
INC SI
CMP SI,0005H
JAE boot
MOV AH,00H
MOV DL,00H
INT 13H
JMP retry
next:
MOV AX,ES
ADD AX,0020H
MOV ES,AX
INC CL
CMP CL,12H
JBE readloop
MOV CL,01H
INC DH
CMP DH,02H
JB readloop
MOV DH,00H
INC CH
CMP CH,CYLS
JB readloop

;JMP 0x0820:0
size equ $-boot
;获取当前位置到start标号处的字节数
%if size+2 >512
;当字节数+2(包含boot分区结束标识2字节)大于一个扇区时由汇编器执行
%error "代码超过机器引导区大小"
;输出错误信息
%endif
;结束假设
times (512-size-2) db 0
;重复按字节填充0x00，直到为512字节保留2字节
db 55H,0AAH
;引导区结尾标识:0x55aa
