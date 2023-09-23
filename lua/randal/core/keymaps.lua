vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness


-------- start: general keymaps --------

-- insert mode keymaps
keymap.set("i", "jk", "<ESC>")

-- normal mode keymaps
keymap.set("n", "<leader>nh", ":nohl<CR>") -- clear highlight for search result

keymap.set("n", "<leader>+", "<C-a>") -- increment numbers
keymap.set("n", "<leader>-", "<C-x>") -- decrement numbers

keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to previous tab

-- keymap.set("n", "x", '"_x') -- pressing the `x` key does not copy the cut content to the clipboard

-------- end: general keymaps --------


-------- 

