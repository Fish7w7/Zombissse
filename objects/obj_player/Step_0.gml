// Evento: Step do obj_player (Polido e SEM rotação do sprite)

// --- 1. Entrada do Jogador e Cálculo de Velocidade (APENAS SE FOR O JOGADOR LOCAL) ---
if (is_local_player) { // <--- Adicione esta verificação!
    var input_x = 0;
    var input_y = 0;

    // Leitura das teclas de movimento
    if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
        input_x -= 1;
    }
    if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
        input_x += 1;
    }
    if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
        input_y -= 1; // Para ir para cima na tela
    }
    if (keyboard_check(vk_down) || keyboard_check(ord("S"))) {
        input_y += 1; // Para ir para baixo na tela
    }

    // Normaliza o vetor de movimento
    var move_len = point_distance(0, 0, input_x, input_y);
    if (move_len != 0) {
        input_x /= move_len;
        input_y /= move_len;
    }

    // Calcula as velocidades e aplica
    var hspd = input_x * velocidade;
    var vspd = input_y * velocidade;

    // --- 2. Movimento e Colisões com Paredes (Manual) ---
    // (Este código permanece igual)
    // Movimento Horizontal
    if (hspd != 0) {
        if (place_meeting(x + hspd, y, obj_parede)) {
            while (!place_meeting(x + sign(hspd), y, obj_parede)) {
                x += sign(hspd);
            }
            hspd = 0;
        }
        x += hspd;
    }

    // Movimento Vertical
    if (vspd != 0) {
        if (place_meeting(x, y + vspd, obj_parede)) {
            while (!place_meeting(x, y + sign(vspd), obj_parede)) {
                y += sign(vspd);
            }
            vspd = 0;
        }
        y += vspd;
    }
    
    // --- 3. Mira com o Mouse (APENAS PARA O JOGADOR LOCAL) ---
    // image_angle é usado para a direção do tiro e é sincronizado com outros players.
    image_angle = point_direction(x, y, mouse_x, mouse_y);
}


// --- 4. Lógica de Tiro do Jogador (APENAS SE FOR O JOGADOR LOCAL) ---
if (is_local_player) { // <--- Adicione esta verificação!
    if (timer_tiro > 0) {
        timer_tiro--;
    }

    if (mouse_check_button(mb_left) && municao_atual > 0 && timer_tiro <= 0) {
        var inst_tiro = instance_create_layer(x, y, "Instances", obj_tiro);
        inst_tiro.direction = point_direction(x, y, mouse_x, mouse_y);
        inst_tiro.speed = 15;
        inst_tiro.image_angle = inst_tiro.direction;

        municao_atual--;
        timer_tiro = taxa_tiro;
    }
}


// --- 5. Checagem de Vida do Jogador (Game Over) ---
// Esta parte pode ser controlada localmente por enquanto, mas em um jogo MP real,
// o servidor decidiria a morte e enviaria a informação a todos.
if (vida <= 0) {
    show_message("Game Over! Você foi devorado pelos zumbis!");
    game_restart();
}