(* "RawForm" is like a more verbose "FullForm" *)
(* RawForm[1+Pi+E+3 I] == "PlusSTART ComplexSTART 1,3 ComplexEND,E,Pi PlusEND"*)
RawForm[expr_] := Module[{funcs = {}},
  StringJoin@Table[
    If[StringMatchQ[s, WordCharacter .. ~~ "["],
     AppendTo[funcs, " " <> First@StringCases[s, WordCharacter ..]]; 
     StringReplace[s, "[" -> "START "],
     If[s == "]", Module[{f = funcs[[-1]]},
       funcs = funcs[[;; -2]]; f <> "END"], s]
     ],
    {s, StringSplit@
      StringReplace[
       ToString@FullForm@expr, {"[" -> "[ ", "]" -> " ] "}]}
    ]
  ]

(* Rewrite "RawForm" code so that it's "eval" friendly*)
PythonCompile[expr_String] := StringReplace[expr, {
   "ListSTART" -> "[", "ListEND" -> "]",
   "PlusSTART" -> "sum([", "PlusEND" -> "])",
   "TimesSTART" -> "self.Times([", "TimesEND" -> "])",
   "ComplexSTART" -> "complex(", "ComplexEND" -> ")",
   "RationalSTART" -> "Fraction(", "RationalEND" -> ")",
   "PowerSTART" -> "pow(", "PowerEND" -> ")"
   }]

expr = "relay.ramdisk/relayi"~Import~"Text" (* don't re-evaluate old expressions *)
While[True,
    If[expr != "relay.ramdisk/relayi"~Import~"Text",
        expr = "relay.ramdisk/relayi"~Import~"Text"//ToExpression//RawForm//PythonCompile;
        Export["relay.ramdisk/relayo", expr, "String"]
    ];
    Pause@.25 (* keeps the CPU cool *)
]
