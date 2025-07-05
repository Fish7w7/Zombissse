if (instance_exists(obj_player)) {
    var dir = point_direction(x, y, obj_player.x, obj_player.y);
    x += lengthdir_x(velocidade, dir);
    y += lengthdir_y(velocidade, dir);
}