options nosource nonotes;
data numbers symbols;
*  infile datalines truncover end=last; *--- Test with the example ---*;
  infile 'h:\adventofcode2023\day3.txt' end=last truncover;
  input row $140.  ;
  length word $ 140;
  i=1;  pos=0;
  rownum=_n_;
  do until (word='');
      word=scan(row,i,,'dk'); *-- everything but numeric as dlm --;
      pos=findw(row,trim(word),,pos+1,'dk');
      len=length(word);
      if word ne '' then output numbers;
      i+1;
  end;
  i=1;  pos=1;
  do until (word='');
      word=scan(row,i,'.','d'); *-- '.' and numeric as dlm --;
      pos=findw(row,trim(word),'.',pos+1,'d');
      if word ne '' then output symbols;
      i+1;
  end;
datalines;
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
;

proc sql noprint;
select sum(ratio) into :total from (
    select max(input(n.word,best.)) * min(input(n.word,best.)) as ratio
    from numbers n join symbols s
     on (n.rownum=s.rownum-1 and s.pos between n.pos-1 and n.pos+n.len)
     or (n.rownum=s.rownum   and s.pos between n.pos-1 and n.pos+n.len)
     or (n.rownum=s.rownum+1 and s.pos between n.pos-1 and n.pos+n.len)
     where s.word='*'
     group by s.rownum,s.pos
     having count(*)=2
 );
quit;

%put Total: &total;



*--84907174--*;


*--206785--to low--;
*--233536--to low--;
*--320233--to low--;
*--379629--not right--;
*--528707--not right--;
*--528566--not rigth--;
*--337914--not right--;
*--338147--not right--;
*--528799--correct--;
/*


proc sql;
create table kalle as 
select distinct n.word, n.rownum, n.pos from numbers n join symbols s
 on (n.rownum=s.rownum-1 and s.pos between n.pos-1 and n.pos+n.len)
 or (n.rownum=s.rownum   and s.pos between n.pos-1 and n.pos+n.len)
 or (n.rownum=s.rownum+1 and s.pos between n.pos-1 and n.pos+n.len)
 order by n.rownum,n.pos
;
select sum( input(word,best.)) from kalle;

quit;



data kalle;
  
  infile datalines truncover end=last; *--- Test with the example ---*;
  *infile 'h:\adventofcode2023\day3.txt' end=last truncover;

  *-- setup --;
  retain total 0  ;
  length word $ 100;
  valid=1;
  
  
  * rad, word, 1=val, 2=start, 3=end ;
  array num[10,10,3] ;
  array sym[10,10,2] ;

  *array sym[row,start] ;

  do until last or _n_=10;
   
    input row $200.  ;
    
    i=1;
    pos=1;
    do until (word=' ');
      word=scan(row,i,,'dk');
      pos=findw(row,trim(word),,pos,'dk');
      len=length(word);
      num[_N_,i,1]=word;
      num[_N_,i,2]=pos;
      num[_N_,i,3]=pos+len;
      

      i+1;
    end;

    i=1;
    pos=1;
    do until (word=' ');
      word=scan(row,i,'.','d');
      sym[_N_,i,1]=word;
      
      pos=findw(row,trim(word),'.',pos,'d');
      len=length(word);
      num[_N_,i,1]=word;
      num[_N_,i,2]=pos;

      i+1;
    end;
  end;

  *--- check array ---;
  do rownum=1 to 10;
    do wordnum=1 to 10;
      if sym[




datalines;
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
;


/*



  game_id=input(scan(game,2,' :'),best.);


  *-- find semicolon --;
  do part=1 to 10;
    red=1;green=1;blue=1;
    part_row=scan(row,part,';');
    if part_row ne '' then do;
      *-- find comma --;
      do col=1 to 3;
        col_part_row=scan(part_row,col,',');
        if col_part_row ne '' then do;
          *-- find space --;
          color=scan(col_part_row,2);
          number=input(scan(col_part_row,1),best.);
          *-- check valid --;
          if (color='red' and number>12)
          or (color='green' and number>13)
          or (color='blue' and number>14)
          then valid=0;

          *-- create colors --;
          if color='red' then red=number;
          if color='green' then green=number;
          if color='blue' then blue=number;
          
        end;
      end;
    end;
    min_red=max(min_red,red);
    min_green=max(min_green,green);
    min_blue=max(min_blue,blue);
  end;
  
  power=min_red*min_green*min_blue;
  *if valid then total=sum(total,game_id);
  total=sum(total,power);
  
  if last then put 'Total: ' total;