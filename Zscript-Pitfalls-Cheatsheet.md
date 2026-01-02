# NOTES ABOUT ZSCRIPT IRREGURALITIES





## CHAINING SNAKE CASE VARIABLES

### If variables starts with same prefix, then act like single variable


```
    /* THIS WORK */
    [VarDef, foo,      "foo" ]      	// return "foo"
    [VarDef, foobar,   "foobar" ]       // return "foobar"
    [VarDef, Xfoo_bar, "Xfoo_bar" ] 	// return "Xfoo_bar"
    [VarDef, foox_bar,  "foox_bar" ]     // return "foox_bar"

    /* THIS NOT WORK */
    [VarDef, foo_bar,  "foo_bar" ]       // return "foo" as #foo WTF ?
    [VarDef, foo_bar_baz,"foo_bar_baz" ] // return "foo" as #foo WTF ?

    /* THIS CAUSES ERROR in [Note] */
    [VarDef, _foo_bar,  "_foo_bar" ]       // return "foo" as #foo WTF ?

	/* DUMP */
    [Note, [StrMerge,
        " foo: ",            	foo,
        "\n foobar: ",       	foobar,
        "\n Xfoo_bar: ",       	Xfoo_bar,
        "\n foox_bar: ",       	foox_bar,

        "\n foo_bar: ", 	foo_bar,
        "\n foo_bar_baz: ",	foo_bar_baz
    ]]

```


## MATH

THIS WORK
```

	[VarDef, foonumber, 0 ]
	[VarSet, foonumber, (#foonumber + 1) ]

```

THIS CAUSES ERROR

```
	[VarDef, foo_number, 0 ]
	[VarSet, foo_number, (#foo_number + 1) ]

```


## COMPARE VALUES

Always wrap to brackets "()"

```
	[VarDef, value, 99]
	[VarSet, value, (#value + 1)]

	[VarDef, testok,  (#value == 100)] // THIS WORK
	[VarDef, testwtf,  #value == 100]  // THIS NOT WORK

	/* DUMP */
    [Note, [StrMerge,
        " value: ",  value,   " // value for compare: ( value == 100 )\n\n",
        "testok: ",  testok,  " // OK return true \n\n",
        "testwtf: ", testwtf, " // WTF return 100 - WHY ????"
    ]]

```


## SCRIPT ACTS LIKE INSTANCE OF CLASS MORE THEN SCRIPT

### *VARIABLES ARE PERSISTENT !!!*

• IF SCRIPT RUNS MULTIPLE TIMES, THAN VALUES OF VARIABLE STAY DEFINED
• What is [VarDef] good for ? ... I don`t know

Solution: Use [VarSet] with init value instead of [VarDef]

```
[IButton, PERSIST_VALUES, "",

	[VarDef, counter]

	[VarSet, counter, ( counter+1)]

	/* ADD 1 ON EACH EXECTION, BUT IT SHOULD NOT BECAUSE OF [VarDef] */
	[Note, [StrMerge, "counter: ", counter ] ]

,/*Disabled*/, 256 ,/*Hotkey*/,/*Icon*/,64]

```




# CONDITIONS

```
	[VarSet, snake_case, 1]

	[If,  ( [Var, found_subtool] > 0 ),] // THIS WORK

	[If,  ( #found_subtool < 0 ),] // THIS NOT WORK

```








# SQUARE, BRACKETS, EVERYWHERE ! YEEEAH BABY
```
[square, brackets, everywhere][square, brackets, everywhere][square, brackets, everywhere]
[square, brackets, everywhere][square, brackets, everywhere][square, brackets, everywhere]
[square, brackets, everywhere][square, brackets, everywhere][square, brackets, everywhere]
[square, brackets, everywhere][square, brackets, everywhere][square, brackets, everywhere]
[square, brackets, everywhere][square, brackets, everywhere][square, brackets, everywhere]
[square, brackets, everywhere][square, brackets, everywhere][square, brackets, everywhere]
[square, brackets, everywhere][square, brackets, everywhere][square, brackets, everywhere]
[square, brackets, everywhere][square, brackets, everywhere][square, brackets, everywhere]
[square, brackets, everywhere][square, brackets, everywhere][square, brackets, everywhere]
[square, brackets, everywhere][square, brackets, everywhere][square, brackets, everywhere]
[square, brackets, everywhere][square, brackets, everywhere][square, brackets, everywhere]

```
