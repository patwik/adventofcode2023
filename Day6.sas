options source notes;
data kalle;
  *infile datalines truncover dlm=' '; *--- Test with the example ---*;
  infile 'h:\adventofcode2023\day6.txt' end=last truncover;
  array T[4];
  array D[4];
  array Tpmin[4];
  array Tpmax[4];
  array Antal[4];
  input dummy $ T1-T4;
  input dummy $ D1-D4;
  do i=1 to 4;
    Tpmin[i]=int((T[i]/2)-sqrt(((T[i]/2)**2)-D[i]));
    Tpmax[i]=int((T[i]/2)+sqrt(((T[i]/2)**2)-D[i]));
    if (T[i]-Tpmin[i])*Tpmin[i]=D[i] then Tpmin[i]=Tpmin[i]+1;
    
    Antal[i]=Tpmax[i]-Tpmin[i];
    put T[i]= D[i]= Tpmax[i]= Tpmin[i]= Antal[i]=;
  end;
  Total1=Antal[1]*Antal[2]*Antal[3]*Antal[4];
  put Total1=;

datalines;
Time:      7  15   30
Distance:  9  40  200
;
*-246906-;


data kalle;
  *infile datalines truncover dlm=':'; *--- Test with the example ---*;
  infile 'h:\adventofcode2023\day6.txt' dlm=':' end=last truncover;
  length T D $ 200;
  format Tc Dc 32.;
  input dummy $ T $;
  input dummy $ D $;
  
  Tc=input(compress(T),32.);
  Dc=input(compress(D),32.);
  

  Tpmin=int((Tc/2)-sqrt(((Tc/2)**2)-Dc));
  Tpmax=int((Tc/2)+sqrt(((Tc/2)**2)-Dc));
  if (Tc-Tpmin)*Tpmin=Dc then Tpmin=Tpmin+1;
  Total2=Tpmax-Tpmin;
  put Total2=;
 
datalines;
Time:      7  15   30
Distance:  9  40  200
;

*-- 56706216 --to high --;
    43364472
211904
