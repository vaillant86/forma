extends CanvasLayer

func _process(delta):
	var time = Time.get_ticks_msec() / 1000.0
	
	$BaseColor/Shape1.rotation += 0.1 * delta
	$BaseColor/Shape1.position.y += sin(time) * 0.2
	
	$BaseColor/Shape2.rotation -= 0.15 * delta
	$BaseColor/Shape2.position.x += cos(time * 0.8) * 0.2
	
	$BaseColor/Shape3.rotation += 0.05 * delta
	$BaseColor/Shape3.position.y += cos(time * 1.2) * 0.2
