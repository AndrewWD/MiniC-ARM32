module org.crsx.hacs.samples.Compiler {
    /* LEXICAL ANALYSIS */ 
    space [ \t\n] ;  // white space or comments (to be done)

    token NULL      | null ;        // tokens for keywords
    token SIZEOF    | sizeof ;
    token VAR       | var ;
    token INT       | int ;
    token CHAR      | char ;
    token IF        | if ;
    token ELSE      | else ;
    token WHILE     | while ;
    token RETURN    | return ;
    token FUNCTION  | function ;

    token Integer      | ⟨Digit⟩+ ;          // tokens  
    token Identifier   | ⟨IDChar⟩ (⟨IDChar⟩ | ⟨Digit⟩)+ ;
    
    token fragment Digit  | [0-9] ;    // token fragments
    token fragment IDChar | ([a-zA-Z$_]) ;

    /* Temporary code for testing lexical part

    // token INTE    | ⟨Digit⟩+ ;                       // tokens
    // token FLOAT  | ⟨INTE⟩ "." ⟨INTE⟩ ;
    // token ID     | ⟨Lower⟩+ ('_'? ⟨INTE⟩)? ;

    // token fragment Lower  | [a-z] ;
    // /* SYNTAX ANALYSIS. */

    // sort Exp   | ⟦ ⟨Exp@1⟩ + ⟨Exp@2⟩ ⟧@1            // addition
    //         | ⟦ ⟨Exp@2⟩ * ⟨Exp@3⟩ ⟧@2            // multiplication
    //         | ⟦ ⟨INTE⟩ ⟧@3                        // integer
    //         | ⟦ ⟨FLOAT⟩ ⟧@3                      // floating point number
    //         | ⟦ ⟨Name⟩ ⟧@3                       // assigned value
    //         | sugar ⟦ (⟨Exp#⟩) ⟧@3 → Exp# ;       // parenthesis

    // sort Name  | symbol ⟦ ⟨ID⟩ ⟧ ;                  // assigned symbols

    // main sort Stat  | ⟦ ⟨Name⟩ := ⟨Exp⟩ ; ⟨Stat⟩ ⟧
    //                 | ⟦ { ⟨Stat⟩ } ⟨Stat⟩ ⟧
    //                 | ⟦⟧ ;
}