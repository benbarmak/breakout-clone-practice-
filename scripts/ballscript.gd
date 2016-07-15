
extends RigidBody2D
var score = 0

const SPEEDUP = 1000
const MAXSPEED = 80000

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):

	var bodies = get_colliding_bodies()

	for body in  bodies:
		if body.is_in_group("bricks"):
			body.queue_free()
			score+=1
			get_tree().get_root().get_node("World").get_node("scoretext").set_text(str(score))

		if body.get_name() == "Paddle":
			var speed = get_linear_velocity().length()
			var direction = get_pos() - body.get_node("paddlecenter").get_global_pos()
			var velocity = direction.normalized()*min(speed+SPEEDUP*delta, MAXSPEED*delta)
			set_linear_velocity(velocity)

		if get_pos().y > get_viewport_rect().end.y:
			queue_free()