" Enhanced YAML syntax with Jinja support
" This extends the default YAML syntax to properly handle Jinja templates
" Colors automatically adapt to your active colorscheme

" Only load this if YAML syntax is active and file has .jinja extension
if !exists("b:current_syntax") || b:current_syntax != "yaml"
  finish
endif

" Check if this is a Jinja template file
let s:is_jinja = expand('%:e') ==# 'jinja' || expand('%:e') ==# 'jinja2' || expand('%') =~# '\.jinja$'

if !s:is_jinja
  finish
endif

" Jinja template syntax regions with proper priority

" Jinja comments {# ... #}
syntax region jinjaComment start="{#" end="#}" contains=jinjaTodo
syntax keyword jinjaTodo contained TODO FIXME XXX NOTE

" Jinja variable expressions {{ ... }}
syntax region jinjaVariable start="{{" end="}}" contains=jinjaFilter,jinjaOperator,jinjaString,jinjaNumber
syntax match jinjaFilter /|[a-zA-Z_][a-zA-Z0-9_]*/ contained
syntax match jinjaNumber /\<\d\+\>/ contained

" Jinja statement blocks {% ... %}
syntax region jinjaStatement start="{%" end="%}" contains=jinjaKeyword,jinjaOperator,jinjaString,jinjaFilter,jinjaNumber,jinjaBuiltin
syntax keyword jinjaKeyword contained if elif else endif for endfor block endblock extends include import
syntax keyword jinjaKeyword contained macro endmacro call endcall filter endfilter set raw endraw
syntax keyword jinjaBuiltin contained is defined not in and or

" Jinja strings within templates
syntax region jinjaString start=/"/ skip=/\\"/ end=/"/ contained
syntax region jinjaString start=/'/ skip=/\\'/ end=/'/ contained

" Operators
syntax match jinjaOperator /[+\-*/%=!<>]/ contained

" Link to standard highlight groups - works with ANY colorscheme
" These groups are universally supported and will use your active theme's colors
highlight link jinjaComment Comment
highlight link jinjaTodo Todo
highlight link jinjaKeyword Conditional
highlight link jinjaBuiltin Function
highlight link jinjaFilter Function
highlight link jinjaOperator Operator
highlight link jinjaString String
highlight link jinjaNumber Number

" Make delimiters subtle but distinguishable
highlight link jinjaVariable Delimiter
highlight link jinjaStatement PreProc

let b:current_syntax = "yaml.jinja"
