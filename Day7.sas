options source notes;
data hand;
  *infile datalines truncover dlm=' '; *--- Test with the example ---*;
  infile 'h:\adventofcode2023\day7.txt' end=last truncover;
  input hand $ rank;

  *-- rank on card value --;
  *-- replace with hex --;
  *handx=translate(hand,'A','T','B','J','C','Q','D','K','E','A'); *- part one -*;
  handx=translate(hand,'A','T','1','J','C','Q','D','K','E','A'); *- part two -*;
  cardrank=input(handx,hex5.);

  *-- rank on hand --;
  *-- find jokers --;
  jokers=countc(hand,'J');
  *-- count cards --;
  handrank=0;
  do i=1 to 5;
    handrank=handrank+countc(hand,substr(hand,i,1));
  end;

  *-- update handrank with jokers --*;
  if handrank=17 and jokers=1 then handrank=25;
  if handrank=17 and jokers=4 then handrank=25;
  if handrank=13 and jokers=2 then handrank=25;
  if handrank=13 and jokers=3 then handrank=25;
  if handrank=11 and jokers=1 then handrank=17; 
  if handrank=11 and jokers=3 then handrank=17; 
  if handrank=9 and jokers=1 then handrank=13;
  if handrank=9 and jokers=2 then handrank=17;
  if handrank=7 and jokers=1 then handrank=11; 
  if handrank=7 and jokers=2 then handrank=11;
  if handrank=5 and jokers=1 then handrank=7;


datalines;
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
;

proc sort data=hand;
by handrank cardrank;
run;

data hand;
set hand;
totrank=_N_*rank;
run;

proc sql noprint;
  select put(sum(totrank),32.) into :total from hand;
quit;
%put Total: &total.;
*-243101568-*;

*-243146437- to high;
*-242909525- to low;
*-242865127- to low;
*-243111545- not right;


