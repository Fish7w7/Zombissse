// Aumenta a munição do jogador que colidiu
with (other) { // 'other' se refere ao obj_jogador que colidiu
    municao_atual += 15; // Adiciona 15 balas
    
if (municao_atual > 100) municao_atual = 100;
}

// Destrói o item de munição do mapa
instance_destroy();