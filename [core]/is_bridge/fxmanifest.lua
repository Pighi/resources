fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'is_bridge'
author 'inside-scripts'
version '1.0.2'
repository 'https://github.com/inside-scripts/is_bridge'

files {
    '**/*.lua',
    '**/**/*.lua',
    '*.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'init.lua',
}

ox_libs {
    'interface',
}
