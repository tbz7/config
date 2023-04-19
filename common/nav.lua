local M = {}

M.motions = {
  h = { rev = 'l', var = 'aA==', dir = 'Left' },
  j = { rev = 'k', var = 'ag==', dir = 'Down' },
  k = { rev = 'j', var = 'aw==', dir = 'Up' },
  l = { rev = 'h', var = 'bA==', dir = 'Right' },
}

return M
