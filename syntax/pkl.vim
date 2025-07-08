" Quit if already loaded
if exists("b:current_syntax")
  finish
endif

" --- Comments ---
" Regular single-line comments starting with //
syntax match pklComment  /\/\{2}.*$/
" Triple-slash documentation comments
syntax match pklDocComment /\/\{3}.*$/
" Multi-line comments
syntax region pklMultiComment start=/\/\*/ end=/\*\// keepend

" --- Strings ---
" Match strings not followed by colon → regular value string
syntax match pklEscape /\\./ contained
syntax region pklString start=+"+ skip=+\\."+ end=+"+ contains=pklEscape keepend oneline
syntax region pklMultiString start=+"""+ skip=+\\."+ end=+"""+ contains=pklEscape keepend

" Match object keys → "key": or 'key':
syntax match pklKeyString +\v(["']).{-}\1\s*/+

" --- Keywords ---
syntax keyword pklKeyword let in match of type implements with object enum 
      \ return yield static val is outer local
      \ hidden function

syntax keyword pklBoolean true false
syntax keyword pklClass this final super abstract new
syntax keyword pklConditional if else then elif
syntax keyword pklConstant null
syntax keyword pklException try catch finally throw throws
syntax keyword pklInclude module import amends from extends as
syntax keyword pklProtected protected override record delete case switch vararg
syntax keyword pklRepeat for while
syntax keyword pklStruct class

" --- Data types ---
syntax keyword pklType UInt UInt8 UInt16 UInt32 UInt64 UInt128 Int Int8 Int16 Int32 Int64 Int128 
      \ String Float Boolean Number
syntax keyword pklCollections List Listing Set Map Mapping
syntax keyword pklObjectTypes Dynamic Typed Pair Any Nothing unknown Regex T
syntax keyword pklMiscTypes Duration DataSize

" --- Numbers ---
" syntax match pklNumber /\v(^|[^A-Za-z0-9_])(\d+(\.\d*)?|\.\d+)/ 
syntax match pklNumber /\v<(\d+\.\d*|\d*\.\d+|\d+)>/
      \ containedin=ALLBUT,pklComment,pklDocComment,pklString,pklMultiString

" --- Brackets and punctuation ---
syntax match pklBrackets /[{}\[\]()]/
syntax match pklOperator "[=:+\-*<>]"

" --- Functions ---
syntax match pklFunction /\<\h\w*\>\ze\s*(\s*)/

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
hi def link pklProtected      Special
hi def link pklRepeat         Repeat
hi def link pklString         String
hi def link pklStruct         Structure
hi def link pklType           Type

let b:current_syntax = "pkl"
