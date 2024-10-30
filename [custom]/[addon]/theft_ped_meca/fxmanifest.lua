fx_version 'cerulean'
author 'TheftDev'
description "Ped Repair/Cleaner made by TheftDev"
games { 'gta5' }
lua54 'yes'

ui_page 'client/nui/index.html'

files {
    'client/nui/index.html',
    'client/nui/script.js',
    'client/nui/styles.css',
    'client/nui/reset.css',
    'client/nui/img/*.png'
}

client_scripts {
    'client/trad.lua',
    'config.lua',
    'locales/*.lua',
    'client/main.lua'
}

server_script {
    'server/main.lua'
}

escrow_ignore {
    'config.lua',
    'locales/*.lua'
}
dependency '/assetpacks'