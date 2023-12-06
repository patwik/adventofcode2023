options nosource nonotes;
data won(keep=card word) have(keep=card word);
  *infile datalines truncover end=last; *--- Test with the example ---*;
  infile 'h:\adventofcode2023\day4.txt' end=last truncover;
  length word $ 2;

  input row $140.  ;
  card=input(scan(row,2,' :'),best.);
  won=scan(row,2,'|:');
  have=scan(row,3,'|:');
  
  i=1;  
  do until (word='');
      word=scan(won,i,' ');   *--word is a number on the card--;
      if word ne '' then output won;
      i+1;
  end;

  i=1;
  do until (word='');
      word=scan(have,i,' '); 
      if word ne '' then output have;
      i+1;
  end;
datalines;
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
;

proc sql;
create table cards as (
select won.card,2**(count(*)-1) as wins
  from won,have
  where won.card=have.card
    and won.word=have.word
  group by won.card);
  select sum(wins) into :total from cards;
quit;

%put Total1: &total;

proc sql;
create table card2 as (
select won.card,count(*) as wins
  from won,have
  where won.card=have.card
    and won.word=have.word
  group by won.card);

 create table card3 as (
 select a.card as card,
        b.wins as wins 
   from (select distinct card from have) a 
   left join card2 b
   on a.card=b.card 
         );
  
quit;

data _null_;
array acards[500] _temporary_;
array awins[500] _temporary_;
do i=1 to 500 until (last);
  set card3 end=last;
  acards[i]=1;
  awins[i]=wins;
end;
max=i;

do i=1 to max ;
   do k=i+1 to sum(i,awins[i]);
       acards[k]=sum(acards[k],acards[i]);
    end;
end;

do i=1 to max ;
  total=sum(total,acards[i]);
end;
put 'Total2: ' total;
run;

*-- Total2:  5329815 *--;

