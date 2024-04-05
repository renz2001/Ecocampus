extends Node

signal sound_effect_started(sound: AudioStream)
signal sound_effect_finished(sound: AudioStream)

signal music_started(music: AudioStream)
signal music_finished(music: AudioStream)

@export var music: Node
@export var sound_effects: Node
@export var sound_effects_2d: Node

@export var music_player: AudioStreamPlayer
@export var sound_effects_player: AudioStreamPlayer
@export var sound_effects_player_2D: AudioStreamPlayer2D

@export var fade_in_arguments: TweenArguments
@export var fade_out_arguments: TweenArguments
#@export var cross_fade: bool


func fade_in(audio_player: Node) -> Tween: 
	var tween: Tween = fade_in_arguments.create_tween(get_tree())
	tween.tween_property(audio_player.volume_slider, "value", 1, fade_in_arguments.duration)
	tween.play()
	return tween


func fade_out(audio_player: Node) -> Tween: 
	var tween: Tween = fade_out_arguments.create_tween(get_tree())
	tween.tween_property(audio_player.volume_slider, "value", 0, fade_out_arguments.duration)
	tween.play()
	return tween
	
	
func play_music(args: AudioStreamPlayerArguments) -> AudioStreamPlayer: 
	if music_player.stream: 
		await fade_out(music_player).finished
	await fade_in(music_player).finished
	
	_set_player(music_player, args).finished.connect(
		func(): 
			music_finished.emit(args.sound)
	)
	music_started.emit(args.sound)
	return music_player


func _set_player(player: Node, args: AudioStreamPlayerArguments, change_name: bool = false) -> Node: 
	player.stream = args.sound
	player.pitch_scale = args.pitch_scale
	player.volume_db = args.get_volume()
	#if change_name: 
		#player.name = args.sound.resource_name.to_camel_case()
	player.play(args.play_from_position) 
	player.finished.connect(
		func(): 
			player.stream = null
	)
	return player


func play_temporary_music(args: AudioStreamPlayerArguments) -> AudioStreamPlayer: 
	var audio_stream_player: AudioStreamPlayer = AudioStreamPlayer.new()
	music.add_child(audio_stream_player)
	_set_player(audio_stream_player, args, true).finished.connect(
		func(): 
			audio_stream_player.queue_free()
			music_finished.emit(args.sound)
	)
	music_started.emit(args.sound)
	return audio_stream_player


func play_sound_effect(args: AudioStreamPlayerArguments, position: Vector2 = Vector2.ZERO) -> Node: 
	if position != Vector2.ZERO: 
		@warning_ignore("confusable_local_declaration")
		var audio_stream_player: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
		sound_effects_2d.add_child(audio_stream_player)
		_set_player(audio_stream_player, args, true).finished.connect(
			func(): 
				audio_stream_player.queue_free()
				sound_effect_finished.emit(args.sound)
		)
		sound_effect_started.emit(args.sound) 
		return
		
	var audio_stream_player: AudioStreamPlayer = AudioStreamPlayer.new()
	sound_effects.add_child(audio_stream_player)
	_set_player(audio_stream_player, args, true).finished.connect(
		func(): 
			audio_stream_player.queue_free()
			sound_effect_finished.emit(args.sound)
	)
	return audio_stream_player


#func play_sound(args: AudioStreamPlayerArguments, position: Vector2 = Vector2.ZERO) -> void: 
	#if position != Vector2.ZERO: 
		#await fade_out(sound_effects_player_2D).finished
		#await fade_in(sound_effects_player_2D).finished
		#sound_effects_player_2D.stream = args.sound
		#sound_effects_player_2D.pitch_scale = args.pitch_scale
		#sound_effects_player_2D.play(args.play_from_position)
		#sound_effect_started.emit(args.sound)
		#await sound_effects_player.finished
		#sound_effects_player_2D.stream = null
		#sound_effect_finished.emit(args.sound)
		#return
	#await fade_out(sound_effects_player).finished
	#await fade_in(sound_effects_player).finished
	#sound_effects_player.stream = args.sound 
	#sound_effects_player.pitch_scale = args.pitch_scale
	#sound_effects_player.play(args.play_from_position) 
	#sound_effect_started.emit(args.sound) 
	#await sound_effects_player.finished
	#sound_effects_player.stream = null 
	#sound_effect_finished.emit(args.sound)
	
	
#func play_rng_pitch_sound(args: AudioStreamPlayerArguments, _range: Array[int] = [0, 1],  position: Vector2 = Vector2.ZERO) -> void: 
	#var rng: RandomNumberGenerator = RandomNumberGenerator.new() 
	#rng.randomize()
	#var new_pitch: float = rng.randf_range(_range[0], _range[1])
	#range()
	#args.set_pitch_scale(new_pitch)
	#play_sound(args, position)

