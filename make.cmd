@echo off
echo 本脚本由 @OSTA 创作
echo 仅限本程序和本目录结构使用，脚本内容具有不可移植性
echo 功能:根据用户汇编源文件生成操作系统。
pause
echo ...
nasm .\src\boot.asm -o .\src\boot.img
echo 引导扇区汇编过程结束。
echo ...
nasm .\src\loader.asm -o .\src\union.img
echo 汇编执行系统与用户程序联合汇编过程执行结束。
echo ...
copy .\src\boot.img+.\src\union.img system.img
echo 引导扇区与联合二进制文件组装过程结束。
echo ...
echo 再见！
echo ...
pause
@echo on
exit