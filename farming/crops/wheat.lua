
local S = farming.intllib

-- wheat seeds
minetest.register_node("farming:seed_wheat", {
	description = S("Wheat Seed"),
	tiles = {"farming_wheat_seed.png"},
	inventory_image = "farming_wheat_seed.png",
	wield_image = "farming_wheat_seed.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1, flammable = 4},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:wheat_1")
	end,
})

-- harvested wheat
minetest.register_craftitem("farming:wheat", {
	description = S("Wheat"),
	inventory_image = "farming_wheat.png",
	groups = {food_wheat = 1, flammable = 4},
})

-- straw
minetest.register_node("farming:straw", {
	description = S("Straw"),
	tiles = {"farming_straw.png"},
	is_ground_content = false,
	groups = {snappy = 3, flammable = 4, fall_damage_add_percent = -30},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft({
	output = "farming:straw 3",
	recipe = {
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
	}
})

minetest.register_craft({
	output = "farming:wheat 3",
	recipe = {
		{"farming:straw"},
	}
})

-- flour
minetest.register_craftitem("farming:flour", {
	description = S("Flour"),
	inventory_image = "farming_flour.png",
	groups = {food_flour = 1, flammable = 1},
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:flour",
	recipe = {
		"farming:wheat", "farming:mortar_pestle"
	},
	replacements = {{"group:food_mortar_pestle", "farming:mortar_pestle"}},
})

-- bread
minetest.register_craftitem("farming:bread", {
	description = S("Bread"),
	inventory_image = "farming_bread.png",
	on_use = minetest.item_eat(5),
	groups = {food_bread = 1, flammable = 2},
})

minetest.register_craftitem("farming:dough", {
	description = S("Dough"),
	inventory_image = "farming_dough.png",
	groups = {food_bread = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "farming:bread",
	recipe = "farming:flour"
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:dough",
	recipe = {
		"farming:mixingbowl", "bucket:bucket_water", "",
		"farming:flour", "farming:salt", ""
	},
	replacements = {{"group:food_mortar_pestle", "farming:mortar_pestle"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:dough",
	recipe = {
		"farming:mixingbowl", "bucket:bucket_river_water", "",
		"farming:flour", "farming:salt", ""
	},
	replacements = {{"group:food_mortar_pestle", "farming:mortar_pestle"}},
})

-- sliced bread
minetest.register_craftitem("farming:bread_slice", {
	description = S("Sliced Bread"),
	inventory_image = "farming_bread_slice.png",
	on_use = minetest.item_eat(1),
	groups = {food_bread_slice = 1, flammable = 2},
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:bread_slice 5",
	recipe = {"farming:bread", "group:food_cutting_board"},
	replacements = {{"group:food_cutting_board", "farming:cutting_board"}},
})

-- toast
minetest.register_craftitem("farming:toast", {
	description = S("Toast"),
	inventory_image = "farming_toast.png",
	on_use = minetest.item_eat(1),
	groups = {food_toast = 1, flammable = 2},
})

minetest.register_craftitem("farming:toast_sandwich", {
	description = S("Toast Sandwich"),
	inventory_image = "farming_toast_sandwich.png",
	on_use = minetest.item_eat(1),
	groups = {food_toast = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	cooktime = 3,
	output = "farming:toast",
	recipe = "farming:bread_slice"
})

-- toast sandwich
minetest.register_craftitem("farming:toast_sandwich", {
	description = S("Toast Sandwich"),
	inventory_image = "farming_toast_sandwich.png",
	on_use = minetest.item_eat(4),
	groups = {flammable = 2},
})

minetest.register_craft({
	output = "farming:toast_sandwich",
	recipe = {
		{"farming:bread_slice"},
		{"farming:toast"},
		{"farming:bread_slice"},
	}
})

-- wheat definition
local crop_def = {
	drawtype = "plantlike",
	tiles = {"farming_wheat_1.png"},
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 3,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 4, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("farming:wheat_1", table.copy(crop_def))

-- stage 2
crop_def.tiles = {"farming_wheat_2.png"}
crop_def.drop = {
	items = {
		{items = {'farming:seed_wheat'}, rarity = 2},
	}
}
minetest.register_node("farming:wheat_2", table.copy(crop_def))

-- stage 3
crop_def.tiles = {"farming_wheat_3.png"}
crop_def.drop = {
	items = {
		{items = {'farming:seed_wheat'}, rarity = 2},
	}
}
minetest.register_node("farming:wheat_3", table.copy(crop_def))

-- stage 4
crop_def.tiles = {"farming_wheat_4.png"}
crop_def.groups.growing = 0
crop_def.drop = {
	items = {
		{items = {'farming:wheat'}, rarity = 1},
		{items = {'farming:wheat'}, rarity = 3},
		{items = {'farming:seed_wheat'}, rarity = 1},
		{items = {'farming:seed_wheat'}, rarity = 3},
	}
}
minetest.register_node("farming:wheat_4", table.copy(crop_def))

-- add to registered_plants
farming.registered_plants["farming:wheat"] = {
	crop = "farming:wheat",
	seed = "farming:seed_wheat",
	minlight = 13,
	maxlight = 15,
	steps = 8
}

-- fuels
minetest.register_craft({
	type = "fuel",
	recipe = "farming:straw",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:wheat",
	burntime = 1,
})
