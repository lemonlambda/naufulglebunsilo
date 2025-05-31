require("prototype.recipes")
require("prototype.ammonia_tile")
require("prototype.planet-map-gen-expressions")

local helper = require("prototype.helpers")

local mod_settings = helper.load_settings()
-- error(serpent.block(mod_settings))

local planet = table.deepcopy(data.raw["planet"]["nauvis"])
planet.name = "naufulglebunusilo"
planet.distance = 40
planet.orientation = 0.5
planet.localised_name = "Naufulglebunusilo"
planet.icon = "__naufulglebunusilo__/graphics/naufulglebunusilo.png"
planet.starmap_icon = "__naufulglebunusilo__/graphics/starmap-planet-naufulglebunusilo.png"
planet.starmap_icon_size = 512;
if mod_settings.fulgora_buildings == true or mod_settings.all_buildings then
	planet.surface_properties["magnetic-field"] = 99
else
	planet.surface_properties["magnetic-field"] = 80
end
planet.surface_properties["pressure"] = helper.select_pressure(mod_settings)
planet.entities_require_heating = mod_settings.aquilo_heating
data:extend { planet }

-- Fixes https://mods.factorio.com/mod/naufulglebunusilo/discussion/672f2a0a6d9c9e59e87454ee
for _,property in pairs(data.raw["agricultural-tower"]["agricultural-tower"].surface_conditions) do
	if property.property == "pressure" then
		property.min = 900
	end
end
for _,property in pairs(data.raw["assembling-machine"]["captive-biter-spawner"].surface_conditions) do
	if property.property == "pressure" then
		property.min = 900
	end
end
for _,property in pairs(data.raw["lab"]["biolab"].surface_conditions) do
	if property.property == "pressure" then
		property.min = 900
	end
end

data.raw["planet"].naufulglebunusilo.map_gen_settings.autoplace_settings =
{
	["tile"] =
	{
		settings = helper.concat_planets("tile", mod_settings)
	},
	["decorative"] =
	{
		settings = data.raw["planet"][mod_settings.planet_decorations].map_gen_settings.autoplace_settings["decorative"].settings
	},
	["entity"] =
	{
		settings = helper.concat_planets("entity", mod_settings)
	}
}

data.raw["planet"].naufulglebunusilo.map_gen_settings.autoplace_controls = helper.autoplace_controls_generator(mod_settings)
if mod_settings.demolishers == true then
	data.raw["planet"].naufulglebunusilo.map_gen_settings.territory_settings =
	{
		units = { "small-demolisher", "medium-demolisher", "big-demolisher" },
		territory_index_expression = "demolisher_territory_expression",
		territory_variation_expression = "demolisher_variation_expression",
		minimum_territory_size = 10
	}
end
if mod_settings.lightning == true then
	data.raw["planet"].naufulglebunusilo.lightning_properties = data.raw["planet"].fulgora.lightning_properties
end

local aquilotonaufulglebunusilo = table.deepcopy(data.raw["space-connection"]["aquilo-solar-system-edge"])
aquilotonaufulglebunusilo.name = "aquilo-naufulglebunusilo"
aquilotonaufulglebunusilo.length = 300000
aquilotonaufulglebunusilo.to = "naufulglebunusilo"
aquilotonaufulglebunusilo.from = "aquilo"

local fulgoratonaufulglebunusilo = table.deepcopy(data.raw["space-connection"]["fulgora-aquilo"])
fulgoratonaufulglebunusilo.name = "fulgora-naufulglebunusilo"
fulgoratonaufulglebunusilo.length = 200000
fulgoratonaufulglebunusilo.to = "fulgora"
fulgoratonaufulglebunusilo.from = "naufulglebunusilo"

data.raw["planet"].naufulglebunusilo.map_gen_settings.property_expression_names =
{
	elevation = "vulcanus_elevation",
	temperature = "vulcanus_temperature",
	moisture = "vulcanus_moisture",
	aux = "vulcanus_aux",
	cliffiness = "cliffiness_basic",
	cliff_elevation = "cliff_elevation_from_elevation",
	-- Add ore expressions
	["entity:tungsten-ore:probability"] = "vulcanus_tungsten_ore_probability",
	["entity:tungsten-ore:richness"] = "vulcanus_tungsten_ore_richness",
	["entity:coal:probability"] = "vulcanus_coal_probability",
	["entity:coal:richness"] = "vulcanus_coal_richness",
	["entity:calcite:probability"] = "vulcanus_calcite_probability",
	["entity:calcite:richness"] = "vulcanus_calcite_richness",
	["entity:sulfuric-acid-geyser:probability"] = "vulcanus_sulfuric_acid_geyser_probability",
	["entity:sulfuric-acid-geyser:richness"] = "vulcanus_sulfuric_acid_geyser_richness",
	-- Add Fulgora Scrap
	["entity:scrap:probability"] = "(control:scrap:size > 0)\z
		* (1 - fulgora_starting_mask)\z
		* (min((fulgora_structure_cells < min(0.1 * frequency, 0.05 + 0.05 * frequency))\z
		* (1 + fulgora_structure_subnoise) * abs_mult_height_over * fulgora_artificial_mask\z
		+ (fulgora_spots_prebanding < (1.2 + 0.4 * linear_size)) * fulgora_vaults_and_starting_vault * 10,\z
		0.5) * (1 - fulgora_road_paving_2c))",
	["entity:scrap:richness"] = "(1 + fulgora_structure_subnoise) * 1000 * (7 / (6 + frequency) + 100 * fulgora_vaults_and_starting_vault) * richness",
	-- Add Aquilo Ores
	["entity:lithium-brine:probability"] = "aquilo_lithium_brine_probability",
	["entity:lithium-brine:richness"] = "aquilo_lithium_brine_richness",
	["entity:fluorine-vent:probability"] = "aquilo_fluorine_vent_probability",
	["entity:fluorine-vent:richness"] = "aquilo_fluorine_vent_richness",
	-- Add Nauvis Ores
	["entity:iron-ore:probability"] = "iron_ore_probability",
	["entity:iron-ore:richness"] = "iron_ore_richness_expression",
	["entity:copper-ore:probability"] = "copper_ore_probability",
	["entity:copper-ore:richness"] = "copper_ore_richness_expression",
	["entity:stone:probability"] = "stone_probability",
	["entity:stone:richness"] = "stone_richness_expression",
	["entity:uranium-ore:probability"] = "uranium_ore_probability",
	["entity:uranium-ore:richness"] = "uranium_ore_richness_expression",
	["entity:crude-oil:probability"] = "crude_oil_probability",
	["entity:crude-oil:richness"] = "crude_oil_richness_expression"
}

data:extend { aquilotonaufulglebunusilo, fulgoratonaufulglebunusilo }
data:extend { {
	type = "technology",
	name = "planet-discovery-naufulglebunusilo",
	localised_name = "Planet discovery Naufulglebunusilo",
	icon = "__naufulglebunusilo__/graphics/naufulglebunusilo-technology.png",
	icon_size = 256,
	essential = true,
	effects = helper.get_tech_effects(mod_settings),
	prerequisites = { "planet-discovery-aquilo" },
	unit =
	{
		count = 500,
		ingredients =
		{
			{ "automation-science-pack",      1 },
			{ "logistic-science-pack",        1 },
			{ "chemical-science-pack",        1 },
			{ "production-science-pack",      1 },
			{ "utility-science-pack",         1 },
			{ "space-science-pack",           1 },
			{ "metallurgic-science-pack",     1 },
			{ "agricultural-science-pack",    1 },
			{ "electromagnetic-science-pack", 1 },
			{ "cryogenic-science-pack",       1 }
		},
		time = 60
	}
} }
