// Evento: Step do obj_network_manager

// Encontrar a instância do nosso jogador local
var _local_player_inst = noone;
for (var i = 0; i < instance_number(obj_player); ++i) {
    var _inst = instance_find(obj_player, i);
    if (instance_exists(_inst) && _inst.is_local_player) {
        _local_player_inst = _inst;
        break;
    }
}

// Envia a posição do jogador local se ele existe e tem um ID válido
if (instance_exists(_local_player_inst) && _local_player_inst.network_id != -1) {
    // Cria um buffer para enviar os dados
    var _send_buffer = buffer_create(32, buffer_grow, 1); // 32 bytes, dinâmico, alinhamento 1
    buffer_seek(_send_buffer, buffer_seek_start, 0); // Começa a escrever do início do buffer

    buffer_write(_send_buffer, buffer_u8, 1); // Packet type: 1 (Atualização de Posição do Jogador)
    buffer_write(_send_buffer, buffer_u32, _local_player_inst.network_id); // Nosso ID de rede
    buffer_write(_send_buffer, buffer_f32, _local_player_inst.x); // Posição X
    buffer_write(_send_buffer, buffer_f32, _local_player_inst.y); // Posição Y
    buffer_write(_send_buffer, buffer_f32, _local_player_inst.image_angle); // Ângulo (para mira)

    // Precisamos definir a porta aqui também para o broadcast
    var _port = 6510; // Use a mesma porta que você definiu no Create Event do obj_network_manager

    if (global.is_host) {
        // Se somos o host, enviamos para todos os clientes conectados (broadcast)
        network_send_broadcast(global.socket, _port, _send_buffer, buffer_get_size(_send_buffer)); // <-- Linha corrigida!
    } else if (global.is_client) {
        // Se somos um cliente, enviamos apenas para o servidor
        network_send_packet(global.socket, _send_buffer, buffer_get_size(_send_buffer));
    }
    buffer_delete(_send_buffer); // É importante deletar o buffer após o uso para liberar memória
}