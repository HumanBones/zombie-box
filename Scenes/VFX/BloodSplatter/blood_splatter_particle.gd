extends CPUParticles2D

class_name BloodSplatterParticle

func _ready() -> void:
	emitting = true

func _on_finished() -> void:
	self.call_deferred("queue_free")
