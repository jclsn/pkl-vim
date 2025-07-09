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
" One pound
syntax region pklMultiStringOnePound  start=+#"""+  end=+"""#+ contains=pklStringInterpolationOnePound,pklEscapeOnePound keepend
syntax region pklStringOnePound   start=+#"+ end=+"#+ contains=pklStringInterpolationOnePound,pklEscapeOnePound keepend oneline
syntax match pklEscapeOnePound "\\#[\\nt0rbaeuf"']\?" contained containedin=pklStringOnePound,pklMultiStringOnePound
syntax region pklStringInterpolationOnePound
      \ start=+\\#(+ end=+)+ contains=pklNumbers,pklOperator,pklIdentifier
      \ contained containedin=pklStringOnePound,pklMultiStringOnePound
syntax region pklUnicodeEscapeOnePound
      \ start=+\\#u{+ end=+}+ contains=pklUnicode
      \ contained containedin=pklStringOnePound,pklMultiStringOnePound

" Two pounds
syntax region pklMultiStringTwoPounds  start=+##"""+  end=+"""##+ contains=pklStringInterpolationTwoPounds,pklEscapeTwoPounds keepend
syntax region pklStringTwoPounds   start=+##"+ end=+"##+ contains=pklStringInterpolationTwoPounds,pklEscapeTwoPounds keepend oneline
syntax match pklEscapeTwoPounds "\\##[\\nt0rbaeuf"']\?" contained containedin=pklStringTwoPounds,pklMultiStringTwoPounds
syntax region pklStringInterpolationTwoPounds
      \ start=+\\##(+ end=+)+ contains=pklNumbers,pklOperator,pklIdentifier
      \ contained containedin=pklStringTwoPounds,pklMultiStringTwoPounds
syntax region pklUnicodeEscapeTwoPounds
      \ start=+\\##u{+ end=+}+ contains=pklUnicode
      \ contained containedin=pklStringTwoPounds,pklMultiStringTwoPounds

" Three pounds
syntax region pklMultiStringThreePounds  start=+###"""+  end=+"""###+ contains=pklStringInterpolationThreePounds,pklEscapeThreePounds keepend
syntax region pklStringThreePounds   start=+###"+ end=+"###+ contains=pklStringInterpolationThreePounds,pklEscapeThreePounds keepend oneline
syntax match pklEscapeThreePounds "\\###[\\nt0rbaeuf"']\?" contained containedin=pklStringThreePounds,pklMultiStringThreePounds
syntax region pklStringInterpolationThreePounds
      \ start=+\\###(+ end=+)+ contains=pklNumbers,pklOperator,pklIdentifier
      \ contained containedin=pklStringThreePounds,pklMultiStringThreePounds
syntax region pklUnicodeEscapeThreePounds
      \ start=+\\###u{+ end=+}+ contains=pklUnicode
      \ contained containedin=pklStringThreePounds,pklMultiStringThreePounds

" Four pounds
syntax region pklMultiStringFourPounds  start=+####"""+  end=+"""####+ contains=pklStringInterpolationFourPounds,pklEscapeFourPounds keepend
syntax region pklStringFourPounds   start=+####"+ end=+"####+ contains=pklStringInterpolationFourPounds,pklEscapeFourPounds keepend oneline
syntax match pklEscapeFourPounds "\\####[\\nt0rbaeuf"']\?" contained containedin=pklStringFourPounds,pklMultiStringFourPounds
syntax region pklStringInterpolationFourPounds
      \ start=+\\####(+ end=+)+ contains=pklNumbers,pklOperator,pklIdentifier
      \ contained containedin=pklStringFourPounds,pklMultiStringFourPounds
syntax region pklUnicodeEscapeFourPounds
      \ start=+\\####u{+ end=+}+ contains=pklUnicode
      \ contained containedin=pklStringFourPounds,pklMultiStringFourPounds

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
syntax region	pklParen		start='(' end=')' contains=ALLBUT,pklString
syntax region	pklBracket      start='\[\|<::\@!' end=']\|:>' end='}'me=s-1 contains=ALLBUT,pklString
syntax region	pklBlock		start="{" end="}" contains=ALLBUT,pklString

syntax match pklOperator /\v(\.\.|[=:+\-*<>])/
syntax match pklFunction  /\<\h\w*\>\ze\s*(/

" --- Highlight links ---
hi def link pklBlock                     Delimiter
hi def link pklBoolean                   Boolean
hi def link pklBrackets                  Delimiter
hi def link pklClass                     Statement
hi def link pklCollections               Type
hi def link pklComment                   Comment
hi def link pklConditional               Conditional
hi def link pklConstant                  Constant
hi def link pklDecorator                 Special
hi def link pklDocComment                Comment
hi def link pklException                 Exception
hi def link pklFloat                     Number
hi def link pklFunction                  Function
hi def link pklInclude                   Include
hi def link pklKeyString                 Identifier
hi def link pklKeyword                   Keyword
hi def link pklMiscTypes                 Type
hi def link pklMultiComment              Comment
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
hi def link pklSpecial                   Special
hi def link pklStatement                 Statement
hi def link pklStruct                    Structure
hi def link pklType                      Type

" Strings
let s:string_group = split('
      \ pklString
      \ pklStringOnePound
      \ pklStringTwoPounds
      \ pklStringThreePounds
      \ pklStringFourPounds
      \ ')
for string in s:string_group
  execute 'hi def link ' . string . ' String'
endfor

let s:string_group = split('
      \ pklMultiString
      \ pklMultiStringOnePound
      \ pklMultiStringTwoPounds
      \ pklMultiStringThreePounds
      \ pklMultiStringFourPounds
      \')
for string in s:string_group
  execute 'hi def link ' . string . ' String'
endfor

let s:delimiter_group = split('
      \ pklStringInterpolation             
      \ pklStringInterpolationOnePound    
      \ pklStringInterpolationTwoPounds  
      \ pklStringInterpolationThreePounds
      \ pklStringInterpolationFourPounds
      \')
for delimiter in s:delimiter_group
  execute 'hi def link ' . delimiter . ' Delimiter'
endfor

let s:escape_group = split('
      \ pklEscape             pklUnicodeEscape 
      \ pklEscapeOnePound     pklUnicodeEscapeOnePound
      \ pklEscapeTwoPounds    pklUnicodeEscapeTwoPounds
      \ pklEscapeThreePounds  pklUnicodeEscapeThreePounds 
      \ pklEscapeFourPounds   pklUnicodeEscapeFourPounds
      \')
for escape in s:escape_group
  execute 'hi def link ' . escape . ' SpecialChar'
endfor

let b:current_syntax = "pkl"

