extends Camera2D

@onready var camera_area_top: Area2D = $camera_area_top
@onready var camera_area_bottom: Area2D = $camera_area_bottom
@onready var camera_2d: Camera2D = $"."
@onready var camera_collider_top: CollisionShape2D = $camera_area_top/camera_collider_top
@onready var camera_collider_bottom: CollisionShape2D = $camera_area_bottom/camera_collider_bottom


const camera_translate = 400

func _on_camera_area_top_body_entered(body: Node2D) -> void:
	if "jumper" in body.name:
		camera_2d.offset.y -= camera_translate
		camera_collider_top.position.y -= camera_translate
		camera_collider_bottom.position.y -= camera_translate



func _on_camera_area_bottom_body_entered(body: Node2D) -> void:
	if "jumper" in body.name:
		camera_2d.offset.y += camera_translate
		camera_collider_top.position.y += camera_translate
		camera_collider_bottom.position.y += camera_translate
