" Quit if already loaded
if exists("b:current_syntax")
  finish
endif

" --- Comments ---
" Regular single-line comments starting with #
syntax match pklComment /#.*$/
" Triple-slash documentation comments
syntax match pklDocComment /^\s*\/\/\/.*$/

" --- Strings ---
" Match strings not followed by colon → regular value string
syntax region pklString start=+"+ skip=+\\."+ end=+"+ nextgroup=pklColon skipwhite
      \ contains=pklEscape keepend
syntax match pklEscape /\\./ contained

" Match object keys → "key": or 'key':
syntax match pklKeyString +\v(["']).{-}\1\s*:+

" --- Keywords ---
syntax keyword pklKeyword let in match case of type class implements with object enum 
      \ interface throws try catch finally throw return yield override abstract static 
      \ final val is this outer super local hidden

syntax keyword pklBoolean true false
syntax keyword pklConstant null
syntax keyword pklRepeat for while
syntax keyword pklConditional if else then elif
syntax keyword pklInclude module import amends from extends as

" --- Data types ---
syntax keyword pklType UInt UInt8 UInt16 UInt32 UInt64 UInt128 Int Int8 Int16 Int32 Int64 Int128 
      \ String Float Boolean Number
syntax keyword pklCollections List Listing Set Map Mapping
syntax keyword pklObjectTypes Dynamic Typed Pair Any Nothing unknown Regex T
syntax keyword pklMiscTypes Duration DataSize

" --- Numbers ---
syntax match pklNumber /\v(^|[^A-Za-z0-9_])(\d+(\.\d*)?|\.\d+)/ 
      \ containedin=ALLBUT,pklType,pklComment,pklDocComment

" --- Brackets and punctuation ---
syntax match pklBrackets /[{}\[\]()]/
syntax match pklOperator "[=:+\-*<>]"

" --- Functions ---
syntax match pklFunction /\<\h\w*\>\ze\s*(\s*)/

" --- Highlight links ---
hi def link pklRepeat         Repeat
hi def link pklBoolean        Boolean
hi def link pklBrackets       Delimiter
hi def link pklCollections    Type
hi def link pklComment        Comment
hi def link pklConditional    Conditional
hi def link pklConstant       Constant
hi def link pklDocComment     Comment
hi def link pklEscape         SpecialChar
hi def link pklFunction       Function
hi def link pklKeyString      Identifier
hi def link pklKeyword        Keyword
hi def link pklInclude        Include
hi def link pklMiscTypes      Type
hi def link pklNumber         Number
hi def link pklObjectTypes    Type
hi def link pklOperator       Operator
hi def link pklString         String
hi def link pklType           Type

let b:current_syntax = "pkl"
