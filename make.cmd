@echo off
echo ���ű��� @OSTA ����
echo ���ޱ�����ͱ�Ŀ¼�ṹʹ�ã��ű����ݾ��в�����ֲ��
echo ����:�����û����Դ�ļ����ɲ���ϵͳ��
pause
echo ...
nasm .\src\boot.asm -o .\src\boot.img
echo �������������̽�����
echo ...
nasm .\src\loader.asm -o .\src\union.img
echo ���ִ��ϵͳ���û��������ϻ�����ִ�н�����
echo ...
copy .\src\boot.img+.\src\union.img system.img
echo �������������϶������ļ���װ���̽�����
echo ...
echo �ټ���
echo ...
pause
@echo on
exit