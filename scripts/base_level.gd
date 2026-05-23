extends Node2D

var gioco_attivo = false
var raggio_calamita = 80.0

var grid_step = 75.0
var grid_offset_x = 0.0
var grid_offset_y = 0.0
var griglia_calcolata = false

func _ready():
	pass

func _get_level_number() -> int:
	var nome = scene_file_path.get_file().get_basename()
	if "_" in nome:
		return int(nome.split("_")[1])
	return 1
	
func _process(_delta):
	if not griglia_calcolata:
		calcola_griglia_automatica()
		imposta_interfaccia()
		
		SaveManager.current_level = _get_level_number()
		
		gioco_attivo = true
		return
		
	if not gioco_attivo:
		return
		
	if controlla_vittoria():
		gestisci_vittoria()

func imposta_interfaccia():
	$UI/LabelVittoria.hide()
	$UI/BtnProssimoLivello.hide()
	$UI/BtnLevel.text = "LEVEL " + str(_get_level_number())
	
func calcola_griglia_automatica():
	var sagoma = null
	var primo_pezzo = null
	
	for n in get_children():
		if n is Polygon2D and not n.name.begins_with("Pezzo"):
			sagoma = n
		elif n.name.begins_with("Pezzo_") and primo_pezzo == null:
			primo_pezzo = n
			
	if sagoma != null and primo_pezzo != null:
		grid_step = 50.0 * primo_pezzo.scale.x
		
		var min_x = 99999.0
		var min_y = 99999.0
		var trans = sagoma.get_global_transform()
		
		for pt in sagoma.polygon:
			var global_pt = trans * pt
			if global_pt.x < min_x: min_x = global_pt.x
			if global_pt.y < min_y: min_y = global_pt.y
			
		grid_offset_x = fmod(min_x, grid_step)
		grid_offset_y = fmod(min_y, grid_step)
		
	griglia_calcolata = true

func controlla_vittoria() -> bool:
	var pezzi = []
	for n in get_children():
		if n.name.begins_with("Pezzo_"):
			if "trascinamento" in n and n.trascinamento:
				return false
			pezzi.append(n)
			
	var sagoma = null
	for n in get_children():
		if n is Polygon2D and not n.name.begins_with("Pezzo"):
			sagoma = n
			break
			
	if sagoma == null or pezzi.is_empty():
		return false
		
	var sagoma_global_poly = PackedVector2Array()
	var trans_sagoma = sagoma.get_global_transform()
	for pt in sagoma.polygon:
		sagoma_global_poly.append(trans_sagoma * pt)
	
	var poligoni_pezzi = []
	for pezzo in pezzi:
		var poly_node = null
		for c in pezzo.get_children():
			if "polygon" in c:
				poly_node = c
				break
				
		if poly_node:
			var trans = poly_node.get_global_transform()
			var global_poly = PackedVector2Array()
			for pt in poly_node.polygon:
				global_poly.append(trans * pt)
			poligoni_pezzi.append(global_poly)
			
	if poligoni_pezzi.size() < pezzi.size():
		return false
			
	var rimanenza_sagoma = [sagoma_global_poly]
	for poly_p in poligoni_pezzi:
		var nuova_rimanenza = []
		for r_poly in rimanenza_sagoma:
			nuova_rimanenza.append_array(Geometry2D.clip_polygons(r_poly, poly_p))
		rimanenza_sagoma = nuova_rimanenza
		
	var area_scoperta = 0.0
	for r_poly in rimanenza_sagoma:
		area_scoperta += calcola_area(r_poly)
		
	var area_fuori = 0.0
	for poly_p in poligoni_pezzi:
		var pezzi_fuori = Geometry2D.clip_polygons(poly_p, sagoma_global_poly)
		for p_fuori in pezzi_fuori:
			area_fuori += calcola_area(p_fuori)

	return area_scoperta < 500.0 and area_fuori < 500.0

func calcola_area(poly: PackedVector2Array) -> float:
	var area = 0.0
	var n = poly.size()
	for i in range(n):
		var j = (i + 1) % n
		area += poly[i].x * poly[j].y - poly[j].x * poly[i].y
	return abs(area) / 2.0

func gestisci_vittoria():
	$UI/LabelVittoria.show()
	$UI/BtnProssimoLivello.show()
	
	var lv = _get_level_number()
	if SaveManager.save_data["livello_sbloccato"] <= lv:
		SaveManager.save_data["livello_sbloccato"] = lv + 1
		SaveManager.save_game()
	
	SaveManager.current_level = lv + 1
	
	gioco_attivo = false
	set_process(false)

func _on_btn_prossimo_livello_pressed():
	var prossimo = _get_level_number() + 1
	var path = "res://lev_" + str(prossimo) + ".tscn"
	if ResourceLoader.exists(path):
		get_tree().change_scene_to_file(path)
	else:
		get_tree().change_scene_to_file("res://main_menu.tscn")
		
func _on_btn_menu_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_btn_reset_pressed():
	get_tree().reload_current_scene()
