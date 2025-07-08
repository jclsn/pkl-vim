if exists("b:current_syntax")
  finish
endif

syntax clear

syntax sync fromstart

" --- Comments ---
syntax match pklComment /^\s*\/\{2}\([^\/].*\)\?$/  " Regular comments
syntax match pklDocComment   /^\s*\/\{3}.*/         " Doc comments first (more specific)
syntax region pklMultiComment start=/\/\*/ end=/\*\// keepend

" --- Strings ---
syntax match pklEscape        /\\./ contained
syntax region pklString       start=+"+ skip=+\\."+ end=+"+ contains=pklEscape keepend oneline
syntax region pklMultiString  start=+"""+ skip=+\\."+ end=+"""+ contains=pklEscape keepend

" --- Object keys ---
syntax match pklKeyString /\v(["'])\zs.{-}\ze\1\s*:/

" --- Keywords ---
syntax keyword pklBoolean      false true
syntax keyword pklClass        abstract external final new open outer super this
syntax keyword pklConditional  elif else if then when
syntax keyword pklConstant     null
syntax keyword pklException    catch finally throw try
syntax keyword pklInclude      amends as extends from import module
syntax keyword pklKeyword      function is let out
syntax keyword pklPropertyMod  const fixed hidden local
syntax keyword pklProtected    case delete override protected record switch vararg
syntax keyword pklRepeat       for in while
syntax keyword pklSpecial      nothing
syntax keyword pklStatement    read return throws trace
syntax keyword pklStruct       class typealias

" --- Types ---
syntax keyword pklType         UInt UInt8 UInt16 UInt32 UInt64 UInt128 Int Int8 Int16 Int32 Int64 Int128 String Float Boolean Number

syntax keyword pklCollections  List Listing Set Map Mapping
syntax keyword pklMiscTypes    Duration DataSize
syntax keyword pklObjectTypes  Dynamic Typed Pair Any unknown Regex T

" --- Numbers ---
syntax match pklNumber /\v<0[xX][0-9a-fA-F]+|0[bB][01]+|0[oO][0-7]+|(\d+\.\d*|\d*\.\d+|\d+)>/
      \ containedin=ALLBUT,pklComment,pklDocComment,pklString,pklMultiString

" --- Brackets, operators, functions ---
syntax match pklBrackets  /[{}\[\]()]/
syntax match pklOperator /\v(\.\.|[=:+\-*<>])/
syntax match pklFunction  /\<\h\w*\>\ze\s*(/

" --- Highlight links ---
hi def link pklBoolean        Boolean
hi def link pklBrackets       Delimiter
hi def link pklClass          Statement
hi def link pklCollections    Type
hi def link pklComment        Comment
hi def link pklConditional    Conditional
hi def link pklConstant       Constant
hi def link pklDocComment     Comment
hi def link pklEscape         SpecialChar
hi def link pklException      Exception
hi def link pklFunction       Function
hi def link pklInclude        Include
hi def link pklKeyString      Identifier
hi def link pklKeyword        Keyword
hi def link pklMiscTypes      Type
hi def link pklMultiComment   Comment
hi def link pklMultiString    String
hi def link pklNumber         Number
hi def link pklObjectTypes    Type
hi def link pklOperator       Operator
hi def link pklPropertyMod    StorageClass
hi def link pklProtected      Special
hi def link pklRepeat         Repeat
hi def link pklSpecial        Special
hi def link pklStatement      Statement
hi def link pklString         String
hi def link pklStruct         Structure
hi def link pklType           Type

let b:current_syntax = "pkl"

