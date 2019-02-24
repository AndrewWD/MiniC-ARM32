module org.crsx.hacs.samples.Pr1YangGao {
    /* LEXICAL ANALYSIS */ 
    space [ \t\n] | nested "/*" "*/" | "//" .*;  // white space or comments (seems the comments will not show in output, but not sure what will happen if it is put between two statments)

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
    //token Identifier   | ⟨IDChar⟩ (⟨IDChar⟩ | ⟨Digit⟩)+ ;
    token String       | \" (⟨StrChar⟩ | ⟨Escapes⟩)+ \" ;

    // token fragments
    token fragment Digit    | [0-9] ;
    token fragment OCTDigit | [0-7] ;  
    token fragment HEXDigit | [0-9a-f] ; 
    token fragment IDChar   | [a-zA-Z$_] ;
    token fragment StrChar  | [^\"\\\n\r] ;  
    token fragment NewLine  | \n | \r \n | \r ;  // newline characters in Windows and Unix
    token fragment Escapes  | \\ ⟨NewLine⟩ | \\ \" | \\ \\ | \\ n | \\ t | \\ ⟨OCTDigit⟩ ⟨OCTDigit⟩? ⟨OCTDigit⟩? | \\ x ⟨HEXDigit⟩ ⟨HEXDigit⟩;

    main sort Stat | ⟦⟧ ;
}