// Evento: Create do obj_player

// Variáveis de Multiplayer (Adicionar estas!)
is_local_player = false; // Será 'true' apenas para a instância controlada por este jogador
network_id = -1; // ID único de rede para este jogador, atribuído pelo host

// ... (Seu código existente de velocidade, vida, municao, taxa_tiro, timer_tiro) ...
velocidade = 4;
vida = 100;
municao_atual = 30;
taxa_tiro = 15;
timer_tiro = 0;