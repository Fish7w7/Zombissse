// Evento: Draw do obj_zumbie

// Desenha o sprite padrão do zumbi primeiro
draw_self();

// --- Desenha a Barra de Vida ---
var bar_width = 32;  // Largura da barra de vida (ajuste conforme o tamanho do seu sprite)
var bar_height = 4; // Altura da barra de vida
var bar_offset_y = -40; // <-- Ajuste este valor! Ex: -40, -50 para subir mais

// Calcula a porcentagem de vida atual
var life_percentage = vida_zumbi / vida_maxima_zumbi; 

// Posição da barra (centralizada acima do zumbi)
var bar_x1 = x - (bar_width / 2);
var bar_y1 = y + bar_offset_y;
var bar_x2 = x + (bar_width / 2);
var bar_y2 = y + bar_offset_y + bar_height;

// Desenha o fundo da barra de vida (geralmente cinza escuro ou preto)
draw_set_color(c_black); // Cor preta para o fundo da barra
draw_rectangle(bar_x1, bar_y1, bar_x2, bar_y2, false); // 'false' significa preenchido

// Desenha a parte preenchida da barra de vida (verde)
draw_set_color(c_lime); // Cor verde-limão para a vida
draw_rectangle(bar_x1, bar_y1, bar_x1 + (bar_width * life_percentage), bar_y2, false);

// Opcional: Desenha uma borda para a barra de vida (fina e branca)
draw_set_color(c_white); // Cor branca para a borda
draw_rectangle(bar_x1, bar_y1, bar_x2, bar_y2, true); // 'true' significa apenas a borda

// Restaura a cor de desenho para o padrão (importante para não afetar outros desenhos)
draw_set_color(c_white);