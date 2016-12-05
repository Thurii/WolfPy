(* Rewrite Wolfram code so that it's "eval" friendly *)
Port[expr_String] :=
 Fold[StringReplace,
  Rationalize[N@ToExpression@expr] // FullForm // ToString, {
   "E" -> ToString@N[E, 20],
   "Pi" -> ToString@N[Pi, 20],
   Shortest["Rational[" ~~ a__ ~~ ", " ~~ b__ ~~ "]"] ->
    "Fraction(" ~~ a ~~ ", " ~~ b ~~ ")",
   Shortest["Complex[" ~~ a__ ~~ ", " ~~ b__ ~~ "]"] ->
    "complex(" ~~ a ~~ ", " ~~ b ~~ ")",
   "List" | "`" -> ""
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
