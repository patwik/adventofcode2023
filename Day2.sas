options nosource notes;
data _null_;
  
  *infile datalines dlm=':' truncover end=last; *--- Test with the example ---*;
  infile 'h:\adventofcode2023\day2.txt' dlm=':' end=last truncover;

  *-- find colon using dlm --;
  input game $ row $200.  ;
  game_id=input(scan(game,2,' :'),best.);

  *-- setup --;
  retain total 0  ;
  length number 8 color $ 8;
  valid=1;

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
datalines4;
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
;;;;
*--69629--:

