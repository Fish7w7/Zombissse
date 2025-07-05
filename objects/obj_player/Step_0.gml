//  MOVIMENTO DO JOGADOR
var move_x = 0;
var move_y = 0;

if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
	move_x = -1;
}
if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
	move_x = 1;
}
if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
	move_y = -1;
}
if (keyboard_check(vk_down) || keyboard_check(ord("S"))) {
	move_y = 1;
}

// Normaliza o vetor de movimento para que a velocidade seja constante na diagonal
if (move_x != 0 || move_y != 0) {
	var len = point_distance(0, 0, move_x, move_y);
	x += (move_x / len) * velocidade;
	y += (move_y / len) * velocidade;
}

//  MIRA COM O MOUSE
// Faz o sprite do jogador girar para apontar para a posição do mouse
image_angle = point_direction(x, y, mouse_x, mouse_y);

// Tiro do jogador
// Diminui o timer de tiro
if (timer_tiro > 0) {
    timer_tiro--;
}


// Verifica se o botão esquerdo do mouse está pressionado, tem munição e o timer permite atirar
if (mouse_check_button(mb_left) && municao_atual > 0 && timer_tiro <= 0) {
    // Cria uma instância do obj_tiro na posição do jogador
    var inst_tiro = instance_create_layer(x, y, "Instances", obj_tiro);

// Define a direção do tiro baseada na mira do jogador
    inst_tiro.direction = image_angle;
    inst_tiro.speed = 15; // Velocidade do tiro (pode ajustar)
    inst_tiro.image_angle = inst_tiro.direction; // Faz o sprite do tiro girar junto
	

// Consome uma unidade de munição 
municao_atual--;

// Reseta o timer de tiro para controlar a taxa de tiro
timer_tiro = taxa_tiro;
		
}	
	