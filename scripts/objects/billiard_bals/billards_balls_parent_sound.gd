extends Node3D

@onready var hit_sound: AudioStreamPlayer3D = $HitSound

func play_hit_sound(position: Vector3):
	hit_sound.global_position = position
	#hit_sound.pitch_scale = randf_range(0.95, 1.05)  # opcional, variação leve
	hit_sound.play()
