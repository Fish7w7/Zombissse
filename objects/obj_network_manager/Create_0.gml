// Evento: Create do obj_network_manager

global.socket = -1; // Socket de rede para a conexão (servidor ou cliente)
global.players_map = ds_map_create(); // Mapeia Network IDs para instâncias de obj_player

global.is_host = false; // Flag para indicar se esta instância é o host
global.is_client = false; // Flag para indicar se esta instância é um cliente

// Pergunta ao jogador se deseja HOSPEAR (H) ou ENTRAR (E)
var _choice_id = get_string_async("Multiplayer", "Deseja HOSPEAR (H) ou ENTRAR (E) no jogo?");

// Guarda o ID da requisição assíncrona para processar a resposta
network_async_dialog_id = _choice_id;

// Certifique-se de que o jogador local seja criado apenas UMA VEZ
local_player_created = false;