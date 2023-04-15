@tool
@icon("res://addons/stylized_material/icon.png")
class_name StylizedMaterial
extends ShaderMaterial

enum BlendMode {MIX, ADD, SUB, MUL}
enum DepthDrawMode {OPAQUE_ONLY, ALWAYS, DISABLED, ALPHA_OPAQUE_PREPASS}
enum CullMode {BACK, FRONT, DISABLED}
enum CelPrimaryMode {NONE, SINGLE, MULTI}

var flags_blend_mode: BlendMode = BlendMode.MIX:
	set(value):
		flags_blend_mode = value;
		_queue_shader_update()

var flags_depth_draw_mode: DepthDrawMode = DepthDrawMode.OPAQUE_ONLY:
	set(value):
		flags_depth_draw_mode = value
		_queue_shader_update()

var flags_cull_mode: CullMode = CullMode.BACK:
	set(value):
		flags_cull_mode = value
		_queue_shader_update()

var flags_recieve_shadows: = true:
	set(value):
		flags_recieve_shadows = value
		_queue_shader_update()

var flags_ambient_light: = false:
	set(value):
		flags_ambient_light = value
		_queue_shader_update()

var flags_use_transparency: = false:
	set(value):
		flags_use_transparency = value
		_queue_shader_update()

var flags_use_vertex_color: = false:
	set(value):
		flags_use_vertex_color = value
		_queue_shader_update()

var cel_shading_mode: CelPrimaryMode = CelPrimaryMode.NONE:
	set(value):
		cel_shading_mode = value
		_queue_shader_update()

var cel_color_primary: = Color.WHITE:
	set(value):
		cel_color_primary = value
		set_shader_parameter("color_primary", value)

var cel_texture_primary: Texture:
	set(value):
		cel_texture_primary = value
		_queue_shader_update()

var cel_color_shaded: = Color(0.86, 0.86, 0.86, 1.0):
	set(value):
		cel_color_shaded = value
		set_shader_parameter("color_shaded", value)

var cel_self_shading_size: = 0.5:
	set(value):
		cel_self_shading_size = value
		set_shader_parameter("self_shading_size", value)

var cel_shadow_edge_size: = 0.05:
	set(value):
		cel_shadow_edge_size = value
		set_shader_parameter("shadow_edge_size", value)

var cel_flatness: = 1.0:
	set(value):
		cel_flatness = value
		set_shader_parameter("flatness", value)

var cel_step_texture: Texture:
	set(value):
		cel_step_texture = value
		_queue_shader_update()

var extra_enable: = false:
	set(value):
		extra_enable = value
		_queue_shader_update()

var extra_color_shaded: = Color(0.86, 0.86, 0.86, 1.0):
	set(value):
		extra_color_shaded = value
		set_shader_parameter("extra_color_shaded", value)

var extra_self_shading_size: = 0.6:
	set(value):
		extra_self_shading_size = value
		set_shader_parameter("extra_self_shading_size", value)

var extra_shadow_edge_size: = 0.05:
	set(value):
		extra_shadow_edge_size = value
		set_shader_parameter("extra_shadow_edge_size", value)

var extra_flatness: = 1.0:
	set(value):
		extra_flatness = value
		set_shader_parameter("extra_flatness", value)

var specular_enable: = false:
	set(value):
		specular_enable = value
		_queue_shader_update()

var specular_color: = Color(0.86, 0.86, 0.86, 1.0):
	set(value):
		specular_color = value
		set_shader_parameter("specular_color", value)

var specular_size: = 0.1:
	set(value):
		specular_size = value
		set_shader_parameter("specular_size", value)

var specular_edge_smoothness: = 0.0:
	set(value):
		specular_edge_smoothness = value
		set_shader_parameter("specular_edge_smoothness", value)

var rim_enable: = false:
	set(value):
		rim_enable = value
		_queue_shader_update()

var rim_color: = Color(0.86, 0.86, 0.86, 1.0):
	set(value):
		rim_color = value
		set_shader_parameter("rim_color", value)

var rim_light_align: = 0.0:
	set(value):
		rim_light_align = value
		set_shader_parameter("rim_light_align", value)

var rim_size: = 0.5:
	set(value):
		rim_size = value
		set_shader_parameter("rim_size", value)

var rim_edge_smoothness: = 0.5:
	set(value):
		rim_edge_smoothness = value
		set_shader_parameter("rim_edge_smoothness", value)

var height_gradient_enable: = false:
	set(value):
		height_gradient_enable = value
		_queue_shader_update()

var height_gradient_color: = Color(0.86, 0.86, 0.86, 1.0):
	set(value):
		height_gradient_color = value
		set_shader_parameter("height_gradient_color", value)

var height_gradient_center: = Vector2.ZERO:
	set(value):
		height_gradient_center = value
		set_shader_parameter("height_gradient_center", value)

var height_gradient_size: = 10.0:
	set(value):
		height_gradient_size = value
		set_shader_parameter("height_gradient_size", value)

var height_gradient_angle: = 0.0:
	set(value):
		height_gradient_angle = value
		set_shader_parameter("height_gradient_angle", value)

var outline_enable: = false:
	set(value):
		outline_enable = value
		_queue_shader_update()

var outline_width: = 4:
	set(value):
		outline_width = value
		next_pass.set_shader_parameter("outline_width", outline_width)

var outline_color: = Color.BLACK:
	set(value):
		outline_color = value
		if (outline_enable):
			next_pass.set_shader_parameter("outline_color", value)

var _is_dirty: = false


func _init():
	_queue_shader_update()


func _get_property_list():
	var props = []
	props.append({
		name = "Flags",
		type = TYPE_NIL,
		usage = PROPERTY_USAGE_GROUP,
		hint_string = "flags_"
	})
	props.append({
		name = "flags_blend_mode",
		type = TYPE_INT,
		hint = PROPERTY_HINT_ENUM,
		hint_string = ",".join(BlendMode.keys())
	})
	props.append({
		name = "flags_depth_draw_mode",
		type = TYPE_INT,
		hint = PROPERTY_HINT_ENUM,
		hint_string = ",".join(DepthDrawMode.keys())
	})
	props.append({
		name = "flags_cull_mode",
		type = TYPE_INT,
		hint = PROPERTY_HINT_ENUM,
		hint_string = ",".join(CullMode.keys())
	})
	props.append({
		name = "flags_recieve_shadows",
		type = TYPE_BOOL,
	})
	props.append({
		name = "flags_ambient_light",
		type = TYPE_BOOL,
	})
	props.append({
		name = "flags_use_vertex_color",
		type = TYPE_BOOL,
	})
	props.append({
		name = "Cel",
		type = TYPE_NIL,
		usage = PROPERTY_USAGE_GROUP,
		hint_string = "cel_"
	})
	props.append({
		name = "cel_shading_mode",
		type = TYPE_INT,
		hint = PROPERTY_HINT_ENUM,
		hint_string = ",".join(CelPrimaryMode.keys())
	})
	props.append({
		name = "cel_color_primary",
		type = TYPE_COLOR,
	})
	props.append({
		name = "cel_texture_primary",
		type = TYPE_OBJECT,
		hint = PROPERTY_HINT_RESOURCE_TYPE,
		hint_string = "Texture"
	})
	if cel_shading_mode != CelPrimaryMode.NONE:
		props.append({
			name = "cel_color_shaded",
			type = TYPE_COLOR,
		})
		if cel_shading_mode == CelPrimaryMode.SINGLE:
			props.append({
				name = "cel_self_shading_size",
				type = TYPE_FLOAT,
				hint = PROPERTY_HINT_RANGE,
				hint_string = "0.0, 1.0"
			})
			props.append({
				name = "cel_shadow_edge_size",
				type = TYPE_FLOAT,
				hint = PROPERTY_HINT_RANGE,
				hint_string = "0.0, 0.5"
			})
			props.append({
				name = "cel_flatness",
				type = TYPE_FLOAT,
				hint = PROPERTY_HINT_RANGE,
				hint_string = "0.0, 1.0"
			})
		if cel_shading_mode == CelPrimaryMode.MULTI:
			props.append({
				name = "cel_step_texture",
				type = TYPE_OBJECT,
				hint = PROPERTY_HINT_RESOURCE_TYPE,
				hint_string = "Texture"
			})
		props.append({
			name = "Extra Cel",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_GROUP,
			hint_string = "extra_"
		})
		props.append({
			name = "extra_enable",
			type = TYPE_BOOL,
		})
		if extra_enable:
			props.append({
				name = "extra_color_shaded",
				type = TYPE_COLOR,
			})
			props.append({
				name = "extra_self_shading_size",
				type = TYPE_FLOAT,
				hint = PROPERTY_HINT_RANGE,
				hint_string = "0.0, 1.0"
			})
			props.append({
				name = "extra_shadow_edge_size",
				type = TYPE_FLOAT,
				hint = PROPERTY_HINT_RANGE,
				hint_string = "0.0, 0.5"
			})
			props.append({
				name = "extra_flatness",
				type = TYPE_FLOAT,
				hint = PROPERTY_HINT_RANGE,
				hint_string = "0.0, 1.0"
			})
		props.append({
			name = "Specular",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_GROUP,
			hint_string = "specular_"
		})
		props.append({
			name = "specular_enable",
			type = TYPE_BOOL,
		})
		if specular_enable:
			props.append({
				name = "specular_color",
				type = TYPE_COLOR,
			})
			props.append({
				name = "specular_size",
				type = TYPE_FLOAT,
				hint = PROPERTY_HINT_RANGE,
				hint_string = "0.0, 1.0"
			})
			props.append({
				name = "specular_smoothness",
				type = TYPE_FLOAT,
				hint = PROPERTY_HINT_RANGE,
				hint_string = "0.0, 1.0"
			})
		props.append({
			name = "Rim",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_GROUP,
			hint_string = "rim_"
		})
		props.append({
			name = "rim_enable",
			type = TYPE_BOOL,
		})
		if rim_enable:
			props.append({
				name = "rim_color",
				type = TYPE_COLOR,
			})
			props.append({
				name = "rim_light_align",
				type = TYPE_FLOAT,
				hint = PROPERTY_HINT_RANGE,
				hint_string = "0.0, 1.0"
			})
			props.append({
				name = "rim_size",
				type = TYPE_FLOAT,
				hint = PROPERTY_HINT_RANGE,
				hint_string = "0.0, 1.0"
			})
			props.append({
				name = "rim_edge_smoothness",
				type = TYPE_FLOAT,
				hint = PROPERTY_HINT_RANGE,
				hint_string = "0.0, 1.0"
			})
		props.append({
			name = "Height Gradient",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_GROUP,
			hint_string = "height_gradient_"
		})
		props.append({
			name = "height_gradient_enable",
			type = TYPE_BOOL,
		})
		if height_gradient_enable:
			props.append({
				name = "height_gradient_color",
				type = TYPE_COLOR,
			})
			props.append({
				name = "height_gradient_center",
				type = TYPE_VECTOR2,
			})
			props.append({
				name = "height_gradient_size",
				type = TYPE_FLOAT,
				hint = PROPERTY_HINT_RANGE,
				hint_string = "0.0, 1.0"
			})
			props.append({
				name = "height_gradient_angle",
				type = TYPE_FLOAT,
				hint = PROPERTY_HINT_RANGE,
				hint_string = "0.0, 360.0"
			})
	props.append({
		name = "Outline",
		type = TYPE_NIL,
		usage = PROPERTY_USAGE_GROUP,
		hint_string = "outline_"
	})
	props.append({
		name = "outline_enable",
		type = TYPE_BOOL
	})
	if outline_enable:
		props.append({
			name = "outline_width",
			type = TYPE_FLOAT,
			hint = PROPERTY_HINT_RANGE,
			hint_string = "0.0, 30, 0.1"
		})
		props.append({
			name = "outline_color",
			type = TYPE_COLOR
		})
	return props


func _queue_shader_update():
	if _is_dirty: return
	print("Queue Shader Update.")
	_is_dirty = true
	notify_property_list_changed()
	_generate_shader_code.call_deferred()


func _generate_shader_code():
	var code = "#pragma disable_preprocessor\n"
	
	code += "shader_type spatial;"
	code += "render_mode "
	
	match flags_blend_mode:
		BlendMode.MIX: code += "blend_mix"
		BlendMode.ADD: code += "blend_add"
		BlendMode.SUB: code += "blend_sub"
		BlendMode.MUL: code += "blend_mul"
	
	match flags_depth_draw_mode:
		DepthDrawMode.OPAQUE_ONLY: code += ",depth_draw_opaque"
		DepthDrawMode.ALWAYS: code += ",depth_draw_always"
		DepthDrawMode.DISABLED: code += ",depth_draw_never"
		DepthDrawMode.ALPHA_OPAQUE_PREPASS: code += ",depth_draw_alpha_prepass"
	
	match flags_cull_mode:
		CullMode.BACK: code += ",cull_back"
		CullMode.FRONT: code += ",cull_front"
		CullMode.DISABLED: code += ",cull_disabled"
	
	if cel_shading_mode == CelPrimaryMode.NONE:
		code += ",unshaded"
	
	if not flags_recieve_shadows:
		code += ",shadows_disabled";
	
	if not flags_ambient_light:
		code += ",ambient_light_disabled"
	
	code += ";"
	
	code += "uniform vec4 color_primary: source_color = vec4(1.0, 1.0, 1.0, 1.0);"
	if cel_texture_primary != null:
		code += "uniform sampler2D texture_primary: source_color;"
	
	if not cel_shading_mode == CelPrimaryMode.NONE:
		code += "uniform vec4 color_shaded: source_color = vec4(0.86, 0.86, 0.86, 1.0);"
		if cel_shading_mode == CelPrimaryMode.SINGLE:
			code += "uniform float self_shading_size: hint_range(0.0, 1.0) = 0.5;"
			code += "uniform float shadow_edge_size: hint_range(0.0, 0.5) = 0.05;"
			code += "uniform float flatness: hint_range(0.0, 1.0) = 1.0;"
		elif cel_shading_mode == CelPrimaryMode.MULTI and cel_step_texture != null:
				code += "uniform sampler2D cel_step_texture: source_color;"
		
		if extra_enable:
			code += "uniform vec4 extra_color_shaded: source_color = vec4(0.86, 0.86, 0.86, 1.0);"
			code += "uniform float extra_self_shading_size: hint_range(0.0, 1.0) = 0.6;"
			code += "uniform float extra_shadow_edge_size: hint_range(0.0, 0.5) = 0.05;"
			code += "uniform float extra_flatness: hint_range(0.0, 1.0) = 1.0;"
		
		if specular_enable:
			code += "uniform vec4 specular_color: source_color = vec4(0.86, 0.86, 0.86, 1.0);"
			code += "uniform float specular_size: hint_range(0.0, 1.0) = 0.1;"
			code += "uniform float specular_edge_smoothness: hint_range(0.0, 1.0) = 0.0;"
		
		if rim_enable:
			code += "uniform vec4 rim_color: source_color = vec4(0.86, 0.86, 0.86, 1.0);"
			code += "uniform float rim_light_align: hint_range(0.0, 1.0) = 0.0;"
			code += "uniform float rim_size: hint_range(0.0, 1.0) = 0.5;"
			code += "uniform float rim_edge_smoothness: hint_range(0.0, 1.0) = 0.5;"
		
		if height_gradient_enable:
			code += "uniform vec4 height_gradient_color: source_color = vec4(0.86, 0.86, 0.86, 1.0);"
			code += "uniform vec2 height_gradient_center = vec2(0.0, 0.0);"
			code += "uniform float height_gradient_size = 10.0;"
			code += "uniform float height_gradient_angle: hint_range(0.0, 360.0) = 0.0;"
		
		code += "float cel_transition(float ndotl, float p_self_shading_size, float p_shadow_edge_size, float p_flatness) {"
		code += "float angle_diff = clamp((ndotl * 0.5 + 0.5) - p_self_shading_size, 0.0, 1.0);"
		code += "float angle_diff_transition = smoothstep(0.0, p_shadow_edge_size, angle_diff);"
		code += "return mix(angle_diff, angle_diff_transition, p_flatness);"
		code += "}"
		
		if cel_shading_mode == CelPrimaryMode.SINGLE:
			code += "float cel_transition_primary(float ndotl) {"
			code += "return cel_transition(ndotl, self_shading_size, shadow_edge_size, flatness);"
			code += "}"
		elif cel_shading_mode == CelPrimaryMode.MULTI:
			code += "float cel_transition_texture(float ndotl, sampler2D step_texture) {"
			code += "float angle_diff = clamp((ndotl * 0.5 + 0.5), 0.0, 1.0);"
			code += "return texture(step_texture, vec2(angle_diff, 0.5)).r;"
			code += "}"
		
		if extra_enable:
			code += "float cel_transition_extra(float ndotl){"
			code += "return cel_transition(ndotl, extra_self_shading_size, extra_shadow_edge_size, extra_flatness);"
			code += "}"
		
		if height_gradient_enable:
			code += "varying vec3 world_pos;"
			code += ""
			code += "void vertex() {"
			code += "vec4 world = WORLD_MATRIX * vec4(VERTEX, 1.0);"
			code += "world_pos = world.xyz / world.w;"
			code += "}"
	
	code += "void fragment(){"
	if cel_texture_primary != null:
		code += "vec4 primary = texture(texture_primary, UV) * color_primary;"
	else: code += "vec4 primary = color_primary;"
	if flags_use_vertex_color:
		code += "primary *= COLOR;"
	code += "ALBEDO = primary.rgb;"
	if flags_use_transparency:
		code += "ALPHA = primary.a;"
	code += "}"
	
	if not cel_shading_mode == CelPrimaryMode.NONE:
		code += "void light(){"
		code += "vec4 color = color_primary;"
		code += "float ndotl = dot(NORMAL, LIGHT);"
		if cel_shading_mode == CelPrimaryMode.SINGLE:
			code += "float cel_transition = cel_transition_primary(ndotl);"
		elif cel_shading_mode == CelPrimaryMode.MULTI and cel_step_texture != null:
			code += "float cel_transition = cel_transition_texture(ndotl, cel_step_texture);"
		else:
			code += "float cel_transition = 1.0;"
		code += "color = mix(color_shaded, color, cel_transition);"
		
		if extra_enable:
			code += "float extra_cel_transition = cel_transition_extra(ndotl);"
			code += "color = mix(extra_color_shaded, color, extra_cel_transition);"
		
		if height_gradient_enable:
			code += "float angle_radians = radians(height_gradient_angle / 180.0);"
			code += "float pos_grad_rotated = (world_pos.x - height_gradient_center.x) * sin(angle_radians) + (world_pos.y - height_gradient_center.y) * cos(angle_radians);"
			code += "float gradient_top = height_gradient_center.y + height_gradient_size * 0.5;"
			code += "float gradient_factor = clamp((gradient_top - pos_grad_rotated) / height_gradient_size, 0.0, 1.0);"
			code += "color = mix(height_gradient_color, color, gradient_factor);"
		
		if rim_enable:
			code += "float rim = 1.0 - dot(VIEW, NORMAL);"
			code += "float rim_spread = 1.0 - rim_size - ndotl * rim_light_align;"
			code += "float rim_transition = smoothstep(rim_spread - rim_edge_smoothness * 0.5, rim_spread + rim_edge_smoothness * 0.5, rim);"
			code += "color = mix(color, rim_color, rim_transition);"
		
		if specular_enable:
			code += "vec3 half_vector = normalize(VIEW + LIGHT);"
			code += "float ndoth = dot(NORMAL, half_vector) * 0.5 + 0.5;"
			code += "float specular = clamp(pow(ndoth, 100.0 * (1.0 - specular_size) * (1.0 - specular_size)), 0.0, 1.0);"
			code += "float specular_transition = smoothstep(0.5 - specular_edge_smoothness * 0.1, 0.5 + specular_edge_smoothness * 0.1, specular);"
			code += "SPECULAR_LIGHT = mix(vec4(0.0,0.0,0.0,1.0), specular_color, specular_transition).rgb * ALBEDO;"
		
		code += "DIFFUSE_LIGHT += color.rgb * ALBEDO;"
		if flags_use_transparency:
			code += "ALPHA = color.a;"
		code +="}"
	
	if not shader:
		shader = Shader.new()
	
	shader.code = code

	set_shader_parameter("color_primary", cel_color_primary)
	if cel_texture_primary != null:
		set_shader_parameter("texture_primary", cel_texture_primary)
	if not cel_shading_mode == CelPrimaryMode.NONE:
		set_shader_parameter("color_shaded", cel_color_shaded)
	if cel_shading_mode == CelPrimaryMode.SINGLE:
		set_shader_parameter("self_shading_size", cel_self_shading_size)
		set_shader_parameter("shadow_edge_size", cel_shadow_edge_size)
		set_shader_parameter("flatness", cel_flatness)
	elif cel_shading_mode == CelPrimaryMode.MULTI and cel_step_texture != null:
		set_shader_parameter("cel_step_texture", cel_step_texture)
	if extra_enable:
		set_shader_parameter("extra_self_shading_size", extra_self_shading_size)
		set_shader_parameter("extra_shadow_edge_size", extra_shadow_edge_size)
		set_shader_parameter("extra_flatness", extra_flatness)
		set_shader_parameter("extra_color_shaded", extra_color_shaded)
	if specular_enable:
		set_shader_parameter("specular_color", specular_color)
		set_shader_parameter("specular_size", specular_size)
		set_shader_parameter("specular_edge_smoothness", specular_edge_smoothness)
	if rim_enable:
		set_shader_parameter("rim_size", rim_size)
		set_shader_parameter("rim_light_align", rim_light_align)
		set_shader_parameter("rim_edge_smoothness", rim_edge_smoothness)
		set_shader_parameter("rim_color", rim_color)
	if height_gradient_enable:
		set_shader_parameter("height_gradient_angle", height_gradient_angle)
		set_shader_parameter("height_gradient_center", height_gradient_center)
		set_shader_parameter("height_gradient_size", height_gradient_size)
		set_shader_parameter("height_gradient_color", height_gradient_color)
	
	if outline_enable:
		var outline_code = ""
		outline_code += "shader_type spatial;"
		outline_code += "render_mode cull_front, unshaded;"
		outline_code += "uniform vec4 outline_color: source_color;"
		# Set this value as 2 * outline_width_in_pixels * (1 / screen_size.xy)
		outline_code += "uniform float outline_width = 2;"
		outline_code += "void vertex () {"
		# Move to clip space before applying the vertex growth.
		# This should counteract any object scaling and the outlines should
		# be of same thickness.
		outline_code += "vec4 position = PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX, 1.0);"
#		outline_code += "vec3 position_normal = normalize(position.xyz);"
		outline_code += "vec3 clip_normal = (PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;"
#		outline_code += "clip_normal = mix(clip_normal, position_normal, 1);"
		# In clip space xy corresponds to screen positions.
		# By normalizing only xy we ensure the outline takes up exaclty
		# `outline_width` of clip space.
		# By extruding only in xy we can reduce the variations of the outline
		# thickness at grazing angles.
		# Eliminate foreshortening by counteracting perspective division.
		outline_code += "vec2 scaled_outline_width = 2.0 * outline_width / VIEWPORT_SIZE;"
		outline_code += "position.xy += normalize(clip_normal.xy) * scaled_outline_width * position.w;"
		outline_code += "POSITION = position;"
		outline_code += "}"
		outline_code += "void fragment() {"
		outline_code += "ALBEDO = outline_color.xyz;"
		if outline_color.a > 0:
			outline_code += "ALPHA = outline_color.a;"
		outline_code += "}"
		if not next_pass or not next_pass is ShaderMaterial:
			next_pass = ShaderMaterial.new()
		if not next_pass.shader:
			next_pass.shader = Shader.new()
		next_pass.shader.code = outline_code
		next_pass.set_shader_parameter("outline_color", outline_color)
		next_pass.set_shader_parameter("outline_width", outline_width)
	else:
		next_pass = null
	
	_is_dirty = false
