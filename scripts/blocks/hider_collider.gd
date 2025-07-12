extends Area2D


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var tranparent_cover: Sprite2D = $"../../../high_layer_assets/screen5/tranparent_cover"



func _on_body_entered(body: Node2D) -> void:
	if "jumper" in body.name:
		tranparent_cover.visible = false
	



func _on_body_exited(body: Node2D) -> void:
	if "jumper" in body.name:
		tranparent_cover.visible = true
