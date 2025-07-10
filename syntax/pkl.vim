if exists("b:current_syntax")
  finish
endif

syntax clear
syntax sync fromstart

syntax region pklShebang start=/^\s*#!/ end=/$/ keepend contains=@Nothing oneline

" --- Comments ---
syntax match pklComment /^\s*\/\{2}\([^\/].*\)\?$/  " Regular comments
syntax match pklDocComment   /^\s*\/\{3}.*/         " Doc comments first (more specific)
syntax region pklMultiComment start=/\/\*/ end=/\*\// keepend

" --- Strings ---
syntax region pklString	 start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=pklEscape,pklUnicodeEscape keepend oneline
syntax region pklMultiString start=+"""+ skip=+\\."+ end=+"""+ contains=pklEscape,pklUnicodeEscape keepend
syntax match pklEscape "\\[\\nt0rbaeuf"']\?" contained containedin=pklString,pklMultiString
syntax match pklUnicode /[0-9A-Fa-f]\+/ contained

" --- String interpolation---
" Identifiers inside interpolation brackets/parens
syntax match pklIdentifier "\<[A-Za-z_][A-Za-z0-9_]*\>" contained
syntax match pklIdentifier "\v\#[a-zA-Z]\{\zs[^\}]*\ze\}" contained

" Standard interpolation
syntax region pklStringInterpolation
      \ start=+\\(+ end=+)+ contains=pklNumbers,pklOperator,pklIdentifier
      \ contained containedin=pklString,pklMultiString
" Unicode escape sequences
syntax region pklUnicodeEscape
      \ start=+\\u{+ end=+}+ contains=pklUnicode
      \ contained containedin=pklString,pklMultiString

" -- Custom string delimiters ---
for x in range(1, 20)
    exe $'syntax region pklMultiString{x}Pound  start=+' .. repeat("#", x) .. $'"""+  end=+"""{repeat("#", x)}+ contains=pklStringInterpolation{x}Pound,pklEscape{x}Pound keepend'
    exe $'hi def link pklMultiString{x}Pound String'

    exe $'syntax region pklString{x}Pound   start=+' .. repeat("#", x) .. $'"+ end=+"{repeat("#", x)}+ contains=pklStringInterpolation{x}Pound,pklEscape{x}Pound keepend oneline'
    exe $'hi def link pklString{x}Pound String'

    exe $'syntax match pklEscape{x}Pound "\\' .. repeat("#", x) .. $'[\\nt0rbaeuf"'']\?" contained containedin=pklString{x}Pound,pklMultiString{x}Pound'
    exe $'hi def link pklEscape{x}Pound SpecialChar'

    exe $'syntax region pklStringInterpolation{x}Pound start=+\\' .. repeat("#", x) .. $'(+ end=+)+ contains=pklNumbers,pklOperator,pklIdentifier contained containedin=pklString{x}Pound,pklMultiString{x}Pound'
    exe $'hi def link pklStringInterpolation{x}Pound Delimiter'

    exe $'syntax region pklUnicodeEscape{x}Pound start=+\\' .. repeat("#", x) .. 'u{+ end=+}+' .. $' contains=pklUnicode contained containedin=pklString{x}Pound,pklMultiString{x}Pound'
    exe $'hi def link pklUnicodeEscape{x}Pound SpecialChar'
endfor

" " --- Object keys ---
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
syntax match pklDecorator /@[a-zA-Z]\{1,}/

" --- Types ---
syntax keyword pklType         UInt UInt8 UInt16 UInt32 UInt64 UInt128 Int Int8 Int16 Int32 Int64 Int128 String Float Boolean Number

syntax keyword pklCollections  List Listing Set Map Mapping
syntax keyword pklMiscTypes    Duration DataSize
syntax keyword pklObjectTypes  Dynamic Typed Pair Any unknown Regex T

" --- Numbers ---
syntax match    pklNumbers    display transparent     "\<\d\|\.\d" contains=pklNumber,pklFloat,pklOctal
" decimal numbers
" hex numbers
syntax match    pklNumber     display contained       "\d\%(\d\+\)*\>"
syntax match    pklNumber     display contained       "0x\x\%('\=\x\+\)\>"
" binary numbers
syntax match    pklNumber     display contained       "0b[01]\%('\=[01]\+\)\>"
" octal numbers
syntax match    pklOctal      display contained       "0o\o\+\>" contains=pklOctalZero
syntax match    pklOctalZero  display contained       "\<0"

"floating point number, with dot, optional exponent
syntax match	pklFloat      display contained       "\d\+\.\d*\%(e[-+]\=\d\+\)\="
"floating point number, starting with a dot, optional exponent
syntax match	pklFloat      display contained       "\.\d\+\%(e[-+]\=\d\+\)\=\>"
"floating point number, without dot, with exponent
syntax match	pklFloat      display contained       "\d\+e[-+]\=\d\+\>"

" --- Brackets, operators, functions ---
" syntax match pklBrackets  /[{}\[\]()]/
syntax region	pklParen		start='(' end=')' contains=ALL
syntax region	pklBracket      start='\[\|<::\@!' end=']\|:>' contains=ALL
syntax region	pklBlock		start="{" end="}" contains=ALL

syntax match pklOperator /\v(\.\.|[=:+\-*<>])/
syntax match pklFunction  /\<\h\w*\>\ze\s*(/

" --- Highlight links ---
hi def link pklBlock                     Delimiter
hi def link pklBoolean                   Boolean
hi def link pklBracket                   Delimiter
hi def link pklClass                     Statement
hi def link pklCollections               Type
hi def link pklComment                   Comment
hi def link pklConditional               Conditional
hi def link pklConstant                  Constant
hi def link pklDecorator                 Special
hi def link pklDocComment                Comment
hi def link pklEscape                    SpecialChar
hi def link pklException                 Exception
hi def link pklFloat                     Number
hi def link pklFunction                  Function
hi def link pklInclude                   Include
hi def link pklKeyString                 Identifier
hi def link pklKeyword                   Keyword
hi def link pklMiscTypes                 Type
hi def link pklMultiComment              Comment
hi def link pklMultiString               String
hi def link pklNumber                    Number
hi def link pklNumbers                   Number
hi def link pklObjectTypes               Type
hi def link pklOctal                     Number
hi def link pklOctalZero                 Number
hi def link pklOperator                  Operator
hi def link pklParen                     Delimiter
hi def link pklPropertyMod               StorageClass
hi def link pklProtected                 Special
hi def link pklRepeat                    Repeat
hi def link pklShebang                   Comment
hi def link pklSpecial                   Special
hi def link pklStatement                 Statement
hi def link pklString                    String
hi def link pklStringInterpolation       Delimiter
hi def link pklStruct                    Structure
hi def link pklType                      Type
hi def link pklUnicodeEscape             SpecialChar

let b:current_syntax = "pkl"
