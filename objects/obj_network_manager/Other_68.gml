// Evento: Async - Network do obj_network_manager

var _type = async_load[?"type"];
var _id = async_load[?"id"]; // ID do socket do remetente (cliente ou servidor)
var _buffer = async_load[?"buffer"]; // O buffer de dados recebido

switch (_type) {
    case network_type_connect: // Uma nova conexão foi estabelecida
        if (global.is_host) {
            show_debug_message("Novo cliente conectado! Socket ID: " + string(_id));
            // O host atribui um network_id ao novo cliente (usa o socket ID para simplificar)
            // e cria uma instância de obj_player para ele.
            var _new_player_inst = instance_create_layer(x, y, "Instances", obj_player);
            _new_player_inst.is_local_player = false; // Não é controlado por este PC
            _new_player_inst.network_id = _id; // Usa o socket ID como ID de rede do player remoto
            ds_map_add(global.players_map, _id, _new_player_inst);

            // O host agora informa o novo cliente sobre seu próprio jogador
            var _my_player_inst = ds_map_find_value(global.players_map, 0); // Assumindo host é ID 0
            if (instance_exists(_my_player_inst)) {
                var _send_buffer = buffer_create(32, buffer_grow, 1);
                buffer_seek(_send_buffer, buffer_seek_start, 0);
                buffer_write(_send_buffer, buffer_u8, 0); // Tipo de pacote: 'Meu ID' e Posição Inicial
                buffer_write(_send_buffer, buffer_u32, _my_player_inst.network_id);
                buffer_write(_send_buffer, buffer_f32, _my_player_inst.x);
                buffer_write(_send_buffer, buffer_f32, _my_player_inst.y);
                buffer_write(_send_buffer, buffer_f32, _my_player_inst.image_angle);
                network_send_packet(_id, _send_buffer, buffer_get_size(_send_buffer));
                buffer_delete(_send_buffer);
            }
            
            // E o host informa todos os clientes (incluindo o novo) sobre todos os jogadores existentes
            // (Isso é mais complexo e não será feito neste básico, para simplificar)
        } else if (global.is_client) {
            show_debug_message("Conectado ao servidor. Aguardando informações do meu player ID.");
        }
        break;

    case network_type_disconnect: // Uma conexão foi perdida
        if (global.is_host) {
            show_debug_message("Cliente desconectado: " + string(_id));
            var _player_to_destroy = ds_map_find_value(global.players_map, _id);
            if (instance_exists(_player_to_destroy)) {
                instance_destroy(_player_to_destroy); // Destrói o player do cliente que saiu
            }
            ds_map_delete(global.players_map, _id); // Remove do mapa
        } else if (global.is_client && _id == global.socket) { // Se o servidor desconectou
            show_message("Desconectado do servidor!");
            game_end(); // Encerra o jogo para o cliente
        }
        break;

    case network_type_data: // Dados foram recebidos
        buffer_seek(_buffer, buffer_seek_start, 0);
        var _packet_type = buffer_read(_buffer, buffer_u8); // Lê o tipo de pacote

        switch (_packet_type) {
            case 0: // Pacote de 'Meu ID' e Posição Inicial (principalmente do host para cliente)
                var _player_id = buffer_read(_buffer, buffer_u32);
                var _player_x = buffer_read(_buffer, buffer_f32);
                var _player_y = buffer_read(_buffer, buffer_f32);
                var _player_angle = buffer_read(_buffer, buffer_f32);

                if (global.is_client && _player_id == 0) { // Se for o pacote do próprio host
                    // O cliente precisa saber o ID do seu próprio jogador, que o servidor atribuiu.
                    // Para o cliente, o player local tem network_id -1 inicialmente.
                    var _my_local_player_inst = ds_map_find_value(global.players_map, -1);
                    if (instance_exists(_my_local_player_inst)) {
                        _my_local_player_inst.network_id = _id; // O ID do socket do servidor é o nosso player ID
                        ds_map_delete(global.players_map, -1); // Remove a entrada temporária
                        ds_map_add(global.players_map, _id, _my_local_player_inst); // Adiciona com o ID correto
                        show_debug_message("Meu ID de rede atribuído pelo servidor: " + string(_id));
                    }
                }
                // Se o player ID recebido não é o do nosso player local, e não está no mapa, cria
                if (!ds_map_exists(global.players_map, _player_id)) {
                    var _new_remote_player_inst = instance_create_layer(_player_x, _player_y, "Instances", obj_player);
                    _new_remote_player_inst.is_local_player = false;
                    _new_remote_player_inst.network_id = _player_id;
                    _new_remote_player_inst.x = _player_x;
                    _new_remote_player_inst.y = _player_y;
                    _new_remote_player_inst.image_angle = _player_angle;
                    ds_map_add(global.players_map, _player_id, _new_remote_player_inst);
                    show_debug_message("Novo jogador remoto detectado: " + string(_player_id));
                }
                break;
            
            case 1: // Pacote de atualização de posição do jogador
                var _sender_player_id = buffer_read(_buffer, buffer_u32);
                var _pos_x = buffer_read(_buffer, buffer_f32);
                var _pos_y = buffer_read(_buffer, buffer_f32);
                var _angle = buffer_read(_buffer, buffer_f32);

                // Encontra a instância do jogador correspondente no mapa
                var _player_to_update = ds_map_find_value(global.players_map, _sender_player_id);
                
                // Atualiza a posição e o ângulo APENAS se não for o nosso jogador local
                // e se a instância existir (pode ter sido destruída por desconexão)
                if (instance_exists(_player_to_update) && !_player_to_update.is_local_player) {
                    _player_to_update.x = _pos_x;
                    _player_to_update.y = _pos_y;
                    _player_to_update.image_angle = _angle;
                }
                break;
        }
        break;
}