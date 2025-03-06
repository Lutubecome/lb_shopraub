fx_version 'cerulean'
game 'gta5'

version '1.0'
description 'Laden Raub mit Kasse'
author 'Lutubecome'

lua54 'yes'
use_experimental_fxv2_oal 'yes'

client_scripts {
    'client.lua',
}

server_script 'server.lua'

dependencies {
    'ox_lib',
}

shared_scripts {

    '@ox_lib/init.lua',

}