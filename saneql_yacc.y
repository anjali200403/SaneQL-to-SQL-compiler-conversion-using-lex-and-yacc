%{
#include <stdio.h>
#include<stdlib.h>
#include <stdbool.h>
#include<string.h>

void yyerror (const char *str) {
	fprintf(stderr, "error: %s\n", str);
}

int yywrap() {
	return 1;
}

int main() {
	yyparse();
}



char val[2000]="*";
char query[30000]="@";
bool ob=false,gb=false,j=false;
char order[500];
char group[500];
char join[2000];
char join_help[2000];

%}




%token FILTER GROUPBY ORDERBY LPAREN RPAREN COLON EQ DOT;
%token <str>IDENTIFIER;
%token JOIN PROJECT OP ROP COMMA CLP CRP DESC TABLE LET AND;
%token SUM AVG COUNT AGGREGATE MAP EXTRACT AS;
%token FC INTEGER TEXT OPERATOR TYPE DATE INTERVAL;
%token ISIDENTICAL EXCEPT UNION T F ALL STRING DIGIT;

%union {
    int num;
    char *str;
}
%type <str> expr;


%%

line: IDENTIFIER filters  { printf("\nSyntax Correct\n\n");
                            printf("select %s from %s ",val,$1);
                            if(ob){
                               printf("order by %s ",order);
                            }
                            if(gb){
                               printf("group by %s",group);
                            
                            }
                            if(j){
                               printf("inner join %s on %s",join,join_help);
                            }
                            printf(";\n");
                            exit(0); } 
      | TABLE LPAREN CLP identifiers CRP RPAREN { printf("\nSyntax Correct\n");exit(0); } 
      | LET IDENTIFIER COLON EQ IDENTIFIER filters  { printf("\nSyntax Correct\n");exit(0); }
      | line COMMA line { printf("\nSyntax Correct\n");exit(0); }
      | LET IDENTIFIER COLON EQ foreign  { printf("\nSyntax Correct\n");exit(0); }| LET identical  { printf("\nSyntax Correct\n");exit(0); };

identical:ISIDENTICAL LPAREN IDENTIFIER TABLE COMMA IDENTIFIER TABLE RPAREN COLON EQ except union aggregate COMMA iden_query;

except: IDENTIFIER DOT EXCEPT LPAREN IDENTIFIER COMMA ALL COLON EQ T RPAREN;

union: DOT UNION LPAREN except RPAREN;

aggregate:DOT AGGREGATE LPAREN COUNT LPAREN RPAREN RPAREN EQ IDENTIFIER;

iden_query: ISIDENTICAL LPAREN IDENTIFIER COMMA IDENTIFIER RPAREN;

foreign: FC LPAREN IDENTIFIER COMMA foreign_help COMMA CLP expr CRP RPAREN
        |FC LPAREN IDENTIFIER COMMA foreign_help COMMA CLP expr CRP COMMA TYPE COLON EQ OPERATOR RPAREN;

foreign_help: INTEGER
             |TEXT;

filters: DOT FILTER LPAREN filter_expr RPAREN filters
         | DOT GROUPBY LPAREN groupby_expr RPAREN filters {gb=true;}
         | DOT ORDERBY LPAREN CLP expr CRP RPAREN filters {strcpy(order,$5);ob=true;} 
         |DOT PROJECT LPAREN CLP expr CRP RPAREN filters {if(strcmp(val,"*")==0){
                                                               strcpy(val,$5);
                                                           }else{
                                                               strcat(val,",");
                                                               strcat(val,$5);
                                                           }}      
         |DOT JOIN LPAREN join_expr RPAREN filters {j=true;}
         |DOT AGGREGATE LPAREN aggr_expr RPAREN filters
         |DOT MAP LPAREN CLP map_expr CRP RPAREN filters 
         |;

oper: OP | ROP | ROP EQ | EQ;

filter_expr: IDENTIFIER ROP STRING COLON COLON DATE OP IDENTIFIER COLON COLON INTERVAL
            |IDENTIFIER ROP EQ STRING COLON COLON DATE OP IDENTIFIER COLON COLON INTERVAL;

expr: IDENTIFIER {strcpy($$,$1);} 
     | IDENTIFIER COMMA expr {strcat($1,",");strcat($1,$3);strcpy($$,$1);} ;

map_expr: IDENTIFIER COLON EQ map_help map_expr
        | COMMA IDENTIFIER COLON EQ map_help map_expr 
        | ;

map_help: LPAREN map_help RPAREN 
        | map_help OP map_help 
        | IDENTIFIER
        | IDENTIFIER DOT EXTRACT LPAREN IDENTIFIER RPAREN; 

aggr_expr: SUM LPAREN aggr_help RPAREN | AVG LPAREN aggr_help RPAREN | COUNT LPAREN IDENTIFIER RPAREN ;

aggr_help: IDENTIFIER | IDENTIFIER OP IDENTIFIER;

join_expr: IDENTIFIER COMMA IDENTIFIER EQ IDENTIFIER join_help {strcpy(join,$1);
                                                                strcpy(join_help,$3);
                                                                strcat(join_help,"=");
                                                                strcat(join_help,$5);
                                                               }
         | IDENTIFIER DOT FILTER LPAREN identifiers RPAREN filters join_help 
         | IDENTIFIER DOT AS LPAREN IDENTIFIER RPAREN filters join_help;

join_help: AND IDENTIFIER EQ IDENTIFIER join_help {strcat(join_help," and ");
                                                   strcat(join_help,$2);
                                                   strcat(join_help," = ");
                                                   strcat(join_help,$4);
                                                  }
          | ; 

groupby_expr: CLP expr CRP COMMA CLP IDENTIFIER COLON EQ groupby_help CRP {strcpy(group,$2);} ;

groupby_help: SUM LPAREN IDENTIFIER RPAREN func{
                                                char sum[200]="";
                                                strcat(sum,"sum(");
                                                strcat(sum,$3);
                                                strcat(sum,")");
                                                if(strcmp(val,"*")==0){
                                                    strcpy(val,sum);
                                                }else{
                                                    strcat(val,",");
                                                    strcat(val,sum);
                                                }}
            | AVG LPAREN IDENTIFIER RPAREN func{
                                                char avg[200]="";
                                                strcat(avg,"avg(");
                                                strcat(avg,$3);
                                                strcat(avg,")");
                                                if(strcmp(val,"*")==0){
                                                    strcpy(val,avg);
                                                }else{
                                                    strcat(val,",");
                                                    strcat(val,avg);
                                                }}
            | COUNT LPAREN RPAREN func{if(strcmp(val,"*")==0){
                                            strcpy(val,(" count(*)"));
                                       }else{
                                            strcat(val,",");
                                            strcat(val,(" count(*)"));
                                       }};

func: COMMA groupby_help | ;
 
identifiers:identifiers COMMA identifiers 
           | CLP identifiers CRP 
           | IDENTIFIER COLON EQ identifiers 
           | identifiers oper identifiers 
           | IDENTIFIER 
           | LPAREN identifiers RPAREN;



%%
