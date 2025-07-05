
draw_set_halign(fa_left); // Alinha o texto à esquerda
draw_set_valign(fa_top);  // Alinha o texto ao topo
draw_set_colour(c_white); // Cor do texto
//draw_set_font(fnt_pixel_font); // Opcional: use uma fonte customizada (você precisaria criar ela primeiro)
draw_text(10, 10, "Municao: " + string(municao_atual));
draw_text(10, 30, "Vida: " + string(vida));