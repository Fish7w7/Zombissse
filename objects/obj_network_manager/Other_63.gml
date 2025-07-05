// Evento: Async - Dialog do obj_network_manager

// Verifica se a resposta é da nossa caixa de diálogo de rede
if (async_load[?"id"] == network_async_dialog_id) {
    var _result = string_upper(async_load[?"result"]); // Pega a resposta e converte para maiúscula
    var _port = 6510; // Porta padrão para a conexão (pode ser qualquer número entre 1024 e 65535)

    if (_result == "H") { // Host (Servidor)
        global.socket = network_create_server(network_socket_tcp, _port, 4); // Max 4 jogadores (ajuste se quiser mais)
        if (global.socket < 0) {
            show_message("Falha ao criar o servidor na porta " + string(_port) + "! Tente outra porta ou feche outros programas.");
            game_end();
        } else {
            global.is_host = true;
            show_message("Servidor criado na porta " + string(_port) + ". Esperando jogadores...");
            
            // Cria a instância do jogador local para o host
            if (!local_player_created) {
                var _player_inst = instance_create_layer(x, y, "Instances", obj_player);
                _player_inst.is_local_player = true; // Marca como o jogador local
                _player_inst.network_id = 0; // Host geralmente tem ID 0 ou um ID inicial
                ds_map_add(global.players_map, _player_inst.network_id, _player_inst);
                local_player_created = true;
                // Move o player para uma posição inicial (pode ser ajustado)
                _player_inst.x = room_width / 4;
                _player_inst.y = room_height / 2;
            }
        }
    } else if (_result == "E") { // Cliente (Entrar)
        var _ip_choice_id = get_string_async("Multiplayer", "Digite o IP do host (ex: 127.0.0.1 para localhost):");
        network_async_dialog_id = _ip_choice_id; // Atualiza o ID para esperar a resposta do IP
    } else {
        show_message("Opção inválida. Por favor, digite H ou E.");
        game_end();
    }
}
// Se a resposta do async_load[?"id"] for diferente de network_async_dialog_id,
// significa que é a resposta da caixa de diálogo de IP
else if (async_load[?"id"] == network_async_dialog_id) {
    var _ip_address = async_load[?"result"];
    var _port = 6510; // Use a mesma porta

    global.socket = network_create_client(network_socket_tcp, _ip_address, _port);
    if (global.socket < 0) {
        show_message("Falha ao conectar ao servidor em " + _ip_address + ":" + string(_port) + "!");
        game_end();
    } else {
        global.is_client = true;
        show_message("Conectado ao servidor em " + _ip_address + ":" + string(_port));
        
        // Cria a instância do jogador local para o cliente
        if (!local_player_created) {
            var _player_inst = instance_create_layer(x, y, "Instances", obj_player);
            _player_inst.is_local_player = true;
            _player_inst.network_id = -1; // ID temporário, será atribuído pelo servidor
            ds_map_add(global.players_map, _player_inst.network_id, _player_inst); // Adiciona temporariamente
            local_player_created = true;
            // Move o player para uma posição inicial (pode ser ajustado)
            _player_inst.x = room_width * 3 / 4;
            _player_inst.y = room_height / 2;
        }
    }
}