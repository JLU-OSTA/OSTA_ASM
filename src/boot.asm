;��������OSTAѧ�����༭��ɣ�������Դ���롣
;������Դ��ʹ�ÿ�Դ�����NASM���﷨�����32λCPU��д
;ʹ���ر�Э�鿪��Դ���롣

ORG 7C00H  ;αָ������λ�ã�BIOS����CPU��7C00H����ʼ����
CYLS equ 0AH
boot:      ;��������ţ�����ȡַ
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
;��ȡ��ǰλ�õ�start��Ŵ����ֽ���
%if size+2 >512
;���ֽ���+2(����boot����������ʶ2�ֽ�)����һ������ʱ�ɻ����ִ��
%error "���볬��������������С"
;���������Ϣ
%endif
;��������
times (512-size-2) db 0
;�ظ����ֽ����0x00��ֱ��Ϊ512�ֽڱ���2�ֽ�
db 55H,0AAH
;��������β��ʶ:0x55aa
