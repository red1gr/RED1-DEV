
fx_version 'cerulean'
game 'gta5'

client_scripts {
	'client/cl_*.lua'
}

server_scripts {
	'server/sv_*.lua'
}

shared_script "config.lua"

files {
    'ui/app.js',
    'ui/index.html',
    'ui/style.css',
    'ui/*.png',
}

ui_page {
    'ui/index.html'
}