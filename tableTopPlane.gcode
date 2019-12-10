%
:2001 (Table Top Plane);
(this program planes rough tables to a specified depth)

(Tooling);
(Name of router bit and exact info);

(Set dimensions below:);
#100=36.0 (width of board in inches x-axis);
#101=60.0 (length of board in inches y-axis);
#102=7.25 (totalDepth to take DOWN z-axis, say 1/4");
#103=1.0625 (depthEachPass, say 1/16");
#104=1.0 (radius of tool bit);
#105=700 (spindle rpm);
#106=1 (feedRate);


;
#132=[#104*2] (diameter  of tool bit);

G20 (G20 for Imperial G21 Metric);
G90 (absolute position mode);
G40 P#104 (no offset, P#104 is tool radius cutting );
G00 X-300.0 Y210.0 (rapid move the tool into position, start at top right of board dimensions TBD);
G91 (relative X-axis mode);
M01 (operator checks dimensions before starting);
S#105 M3 (Spindle speed, Clockwise spin TBD);
;
#131=0.0 (depthMilled starts zero'd out);
WHILE [#131 LT #102] DO1
  #130=0.0 (width starts zero'd out);
  IF [ [#102-#131] GE #103] THEN #1=#103;
  IF [ [#102-#131] LT #103] THEN #1=[#102-#131];
  G01 Z-#1 F#106 (cut 1/16th inch) ;
  

  WHILE [#130 LT #100] DO2
    G01 Y[-#101] F#106 (move/cut Y axis DOWN for length ; 
    G01 X#132 (cut X-over by diameter of tool);
    #130=[#130 + #132] (widthDone = widthDone + diameter of tool);
    G01 Y[#101] (cut Y axis UP length  );
    G01 X#132 (cut X-over diameter of tool);
    #130=[#130 + #132] (widthDone = widthDone + diameter of tool);
  END2
#131=[#131+#103] (depthMilled=depthMilled+depthEachPass);
G00 Z[#131+3](lift up  a bit);
G00 X-#130 (rapid move the tool into position, back at top left of board dimensions TBD);
G00 Z[-#131-3] (drop back down);
END1
;
(wrap it up);
Z#102;
Z12;
M05;
G91;
G00 X0.0 Y0.0; 
M30;
