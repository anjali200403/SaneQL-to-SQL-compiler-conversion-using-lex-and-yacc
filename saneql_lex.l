%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}

%%
filter {
    printf("Token: FILTER, Value: '%s'\n", yytext);
    return FILTER;
}
groupby {
    printf("Token: GROUPBY, Value: '%s'\n", yytext);
    return GROUPBY;
}
orderby {
    printf("Token: ORDERBY, Value: '%s'\n", yytext);
    return ORDERBY;
}
join {
    printf("Token: JOIN, Value: '%s'\n", yytext);
    return JOIN;
}
project {
    printf("Token: PROJECT, Value: '%s'\n", yytext);
    return PROJECT;
}
table {
    printf("Token: TABLE, Value: '%s'\n", yytext);
    return TABLE;
}
aggregate {
    printf("Token: AGGREGATE, Value: '%s'\n", yytext);
    return AGGREGATE;
}
map {
    printf("Token: MAP, Value: '%s'\n", yytext);
    return MAP;
}
let {
    printf("Token: LET, Value: '%s'\n", yytext);
    return LET;
}
desc {
    printf("Token: DESC, Value: '%s'\n", yytext);
    return DESC;
}
extract {
    printf("Token: EXTRACT, Value: '%s'\n", yytext);
    return EXTRACT;
}
date {
    printf("Token: DATE, Value: '%s'\n", yytext);
    return DATE;
}
interval {
    printf("Token: INTERVAL, Value: '%s'\n", yytext);
    return INTERVAL;
}
as {
    printf("Token: AS, Value: '%s'\n", yytext);
    return AS;
}
foreigncall {
    printf("Token: FC, Value: '%s'\n", yytext);
    return FC;
}
type {
    printf("Token: TYPE, Value: '%s'\n", yytext);
    return TYPE;
}
integer {
    printf("Token: INTEGER, Value: '%s'\n", yytext);
    return INTEGER;
}
text {
    printf("Token: TEXT, Value: '%s'\n", yytext);
    return TEXT;
}
operator {
    printf("Token: OPERATOR, Value: '%s'\n", yytext);
    return OPERATOR;
}
isidentical {
    printf("Token: ISIDENTICAL, Value: '%s'\n", yytext);
    return ISIDENTICAL;
}
except {
    printf("Token: EXCEPT, Value: '%s'\n", yytext);
    return EXCEPT;
}
union {
    printf("Token: UNION, Value: '%s'\n", yytext);
    return UNION;
}
true {
    printf("Token: TRUE, Value: '%s'\n", yytext);
    return T;
}
false {
    printf("Token: FALSE, Value: '%s'\n", yytext);
    return F;
}
all {
    printf("Token: ALL, Value: '%s'\n", yytext);
    return ALL;
}
&& {
    printf("Token: AND, Value: '%s'\n", yytext);
    return AND;
}
sum {
    printf("Token: SUM, Value: '%s'\n", yytext);
    return SUM;
}
avg {
    printf("Token: AVG, Value: '%s'\n", yytext);
    return AVG;
}
count {
    printf("Token: COUNT, Value: '%s'\n", yytext);
    return COUNT;
}
\( {
    printf("Token: LPAREN, Value: '%s'\n", yytext);
    return LPAREN;
}
\) {
    printf("Token: RPAREN, Value: '%s'\n", yytext);
    return RPAREN;
}
\{ {
    printf("Token: CLP, Value: '%s'\n", yytext);
    return CLP;
}
\} {
    printf("Token: CRP, Value: '%s'\n", yytext);
    return CRP;
}
: {
    printf("Token: COLON, Value: '%s'\n", yytext);
    return COLON;
}
, {
    printf("Token: COMMA, Value: '%s'\n", yytext);
    return COMMA;
}
[+|-|*|/] {
    printf("Token: OP, Value: '%s'\n", yytext);
    return OP;
}
[>|<] {
    printf("Token: ROP, Value: '%s'\n", yytext);
    return ROP;
}
= {
    printf("Token: EQ, Value: '%s'\n", yytext);
    return EQ;
}
[0-9]+ {
    printf("Token: DIGIT, Value: '%s'\n", yytext);
    return DIGIT;
}
[a-zA-Z_][a-zA-Z0-9_]+ {
    yylval.str = strdup(yytext);
    printf("Token: IDENTIFIER, Value: '%s'\n", yytext);
    return IDENTIFIER;
}
\. {
    printf("Token: DOT, Value: '%s'\n", yytext);
    return DOT;
}
\n {
    printf("Token: NEWLINE, Value: '%s'\n", yytext);
    return *yytext;
}
[ \t]+ {
    // Ignore whitespace
}

