-- Embeeds a terminal(s) within an active Neovim session
--
--I typically don't use thing plugins when I am using a Unix based system,
--because I have `fg`, but it's fine to have it sometimes when I am on W2
--and I don't want to have like a million of tabs in Windows Terminal
--
return {
    cmd = {'ToggleTerm'},
    version = "*",
    config = true,
    opts = {
        size = 10,
        autochdir = true,
        winbar = {
            enabled = true,
            name_formatter = nil
        }
    }
}
