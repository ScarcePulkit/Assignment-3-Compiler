%{
#include<stdio.h> 
#include<stdlib.h>
#include<math.h>
#include<string.h>
#include <stdbool.h>

char curid[200];
int d = 0;
int m = 0;
char* temp;
int val = 0;
int err = 0;

struct Date{
    char id[200];
    int k;
    int v;
};

struct Date* initialise(){
    struct Date* new = malloc(sizeof(struct Date));
    new->v = 0;
    new->k = 0;
    return new;
}

struct Date* dat[31][13];

bool flag = false;
%}

%x DOL
%x SPACE1
%x DATE
%x SL
%x MONTH
%x SPACE2
%x SC
%x VAL
%%
\/\/.*[\n] {;}
[\n] {;}
[  \t]* {;}
\$ {BEGIN DOL;}
<DOL>[  \t]* {;}
<DOL>[A-Z]+[0-9]+ {strcpy(curid,yytext); BEGIN SPACE1;}
<DOL>. {;}
<DOL>[\n] {;}
<SPACE1>[  \t]+ {BEGIN DATE;}
<DATE>[0-9][0-9] {  temp = yytext; 
                    d = atoi(temp);
                    if(d <= 0 || d > 30){
                        flag = true;
                        fprintf(yyout,"%d",err);
                        exit(0);
                    }
                    BEGIN SL;
                    }
<SL>\/ {BEGIN MONTH;}
<MONTH>[0-9][0-9] { temp = yytext; 
                    m = atoi(temp);
                    if(m <= 0 || m > 12){
                        flag = true;
                        fprintf(yyout,"%d",err);
                        exit(0);
                    }
                    BEGIN SPACE2;
                    }
<SPACE2>[ \t]+ {BEGIN VAL;}
<SPACE2>. {;}
<VAL>[0-9]+ {temp = yytext; 
            val = atoi(temp); 
            BEGIN SC;}
<SC>;[ \t]*\$ {if(val > dat[d][m]->v){
                    dat[d][m]->v = val;
                    strcpy(dat[d][m]->id,curid);
                }
                dat[d][m]->k++;
                BEGIN DOL;}
<SC>;[ \t]*\n {if(val > dat[d][m]->v){
                dat[d][m]->v = val;
                strcpy(dat[d][m]->id,curid);
            }
            dat[d][m]->k++;
            BEGIN 0;}
<SC>;[ \t]* {if(val > dat[d][m]->v){
                    dat[d][m]->v = val;
                    strcpy(dat[d][m]->id,curid);
                }
                dat[d][m]->k++;
                BEGIN DATE;}
. {;}
%%

int yywrap()
{ 
    return 1;
}

main(){
    for(int i = 0; i<31; i++)
        for(int j = 0; j<13; j++)
            dat[i][j] = initialise();
    yyin = fopen("data.txt","r");
    yyout = fopen("output.txt","w");
    yylex();

    FILE *ptr;
    ptr = fopen("input.txt","r");

    if (NULL == ptr) {
        printf("file can't be opened \n");
    }

    char ch='!';
    
    int x=0,y=0;
    while(ch!= EOF){
        ch = fgetc(ptr);
        if(ch == '/'){
            y = x;
            x = 0;
            continue;
        }
        if(ch >='0' && ch<= '9'){
            x = x*10 + (ch - '0');
            continue;
        }
    }
    fprintf(yyout,"$%d$%s#",dat[y][x]->k,dat[y][x]->id);
}