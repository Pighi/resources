fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'is_lib'
author 'inside-scripts'
version '2.0.0'
repository 'https://github.com/inside-scripts/is-lib'

client_scripts {
    'client/main.lua',
    'shared/functions.lua',
    'client/callbacks.lua',
    'client/entity.lua',
    'client/blip.lua',
}

server_scripts {
    'server/main.lua',
    'shared/functions.lua',
    'server/timezone.lua',
    'server/webhook.lua',
    'server/callbacks.lua',
    'server/identifier.lua',
    'server/entity.lua',
}
