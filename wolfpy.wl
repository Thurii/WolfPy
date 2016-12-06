(* Rewrite Wolfram code so that it's "eval" friendly *)
Port[expr_String] :=
 Fold[StringReplace, 
  Rationalize[ToExpression@expr] // FullForm // ToString, {
   Shortest["Rational[" ~~ a__ ~~ ", " ~~ b__ ~~ "]"] -> 
    "Fraction(" ~~ a ~~ ", " ~~ b ~~ ")",
   Shortest["Complex[" ~~ a__ ~~ ", " ~~ b__ ~~ "]"] -> 
    "complex(" ~~ a ~~ ", " ~~ b ~~ ")",
   "List" | "`" -> "",
   Shortest["Times[" ~~ a__ ~~ "]"] -> "Times([" ~~ a ~~ "])",
   Longest["Plus[" ~~ a__ ~~ "]"] -> "sum([" ~~ a ~~ "])"
   }
  ]

expr = "relay.ramdisk/relayi"~Import~"Text" (* don't re-evaluate old expressions *)
While[True,
    If[expr != "relay.ramdisk/relayi"~Import~"Text",
        expr = "relay.ramdisk/relayi"~Import~"Text"//Port;
        Export["relay.ramdisk/relayo", expr, "String"]
    ];
    Pause@.25 (* keeps the CPU cool *)
]
