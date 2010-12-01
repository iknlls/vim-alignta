"=============================================================================
" Align Them All!
"
" File		: plugin/alignta.vim
" Author	: h1mesuke <himesuke@gmail.com>
" Updated : 2010-12-01
" Version : 0.0.5
" License : MIT license {{{
"
"   Permission is hereby granted, free of charge, to any person obtaining
"   a copy of this software and associated documentation files (the
"   "Software"), to deal in the Software without restriction, including
"   without limitation the rights to use, copy, modify, merge, publish,
"   distribute, sublicense, and/or sell copies of the Software, and to
"   permit persons to whom the Software is furnished to do so, subject to
"   the following conditions:
"
"   The above copyright notice and this permission notice shall be included
"   in all copies or substantial portions of the Software.
"
"   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

if v:version < 700 || &cp
  echoerr "alignta: Vim 7.0 or later required"
  finish
elseif exists('g:loaded_alignta')
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

"-----------------------------------------------------------------------------
" Variables

if !exists('g:alignta_align_as_many_as_possible')
  let g:alignta_align_as_many_as_possible = 1
endif

if !exists('g:alignta_confirm_for_retab')
  let g:alignta_confirm_for_retab = 1
endif

"-----------------------------------------------------------------------------
" Command

command! -bang -range -nargs=+ Alignta <line1>,<line2>call <SID>align([<f-args>], '<bang>')

if !exists(':Align')
  " :Align is mine, hehehe
  command! -bang -range -nargs=+ Align Alignta<bang> <args>
endif

function! s:align(align_args, bang) range
  let vismode = visualmode()
  if vismode == "\<C-v>" && a:firstline == line("'<") && a:lastline == line("'>")
    let region = vismode
  else
    let region = [a:firstline, a:lastline]
  endif
  let use_regex = (a:bang == '!')
  call alignta#align(region, a:align_args, use_regex)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_alignta = 1

" vim: filetype=vim
