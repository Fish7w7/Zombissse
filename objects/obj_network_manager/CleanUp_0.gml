// Evento: Clean Up do obj_network_manager

if (global.socket != -1) {
    network_destroy(global.socket); // Fecha o socket de rede
}
// A função ds_map_exists precisa de 2 argumentos: o ID do mapa e a chave a ser verificada.
// Para verificar se o mapa existe, basta verificar se a variável que o contém não é 'undefined' ou 'noone'.
// No entanto, a forma mais robusta e idiomática para verificar se um mapa DS existe E ainda não foi destruído
// é usando is_ds_map.
if (is_ds_map(global.players_map)) { // <-- Linha corrigida! Usando is_ds_map
    ds_map_destroy(global.players_map); // Destrói o mapa de jogadores
}