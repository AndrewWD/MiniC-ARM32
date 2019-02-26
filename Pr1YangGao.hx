module org.crsx.hacs.samples.Pr1YangGao {
    /* LEXICAL ANALYSIS */ 
    space [ \t\n\r] | "/*" ([^*] | "*" [^/])* "*/" | "//" .*;  

    // tokens for keywords
    token NULL      | null ; 
    token SIZEOF    | "sizeof" ;
    token VAR       | var ;
    token INT       | int ;
    token CHAR      | char ;
    token IF        | if ;
    token ELSE      | else ;
    token WHILE     | while ;
    token RETURN    | return ;
    token FUNCTION  | function ;
    //token MAIN      | main ;

    // Other tokens 
    token Integer      | ⟨Digit⟩+ ;          
    token Identifier   | ⟨IDChar⟩ (⟨IDChar⟩ | ⟨Digit⟩)* ;
    token String       | \" (⟨StrChar⟩ | ⟨Escapes⟩)+ \" ;

    // token fragments
    token fragment Digit    | [0-9] ;
    token fragment OCTDigit | [0-7] ;  
    token fragment HEXDigit | [0-9a-f] ; 
    token fragment IDChar   | [a-zA-Z$_] ;
    token fragment StrChar  | [^\"\\\n\r] ; 
    token fragment NewLine  | \n | \r \n | \r ;  // newline characters in Windows and Unix
    token fragment Escapes  | \\ ⟨NewLine⟩ | \\ \" | \\ \\ | \\ n | \\ t | \\ ⟨OCTDigit⟩ ⟨OCTDigit⟩? ⟨OCTDigit⟩? | \\ x ⟨HEXDigit⟩ ⟨HEXDigit⟩;    

    // Expressions
    sort Expr | ⟦ ⟨Expr@2⟩ || ⟨Expr@1⟩ ⟧@1    // Right recursive OR
              | ⟦ ⟨Expr@3⟩ && ⟨Expr@2⟩ ⟧@2    // Right recursive AND
              | ⟦ ⟨Expr@4⟩ == ⟨Expr@4⟩ ⟧@3    // Equality comparator
              | ⟦ ⟨Expr@4⟩ != ⟨Expr@4⟩ ⟧@3    // Inequality comparator
              | ⟦ ⟨Expr@5⟩ < ⟨Expr@5⟩ ⟧@4     // Smaller comparator
              | ⟦ ⟨Expr@5⟩ > ⟨Expr@5⟩ ⟧@4     // Greater comparator
              | ⟦ ⟨Expr@5⟩ <= ⟨Expr@5⟩ ⟧@4    // Smaller or equal to
              | ⟦ ⟨Expr@5⟩ >= ⟨Expr@5⟩ ⟧@4    // Greater or equal to
              | ⟦ ⟨Expr@5⟩ + ⟨Expr@6⟩ ⟧@5     // Addition
              | ⟦ ⟨Expr@5⟩ - ⟨Expr@6⟩ ⟧@5     // Subtraction
              | ⟦ ⟨Expr@6⟩ * ⟨Expr@7⟩ ⟧@6     // Multiplication
              | ⟦ ⟨Expr@6⟩ / ⟨Expr@7⟩ ⟧@6     // Division
              | ⟦ ⟨Expr@6⟩ % ⟨Expr@7⟩ ⟧@6     // Modulo
              | ⟦ !⟨Expr@7⟩ ⟧@7               // Inversion
              | ⟦ -⟨Expr@7⟩ ⟧@7               // Negative
              | ⟦ +⟨Expr@7⟩ ⟧@7               // Positive
              | ⟦ *⟨Expr@7⟩ ⟧@7               // Pointer
              | ⟦ &⟨Expr@7⟩ ⟧@7               // Bitwise AND
              | ⟦ ⟨Expr@8⟩(⟨ExprList⟩) ⟧@8   // Function call
              | ⟦ ⟨NULL⟩(⟨Type⟩) ⟧@8         // null type
              | ⟦ ⟨SIZEOF⟩(⟨Type⟩) ⟧@8       // Sizeof function
              | ⟦ ⟨Identifier⟩ ⟧@9            // Identifier
              | ⟦ ⟨String⟩ ⟧@9                // String
              | ⟦ ⟨Integer⟩ ⟧@9               // Integer
              | sugar ⟦ (⟨Expr#⟩) ⟧@9 → Expr# // parenthesis
              ; 
    
    // Productions to produce a list of zero or more expression
    sort ExprList | ⟦ ⟨Expr⟩, ⟨ExprList⟩ ⟧
                  | ⟦ ⟨Expr⟩ ⟧
                  | ⟦⟧
                  ;
    
    sort Type | ⟦ *⟨Type@1⟩ ⟧@1
              | ⟦ ⟨Type@2⟩ (⟨TypeList⟩) ⟧@2
              | ⟦ ⟨INT⟩ ⟧@3
              | ⟦ ⟨CHAR⟩ ⟧@3
              | sugar ⟦ (⟨Type#⟩) ⟧@3 → Type#
              ;

    // Productions to produce a list of zero or more types
    sort TypeList | ⟦ ⟨Type⟩, ⟨TypeList⟩ ⟧
                  | ⟦ ⟨Type⟩ ⟧
                  | ⟦⟧
                  ;
    
    // Statements
    sort Stat | ⟦ ⟨VAR⟩ ⟨Type⟩ ⟨Identifier⟩ ; ⟧ 
              | ⟦ ⟨Identifier⟩ = ⟨Expr⟩ ; ⟧
              | ⟦ *⟨Expr⟩ = ⟨Expr⟩ ; ⟧ 
              | ⟦ ⟨IF⟩ ( ⟨Expr⟩ ) ⟨Stat⟩ ⟧
              | ⟦ ⟨IF⟩ ( ⟨Expr⟩ ) ⟨Stat⟩ ⟨ELSE⟩ ⟨Stat⟩ ⟧
              | ⟦ ⟨WHILE⟩ ( ⟨Expr⟩ ) ⟨Stat⟩ ⟧
              | ⟦ ⟨RETURN⟩ ⟨Expr⟩ ; ⟧
              | ⟦ { ⟨StatList⟩ } ⟧
              ;

    // Productions to produce a list of zero or more statments
    sort StatList | ⟦ ⟨Stat⟩ ⟨StatList⟩ ⟧
                  | ⟦⟧
                  ;

    // Productions to produce a list of zero or more parameters
    sort ParaList | ⟦ ⟨Type⟩ ⟨Identifier⟩, ⟨ParaList⟩ ⟧
                  | ⟦ ⟨Type⟩ ⟨Identifier⟩ ⟧
                  | ⟦⟧
                  ;

    sort Declr | ⟦ ⟨FUNCTION⟩ ⟨Type⟩ ⟨Identifier⟩ ( ⟨ParaList⟩ ) { ⟨StatList⟩ } ⟧ ;

    // sort MainFunc | ⟦ ⟨FUNCTION⟩ ⟨Type⟩ ⟨MAIN⟩ ( ⟨ParaList⟩ ) { ⟨StatList⟩ } ⟧ ;
    
    main sort Program | ⟦ ⟨Declr⟩ ⟨Program⟩ ⟧
                      | ⟦ ⟨Declr⟩ ⟧
                      ;
}