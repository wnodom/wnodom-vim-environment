function! HangingIndent(lnum)

	" Search backwards for the previous non-empty line.
	let plnum = prevnonblank(v:lnum - 1)

	if plnum == 0
		" This is the first non-empty line, use zero indent.
		return 0
	endif

	let plindent = indent(plnum) + 1 " &shiftwidth

	return plindent

endfunction

