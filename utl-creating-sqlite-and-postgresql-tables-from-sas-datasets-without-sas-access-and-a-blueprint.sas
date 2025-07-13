%let pgm=utl-creating-sqlite-and-postgresql-tables-from-sas-datasets-without-sas-access-and-a-blueprint;

%stop_submission;

Creating sqlite and postgreSQL tables from sas datasets dropdowns to sqlite and postgreSQL without sas access
Blueprint for any databse access from sas without sas access
Best run with the classic editor, note the display manager 'DM' commands.

github
https://tinyurl.com/5mpbc23d
https://github.com/rogerjdeangelis/utl-creating-sqlite-and-postgresql-tables-from-sas-datasets-without-sas-access-and-a-blueprint

MACROS
======

Line location and macro used in this post. consider putting these in an autocall folder.

Editor
Line    Macro                   Action

264     macro utl_pgbegin       drop down to postgresql
275     macro utl_pgend

428     macro utl_sqbegin       drop down to sqlite
435     macro utl_sqend

760     macro utl_tagsets_sql   generates create table and all the inserts for proc sql (wordy)
                                you only need to run once and save the template in sasuser

948     macro utl_sqlinsert     standardize create inserts script for 12 database, about the same size as csv but has data types

1022    macro utl_pgcsvtyp      posgresql uses meta data to create a sas table with data tyeping
1221    macro utl_sqcsvtyp      sqlitel   uses meta data to create a sas table with data tyeping


The following are ot included in this post, you need to get them from https://tinyurl.com/y9nfugth

utlfkil           delete a file
utl_optlenpos     optimize sas variable lengths
array             macro arrays  (Ted Clay)
do_over           macro do loop for macro arrays
utl_close         just a precaution - closes all temp open files including ft15f001. Prevents freezes, file in use freeze.

All macros can be found at
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories


SOAPBOX ON

Be skepticle, it is my understanding?

Someone should publish a book on what cannot be done, it would save a lot of programmer time.

This repo solves these issues
=============================

   1 postgreSQL: It's not possible to import a CSV file into a PostgreSQL table
      using psql CLI without first creating the table structure, names and datatypes.

   2 Sqlite: It's not possible to import a CSV file with numeric data into a sqlite table
     using sqlite CLI. without first creating the table structure, names and datatypes.
     All columns are created with the TEXT data type by default,
     regardless of whether the CSV contains numbers, text, or a mix of both.
     SQLite does not auto-detect numeric types during the import process.

  3 sqlite3: Column dictionary is not a sqlite table.
    Programmer needs to make a create table template and insert rows from a internal sqlite column dictionary.file?
    You only need to create the template once because it will work for any sqlite table.
    You could place the create code in a permanent file and have it automatically run each time you start the sqlite cli.
    everytime you initiate sqllist3 clli

    Store this somewhere
    Create
       table meta (
           pk real
          ,name varchar(32)
          ,type varchar(32)
          ,dum1 varchar(32)
          ,dum2 varchar(32)
          ,dum3 varchar(32)
     );

    and then yow will need to program this for each sqlite table.
    INSERT INTO meta SELECT * FROM pragma_table_info('stats');

IMPORTANT NOTE

    1  postgreSQL comes with a builtin admin user account, postgres. I am using tis account here.
    2  postgres comes with an builtin database, template1
    3  sqlite is a simple file based data base and does not need a admin user or builtin database.
       use file security?

SOAPBOX OFF

related github
https://tinyurl.com/yc8h92zw
https://github.com/rogerjdeangelis/sas-macros-to-import-sqlite-tables-with-and-without-data-typing-sas-access-prouct-not-needed

/*               _             _
  ___ ___  _ __ | |_ ___ _ __ | |_ ___
 / __/ _ \| `_ \| __/ _ \ `_ \| __/ __|
| (_| (_) | | | | ||  __/ | | | |_\__ \
 \___\___/|_| |_|\__\___|_| |_|\__|___/
                          _   _       _            _       _   _
  __ _   _ __   __ _ _ __| |_(_) __ _| | ___  ___ | |_   _| |_(_) ___  _ __  ___
 / _` | | `_ \ / _` | `__| __| |/ _` | |/ __|/ _ \| | | | | __| |/ _ \| `_ \/ __|
| (_| | | |_) | (_| | |  | |_| | (_| | |\__ \ (_) | | |_| | |_| | (_) | | | \__ \
 \__,_| | .__/ \__,_|_|   \__|_|\__,_|_||___/\___/|_|\__,_|\__|_|\___/|_| |_|___/
        |_|
*/

1 Manual posgressql solution       individual x commands (you can play with)
2 posrgresql drop down solution    drop down to postgresql and hard code create table inserts

3 Manual sqlite3 solution          individual x commands
4 sqlite3 drop down solution       drop down to sqlite and hard code create table inserts

/*       __       _ _             _       _   _
| |__   / _|_   _| | |  ___  ___ | |_   _| |_(_) ___  _ __  ___
| `_ \ | |_| | | | | | / __|/ _ \| | | | | __| |/ _ \| `_ \/ __|
| |_) ||  _| |_| | | | \__ \ (_) | | |_| | |_| | (_) | | | \__ \
|_.__/ |_|  \__,_|_|_| |___/\___/|_|\__,_|\__|_|\___/|_| |_|___/

*/

5 postgressql - generates the create table inserts data but does not type the variables
6 postgressql - generates the create table inserts data  and does data typing

7 sqlite      - generates the create table inserts data but does not type the variables
8 sqlite      - generates the create table inserts data and does data typing

/*          _                                       _        _   _
  ___    __| | ___   ___ _   _ _ __ ___   ___ _ __ | |_ __ _| |_(_) ___  _ __
 / __|  / _` |/ _ \ / __| | | | `_ ` _ \ / _ \ `_ \| __/ _` | __| |/ _ \| `_ \
| (__  | (_| | (_) | (__| |_| | | | | | |  __/ | | | || (_| | |_| | (_) | | | |
 \___|  \__,_|\___/ \___|\__,_|_| |_| |_|\___|_| |_|\__\__,_|\__|_|\___/|_| |_|

*/

9 postgressql cli options and meta commands
7 sqlite      cli options and meta commands
8 powershell  cli options and meta commands

/*   _            _       _           _
  __| |  _ __ ___| | __ _| |_ ___  __| |  _ __ ___ _ __   ___  ___
 / _` | | `__/ _ \ |/ _` | __/ _ \/ _` | | `__/ _ \ `_ \ / _ \/ __|
| (_| | | | |  __/ | (_| | ||  __/ (_| | | | |  __/ |_) | (_) \__ \
 \__,_| |_|  \___|_|\__,_|\__\___|\__,_| |_|  \___| .__/ \___/|___/
                                                  |_|
*/

9  postgresql
10 sqlite
11 powershell

/*                 _   _       _            _       _   _
  _ __   __ _ _ __| |_(_) __ _| | ___  ___ | |_   _| |_(_) ___  _ __  ___
 | `_ \ / _` | `__| __| |/ _` | |/ __|/ _ \| | | | | __| |/ _ \| `_ \/ __|
 | |_) | (_| | |  | |_| | (_| | |\__ \ (_) | | |_| | |_| | (_) | | | \__ \
 | .__/ \__,_|_|   \__|_|\__,_|_||___/\___/|_|\__,_|\__|_|\___/|_| |_|___/
 |_|
*/

 1 Manual posgressql solution
 2 posrgresql drop down solution
 3 Manual sqlite3 solution
 4 sqlite3 drop down solution

/*                                    _  _ __   ___  ___  __ _ _ __ ___  ___  __ _| |   ___| (_)
/ | _ __ ___   __ _ _ __  _   _  __ _| || `_ \ / _ \/ __|/ _` | `__/ _ \/ __|/ _` | |  / __| | |
| || `_ ` _ \ / _` | `_ \| | | |/ _` | || |_) | (_) \__ \ (_| | | |  __/\__ \ (_| | | | (__| | |
| || | | | | | (_| | | | | |_| | (_| | || .__/ \___/|___/\__, |_|  \___||___/\__, |_|  \___|_|_|
|_||_| |_| |_|\__,_|_| |_|\__,_|\__,_|_||_|              |___/                  |_|

Note: we are using the builtin admin user and builtin database
also note the table test should
*/

%utlfkil(c:/temp/tstcsv.csv)

/*--- run one at a time to intermediate results ----*/
Options xwait xsync;
x 'cmd /K psql -U postgres -d template1 -c "drop table if exists tst"');
x 'cmd /K psql -U postgres -d template1 -c "create
                                               table tst (id real);
                                             insert
                                               into tst(id)
                                             values
                                               (100),(200),(300),(400)"');
x 'cmd /K psql -U postgres -d template1 -c "\dt;"');
x 'cmd /K psql -U postgres -d template1 -c "select * from tst;"');
x 'cmd /k psql -U postgres -d template1 -c "\copy tst to ''c:/temp/tstcsv.csv'' with csv header;"');

dm "dimport 'c:/temp/tstcsv.csv' tst replace";

proc print data=tst;
run;quit;

/**************************************************************************************************************************/
/* POSTGRESQL                          |  CREATE SAS TABLE                                                                 */
/* ======                              |  ================                                                                 */
/*                List of relations    |  dm "dimport 'c:/temp/tstcsv.csv' tst replace";                                   */
/* Schema |  Name  | Type  |  Owner    |                                                                                   */
/* -------+--------+-------+---------- |  SAS work.tst                                                                     */
/* public | tst    | table | postgres  |                                                                                   */
/*                                     |   ID                                                                              */
/*                                     |  100                                                                              */
/*                                     |  200                                                                              */
/*                                     |  300                                                                              */
/*                                     |  400                                                                              */
/***************************************************************************************************************************/

/*___                                              _      _                           _
|___ \   _ __   ___  ___  __ _ _ __ ___  ___  __ _| |  __| |_ __ ___  _ __         __| | _____      ___ __
  __) | | `_ \ / _ \/ __|/ _` | `__/ _ \/ __|/ _` | | / _` | `__/ _ \| `_ \ _____ / _` |/ _ \ \ /\ / / `_ \
 / __/  | |_) | (_) \__ \ (_| | | |  __/\__ \ (_| | || (_| | | | (_) | |_) |_____| (_| | (_) \ V  V /| | | |
|_____| | .__/ \___/|___/\__, |_|  \___||___/\__, |_| \__,_|_|  \___/| .__/       \__,_|\___/ \_/\_/ |_| |_|
        |_|              |___/                  |_|                  |_|

Mcro is after example run;

The create table script is in a separate file that the postgresql will call and execute.
You can insert the create atble script into the inlive sql script, but it
more likely that the script would be too long for inserting.
*/

%utlfkil(c:/temp/tstcsv.csv)

%utl_pgbegin;
parmcards4;
drop table if exists tst;
drop table if exists meta;
\dt
;;;;
%utl_pgend;

/*--- -f has to be the first record ---*/
%utl_pgbegin;
parmcards4;
drop table if exists tst;
create
   table tst (id real);
 insert
   into tst(id)
 values
   (100),(200),(300),(400);
\dt
select * from tst;
\copy tst to 'c:/temp/tstcsv.csv' with csv header;
;;;;
%utl_pgend;

dm "";
dm "dimport 'c:/temp/tstcsv.csv' tst replace";

proc print data=tst;
run;quit;

/**************************************************************************************************************************/
/* POSTGRESQL                          |  CREATE SAS TABLE                                                                 */
/* ======                              |  ================                                                                 */
/*                List of relations    |  dm "dimport 'c:/temp/tstcsv.csv' tst replace";                                   */
/* Schema |  Name  | Type  |  Owner    |                                                                                   */
/* -------+--------+-------+---------- |  SAS work.tst                                                                     */
/* public | tst    | table | postgres  |                                                                                   */
/*                                     |   ID                                                                              */
/*                                     |  100                                                                              */
/*                                     |  200                                                                              */
/*                                     |  300                                                                              */
/*                                     |  400                                                                              */
/***************************************************************************************************************************/
/*               _                            _
 _ __   ___  ___| |_ __ _ _ __ ___  ___  __ _| | _ __ ___   __ _  ___ _ __ ___
| `_ \ / _ \/ __| __/ _` | `__/ _ \/ __|/ _` | || `_ ` _ \ / _` |/ __| `__/ _ \
| |_) | (_) \__ \ || (_| | | |  __/\__ \ (_| | || | | | | | (_| | (__| | | (_) |
| .__/ \___/|___/\__\__, |_|  \___||___/\__, |_||_| |_| |_|\__,_|\___|_|  \___/
|_|                 |___/                  |_|
*/

/*---- this copys macros to c:/oto autocall folder ----*/

filename ft15f001 "c:/oto/utl_pgbegin.sas";
parmcards4;
%macro utl_pgbegin;
%utlfkil(c:/temp/pg_pgm.sql);
%utlfkil(c:/temp/pg_pgmx.sql);
%utlfkil(c:/temp/pg_pgm.log);
filename ft15f001 "c:/temp/pg_pgm.sql";
%mend utl_pgbegin;
;;;;
run;quit;

filename ft15f001 "c:/oto/utl_pgend.sas";
parmcards4;
%macro utl_pgend(returnvar=N);
options noxwait noxsync;
  data _null_;
    length cmd $200;
    infile  "c:/temp/pg_pgm.sql";
    file  "c:/temp/pg_pgmx.sql" ;
    input;
    if left(_infile_) =: '-f ' then do;
      cmd=catx(' ','psql -U postgres -d template1',_infile_);
      putlog cmd;
      rc=system(strip(cmd));
    end;
    else do;
       put _infile_;
    end;
  run;quit;
  filename rut pipe  "psql -U postgres -d template1 -f c:/temp/pg_pgmx.sql > c:/temp/pg_pgm.log";
  data _null_;
    file print;
    infile rut recfm=v lrecl=32756;
    input;
    putlog _infile_;
    put _infile_;
  run;
  filename ft15f001 clear;
  * use the clipboard to create macro variable;
  %if %upcase(%substr(&returnVar.,1,1)) ne N %then %do;
    filename clp clipbrd ;
    data _null_;
     length txt $200;
     infile clp;
     input;
     putlog "macro variable &returnVar = " _infile_;
     call symputx("&returnVar.",_infile_,"G");
    run;quit;
  %end;
data _null_;
  file print;
  infile rut;
  input;
  put _infile_;
  putlog _infile_;
run;quit;
data _null_;
  infile "c:/temp/pg_pgm.log";
  input;
  putlog _infile_;
run;quit;
filename ft15f001 clear;
%mend utl_pgend;
;;;;
run;quit;

/*____                                     _             _ _ _       _____
|___ /   _ __ ___   __ _ _ __  _   _  __ _| |  ___  __ _| (_) |_ ___|___ /
  |_ \  | `_ ` _ \ / _` | `_ \| | | |/ _` | | / __|/ _` | | | __/ _ \ |_ \
 ___) | | | | | | | (_| | | | | |_| | (_| | | \__ \ (_| | | | ||  __/___) |
|____/  |_| |_| |_|\__,_|_| |_|\__,_|\__,_|_| |___/\__, |_|_|\__\___|____/
                                                      |_|
*/

%utl_close;

/*---- make sure you delete database between runs ---*/
%utlfkil(c:/temp/tst.db);
%utlfkil(c:/temp/tstcsv.csv);


x 'cmd /K sqlite3 c:/temp/tst.db "create
                                     table tst (id real);
                                  insert
                                    into tst(id)
                                  values
                                    (100),(200),(300),(400);"');
x 'cmd /K sqlite3 c:/temp/tst.db ".tables"';
x 'cmd /K sqlite3 c:/temp/tst.db "select * from tst"';
x 'cmd /K sqlite3 c:/temp/tst.db "PRAGMA table_info(''tst'');"';
x 'cmd /K sqlite3 c:/temp/tst.db -csv -header "select * from tst;" > c:/temp/tstcsv.csv';

dm "dimport 'c:/temp/tstcsv.csv' tst replace";

proc print data=tst;
run;quit;

/**************************************************************************************************************************/
/*  sqlite3                       |    SAS                                                                                */
/*                                |                                                                                       */
/*  .tables                       |                                                                                       */
/*  =======                       |                                                                                       */
/*  tst                           |     ID     Variable    Type    Len    Format     Informat                             */
/*                                |                                                                                       */
/*  select * from tst             |    100     ID          Num       8    BEST12.    BEST32.                              */
/*                                |    200                                                                                */
/*  100.0                         |    300                                                                                */
/*  200.0                         |    400                                                                                */
/*  300.0                         |                                                                                       */
/*  400.0                         |                                                                                       */
/**************************************************************************************************************************/

/*  _               _ _ _       _____      _                           _
| || |    ___  __ _| (_) |_ ___|___ /   __| |_ __ ___  _ __         __| | _____      ___ __
| || |_  / __|/ _` | | | __/ _ \ |_ \  / _` | `__/ _ \| `_ \ _____ / _` |/ _ \ \ /\ / / `_ \
|__   _| \__ \ (_| | | | ||  __/___) || (_| | | | (_) | |_) |_____| (_| | (_) \ V  V /| | | |
   |_|   |___/\__, |_|_|\__\___|____/  \__,_|_|  \___/| .__/       \__,_|\___/ \_/\_/ |_| |_|
                 |_|                                  |_|
macro is after example usage

*/

%utlfkil(c:/temp/tst.db);
%utlfkil(c:/temp/tstcsv.csv);

%utl_sqbegin;
parmcards4;
.open c:/temp/tst.db
.tables
drop table if exists tst;
create
   table tst (id real);
 insert
   into tst(id)
 values
   (100),(200),(300),(400);
select * from tst;
.headers on
.mode csv
.output c:/temp/tstcsv.csv
SELECT * FROM tst;
.output stdout
;;;;
%utl_sqend;

dm "";
dm "dimport 'c:/temp/tstcsv.csv' tst replace";

proc print data=tst;
run;quit;


/**************************************************************************************************************************/
/*  sqlite3                       |    SAS                                                                                */
/*                                |                                                                                       */
/*  .tables                       |                                                                                       */
/*  =======                       |                                                                                       */
/*  tst                           |     ID     Variable    Type    Len    Format     Informat                             */
/*                                |                                                                                       */
/*  select * from tst             |    100     ID          Num       8    BEST12.    BEST32.                              */
/*                                |    200                                                                                */
/*  100.0                         |    300                                                                                */
/*  200.0                         |    400                                                                                */
/*  300.0                         |                                                                                       */
/*  400.0                         |                                                                                       */
/**************************************************************************************************************************/

/*         _ _ _
 ___  __ _| (_) |_ ___   _ __ ___   __ _  ___ _ __ ___
/ __|/ _` | | | __/ _ \ | `_ ` _ \ / _` |/ __| `__/ _ \
\__ \ (_| | | | ||  __/ | | | | | | (_| | (__| | | (_) |
|___/\__, |_|_|\__\___| |_| |_| |_|\__,_|\___|_|  \___/
        |_|
*/

%utl_close;

filename ft15f001 "c:/oto/utl_sqbegin.sas";
parmcards4;
%macro utl_sqbegin;
%utlfkil(c:/temp/sq_pgm.ps1);
%utlfkil(c:/temp/sq_pgm.log);
filename ft15f001 "c:/temp/sq_pgm.ps1";
%mend utl_sqbegin;
;;;;
run;quit;


filename ft15f001 "c:/oto/utl_sqend.sas";
parmcards4;
%macro utl_sqend(returnvar=N);
options noxwait noxsync;
filename rut pipe  "sqlite3 -batch < c:/temp/sq_pgm.ps1 > c:/temp/ps_pgm.log";
run;quit;
  data _null_;
    file print;
    infile rut recfm=v lrecl=32756;
    input;
    put _infile_;
    putlog _infile_;
  run;
  filename ft15f001 clear;
  * use the clipboard to create macro variable;
  %if %upcase(%substr(&returnVar.,1,1)) ne N %then %do;
    filename clp clipbrd ;
    data _null_;
     length txt $200;
     infile clp;
     input;
     putlog "macro variable &returnVar = " _infile_;
     call symputx("&returnVar.",_infile_,"G");
    run;quit;
  %end;
data _null_;
  file print;
  infile rut;
  input;
  put _infile_;
  putlog _infile_;
run;quit;
data _null_;
  infile "c:/temp/ps_pgm.log";
  input;
  putlog _infile_;
run;quit;
filename ft15f001 clear;
%mend utl_sqend;
;;;;
run;quit;


/*              _                    _   _       _            _       _   _
  ___ _ __   __| |  _ __   __ _ _ __| |_(_) __ _| | ___  ___ | |_   _| |_(_) ___  _ __  ___
 / _ \ `_ \ / _` | | `_ \ / _` | `__| __| |/ _` | |/ __|/ _ \| | | | | __| |/ _ \| `_ \/ __|
|  __/ | | | (_| | | |_) | (_| | |  | |_| | (_| | |\__ \ (_) | | |_| | |_| | (_) | | | \__ \
 \___|_| |_|\__,_| | .__/ \__,_|_|   \__|_|\__,_|_||___/\___/|_|\__,_|\__|_|\___/|_| |_|___/
                   |_|

/**************************************************************************************************************************/
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/**************************************************************************************************************************/

 _       __       _ _             _       _   _
| |__   / _|_   _| | |  ___  ___ | |_   _| |_(_) ___  _ __  ___
| `_ \ | |_| | | | | | / __|/ _ \| | | | | __| |/ _ \| `_ \/ __|
| |_) ||  _| |_| | | | \__ \ (_) | | |_| | |_| | (_) | | | \__ \
|_.__/ |_|  \__,_|_|_| |___/\___/|_|\__,_|\__|_|\___/|_| |_|___/

 _ __                    _                       _  _        __                        _   _               _
| ___|   _ __   ___  ___| |_ __ _ _ __ ___  __ _| |(_)_ __  / _| ___ _ __ _ __ ___  __| | | |_ _   _ _ __ (_)_ __   __ _
|___ \  | `_ \ / _ \/ __| __/ _` | `__/ __|/ _` | || | `_ \| |_ / _ \ `__| `__/ _ \/ _` | | __| | | | `_ \| | `_ \ / _` |
 ___) | | |_) | (_) \__ \ || (_| | |  \__ \ (_| | || | | | |  _|  __/ |  | | |  __/ (_| | | |_| |_| | |_) | | | | | (_| |
|____/  | .__/ \___/|___/\__\__, |_|  |___/\__, |_||_|_| |_|_|  \___|_|  |_|  \___|\__,_|  \__|\__, | .__/|_|_| |_|\__, |
        |_|                 |___/             |_|                                              |___/|_|            |___/
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

/*---- INPUT ----*/


data class;
informat
NAME $8.
SEX $1.
AGE 8.
HEIGHT 8.
WEIGHT 8.
;input
NAME SEX AGE HEIGHT WEIGHT;
cards4;
Alfred M 14 69 112.5
Alice F 13 56.5 84
Barbara F 13 65.3 98
Carol F 14 62.8 102.5
Henry M 14 63.5 102.5
James M 12 57.3 83
Jane F 12 59.8 84.5
Janet F 15 62.5 112.5
Jeffrey M 13 62.5 84
John M 12 59 99.5
Joyce F 11 51.3 50.5
Judy F 14 64.3 90
Louise F 12 56.3 77
Mary F 15 66.5 112
Philip M 16 72 150
Robert M 12 64.8 128
Ronald M 15 67 133
Thomas M 11 57.5 85
William M 15 66.5 112
;;;;
run;quit;

/*__ _             _   _        __                        _  _
 / _(_)_ __   __ _| | (_)_ __  / _| ___ _ __ _ __ ___  __| || |_ _   _ _ __   ___  ___
| |_| | `_ \ / _` | | | | `_ \| |_ / _ \ `__| `__/ _ \/ _` || __| | | | `_ \ / _ \/ __|
|  _| | | | | (_| | | | | | | |  _|  __/ |  | | |  __/ (_| || |_| |_| | |_) |  __/\__ \
|_| |_|_| |_|\__,_|_| |_|_| |_|_|  \___|_|  |_|  \___|\__,_| \__|\__, | .__/ \___||___/
                                                                 |___/|_|
STEPS (what the macros do)
SLOWER THAN SQLITE. MORE OVERHEAD?

 1. SAS:
      a tagsets_sql template into sasusers templates
      b This only has to be done once
      c %utl_tagsets_sql;
      d standardize the tagset creat table script

 2. POSTGRESQL:
      a drop table if exists class
      b create table class from 1d
      c create table stats with  mean age, height and weight by sex
      d copy table stats to a csv file statscsv
*/

%utl_tagsets_sql; /*--- never need to run again ----*/


%utlfkil(c:/temp/sqlcreins.sql);

/*---- generate create insert code a---*/
ods path (prepend) sasuser.templates(update);
%utl_sqlinsert(class,c:/temp/sqlcreins.sql);

/*---- clear out template1 database ----*/
%utl_pgbegin;
parmcards4;
drop table if exists meta;
drop table if exists class;
drop table if exists tst;
drop table if exists stats;
\dt
;;;;
%utl_pgend;

%utlfkil(c:/temp/statscsv.csv);

%utl_pgbegin;
parmcards4;
-f c:/temp/sqlcreins.sql
drop table if exists stats;
create
   table stats as
select
   sex
  ,avg(age) as avgage
  ,avg(weight) as avgwgt
  ,avg(height) as avghgt
from
  class
group
  by sex
;
\dt
select * from stats;
\copy stats TO 'c:/temp/statscsv.csv' WITH CSV HEADER;
;;;;
%utl_pgend;

dm "";
dm "dimport 'c:/temp/statscsv.csv' stats  replace";

proc print data=stats;
run;quit;

/**************************************************************************************************************************/
/* POSTGRESQL                                                           | SAS                                             */
/*                                                                      |                                                 */
/* c:/temp/statscsv.csv                                                 | SEX     AVGAGE     AVGWGT     AVGHGT            */
/*                                                                      |                                                 */
/* Create table class(                                                  |  M     13.3333    108.556    63.3444            */
/*    name varchar(200)                                                 |  F     13.2222     90.111    60.5889            */
/*    ,sex varchar(200)                                                 |                                                 */
/*    ,age float                                                        |                                                 */
/*    ,height float                                                     |                                                 */
/*    ,weight float);                                                   |                                                 */
/* ('Alice', 'F', 13, 56.5, 84.0),                                      |                                                 */
/* ('Barbara', 'F', 13, 65.3, 98.0),                                    |                                                 */
/* ('Carol', 'F', 14, 62.8, 102.5),                                     |                                                 */
/* ('Henry', 'M', 14, 63.5, 102.5),                                     |                                                 */
/* ...                                                                  |                                                 */
/* ('Ronald', 'M', 15, 67.0, 133.0),                                    |                                                 */
/* ('Thomas', 'M', 11, 57.5, 85.0),                                     |                                                 */
/* ('William', 'M', 15, 66.5, 112.0);                                   |                                                 */
/*                                                                      |                                                 */
/*                                                                      |                                                 */
/*         List of relations                                            |                                                 */
/* Schema |  Name| Type | Owner                                         |                                                 */
/* -------+------+------+---------                                      |                                                 */
/* public | class| table|postgres  input table from tagsets sql script  |                                                 */
/* public | stats| table|postgres  output table means                   |                                                 */
/* 3 rows)                                                              |                                                 */
/*                                                                      |                                                 */
/* STATS TABLE                                                          |                                                 */
/* ELECT 2                                                              |                                                 */
/*                                                                      |                                                 */
/* sex |       avgage       |       avgwgt       |      avghgt          |                                                 */
/* ----+--------------------+--------------------+-------------------   |                                                 */
/* M   | 13.333333333333334 | 108.55555555555556 | 63.34444444444445    |                                                 */
/* F   | 13.222222222222221 |  90.11111111111111 | 60.58888888888888    |                                                 */
/* 2 rows)                                                              |                                                 */
/**************************************************************************************************************************/


/*__                     _                                      _       _          _
 / /_    _ __   ___  ___| |_ __ _ _ __ ___  ___  __      __  __| | __ _| |_ __ _  | |_ _   _ _ __   ___  ___
| `_ \  | `_ \ / _ \/ __| __/ _` | `__/ _ \/ __| \ \ /\ / / / _` |/ _` | __/ _` | | __| | | | `_ \ / _ \/ __|
| (_) | | |_) | (_) \__ \ || (_| | | |  __/\__ \  \ V  V / | (_| | (_| | || (_| | | |_| |_| | |_) |  __/\__ \
 \___/  | .__/ \___/|___/\__\__, |_|  \___||___/   \_/\_/   \__,_|\__,_|\__\__,_|  \__|\__, | .__/ \___||___/
        |_|                 |___/                                                      |___/|_|

MACROS ARE AFTER EXAMPLE

LITLLE SLOW

*/

%utlfkil(c:/temp/sqlcreins.sql);

/*---- make create table and insert sql script ----*/
ods path (prepend) sasuser.templates(update);
%utl_sqlinsert(class,c:/temp/sqlcreins.sql);

/*---- clear out template1 database ----*/
%utl_pgbegin;
parmcards4;
drop table if exists meta;
drop table if exists class;
drop table if exists tst;
drop table if exists stats;
\dt
;;;;
%utl_pgend;

%utlfkil(c:/temp/statscsv.csv);
%utlfkil(c:/temp/metacsv.csv);

/*--- -f has to be the first record ---*/
%utl_pgbegin;
parmcards4;
-f c:/temp/sqlcreins.sql
\dt
drop table if exists tst;
create
   table stats as
select
   sex
  ,avg(age) as avgage
  ,avg(weight) as avgwgt
  ,avg(height) as avghgt
from
  class
group
  by sex
;
select * from stats;
\copy stats TO 'c:/temp/statscsv.csv' WITH CSV HEADER;
drop table if exists meta;
create
   table meta as
select
  column_name
 ,data_type
from
  information_schema.columns
where
  table_name = 'stats'
order
  by ordinal_position;
;
select * from meta;
\copy meta TO 'c:/temp/metacsv.csv' WITH CSV HEADER;
;;;;
%utl_pgend;

proc datasets lib=work nolist nodetails;
 delete meta stats;
run;quit;

dm "";
dm "dimport 'c:/temp/metacsv.csv' meta replace";
dm "dimport 'c:/temp/statscsv.csv' stats  replace";

proc print data=meta;
run;quit;

/*--- use the meta data to map postgresql data types to sas data types ----*/
%utl_pgcsvtyp(
   meta    = work.meta
  ,datacsv = c:/temp/statscsv.csv
  ,out     = statstyp
  );

proc print data=statstyp;
format _numeric_ 7.2;
run;quit;

/**************************************************************************************************************************/
/* POSTGRESQL                                                               | SAS                                         */
/*           List of relations                                              | c:/temp/statscsv.csv                        */
/*   Schema |  Name  | Type  |  Owner                                       |                                             */
/*  --------+--------+-------+----------                                    | sex,avgage,avgwgt,avghgt                    */
/*   public | class  | table | postgres                                     | M,13.3333333333,108.555555555,63.344444444  */
/*   public | meta   | table | postgres                                     | F,13.2222222222,90.1111111111,60.588888888  */
/*   public | sample | table | postgres                                     |                                             */
/*   public | stats  | table | postgres                                     |                                             */
/*  (4 rows)                                                                | WORK.META                                   */
/*                                                                          |                                             */
/*  DROP TABLE                                                              | COLUMN_                                     */
/*   sex |       avgage       |       avgwgt       |      avghgt            |  NAME      DATA_TYPE                        */
/*  -----+--------------------+--------------------+-------------------     |                                             */
/*   M   | 13.333333333333334 | 108.55555555555556 | 63.34444444444445      | sex        character varying                */
/*   F   | 13.222222222222221 |  90.11111111111111 | 60.58888888888888      | avgage     double precision                 */
/*  (2 rows)                                                                | avgwgt     double precision                 */
/*                                                                          | avghgt     double precision                 */
/*  COPY 2                                                                  |                                             */
/*  DROP TABLE                                                              | #    Variable    Type    Len                */
/*  SELECT 4                                                                |                                             */
/*                                                                          | 1    SEX         Char      1                */
/*   column_name |     data_type                                            | 2    AVGAGE      Num       8                */
/*  -------------+-------------------                                       | 3    AVGWGT      Num       8                */
/*   sex         | character varying                                        | 4    AVGHGT      Num       8                */
/*   avgage      | double precision                                         |                                             */
/*   avgwgt      | double precision                                         |                                             */
/*   avghgt      | double precision                                         |                                             */
/*  (4 rows)                                                                |                                             */
/**************************************************************************************************************************/

/*                       _
| |_ __ _  __ _ ___  ___| |_ ___   _ __ ___   __ _  ___ _ __ ___
| __/ _` |/ _` / __|/ _ \ __/ __| | `_ ` _ \ / _` |/ __| `__/ _ \
| || (_| | (_| \__ \  __/ |_\__ \ | | | | | | (_| | (__| | | (_) |
 \__\__,_|\__, |___/\___|\__|___/ |_| |_| |_|\__,_|\___|_|  \___/
          |___/
*/

filename ft15f001 "c:/oto/utl_tagsets_sql,sas";
parmcards4;
%macro utl_tagsets_sql(dummy);
proc template ;
    define tagset tagsets.sql / STORE=sasuser.templates;
        /*---------------------------------------------------------------eric-*/
        /*-- Set up some look-up tables for convenience.                    --*/
        /*------------------------------------------------------------11Feb04-*/
        /* type translations */
        define event type_translations;
            set $types['string'] 'varchar';
            set $types['double'] 'float';
            set $types['int']    'integer';
        end;
        /* column name translation */
        define event name_translations;
            set $name_trans['desc'] 'description';
        end;
        define event initialize;
            trigger type_translations;
            trigger name_translations;
            /* types that need widths */
            set $types_with_widths['string'] "True";
            /* types that need quotes */
            set $types_with_quotes['string'] "True";
        end;
        /*---------------------------------------------------------------eric-*/
        /*-- Reset everything so we can run one proc print after another.   --*/
        /*------------------------------------------------------------11Feb04-*/
        define event table;
            unset $names;
            unset $col_types;
            unset $columns;
            unset $values;
            unset $lowname;
        end;
        define event colspec_entry;
            /*---------------------------------------------------------------eric-*/
            /*-- Ignore the obs column.  The value will get ignored because     --*/
            /*-- it will be in a header cell and we don't define a header       --*/
            /*-- event to catch it.                                             --*/
            /*------------------------------------------------------------12Feb04-*/
            break /if cmp(name, 'obs');
            /*---------------------------------------------------------------eric-*/
            /*-- Create a list of column names.  Translate the names            --*/
            /*-- if they are in the translate list.                             --*/
            /*------------------------------------------------------------11Feb04-*/
            set $lowname lowcase(name);
            do /if $name_trans[$lowname];
                set $names[] $name_trans[$lowname];
            else;
                set $names[] $lowname;
            done;
            /* keep a list of types */
            set $col_types[] type;
            /* make a list of column type definitions */
            set $col_def $types[type];
            /* append width if needed */
            /*set $col_def $col_def "(" width ")" /if $types_with_widths[type];*/
            set $col_def $col_def "(" "200" ")" /if $types_with_widths[type];
            set $columns[] $col_def;
        end;
        /*---------------------------------------------------------------eric-*/
        /*-- Catch the data label and get the data set name from it.        --*/
        /*------------------------------------------------------------11Feb04-*/
        define event output;
            start:
                set $table_name reverse(label);
                set $table_name scan($table_name, 1, '.');
                set $table_name reverse($table_name);
                set $table_name lowcase($table_name);
        end;
       /*---------------------------------------------------------------eric-*/
       /*-- Print out the create table statement before Any data           --*/
       /*-- rows come along.                                               --*/
       /*------------------------------------------------------------11Feb04-*/
        define event table_body;
            put "proc sql;" nl; put " Create table " $table_name "(";
            /* put "           "; */
            /* loop over the names, and column definitions */
            eval $i 1;
            unset $not_first;
            do /while $i <= $names;
                /* comma's only after the first name */
                put ', ' /if $not_first;
                put $names[$i] " ";
                put $columns[$i];
                eval $i $i+1;
                set $not_first "True";
            done;
            put ");" nl;
        end;
        /*---------------------------------------------------------------eric-*/
        /*-- Reset the values at the beginning of each row.  Print the      --*/
        /*-- insert statement at the end of each row.                       --*/
        /*------------------------------------------------------------11Feb04-*/
        define event row;
            start:
                unset $values;
            finish:
                trigger insert;
        end;
        /*---------------------------------------------------------------eric-*/
        /*-- Save away the data.  The Obs column won't hit this because     --*/
        /*-- it's a header.                                                 --*/
        /*------------------------------------------------------------12Feb04-*/
        define event data;
            do /if value;
                set $values[] strip(value);
            else;
                set $values[] ' ';
            done;
        end;
        /*---------------------------------------------------------------eric-*/
        /*-- Create the insert statement                                    --*/
        /*------------------------------------------------------------12Feb04-*/
        define event insert;
            finish:
                break /if ^$values;
                put "Insert into " $table_name;
                trigger print_names;
                put;
                put  " Values";
                trigger print_values;
                put ";" nl;
        end;
        /*---------------------------------------------------------------eric-*/
        /*-- Print the list of names.  This could use                       --*/
        /*-- a single putvars statement if it weren't for                   --*/
        /*-- the commas.                                                    --*/
        /*------------------------------------------------------------12Feb04-*/
        define event print_names;
            put "(";
            iterate $names;
            unset $not_first;
            do /while _value_;
                /* comma's only after the first name */
                put ", " /if $not_first;
                put lowcase(_value_);
                set $not_first "true";
                next $names;
            done;
            put ")";
        end;
        /*---------------------------------------------------------------eric-*/
        /*-- Print the values for the insert statement. Commas and quoting  --*/
        /*-- are an issue.  double up the quotes in strings.  Remove        --*/
        /*-- commas from numbers.                                           --*/
        /*------------------------------------------------------------12Feb04-*/
        define event print_values;
            put "(" ;
            eval $i 1;
            unset $not_first;
            iterate $values;
            do /while _value_;
                put ", " /if $not_first;
                do /if $types_with_quotes[$col_types[$i]];
                    put "'" ;
                    put tranwrd(_value_, "'", "''") /if ^cmp(_value_, ' ');
                    put "'";
                else;
                    do /if cmp(_value_, ' ');
                        put '0';
                    else;
                        put tranwrd(_value_, "," , "") ;
                    done;
                done;
                set $not_first "true";
                next $values;
                eval $i $i+1;
            done;
            put ")";
        end;
    end;
  run;
/*--- add template to sasuser.templates ---*/
%mend utl_tagsets_sql;
;;;;
run;quit;

/*     _   _             _ _                     _
 _   _| |_| |  ___  __ _| (_)_ __  ___  ___ _ __| |_  _ __ ___   __ _  ___ _ __ ___
| | | | __| | / __|/ _` | | | `_ \/ __|/ _ \ `__| __|| `_ ` _ \ / _` |/ __| `__/ _ \
| |_| | |_| | \__ \ (_| | | | | | \__ \  __/ |  | |_ | | | | | | (_| | (__| | | (_) |
 \__,_|\__|_|_|___/\__, |_|_|_| |_|___/\___|_|   \__||_| |_| |_|\__,_|\___|_|  \___/
           |___|      |_|
*/

filename ft15f001 "c:/oto/utl_sqlinsert.sas";
parmcards4;
%macro utl_sqlinsert(dsn,_out_)
   /des="send sql insert code to the log and clipbord paste buffer";

   options ls=256;

   filename tmp temp lrecl=4096;

   ods tagsets.sql file=tmp;

   proc print data=&dsn;
   run;quit;

   ods _all_ close; ** very important;


   data _null_;
   infile tmp end=dne;
   input;
   put _infile_;
   run;quit;


   filename _out_ "&_out_";
   data _null_;
    retain flg 0;
    length once $255 remain $255;
    infile tmp end=dne;
    file _out_;
    input;
    select;
       when (_n_ =1)           leave;
       when (_n_ < 3)  do;
           put _infile_;
           putlog _infile_;
       end;
       when (_infile_=:"Insert into" and flg=0)  do;
          flg=1;
          once=catx(' ',cats(scan(_infile_,1,')'),')'),'VALUES');
          remain=cats(scan(_infile_,2,')'),')');
          put once;
          putlog once;
          *put remain;
          *putlog remain;
       end;
       when (_infile_=:"Insert into") do;
          remain=substr(_infile_,index(_infile_,'Values')+6);
          if not dne then remain=translate(remain,',',';');
          put remain;
          putlog remain;
       end;
       * leave otherwise off to force error;
    end;
   run;quit;

   filename tmp clear;

   ods listing;

   options ls=255;

%mend utl_sqlinsert;
;;;;
run;quit;

/*     _   _                               _
 _   _| |_| |   _ __   __ _  ___ _____   _| |_ _   _ _ __   _ __ ___   __ _  ___ _ __ ___
| | | | __| |  | `_ \ / _` |/ __/ __\ \ / / __| | | | `_ \ | `_ ` _ \ / _` |/ __| `__/ _ \
| |_| | |_| |  | |_) | (_| | (__\__ \\ V /| |_| |_| | |_) || | | | | | (_| | (__| | | (_) |
 \__,_|\__|_|__| .__/ \__, |\___|___/ \_/  \__|\__, | .__/ |_| |_| |_|\__,_|\___|_|  \___/
           |___|_|    |___/                    |___/|_|
*/

filename ft15f001 "c:/oto/utl_pgcsvtyp.sas";
parmcards4;
%macro utl_pgcsvtyp(
   meta    = work.meta
  ,datacsv = c:/temp/statscsv.csv
  ,out     = statstyp
   ) / des="import sqlite table to sas dataset";

   /*----
     %let meta    = work.meta;
     %let datacsv = c:/temp/statscsv.csv;
     %let out     = statstyp;
   ----*/

   proc format;
    value $maptyp
     'double precision'    = '32.'
     'character varying'    = '$255.';
   run;quit;

   data _mapem_;
     set &meta ;
     typ=put(data_type,$maptyp.);
     drop data_type;
   run;quit;
   %array(_typ,data=_mapem_,var=typ);
   %array(_nam,data=_mapem_,var=column_name);
   data &out;
     informat
       %do_over(_nam _typ,phrase=?_nam ?_typ);
     infile "&datacsv" delimiter=',' firstobs=2;
     input
       %do_over(_nam,phrase=?);;
   run;quit;
   %arraydelete(_typ)
   %arraydelete(_nam)
   /*---- optimize variable lengths ----*/
   %utl_optlenpos(&out,&out);
%mend utl_pgcsvtyp;
;;;;
run;quit;

/*____             _ _ _         _        __                        _  _               _
|___  |  ___  __ _| (_) |_ ___  (_)_ __  / _| ___ _ __ _ __ ___  __| || |_ _   _ _ __ (_)_ __   __ _
   / /  / __|/ _` | | | __/ _ \ | | `_ \| |_ / _ \ `__| `__/ _ \/ _` || __| | | | `_ \| | `_ \ / _` |
  / /   \__ \ (_| | | | ||  __/ | | | | |  _|  __/ |  | | |  __/ (_| || |_| |_| | |_) | | | | | (_| |
 /_/    |___/\__, |_|_|\__\___| |_|_| |_|_|  \___|_|  |_|  \___|\__,_| \__|\__, | .__/|_|_| |_|\__, |
                |_|                                                        |___/|_|            |___/
*/

%utlfkil(c:/temp/sqlcreins.sql);

/*---- make create table and insert sql script ----*/
ods path (prepend) sasuser.templates(update);
%utl_sqlinsert(class,c:/temp/sqlcreins.sql);

/*---- clear out template1 database ----*/

%utlfkil(c:/temp/statscsv.csv);

%utl_sqbegin;
parmcards4;
.open c:/temp/tst.db
drop table if exists class;
.read "c:/temp/sqlcreins.sql"
.tables
drop table if exists stats;
create
   table stats as
select
   sex
  ,avg(age) as avgage
  ,avg(weight) as avgwgt
  ,avg(height) as avghgt
from
  class
group
  by sex
;
select * from stats;
.headers on
.mode csv
.output c:/temp/sqstats.csv
SELECT * FROM stats;
.output stdout
.quit
;;;;
%utl_sqend;

dm "";
dm "dimport 'c:/temp/sqstats.csv' stats  replace";

proc print data=stats;
format _numeric_ 7.2;
run;quit;

/**************************************************************************************************************************/
/* sqlite3                                                                                                                */
/*                                                                                                                        */
/* class  stats  tst                                                                                                      */
/* F|13.2222222222222|90.1111111111111|60.5888888888889                                                                   */
/* M|13.3333333333333|108.555555555556|63.3444444444444                                                                   */
/*                                                                                                                        */
/* SAS                                                                                                                    */
/* WORK.STATS total obs=2                      Variable    Type    Len    Format     Informat                             */
/*                                                                                                                        */
/*  SEX     AVGAGE     AVGWGT     AVGHGT       SEX         Char      1    $1.        $1.                                  */
/*                                             AVGAGE      Num       8    BEST12.    BEST32.                              */
/*   F     13.2222     90.111    60.5889       AVGWGT      Num       8    BEST12.    BEST32.                              */
/*   M     13.3333    108.556    63.3444       AVGHGT      Num       8    BEST12.    BEST32.                              */
/**************************************************************************************************************************/

/*___              _ _ _                        _       _         _               _
 ( _ )   ___  __ _| (_) |_ ___  __      __   __| | __ _| |_ __ _ | |_ _   _ _ __ (_)_ __   __ _
 / _ \  / __|/ _` | | | __/ _ \ \ \ /\ / /  / _` |/ _` | __/ _` || __| | | | `_ \| | `_ \ / _` |
| (_) | \__ \ (_| | | | ||  __/  \ V  V /  | (_| | (_| | || (_| || |_| |_| | |_) | | | | | (_| |
 \___/  |___/\__, |_|_|\__\___|   \_/\_/    \__,_|\__,_|\__\__,_| \__|\__, | .__/|_|_| |_|\__, |
                |_|                                                   |___/|_|            |___/
*/

%utlfkil(c:/temp/sqlcreins.sql);

/*---- make create table and insert sql script ----*/
ods path (prepend) sasuser.templates(update);
%utl_sqlinsert(class,c:/temp/sqlcreins.sql);

%utlfkil(c:/temp/sqmeta.csv);
%utlfkil(c:/temp/sqstats.csv);

%utl_sqbegin;
parmcards4;
.open c:/temp/tst.db
drop table if exists class;

.read "c:/temp/sqlcreins.sql"
.tables

drop table if exists stats;
drop table if exists meta;

create
   table stats as
select
   sex
  ,avg(age) as avgage
  ,avg(weight) as avgwgt
  ,avg(height) as avghgt
from
  class
group
  by sex
;
select * from stats;

drop table if exists meta;

/*--- THIS WILL WORK FOR ANY TABLE ---*/
Create
   table meta (
       pk real
      ,name varchar(32)
      ,type varchar(32)
      ,dum1 varchar(32)
      ,dum2 varchar(32)
      ,dum3 varchar(32)
 );
INSERT INTO meta SELECT * FROM pragma_table_info('stats');

select * from meta;

.headers on
.mode csv
.output c:/temp/sqstats.csv
SELECT * FROM stats;
.output stdout

select * from meta;
.headers on
.mode csv
.output c:/temp/sqmeta.csv
SELECT * FROM meta;
.output stdout
;;;;
%utl_sqend;

proc datasets lib=work nolist nodetails;
 delete meta stats;
run;quit;

dm ""
dm "dimport 'c:/temp/sqmeta.csv' meta replace";
dm "dimport 'c:/temp/sqstats.csv' stats  replace";

%utl_sqcsvtyp(
     metacsv=c:/temp/sqmeta.csv
    ,out    =statsopt
    ,datacsv=c:/temp/sqstats.csv
    );

proc print data=stats;
format _numeric_ 7.2;
run;quit;

/*     _   _                            _
 _   _| |_| |  ___  __ _  ___ _____   _| |_ _   _ _ __   _ __ ___   __ _  ___ _ __ ___
| | | | __| | / __|/ _` |/ __/ __\ \ / / __| | | | `_ \ | `_ ` _ \ / _` |/ __| `__/ _ \
| |_| | |_| | \__ \ (_| | (__\__ \\ V /| |_| |_| | |_) || | | | | | (_| | (__| | | (_) |
 \__,_|\__|_|_|___/\__, |\___|___/ \_/  \__|\__, | .__/ |_| |_| |_|\__,_|\___|_|  \___/
           |___|      |_|                   |___/|_|
*/

filename ft15f001 "c:/oto/utl_sqcsvtyp.sas";
parmcards4;
%macro utl_sqcsvtyp(
     metacsv=c:/temp/sqmeta.csv
    ,out    =statsopt
    ,datacsv=c:/temp/sqstats.csv
    )/des  ="map sqlite types to sas types";

proc datasets lib=work;
 delete _mapem_ &out _meta_;
run;quit;

dm "dimport '&metacsv' _meta_  replace";

proc format;
 value $maptyp
  'REAL'    = '32.'
  'INTEGER' = '32.'
  'TEXT'    = '$255.'
   OTHER    = '32.'
;
run;quit;

data _mapem_;
  set _meta_(keep=name type);
  typ=put(type,$maptyp.);
  drop type;
run;quit;

%array(_typ,data=_mapem_,var=typ);
%array(_nam,data=_mapem_,var=name);

%put &=_typ1;
%put &=_nam1;


data &out;
  informat
    %do_over(_nam _typ,phrase=?_nam ?_typ);;
  infile "&datacsv" delimiter=',' firstobs=2;
  input
    %do_over(_nam,phrase=?);;
run;quit;

%arraydelete(_typ)
%arraydelete(_nam)

/*---- optimize variable lengths ----*/
%utl_optlenpos(&out,&out);

proc print data=&out;
title "output table is &out";
run;quit;

%mend utl_sqcsvtyp;
;;;;
run;quit;

/*              _    __       _ _           _       _   _
  ___ _ __   __| |  / _|_   _| | |___  ___ | |_   _| |_(_) ___  _ __  ___
 / _ \ `_ \ / _` | | |_| | | | | / __|/ _ \| | | | | __| |/ _ \| `_ \/ __|
|  __/ | | | (_| | |  _| |_| | | \__ \ (_) | | |_| | |_| | (_) | | | \__ \
 \___|_| |_|\__,_| |_|  \__,_|_|_|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/


            _                                       _        _   _
  ___    __| | ___   ___ _   _ _ __ ___   ___ _ __ | |_ __ _| |_(_) ___  _ __
 / __|  / _` |/ _ \ / __| | | | `_ ` _ \ / _ \ `_ \| __/ _` | __| |/ _ \| `_ \
| (__  | (_| | (_) | (__| |_| | | | | | |  __/ | | | || (_| | |_| | (_) | | | |
 \___|  \__,_|\___/ \___|\__,_|_| |_| |_|\___|_| |_|\__\__,_|\__|_|\___/|_| |_|

*/

  CONTENTS

     1 create standard create table insert ( utl_sqlinsert macro )
     2 pstgressql cli options and meta commands
     2 sqlite3    cli options and meta commands


/*      _                  _               _                       _        _        _     _
/ | ___| |_ __ _ _ __   __| | __ _ _ __ __| |   ___ _ __ ___  __ _| |_ ___ | |_ __ _| |__ | | ___
| |/ __| __/ _` | `_ \ / _` |/ _` | `__/ _` |  / __| `__/ _ \/ _` | __/ _ \| __/ _` | `_ \| |/ _ \
| |\__ \ || (_| | | | | (_| | (_| | | | (_| | | (__| | |  __/ (_| | ||  __/| || (_| | |_) | |  __/
|_||___/\__\__,_|_| |_|\__,_|\__,_|_|  \__,_|  \___|_|  \___|\__,_|\__\___| \__\__,_|_.__/|_|\___|

*/ The problem with this tagsets template is that it create a sas only tagset. We need to convert it to ansi standard

The utl_sqlinsert macro stadardizes the tagset sas output.

All these databases support varchar and float datatypes, The utl_sqlinsert macro generates a create table insert script
tha works with all these sqldialects.

PostgreSQL (all modern versions)
SQLite (all versions)
Microsoft SQL Server (since 2008+)
MariaDB (MySQL-compatible, all versions)
IBM Db2 (since at least version 9.7+)
Amazon Redshift (PostgreSQL-compatible)
CockroachDB (PostgreSQL-compatible)
Snowflake
Teradata
SAP HANA
Google BigQuery (with INSERT INTO or INSERT DML)
Oracle (only 23c+; older versions like 19c/21c do not support this syntax)
*/

/*___                    _                            _        _ _
|___ \   _ __   ___  ___| |_ __ _ _ __ ___  ___  __ _| |   ___| (_)
  __) | | `_ \ / _ \/ __| __/ _` | `__/ _ \/ __|/ _` | |  / __| | |
 / __/  | |_) | (_) \__ \ || (_| | | |  __/\__ \ (_| | | | (__| | |
|_____| | .__/ \___/|___/\__\__, |_|  \___||___/\__, |_|  \___|_|_|
        |_|                 |___/                  |_|
*/

psql CLI options                                          psql meta commands

-d <dbname>      Specify the database name to connect to  \l               List all databases
-U <username>    Specify the database user                \c <dbname>      Connect to another database
-h <host>        Specify the database server host         \dt              List all tables
-p <port>        Specify the port number                  \d <table>       Describe a table (columns, types, etc.)
-W               Force password prompt                    \dn              List all schemas
-c "<command>"   Execute a single command and exit        \df              List all functions
-f <filename>    Execute commands from a file             \dv              List all views
--csv            Output results in CSV format             \du              List all users and roles
-a               Echo all input lines                     \g               Execute the previous command again
-A               Unaligned output mode                    \s               Show command history
-b               Echo failed SQL commands to stderr       \i <file>        Execute commands from a file

KEY DICTIONARY TABLE information_schema.columns where table='class'

/*____             _ _ _       _____        _ _
|___ /   ___  __ _| (_) |_ ___|___ /    ___| (_)
  |_ \  / __|/ _` | | | __/ _ \ |_ \   / __| | |
 ___) | \__ \ (_| | | | ||  __/___) | | (__| | |
|____/  |___/\__, |_|_|\__\___|____/   \___|_|_|
                |_|
*/

sqlite3 cli

Option / Flag   Description
-init file      Read and execute commands from the specified file (can contain SQL and meta-commands).
-echo           Print commands before execution.
-[no]header     Turn headers on or off in query output.
-column         Display query results in a table-like format with aligned columns.
-html           Output query results as simple HTML tables.
-line           Display each value on a separate line, rows separated by a blank line.
-list           Display results separated by the field separator (default: `
-separator SEP  Set the output field separator (default: `
-nullvalue STR  Set the string used to represent NULL values (default: empty string).
-version        Show the SQLite version and exit.
-help           Show help on available options and exit.
-bail           Stop after hitting an error.
-batch          Force batch I/O mode (useful for scripts).
-cmd COMMAND    Run the specified command before reading from stdin. Can be used multiple times.
-csv            Set output mode to CSV (comma-separated values).
-interactive    Force interactive I/O mode.
-mmap N         Set the default memory-mapped I/O size to N.
-stats          Print memory stats before each finalize.
-vfs NAME       Use the specified VFS (Virtual File System) implementation.

sqlite3 meta commands

  COMMAND                 DESCRIPTION

 .backup ?DB? FILE       Backup DB (default "main") to FILE
 .bail on                off
 .clone NEWDB            Clone data into NEWDB from the existing database
 .databases              List names and files of attached databases
 .dump ?TABLE? ...       Dump the database in SQL text format
 .echo on                off
 .eqp on                 off
 .exit, .quit            Exit the sqlite3 program
 .explain ?on            off?
 .fullschema             Show schema and content of sqlite_stat tables
 .headers on             off
 .help                   Show help for meta-commands
 .import FILE TABLE      Import data from FILE into TABLE
 .indices ?TABLE?        Show names of all indices (optionally for TABLE)
 .load FILE ?ENTRY?      Load an extension library
 .log FILE               off
 .mode MODE              Set output mode (csv, column, html, insert, line, list, tabs, tcl)
 .nullvalue STRING       Set string used to represent NULL values
 .once FILENAME          Output next query to FILENAME
 .open ?OPTIONS? FILE    Close existing and reopen FILE
 .output FILENAME        Send output to FILENAME
 .print STRING...        Print literal STRING
 .prompt MAIN CONT       Replace the standard prompts
 .read FILENAME          Execute commands from FILENAME
 .restore ?DB? FILE      Restore DB (default "main") from FILE
 .save FILE              Write database to FILE
 .scanstats on           off
 .schema ?PATTERN?       Show CREATE statements matching PATTERN
 .separator COL ?ROW?    Change column/row separators
 .session ?NAME? CMD     Create or control sessions
 .sha3sum ...            Compute SHA3 hash of database content
 .shell CMD ARGS...      Run CMD ARGS in a system shell
 .show                   Show current settings
 .stats ?ARG?            Show stats or turn stats on/off
 .system CMD ARGS...     Run CMD ARGS in a system shell
 .tables ?PATTERN?       List names of tables matching PATTERN
 .timeout MS             Set busy timeout to MS milliseconds
 .timer on               off
 .trace ?OPTIONS?        Output each SQL statement as it is run
 .unmodule NAME ...      Unregister virtual table modules

/*  _                                      _          _ _        _ _
| || |    _ __   _____      _____ _ __ ___| |__   ___| | |   ___| (_)
| || |_  | `_ \ / _ \ \ /\ / / _ \ `__/ __| `_ \ / _ \ | |  / __| | |
|__   _| | |_) | (_) \ V  V /  __/ |  \__ \ | | |  __/ | | | (__| | |
   |_|   | .__/ \___/ \_/\_/ \___|_|  |___/_| |_|\___|_|_|  \___|_|_|
         |_|
*/
Powershell cli options
                                                                                                                                                                                                                                                                                                                                                Description
-NoLogo                     Starts PowerShell without displaying the logo.
-NoExit                     Keeps the PowerShell window open after executing a command or script.
-NoProfile                  Starts without running profile scripts.
-ExecutionPolicy <policy>   Sets the session's script execution policy (e.g., Restricted, RemoteSigned).
-File <filePath> [args]     Runs the specified script file with optional arguments.
-Command <command>          Executes the specified command or script block and then exits.
`-InputFormat <Text         XML>`
`-OutputFormat <Text        XML>`
-WindowStyle <style>        Sets the window style (Normal, Minimized, Maximized, Hidden).
-Version <version>          Starts a session using the specified version of PowerShell.
-Sta                        Starts PowerShell using single-threaded apartment mode.
-Mta                        Starts PowerShell using multi-threaded apartment mode.
-Help, -?, /help            Displays help for PowerShell CLI options.
-NonInteractive             Does not present prompts to the user.
-EncodedCommand <Base64>    Executes a Base64-encoded command string.
-EncodedArguments <Base64>  Passes Base64-encoded arguments to the command.
-PSConsoleFile <file>       Loads specified Windows PowerShell console file.
-ConfigurationName <name>   Specifies a session configuration.

Powershell meta commands

Get-Command
   Lists all available cmdlets, functions, workflows, aliases, and scripts in your session.
   Example: Get-Command

Get-Help
   Provides detailed help for cmdlets and concepts.
   Example: Get-Help Get-Process

Get-Alias
   Lists all aliases defined in the current session.
   Example: Get-Alias

Get-Module
   Shows all modules loaded in the session or available to load.
   Example: Get-Module -ListAvailable

Set-ExecutionPolicy
   Changes the user or machine policy for script execution.
   Example: Set-ExecutionPolicy RemoteSigned

Import-Module / Remove-Module
   Loads or unloads PowerShell modules.

Get-PSDrive
   Lists all PowerShell drives (file system, registry, etc.).

Get-Variable / Set-Variable
   Views or sets PowerShell variables.

Get-History / Invoke-History
   Views or reruns previous commands.

Clear-Host
   Clears the console window (alias: cls).

Exit
   Exits the current PowerShell session.

/*   _            _       _           _
  __| |  _ __ ___| | __ _| |_ ___  __| |  _ __ ___ _ __   ___  ___
 / _` | | `__/ _ \ |/ _` | __/ _ \/ _` | | `__/ _ \ `_ \ / _ \/ __|
| (_| | | | |  __/ | (_| | ||  __/ (_| | | | |  __/ |_) | (_) \__ \
 \__,_| |_|  \___|_|\__,_|\__\___|\__,_| |_|  \___| .__/ \___/|___/
9                                                  |_|
*/

 postgresql
------------------------------------------------------------------------------------------------------------------------------------
https://github.com/rogerjdeangelis/utl-loading-tiny-one-million-row-sas-dataset-into-postgres-db-sql-and-selecting-distinct-values
https://github.com/rogerjdeangelis/utl-partial-key-matching-and-luminosity-in-gene-analysis-sas-r-python-postgresql
https://github.com/rogerjdeangelis/utl-pivot-wide-when-variable-names-contain-values-sql-and-base-r-sas-oython-excel-postgreSQL
https://github.com/rogerjdeangelis/utl-saving-and-creating-r-dataframes-to-and-from-a-postgresql-database-schema


10 slite
---------------------------------------------------------------------------------------------------------------------------------
https://github.com/rogerjdeangelis/utl-import-a-sqlite-table-with-data-types-without-sas-access-product
https://github.com/rogerjdeangelis/utl-centered-moving-average-of-three-observations-using-sas-r-zoo-package-and-sqlite-sqldf
https://github.com/rogerjdeangelis/utl-example-of-a-cartesian-join-in-sqlite-using-cross-join-instead-of-outer-join
https://github.com/rogerjdeangelis/utl-example-of-sqlite-group_concat-and-associated-sas-datastep-solution
https://github.com/rogerjdeangelis/utl-missing-basic-math-and-stat-functions-in-python-sqlite3-sql
https://github.com/rogerjdeangelis/utl-r-python-sas-sqlite-subtracting-the-means-of-a-specific-column-from-other-columns
https://github.com/rogerjdeangelis/utl-sqlite-processing-in-python-with-added-math-and-stat-functions
https://github.com/rogerjdeangelis/utl-using-r-and-python-sqlite-recursion-to-generate-date-or-number-sequences
https://github.com/rogerjdeangelis/utl-calling-r-functions-from-sqldf-using-r-character-strings-muti-language
https://github.com/rogerjdeangelis/utl-centered-moving-average-of-three-observations-using-sas-r-zoo-package-and-sqlite-sqldf
https://github.com/rogerjdeangelis/utl-passing-arguments-to-sqldf-using-wps-python-f-text-function
https://github.com/rogerjdeangelis/utl-passing-arguments-to-sqldf-wps-r-sql-functional-sql
https://github.com/rogerjdeangelis/utl-update-a-master-sheet-with-transaction-sheet-using-excel-and-r-openxls-package-and-sqldf


11 powerchell
---------------------------------------------------------------------------------------------------------------------------------------
https://github.com/rogerjdeangelis/utl-drop-down-to-powershell-and-programatically-create-an-odbc-data-source-for-excel-wps-r-rodbc
https://sithub.com/rogerjdeangelis/utl-drop-down-to-powershell-and-return-the-number-of-lines-in-a-file-to-wps
https://github.com/rogerjdeangelis/utl-drop-down-using-dosubl-from-sas-datastep-to-wps-r-perl-powershell-python-msr-vb
https://github.com/rogerjdeangelis/utl-examples-of-drop-downs-from-sas-to-wps-r-microsoftR-python-perl-powershell
https://github.com/rogerjdeangelis/utl-how-to-remove-a-record-from-a-csv-file-in-place-with-powershell-fast
https://github.com/rogerjdeangelis/utl-importing-a-sas-created-rtf-file-into-ms-word-using-powershell
https://github.com/rogerjdeangelis/utl-powershell-unzip-one-meber-of-a-winzip-archive
https://github.com/rogerjdeangelis/utl-read-print-file-backwards-in-perl-powershell-sas-r-and-python
https://github.com/rogerjdeangelis/utl-scraping-AI-results-without-restriction-or-API-with-powershell-and-perplexity
https://github.com/rogerjdeangelis/utl_dropping-down-to-powershell-and-converting-doc-and-rtf-files-to-pdfs
https://github.com/rogerjdeangelis/zip-and-unzip-using-ms-powershell

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/








