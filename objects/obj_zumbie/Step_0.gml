// Evento: Step do obj_zumbie (SEM física)

if (instance_exists(obj_player)) {
    // Calcula a direção para o jogador
    var dir_to_player = point_direction(x, y, obj_player.x, obj_player.y);

    // Calcula os componentes de movimento baseados na velocidade_zumbi
    var hspd_z = lengthdir_x(velocidade_zumbi, dir_to_player);
    var vspd_z = lengthdir_y(velocidade_zumbi, dir_to_player);

    // --- COLISÕES COM PAREDES E PLAYER (Manual) ---

    // Checa colisão horizontal com obj_parede
    if (place_meeting(x + hspd_z, y, obj_parede)) {
        while (!place_meeting(x + sign(hspd_z), y, obj_parede)) {
            x += sign(hspd_z);
        }
        hspd_z = 0; // Para o movimento horizontal
    }
    // Checa colisão horizontal com obj_player (para o zumbi não atravessar)
    if (place_meeting(x + hspd_z, y, obj_player)) {
        while (!place_meeting(x + sign(hspd_z), y, obj_player)) {
            x += sign(hspd_z);
        }
        hspd_z = 0; // Para o movimento horizontal
    }
    x += hspd_z; // Aplica o movimento horizontal

    // Checa colisão vertical com obj_parede
    if (place_meeting(x, y + vspd_z, obj_parede)) {
        while (!place_meeting(x, y + sign(vspd_z), obj_parede)) {
            y += sign(vspd_z);
        }
        vspd_z = 0; // Para o movimento vertical
    }
    // Checa colisão vertical com obj_player (para o zumbi não atravessar)
    if (place_meeting(x, y + vspd_z, obj_player)) { // Linha corrigida aqui!
        while (!place_meeting(x, y + sign(vspd_z), obj_player)) { // Linha corrigida aqui!
            y += sign(vspd_z);
        }
        vspd_z = 0; // Para o movimento vertical
    }
    y += vspd_z; // Aplica o movimento vertical

    // Opcional: girar o sprite do zumbi para a direção do player
    // image_angle = dir_to_player;

} else {
    // Se o jogador não existir, zumbi para
    // No sistema sem física, simplesmente não move
}

// --- TIMER DE ATAQUE DO ZUMBI ---
if (timer_ataque_zumbi > 0) {
    timer_ataque_zumbi--;
}