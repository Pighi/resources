fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author "qbcore-framework"
description 'Dependency for creating progressbars in QB-Core.'
version '1.0.0'

ui_page "html/index.html"

client_script "client/main.lua"

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/script.js',

    'html/css/bootstrap.min.css',
    'html/js/jquery.min.js',
}

exports {
    'Progress',
    'ProgressWithStartEvent',
    'ProgressWithTickEvent',
    'ProgressWithStartAndTick'
}

escrow_ignore {
    'html/index.html',
    'html/css/style.css',
    'html/js/script.js',

    'html/css/bootstrap.min.css',
    'html/js/jquery.min.js',

    'client/main.lua'
}

dependency '/assetpacks'