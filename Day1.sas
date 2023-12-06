options nosource nonotes;
data _null_ ;
  
  *infile datalines truncover end=last; *--- Test with the example ---*;
  infile 'h:\adventofcode2023\day1.txt' end=last truncover;
  input row $100.  ;
  retain total 0 ;

  *--- Array with numerics as strings ---*;
  array s[9] $ _temporary_ ('one','two','three','four','five','six','seven','eight','nine');
  
  *--- Loop through array, search for first and last string ---*;
  first_pos=100;
  last_pos=0;
  do i=1 to 9; 
    *--- forward ---*;
    pos=find(row,s[i],'T');
    if pos<first_pos and pos>0 then do;
      first_num=i;
      first_pos=pos;
      first_len=length(s[i]);
    end;
    *--- backward ---*;
    pos=find(row,s[i],'T',-100);
    if pos>last_pos and pos>0 then do;
      last_num=i;
      last_pos=pos;
      last_len=length(s[i]);
    end;
  end;
  
  *--- Replace with numbers if exists ---*;
  if first_pos<100 then substr(row,first_pos,first_len)=put(first_num,best1.);
  if last_pos>0 then substr(row,last_pos,last_len)=put(last_num,best1.);
  
  *--- find first and last number ---*;
  a=input(substr(row,anydigit(row),1),best1.);
  b=input(substr(row,anydigit(row,-100),1),best1.);

  total=sum(total,a*10,b);

  if last then put 'Total: ' total;
datalines;
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
;
*--54431--correct;


