fx_version 'adamant'
game 'gta5'

dependency 'vrp'

shared_scripts { 
    'global.lua';
}

client_scripts { 
    '@vrp/lib/utils.lua',
    'src/client.lua'
}

server_scripts { 
    '@vrp/lib/utils.lua',
    'src/server.lua'
}
              