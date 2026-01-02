extends CharacterBody2D
@export var Animacion: AnimatedSprite2D
@export var area_2d: Area2D
@export var material_personaje_rojo: ShaderMaterial

var _velocidad: float = 100.0
var  _velocidad_salto: float = -300.0
var _muerto: bool

func _ready():
	area_2d.body_entered.connect(_on_area_2d_body_entered)

func _physics_process(delta):
	
	if _muerto:
		return

	#gravedad
	velocity += get_gravity() * delta 

	#salto
	if Input.is_action_just_pressed("saltar") && is_on_floor():
		velocity.y =  _velocidad_salto
	#movimiento lateral
	if Input.is_action_pressed("deracha"):
		velocity.x = _velocidad
		Animacion.flip_h = false 
	elif Input.is_action_pressed("izquierda"):
		velocity.x= -_velocidad
		Animacion.flip_h = true
	else:
		velocity.x = 0
	move_and_slide()
	
	#animacion
	if !is_on_floor():
		Animacion.play("saltar")
	elif velocity.x != 0:
		Animacion.play("correr")
	else :
		Animacion.play("idle")
	
	
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	Animacion.material = material_personaje_rojo
	_muerto = true
	Animacion.stop()
