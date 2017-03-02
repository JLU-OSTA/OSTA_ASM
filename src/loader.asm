;��������OSTAѧ�����༭��ɣ�������Դ���롣
;������Դ��ʹ�ÿ�Դ�����NASM���﷨�����32λCPU��д
;ʹ���ر�Э�鿪��Դ���롣
ORG 0x8200
start:
MOV AX,00H  ;ʹAX���㣬�����������ݶμĴ���
MOV DS,AX   ;�������ݶμĴ�����RAM��һ��
MOV AH,0FH  ;BIOS��ʾ�����ж�0FH��������ȡ��ʾ��ģʽ����ʾģʽ����AL��AH��ҳ��
INT 10H     ;����BIOS��ʾ�����ж�
JMP tz1     ;���е�һ�������ת
wel db 0AH,0DH
db 'Printing test:',0AH,0DH
db 'OSTA is bang bang da!................OK!',0AH,0DH,0AH,0DH
db '****************************************',0AH,0DH
db '*   Here is OSTA ASM System runner!    *',0AH,0DH
db '*Version:                         V0.1 *',0AH,0DH
db '*Designed:                        OSTA *',0AH,0DH
db '*You can get my source code by OSTA.   *',0AH,0DH
db '****************************************',0AH,0DH,0AH,0DH
db 'You can use putstr to print SI pointed. ',0AH,0DH,
db 'Press ENTER, you will see your design...',0AH,0DH,00H
;����msg�ֽ�������
;ASCII����0AH��ʾ���У�0DH��ʾ�س�������00H���ڼ����ַ�����β
;��һ���ǻ�ӭ��
tz1:        ;�������ݶα��
MOV SI,wel  ;׼������ַ���
CALL settext;��ʼ���ı���ʾģʽ�Ӻ���
CALL putstr ;�����ӳ���putstr������ı�
CALL getcmd ;�����ӳ���getcmd���������
CALL user   ;�����û��ӳ���
JMP pass
wel1 db 0AH,0DH,'OK!Press ENTER to reboot...',0AH,0DH,00H
pass:
MOV SI,wel1
CALL putstr
CALL getcmd
JMP start

settext:    ;settext�����ַ���ʾģʽ�Ӻ���
MOV AH,00H  ;BIOS��ʾ�����ж�00H������������ʾ��ģʽ����ʱAL��Ϊ��ʾ��ģʽ������AL=00H��ʾ40x25��16ɫ�ı�ģʽ
INT 10H     ;����BIOS��ʾ�����ж�
RET         ;����CALL��

putstr:     ;��ţ����ڻ�ȡ�ӳ���putstr�ĵ�ַ������ַ��ӳ���
MOV AL,[SI] ;�ַ�����AL�У�����10H�ж�
INC SI      ;׼��������һ���ַ�
OR AL,AL    ;��λ�߼�ȡ�����ڼ���AL���Ƿ�Ϊ0����Ϊ0��flags�Ĵ�����ZF��־λ��1������������ж�
JZ putstrd  ;��ZF��־λΪ1ʱ��ת��putstr������AL��Ϊ��ʱ��ת��putstrd��Ŵ�������putstr���
MOV AH,0EH  ;BIOS��ʾ�����ж�0EH��������ʾ�ַ������ǰ�ƣ��ַ���AL�У�ǰ��ɫ��BL��
MOV BL,07H  ;BIOS��ʾ�����ж���ʾ��������ǰ��ɫ����BL��
INT 10H     ;����BIOS��ʾ�����ж�
JMP putstr  ;����putstr��Ŵ�����ʾ��һ���ַ�
putstrd:    ;��ţ����ڱ�Ҫʱ������һ��
RET        ;����CALL���������Ӷ�ջ�е���CS�Ĵ��������ڶ���ת

getcmd:     ;��ţ����ڻ�ȡ�ӳ���getcmd�ĵ�ַ����ȡ�����ӳ���
getkey:     ;��ţ��˴���Ż�ȡ��������
MOV AH,00H  ;BIOS���̷����ж�00H���������������̣����ݴ����AL��
int 16H     ;����BIOS���̷����ж�
key_buffer: ;��ţ��˴���ż��̻���������
CMP AL,0DH  ;���س�������CPM�������ʱ��ZF�Ĵ�����1���൱��SUBB AL,0DH�����޸�ALֵ
JE endcmd   ;����ʽ���(ZF=1)ʱ����endcmd��ţ�����getcmd�ӳ���
JMP echochar;����echochar�ӳ��򣬻����ַ�
endcmd:     ;��������ַ���δ�س�ʱ���������ַ�����
RET         ;����CALL��
echochar:   ;��ţ��ַ������ӳ���
MOV AH,0EH  ;BIOS��ʾ�����ж�0EH��������ʾ�ַ������ǰ�ƣ��ַ���AL�У�ǰ��ɫ��BL��
MOV BL,07H  ;BIOS��ʾ�����ж���ʾ��������ǰ��ɫ����BL��
INT 10H     ;����BIOS��ʾ�����ж�
JMP getcmd  ;���ض�ȡ��һ������

%include 'user.asm'

ends:
