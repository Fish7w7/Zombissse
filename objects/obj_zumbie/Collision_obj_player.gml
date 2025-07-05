// Evento: Collision com obj_player (SEM física)

// Somente ataca se cooldown acabou
if (timer_ataque_zumbi <= 0) {
    with (other) { // 'other' é o obj_player
        vida -= other.dano_ataque_zumbi; // Reduz a vida do jogador
        image_alpha = 0.5; // Efeito de piscar
        alarm[0] = 5;      // Ativa o alarme para resetar o piscar
    }

    timer_ataque_zumbi = taxa_ataque_zumbi;

    // --- Adiciona um pequeno "knockback" no jogador (Manual) ---
    var knockback_distance = 15; // Distância do empurrão. Ajuste este valor!
    var knockback_dir = point_direction(x, y, other.x, other.y); // Direção do zumbi para o jogador

    // Move o jogador para fora do zumbi
    other.x += lengthdir_x(knockback_distance, knockback_dir);
    other.y += lengthdir_y(knockback_distance, knockback_dir);

    // Certifique-se de que o jogador não seja empurrado para dentro de uma parede
    // Esta é uma checagem básica, pode ser mais sofisticada se necessário.
    with (other) {
        if (place_meeting(x, y, obj_parede)) {
            // Se o knockback empurrou o player para dentro da parede, tente empurrar para fora
            // (Esta é uma solução simples; para algo mais robusto, um pequeno passo a passo seria ideal)
            var push_out_dir = point_direction(other.x, other.y, x, y); // Do player para o zumbi
            x += lengthdir_x(knockback_distance / 2, push_out_dir);
            y += lengthdir_y(knockback_distance / 2, push_out_dir);
        }
    }
}