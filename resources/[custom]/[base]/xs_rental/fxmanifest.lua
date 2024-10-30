fx_version 'cerulean'
game 'gta5'
lua54 'yes'


author 'Beansfl'
description '<xs_rental>, a rental system for FiveM. discord.gg/xstudios'
ui_page 'html/index.html'
files { 'html/**/*' }


shared_scripts {
  '@ox_lib/init.lua',
  'shared/*.lua',
  'config.lua'
}

client_scripts {
  'bridge/**/client.lua',
  'client/*.lua'
}

server_scripts {
  'bridge/**/server.lua',
  'server/*.lua'
}

escrow_ignore {
  'config.lua',
  'bridge/esx/*.lua',
  'bridge/qb/*.lua',
  'bridge/target/*.lua'
}

 
dependency '/assetpacks'