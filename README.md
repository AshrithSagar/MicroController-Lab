# MicroController-Lab

![GitHub](https://img.shields.io/github/license/AshrithSagar/MicroController-Lab) ![GitHub repo size](https://img.shields.io/github/repo-size/AshrithSagar/MicroController-Lab) [![CodeFactor](https://www.codefactor.io/repository/github/AshrithSagar/MicroController-Lab/badge)](https://www.codefactor.io/repository/github/AshrithSagar/MicroController-Lab)

Using Intel 8051 Assembly language

## File naming convention

- E2_E5  => *E*xperiment *2*, *E*xample *5*
- E4_X1  => *E*xperiment *4*, *E*xercise *1*
- E3_P6  => *E*xperiment *3*, *P*ractice problem *6*

# 8051 Assembly setup

## On macOS

Refer to this [8051 Assembly Workflow in macOS](https://mlg556.github.io/posts/8051-assembly-workflow-in-macos/8051-assembly-workflow-in-macos.html) to setup tools for 8051 Assembly.

### Setup

1. [C51ASM compiler ](https://mlg556.github.io/downloads/2019-02-14-8051-assembly-workflow-in-macos/c51asm_macosx_1-2.zip)

1. [8051 emulator](http://sol.gfxile.net/8051.html)

### Running

```shell
c51asm my_file.asm
```

## On Linux

Use [as31](https://manpages.ubuntu.com/manpages/trusty/man1/as31.1.html) - An Intel 8031/8051 assembler.

_On Debian/Ubuntu systems_
```shell
sudo apt update
sudo apt install as31
as31 -h
```

## On Windows

Download C51 demo from [Keil-c51](https://www.keil.com/demo/eval/c51.htm).

# License

This project falls under the MIT license.
