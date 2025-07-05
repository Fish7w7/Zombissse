// Evento: Draw do obj_player

draw_self(); // Desenha o sprite do jogador

// Desenha o Network ID acima do jogador (para debug)
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(c_white);
draw_text(x, y - sprite_height / 2 - 10, string(network_id));
draw_set_halign(fa_left); // Resetar para o padrão
draw_set_valign(fa_top);  // Resetar para o padrão