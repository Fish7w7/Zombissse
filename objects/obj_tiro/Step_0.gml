// Destrói o tiro se ele sair da tela para não acumular objetos
//if (!bbox_in_view(view_camera[0])) { // Verifica se o bounding box do tiro está fora da view da câmera
    //instance_destroy();
//}

// Destrói o tiro se ele sair da área visível (da room ou da view)

// Opção 1: Checar se saiu da Room (mais simples e geralmente suficiente para começar)
if (x < 0 || x > room_width || y < 0 || y > room_height) {
    instance_destroy();
}
