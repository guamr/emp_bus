Config = {
    ['start job'] = {pos = { 453.36, -607.56, 27.6 }, marker = 1}; -- Posições de start do emprego.
    ['key for action'] = {keyName = 'E', keyID = 38}; -- Tecla para ação no emprego (pegar o emprego/entregar uma rota)
    ['key for cancel'] = {keyName = 'F7', keyID = 168}; -- Tecla para cancelar o emprego
    ['route checkpoint'] = {marker = 6, size = 1.0, distanceForView = 20, subtractZinPosition = -0.5}; -- Configuração de rota (marker o id do marker, size o tamanho, distancia para ver, valor pra diminuir no z das posições da tabela abaixo.)
    ['vehicles job'] = { -- hash dos veiculos que podem ser usados no emprego
        [-2072933068] = true;
        [-713569950] = true;
    };
    ['routes'] = { -- rotas, localização e valor por checkpoint.
        {locates = { 
            [1] = { ['x'] = 307.02, ['y'] = -764.82, ['z'] = 29.28 },
            [2] = { ['x'] = 115.69, ['y'] = -784.99, ['z'] = 31.39 },
            [3] = { ['x'] = -245.05, ['y'] = -713.34, ['z'] = 33.51 },
            [4] = { ['x'] = -712.42, ['y'] = -826.58, ['z'] = 23.47 },
            [5] = { ['x'] = -740.53, ['y'] = -752.35, ['z'] = 26.73 },
            [6] = { ['x'] = -692.98, ['y'] = -668.13, ['z'] = 30.83 },
            [7] = { ['x'] = -560.04, ['y'] = -845.14, ['z'] = 27.44 },
            [8] = { ['x'] = -249.17, ['y'] = -881.66, ['z'] = 30.72 },
            [9] = { ['x'] = 355.16, ['y'] = -1064.49, ['z'] = 29.48 },
            [10] = { ['x'] = 429.92, ['y'] = -640.48, ['z'] = 28.58 },
        }, valuePerCheckPoint = {3000, 3500}};
        {locates = { 
            [1] = { ['x'] = 307.02, ['y'] = -764.82, ['z'] = 29.28 },
            [2] = { ['x'] = 115.69, ['y'] = -784.99, ['z'] = 31.39 },
            [3] = { ['x'] = -245.05, ['y'] = -713.34, ['z'] = 33.51 },
            [4] = { ['x'] = -712.42, ['y'] = -826.58, ['z'] = 23.47 },
            [5] = { ['x'] = -740.53, ['y'] = -752.35, ['z'] = 26.73 },
            [6] = { ['x'] = -692.98, ['y'] = -668.13, ['z'] = 30.83 },
            [7] = { ['x'] = -560.04, ['y'] = -845.14, ['z'] = 27.44 },
            [8] = { ['x'] = -249.17, ['y'] = -881.66, ['z'] = 30.72 },
            [9] = { ['x'] = 355.16, ['y'] = -1064.49, ['z'] = 29.48 },
            [10] = { ['x'] = 429.92, ['y'] = -640.48, ['z'] = 28.58 },
        }, valuePerCheckPoint = {3000, 3500}};

    }
}