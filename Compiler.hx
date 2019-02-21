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
    // token Identifier   | ⟨IDChar⟩ (⟨IDChar⟩ | ⟨Digit⟩)+ ;
    token String       | \" (⟨StrChar⟩ | ⟨Escapes⟩)+ \" ;

    token fragment Digit    | [0-9] ;    // token fragments
    token fragment IDChar   | [a-zA-Z$_] ;
    token fragment StrChar  | [^\"\\\n\r] ;  
    token fragment NewLine  | \n | \r\n | \r ;
    token fragment Escapes  | \\⟨NewLine⟩ | \\\" | \\\\ | \\n | \\t ;

    main sort Stat | ⟦⟧ ;
}