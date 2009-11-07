setlocal iskeyword+=45 " (-)
setlocal iskeyword+=58 " (:)

inoremap <buffer>   <LT>?   <LT>/
inoremap <buffer>   ?>      />

if !exists('b:undo_ftplugin')
    let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .= '
            \ | setlocal iskeyword<
            \ | execute "inumap <buffer> <LT>?"
            \ | execute "inumap <buffer> ?>"
            \'
