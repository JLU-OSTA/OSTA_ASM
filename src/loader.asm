;本程序由OSTA学术部编辑完成，并开放源代码。
;程序汇编源码使用开源汇编器NASM的语法，针对32位CPU编写
;使用特别协议开放源代码。
ORG 0x8200
start:
MOV AX,00H  ;使AX置零，用于置零数据段寄存器
MOV DS,AX   ;设置数据段寄存器到RAM第一段
MOV AH,0FH  ;BIOS显示服务中断0FH参数：读取显示器模式，显示模式存入AL，AH存页码
INT 10H     ;调用BIOS显示服务中断
JMP tz1     ;进行第一次设计跳转
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
;定义msg字节型数据
;ASCII码中0AH表示换行，0DH表示回车，这里00H用于检验字符串结尾
;这一段是欢迎语
tz1:        ;跳过数据段标号
MOV SI,wel  ;准备输出字符段
CALL settext;初始化文本显示模式子函数
CALL putstr ;调用子程序putstr：输出文本
CALL getcmd ;调用子程序getcmd：获得输入
CALL user   ;调用用户子程序
JMP pass
wel1 db 0AH,0DH,'OK!Press ENTER to reboot...',0AH,0DH,00H
pass:
MOV SI,wel1
CALL putstr
CALL getcmd
JMP start

settext:    ;settext设置字符显示模式子函数
MOV AH,00H  ;BIOS显示服务中断00H参数：设置显示器模式，此时AL作为显示器模式参数，AL=00H表示40x25的16色文本模式
INT 10H     ;调用BIOS显示服务中断
RET         ;返回CALL处

putstr:     ;标号，便于获取子程序putstr的地址：输出字符子程序
MOV AL,[SI] ;字符送入AL中，用于10H中断
INC SI      ;准备送入下一个字符
OR AL,AL    ;按位逻辑取或，用于检验AL中是否为0，若为0，flags寄存器中ZF标志位置1，便于下面的判断
JZ putstrd  ;当ZF标志位为1时跳转到putstr，即当AL中为零时跳转到putstrd标号处，结束putstr输出
MOV AH,0EH  ;BIOS显示服务中断0EH参数：显示字符并光标前移，字符在AL中，前景色在BL中
MOV BL,07H  ;BIOS显示服务中断显示光标参数：前景色存入BL中
INT 10H     ;调用BIOS显示服务中断
JMP putstr  ;跳回putstr标号处，显示下一个字符
putstrd:    ;标号，用于必要时跳过上一句
RET        ;返回CALL处，但不从堆栈中弹回CS寄存器，用于短跳转

getcmd:     ;标号，便于获取子程序getcmd的地址：获取输入子程序
getkey:     ;标号，此处存放获取按键代码
MOV AH,00H  ;BIOS键盘服务中断00H参数：读基本键盘，数据存放在AL中
int 16H     ;调用BIOS键盘服务中断
key_buffer: ;标号，此处存放键盘缓冲器代码
CMP AL,0DH  ;检查回车键，当CPM对象相等时，ZF寄存器置1，相当于SUBB AL,0DH但不修改AL值
JE endcmd   ;当上式相等(ZF=1)时跳至endcmd标号，结束getcmd子程序
JMP echochar;调用echochar子程序，回显字符
endcmd:     ;标号用于字符串未回车时跳过回显字符过程
RET         ;返回CALL处
echochar:   ;标号，字符回显子程序
MOV AH,0EH  ;BIOS显示服务中断0EH参数：显示字符并光标前移，字符在AL中，前景色在BL中
MOV BL,07H  ;BIOS显示服务中断显示光标参数：前景色存入BL中
INT 10H     ;调用BIOS显示服务中断
JMP getcmd  ;返回读取下一个输入

%include 'user.asm'

ends:
