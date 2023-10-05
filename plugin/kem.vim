if exists("g:kem_loaded")
  finish
endif
let g:kem_loaded=1

nmap <silent> <Plug>(kem_add) :call kem#add()<CR>
nmap <silent> <Plug>(kem_move) :call kem#move()<CR>
