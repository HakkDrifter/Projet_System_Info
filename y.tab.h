/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tMAIN = 258,
    tINT = 259,
    tEQ = 260,
    tIF = 261,
    tELSE = 262,
    tWHILE = 263,
    tPF = 264,
    tPO = 265,
    tAF = 266,
    tPV = 267,
    tVR = 268,
    tAO = 269,
    tADD = 270,
    tSUB = 271,
    tMUL = 272,
    tDIV = 273,
    tPRINTF = 274,
    tCONST = 275,
    tEQEQ = 276,
    tSUP = 277,
    tINF = 278,
    tID = 279,
    tVALINT = 280
  };
#endif
/* Tokens.  */
#define tMAIN 258
#define tINT 259
#define tEQ 260
#define tIF 261
#define tELSE 262
#define tWHILE 263
#define tPF 264
#define tPO 265
#define tAF 266
#define tPV 267
#define tVR 268
#define tAO 269
#define tADD 270
#define tSUB 271
#define tMUL 272
#define tDIV 273
#define tPRINTF 274
#define tCONST 275
#define tEQEQ 276
#define tSUP 277
#define tINF 278
#define tID 279
#define tVALINT 280

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 8 "compile.y" /* yacc.c:1909  */

    int nb;
    char * str;

#line 109 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
