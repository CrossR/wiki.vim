source init.vim

let g:wiki_link_target_map = 'MyFunction'

function MyFunction(text) abort
  return substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction

runtime plugin/wiki.vim

" Test toggle normal on regular markdown links
try
  bwipeout!
  silent edit ex1-basic/index.wiki
  normal! 3G
  silent execute "normal vt.\<Plug>(wiki-link-toggle-visual)"

  if getline('.') !=# '[[this-is-a-wiki|This is a wiki]].'
    call wiki#test#error(expand('<sfile>'), 'Should have created a parsed wiki link.')
  endif
endtry

let g:wiki_link_target_type = 'md'

try
  bwipeout!
  silent edit ex1-basic/index.wiki
  normal! 3G
  silent execute "normal vt.\<Plug>(wiki-link-toggle-visual)"

  if getline('.') !=# '[This is a wiki](this-is-a-wiki).'
    call wiki#test#error(expand('<sfile>'), 'Should have created a parsed markdown link.')
  endif
endtry

call wiki#test#quit()
