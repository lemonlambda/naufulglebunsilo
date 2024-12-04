require("prototype.recipes")
require("prototype.ammonia_tile")

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