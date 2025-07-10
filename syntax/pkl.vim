if exists("b:current_syntax")
  finish
endif

syn	clear
syn	sync fromstart

syn	region	pklShebang		start="^\s*#!" end="$" keepend contains=@Nothing oneline

" --- Comments ---
syn	match	pklComment		"^\s*\/\{2}\([^\/].*\)\?$"
syn	match	pklDocComment	"^\s*\/\{3}.*"
syn	region	pklMultiComment	start="\/\*" end="\*\/" keepend fold

" --- Strings ---
syn	region	pklString		start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=pklEscape,pklUnicodeEscape keepend oneline
syn	region	pklMultiString	start=+"""+ skip=+\\."+ end=+"""+ contains=pklEscape,pklUnicodeEscape keepend fold
syn	match	pklEscape		"\\[\\nt0rbaeuf"']\?" contained containedin=pklString,pklMultiString
syn	match	pklUnicode		"[0-9A-Fa-f]\+" contained

" --- String interpolation---
" Identifiers inside interpolation brackets/parens
syn	match	pklIdentifier	"\<[A-Za-z_][A-Za-z0-9_]*\>" contained
syn	match	pklIdentifier	"\v\#[a-zA-Z]\{\zs[^\}]*\ze\}" contained

" Standard interpolation
syn	region	pklStringInterpolation
	  \ start=+\\(+ end=+)+ contains=pklNumbers,pklOperator,pklIdentifier
	  \ contained containedin=pklString,pklMultiString
" Unicode escape sequences
syn	region	pklUnicodeEscape
	  \ start=+\\u{+ end=+}+ contains=pklUnicode
	  \ contained containedin=pklString,pklMultiString

" -- Custom string delimiters ---
for x in range(1, 20)
  exe $'syn region pklMultiString{x}Pound	start=+' .. repeat("#", x) .. $'"""+  end=+"""{repeat("#", x)}+ contains=pklStringInterpolation{x}Pound,pklEscape{x}Pound keepend fold'
  exe $'hi def link pklMultiString{x}Pound String'

  exe $'syn region pklString{x}Pound	start=+' .. repeat("#", x) .. $'"+ end=+"{repeat("#", x)}+ contains=pklStringInterpolation{x}Pound,pklEscape{x}Pound keepend oneline'
  exe $'hi def link pklString{x}Pound String'

  exe $'syn match pklEscape{x}Pound "\\' .. repeat("#", x) .. $'[\\nt0rbaeuf"'']\?" contained containedin=pklString{x}Pound,pklMultiString{x}Pound'
  exe $'hi def link pklEscape{x}Pound SpecialChar'

  exe $'syn region pklStringInterpolation{x}Pound start=+\\' .. repeat("#", x) .. $'(+ end=+)+ contains=pklNumbers,pklOperator,pklIdentifier contained containedin=pklString{x}Pound,pklMultiString{x}Pound'
  exe $'hi def link pklStringInterpolation{x}Pound Delimiter'

  exe $'syn region pklUnicodeEscape{x}Pound start=+\\' .. repeat("#", x) .. 'u{+ end=+}+' .. $' contains=pklUnicode contained containedin=pklString{x}Pound,pklMultiString{x}Pound'
  exe $'hi def link pklUnicodeEscape{x}Pound SpecialChar'
endfor

" " --- Object keys ---
syn	match	  pklKeyString		"\v(["'])\zs.{-}\ze\1\s*:"

" --- Keywords ---
syn	keyword	  pklBoolean		false true
syn	keyword	  pklClass			abstract external final new open outer super this
syn	keyword	  pklConditional	elif else if then when
syn	keyword	  pklConstant		null
syn	keyword	  pklException		catch finally throw try
syn	keyword	  pklInclude		amends as extends from import module
syn	keyword	  pklKeyword		function is let out
syn	keyword	  pklPropertyMod	const fixed hidden local
syn	keyword	  pklProtected		case delete override protected record switch vararg
syn	keyword	  pklRepeat			for in while
syn	keyword	  pklSpecial		nothing
syn	keyword	  pklStatement		read return throws trace
syn	keyword	  pklStruct			class typealias
syn	match	  pklDecorator		"@[a-zA-Z]\{1,}"

" --- Types ---
syn	keyword	  pklType
	  \ UInt UInt8 UInt16 UInt32 UInt64 UInt128
	  \ Int Int8 Int16 Int32 Int64 Int128
	  \ String
	  \ Float
	  \ Boolean
	  \ Number

syn	keyword	  pklCollections
	  \ List Listing
	  \ Map Mapping
	  \ Set
syn	keyword	  pklMiscTypes		Duration DataSize
syn	keyword	  pklObjectTypes	Dynamic Typed Pair Any unknown Regex T

" --- Numbers ---
" decimal numbers
syn	match	pklNumbers		display transparent	  "\<\d\|\.\d" contains=pklNumber,pklFloat,pklOctal
" hex numbers
syn	match	pklNumber		display contained	  "\d\%(\d\+\)*\>"
syn	match	pklNumber		display contained	  "0x\x\%('\=\x\+\)\>"
" binary numbers
syn	match	pklNumber		display contained	  "0b[01]\%('\=[01]\+\)\>"
" octal numbers
syn	match	pklOctal		display contained	  "0o\o\+\>" contains=pklOctalZero
syn	match	pklOctalZero	display contained	  "\<0"

"floating point number, with dot, optional exponent
syn	match	pklFloat		display contained	  "\d\+\.\d*\%(e[-+]\=\d\+\)\="
"floating point number, starting with a dot, optional exponent
syn	match	pklFloat		display contained	  "\.\d\+\%(e[-+]\=\d\+\)\=\>"
"floating point number, without dot, with exponent
syn	match	pklFloat		display contained	  "\d\+e[-+]\=\d\+\>"

" --- Brackets, operators, functions ---
syn	region	pklParen	start='(' end=')'				contains=ALL
syn	region	pklBracket	start='\[\|<::\@!' end=']\|:>'	contains=ALL
syn	region	pklBlock	start="{" end="}"				contains=ALL fold

syn	match	pklOperator "\v(\.\.|[=:+\-*<>])"
syn	match	pklFunction  "\<\h\w*\>\ze\s*("

" --- Highlight links ---
hi def link pklBlock					Delimiter
hi def link pklBoolean					Boolean
hi def link pklBracket					Delimiter
hi def link pklClass					Statement
hi def link pklCollections				Type
hi def link pklComment					Comment
hi def link pklConditional				Conditional
hi def link pklConstant					Constant
hi def link pklDecorator				Special
hi def link pklDocComment				Comment
hi def link pklEscape					SpecialChar
hi def link pklException				Exception
hi def link pklFloat					Number
hi def link pklFunction					Function
hi def link pklInclude					Include
hi def link pklKeyString				Identifier
hi def link pklKeyword					Keyword
hi def link pklMiscTypes				Type
hi def link pklMultiComment				Comment
hi def link pklMultiString				String
hi def link pklNumber					Number
hi def link pklNumbers					Number
hi def link pklObjectTypes				Type
hi def link pklOctal					Number
hi def link pklOctalZero				Number
hi def link pklOperator					Operator
hi def link pklParen					Delimiter
hi def link pklPropertyMod				StorageClass
hi def link pklProtected				Special
hi def link pklRepeat					Repeat
hi def link pklShebang					Comment
hi def link pklSpecial					Special
hi def link pklStatement				Statement
hi def link pklString					String
hi def link pklStringInterpolation		Delimiter
hi def link pklStruct					Structure
hi def link pklType						Type
hi def link pklUnicodeEscape			SpecialChar

let b:current_syntax = "pkl"
