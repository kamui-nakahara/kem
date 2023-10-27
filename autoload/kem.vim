let s:width=nvim_get_option("columns")
let s:height=nvim_get_option("lines")
let s:winconf={"style":"minimal","relative":"editor","width":s:width/2,"height":s:height/2,"row":s:height/4,"col":s:width/4,"focusable":v:false}
let s:files=[]
let s:win_id=0

hi! kem_bg ctermbg=30 ctermfg=black

function s:CreateWin()
  let s:win_id=nvim_open_win(nvim_create_buf(v:false,v:true),v:true,s:winconf)
  call nvim_win_set_option(s:win_id,"winhighlight","Normal:kem_bg")
  call setline(1,s:files)
  setlocal nomodifiable
  set number
endfunction

function s:move(filename)
  if s:win_id==win_getid()
    q
    execute "e ".a:filename
  endif
endfunction

function kem#move()
  call s:CreateWin()
  nnoremap <buffer> <silent> <ENTER> :call <SID>move(getline("."))<CR>
  nnoremap <buffer> <silent> <nowait> g G:call <SID>move(getline("."))<CR>
  nnoremap <buffer> <silent> <nowait> d :echo "hello"<CR>
endfunction

function kem#add()
  let s:files=add(s:files,bufname())
endfunction

function kem#init(files)
  let s:files=a:files
endfunction
