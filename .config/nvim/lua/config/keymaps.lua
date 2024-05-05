-- delete/change without yank
nmap('d', '"_d', 'delete to black hole register')
nmap('<leader>d', 'd', 'delete')
nmap('D', '"_D', 'delete to black hole register')
nmap('<leader>D', 'D', 'delete to end of line')
vmap('d', '"_d', 'delete to black hole register')
vmap('<leader>d', 'd', 'delete')
nmap('c', '"_c', 'change to black hole register')
nmap('<leader>c', 'c', 'change')
nmap('C', '"_C', 'change to black hole register')
nmap('<leader>C', 'C', 'change to end of line')

-- less disorienting scroll
nmap('<C-u>', '<C-u>zz', 'scroll up half screen')
nmap('<C-d>', '<C-d>zz', 'scroll down half screen')

-- move lines
nmap('<A-j>', ':m .+1<CR>==', 'move line down')
nmap('<A-k>', ':m .-2<CR>==', 'move line up')
imap('<A-j>', '<Esc>:m .+1<CR>==gi', 'insert mode move line down')
imap('<A-k>', '<Esc>:m .-2<CR>==gi', 'insert mode move line up')
vmap('<A-j>', ':m \'>+1<CR>gv=gv', 'visual mode move line down')
vmap('<A-k>', ':m \'<-2<CR>gv=gv', 'visual mode move line up')

-- general
nmap('<F2>', ':%y+<CR>', 'copy entire file content to clipboard')
nmap('<F3>', ':%d_<CR>', 'delete entire file content')
nmap('<C-s>', ':w!<CR>', 'save file')
nmap('<leader>s', ':%s/', 'replace')

-- windows
nmap('nv', ':vsplit<CR>', 'split vertically')
nmap('nh', ':split<CR>', 'split horizontally')
nmap('nq', ':lua AskToExit()<CR>', 'Exit Neovim')

nmap('=', ':wincmd =<CR>', 'make all the vertical windows equal size')
nmap('+', ':vertical resize +5<CR>', 'make the window bigger vertically')
nmap('-', ':vertical resize -5<CR>', 'make the window smaller vertically')

nmap('<leader>+', ':resize +5<CR>', 'make the window bigger horizontally')
nmap('<leader>-', ':resize -5<CR>', 'make the window smaller horizontally')
nmap('<leader>=', ':resize<CR>', 'make all the horizontal windows equal size')

nmap('qq', '<C-w>q', 'close window')

-- refresh
nmap('<A-l>', '<Cmd>nohlsearch|diffupdate|normal! <C-L><CR>', 'Clear search')

nmap('<C-h>', '<C-w>h', 'move left')
nmap('<C-l>', '<C-w>l', 'move right')
nmap('<C-j>', '<C-w>j', 'move down')
nmap('<C-k>', '<C-w>k', 'move up')

-- workspace
nmap('<C-9>', ':vnew .nvim.lua<CR>', 'open .nvim.lua')

nmap('<C-Tab>', ':tabnext<CR>', 'next tab')
nmap('<C-S-Tab>', ':tabprevious<CR>', 'previous tab')
nmap('nn', ':tabnew<CR>', 'new tab')
