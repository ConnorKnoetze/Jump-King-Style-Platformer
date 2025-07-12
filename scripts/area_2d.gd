extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

func _on_body_entered(body: Node2D) -> void:
	if "jumper" in body.name:
		sprite_2d.visible = false
	



func _on_body_exited(body: Node2D) -> void:
	if "jumper" in body.name:
		sprite_2d.visible = true
