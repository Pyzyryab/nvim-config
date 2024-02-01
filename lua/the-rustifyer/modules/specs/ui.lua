-- UI related plugins of this set up
--

local ui = {}

ui['goolord/alpha-nvim'] = {
    event = 'BufWinEnter',
    config = require('ui.alpha')
}

return ui
