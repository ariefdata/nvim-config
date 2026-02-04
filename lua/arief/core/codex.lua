local codex_bufnr = nil
local codex_winid = nil

local function is_valid_buf(bufnr)
  return bufnr and vim.api.nvim_buf_is_valid(bufnr)
end

local function is_valid_win(winid)
  return winid and vim.api.nvim_win_is_valid(winid)
end

local function ensure_codex_available()
  if vim.fn.executable("codex") == 0 then
    vim.notify("codex not found in PATH", vim.log.levels.WARN)
    return false
  end
  return true
end

local function open_codex()
  if not ensure_codex_available() then
    return
  end

  if is_valid_buf(codex_bufnr) then
    local existing_win = vim.fn.bufwinid(codex_bufnr)
    if existing_win ~= -1 then
      vim.api.nvim_set_current_win(existing_win)
      vim.cmd("startinsert")
      return
    end
  end

  vim.cmd("botright split")
  vim.cmd("resize 15")

  if is_valid_buf(codex_bufnr) then
    vim.api.nvim_win_set_buf(0, codex_bufnr)
  else
    vim.cmd("terminal codex")
    codex_bufnr = vim.api.nvim_get_current_buf()
  end

  codex_winid = vim.api.nvim_get_current_win()
  vim.cmd("startinsert")
end

local function close_codex()
  if is_valid_win(codex_winid) then
    vim.api.nvim_win_close(codex_winid, true)
    codex_winid = nil
    return
  end

  if is_valid_buf(codex_bufnr) then
    local existing_win = vim.fn.bufwinid(codex_bufnr)
    if existing_win ~= -1 then
      vim.api.nvim_win_close(existing_win, true)
      return
    end
  end
end

local function toggle_codex()
  if is_valid_win(codex_winid) then
    close_codex()
    return
  end

  if is_valid_buf(codex_bufnr) then
    local existing_win = vim.fn.bufwinid(codex_bufnr)
    if existing_win ~= -1 then
      vim.api.nvim_set_current_win(existing_win)
      vim.cmd("startinsert")
      return
    end
  end

  open_codex()
end

local function set_codex_term_keymaps(bufnr)
  local function to_normal_mode()
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true),
      "n",
      false
    )
  end

  vim.keymap.set("t", "<leader>cq", function()
    to_normal_mode()
    close_codex()
  end, { buffer = bufnr, desc = "Close Codex terminal" })

  vim.keymap.set("t", "<Esc>q", function()
    to_normal_mode()
    close_codex()
  end, { buffer = bufnr, desc = "Exit Codex terminal" })
end

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*codex",
  callback = function(args)
    set_codex_term_keymaps(args.buf)
  end,
})

vim.api.nvim_create_user_command("Codex", open_codex, {
  desc = "Open Codex in a terminal split",
})

vim.api.nvim_create_user_command("CodexToggle", toggle_codex, {
  desc = "Toggle Codex terminal split",
})

vim.api.nvim_create_user_command("CodexClose", close_codex, {
  desc = "Close Codex terminal split",
})
