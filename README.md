# SaneQL-to-SQL-compiler-conversion-using-lex-and-yacc

This project is a SaneQL (a simple and Expressive Query Language) to MySQL converter implemented using Yacc and Lex. It allows users to convert SaneQL queries into equivalent MySQL queries. The code is limited to specific SaneQl queries and can be modified to include more.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)


## Introduction

The SaneQL to MySQL Converter is a tool for translating SaneQL queries into MySQL format. It leverages Lex and Yacc for lexical and syntax analysis, respectively, providing an efficient way to convert SaneQL queries into MySQL queries.

## Features

- Lexical analysis using Lex.
- Syntax analysis using Yacc.
- Conversion of SaneQL queries to MySQL format.
- Basic error handling for malformed queries.

## Requirements

- Flex (Lex)
- Bison (Yacc)
- GCC (or any C compiler)
- MySQL (optional, for testing converted queries)

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/SaneQL-to-SQL-compiler-conversion-using-lex-and-yacc.git
    cd saneql-to-mysql-converter
    ```

2. Compile the Lex and Yacc files:
    ```sh
    flex saneql_lex.l
    bison -d saneql_yacc.y
    gcc lex.yy.c y.tab.c -o saneql_to_mysql -ll
    ```
