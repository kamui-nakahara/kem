let s:width=nvim_get_option("columns")
let s:height=nvim_get_option("lines")
let s:winconf={"style":"minimal","relative":"editor","width":s:width/2,"height":s:height/2,"row":s:height/4,"col":s:width/4,"focusable":v:false}
let s:files=[]
let s:win_id=0
let s:filename=""

hi! kem_bg ctermbg=32 ctermfg=white guibg=#0077ff

function s:CreateWin()
  let s:win_id=nvim_open_win(nvim_create_buf(v:false,v:true),v:true,s:winconf)
  call nvim_win_set_option(s:win_id,"winhighlight","Normal:kem_bg")
  call setline(1,s:files)
  setlocal nomodifiable
  set number
endfunction

function s:move(filename)
  if s:win_id==win_getid()
    call s:close()
    execute "e ".a:filename
  endif
endfunction

function s:delete(pos)
  if s:win_id==win_getid()
    if len(s:files)>0
      unlet s:files[a:pos-1]
      call s:close()
      call kem#move()
    endif
  endif
endfunction

function s:close()
  q
  call s:write()
endfunction

function s:write()
  if s:filename!=""
    call writefile(s:files,s:filename)
  endif
endfunction

function kem#move()
  call s:CreateWin()
  nnoremap <buffer> <silent> <ENTER> :call <SID>move(getline("."))<CR>
  nnoremap <buffer> <silent> <nowait> g G:call <SID>move(getline("."))<CR>
  nnoremap <buffer> <silent> <nowait> d :call <SID>delete(getcurpos()[1])<CR>
endfunction

function kem#add()
  let s:files=add(s:files,bufname())
  call s:write()
endfunction

function kem#init(files)
  let s:files=a:files
endfunction

function kem#load(file)
  let s:filename=a:file
  let s:files=readfile(s:filename)
endfunction

function kem#open()
  if len(s:files)>0
    execute "e ".s:files[0]
  endif
endfunction
