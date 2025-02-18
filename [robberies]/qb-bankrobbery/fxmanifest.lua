
fx_version 'cerulean'

game 'gta5'
lua54 'yes'

description 'Reworked bank robbery script for QBCore'
version '2.1'

client_scripts {
    '@mka-lasers/client/client.lua',
    'client/cl_*.lua',

}

shared_script {
    'shared/sh_config.lua'
}

server_scripts {
    'server/sv_*.lua',
}
