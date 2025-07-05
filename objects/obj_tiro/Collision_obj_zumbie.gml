// Evento: Collision com obj_zumbie (do obj_tiro)

// 'other' aqui se refere à instância do obj_zumbie que o tiro colidiu.
// Causa dano ao zumbi
other.vida_zumbi -= 25; // Dano que o tiro causa ao zumbi (ajuste este valor!)

// Opcional: Adiciona um efeito visual de acerto ao zumbi (ex: piscar, como o player)
// other.image_alpha = 0.5; // Torna o zumbi semi-transparente
// other.alarm[0] = 5;      // Ativa o Alarme 0 para voltar ao normal (se o zumbi tiver Alarme 0)

// Destrói a instância do tiro após atingir o zumbi
instance_destroy();

// --- Checagem de Morte do Zumbi ---
// Verifica se o zumbi morreu após receber o dano
if (other.vida_zumbi <= 0) {
    instance_destroy(other); // Destrói o zumbi
    // Opcional: Adicione efeitos de morte (explosão, som, etc.) aqui
    // instance_create_layer(x, y, "Instances", obj_explosao_zumbi);
    // score += 100; // Exemplo: Adiciona pontos ao jogador
}