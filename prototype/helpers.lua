local helper = {}

function helper.concat_tables(t1, t2)
	local copy = table.deepcopy(t1)
	for k, v in pairs(t2) do copy[k] = v end
	return copy
end

function table_contains(t, v)
	for _,value in pairs(t) do
		if value == v then
			return true
		end
	end
	return false
end

function helper.concat_planets(index, mod_settings)
	local concatted = {}
	for name, v in pairs(data.raw["planet"]) do
		if not table_contains({"vulcanus", "gleba", "nauvis", "fulgora", "aquilo"}, name) then
			goto continue
		end
		if name == "naufulglebunusilo" then
			goto continue
		end
		if table_contains(mod_settings.disabled_planets_tile, name) then
			goto continue
		end

		if v.map_gen_settings and v.map_gen_settings.autoplace_settings then	
			concatted = helper.concat_tables(concatted, v.map_gen_settings.autoplace_settings[index].settings)
		end
		::continue::
	end
	if not table_contains(mod_settings.disabled_planets_tile, "aquilo") and index == "tile" then
		concatted = helper.concat_tables(concatted, {["ammonia-lava"] = {}})
	end
	return concatted
end

function helper.load_settings()
	local mod_settings = {
		all_buildings = true,
		planet_building_type = "gleba",
		planet_decorations = "nauvis",
		disabled_planets_tile = {},
		fulgora_buildings = true,
		lightning = true,
		biters = true,
		wrigglers = true,
		demolishers = true,
		aquilo_heating = true
	}

	mod_settings.all_buildings = settings.startup["all-buildings"].value
	mod_settings.planet_building_type = settings.startup["planet-buildings"].value
	mod_settings.planet_decorations = settings.startup["planet-decorations"].value
	mod_settings.fulgora_buildings = settings.startup["fulgora-buildings"].value
	mod_settings.lightning = settings.startup["fulgora-lightning"].value
	mod_settings.biters = settings.startup["biters"].value
	mod_settings.wrigglers = settings.startup["gleba-enemies"].value
	mod_settings.demolishers = settings.startup["demolishers"].value
	mod_settings.aquilo_heating = settings.startup["aquilo-heating"].value
	mod_settings.nauvis_tiles = settings.startup["nauvis-tiles"].value
	mod_settings.fulgora_tiles = settings.startup["fulgora-tiles"].value
	mod_settings.vulcanus_tiles = settings.startup["vulcanus-tiles"].value
	mod_settings.gleba_tiles = settings.startup["gleba-tiles"].value
	mod_settings.aquilo_tiles = settings.startup["aquilo-tiles"].value

	if settings.startup["nauvis-tiles"].value == false then
		table.insert(mod_settings.disabled_planets_tile, "nauvis")
	end
	if settings.startup["fulgora-tiles"].value == false then
		table.insert(mod_settings.disabled_planets_tile, "fulgora")
	end
	if settings.startup["vulcanus-tiles"].value == false then
		table.insert(mod_settings.disabled_planets_tile, "vulcanus")
	end
	if settings.startup["gleba-tiles"].value == false then
		table.insert(mod_settings.disabled_planets_tile, "gleba")
	end
	if settings.startup["aquilo-tiles"].value == false then
		table.insert(mod_settings.disabled_planets_tile, "aquilo")
	end

	if settings.startup["nauvis-on"].value == false then
		mod_settings.biters = false
		table.insert(mod_settings.disabled_planets_tile, "nauvis")
	end
	if settings.startup["vulcanus-on"].value == false then
		table.insert(mod_settings.disabled_planets_tile, "vulcanus")
		mod_settings.demolishers = false
	end
	if settings.startup["fulgora-on"].value == false then
		mod_settings.lightning = false
		mod_settings.fulgora_buildings = false
		table.insert(mod_settings.disabled_planets_tile, "fulgora")
	end
	if settings.startup["aquilo-on"].value == false then
		mod_settings.aquilo_heating = false
		table.insert(mod_settings.disabled_planets_tile, "aquilo")
	end
	if settings.startup["gleba-on"].value == false then
		table.insert(mod_settings.disabled_planets_tile, "gleba")
		mod_settings.wrigglers = false
	end

	return mod_settings
end

function helper.select_pressure(mod_settings)
	if mod_settings.all_buildings == true then
		return 900
	elseif mod_settings.planet_building_type == "gleba" then
		return 2000
	elseif mod_settings.planet_building_type == "vulcanus" then
		return 4000
	elseif mod_settings.planet_building_type == "aquilo" then
		return 300
	else
		return 2000
	end
end

function helper.autoplace_controls_generator(mod_settings)
	local autoplace_controls = {}

	for name, v in pairs(data.raw["planet"]) do
		if name == "naufulglebunusilo" then
			goto continue
		end
		if table_contains(mod_settings.disabled_planets_tile, name) then
			goto continue
		end
		if v.map_gen_settings and v.map_gen_settings.autoplace_settings then
			autoplace_controls = helper.concat_tables(autoplace_controls, data.raw["planet"][name].map_gen_settings.autoplace_controls)
		end
		::continue::
	end

	return autoplace_controls
end

function helper.get_tech_effects(mod_settings)
    local effects = {
		{
			type = "unlock-space-location",
			space_location = "naufulglebunusilo",
			use_icon_overlay_constant = true
		}
    }
    if mod_settings.all_buildings then
		table.insert(effects, {
			type = "unlock-recipe",
			recipe = "cryogenic-plant-naufulglebunusilo"
		})
		table.insert(effects, {
			type = "unlock-recipe",
			recipe = "foundry-naufulglebunusilo"
		})
		table.insert(effects, {
			type = "unlock-recipe",
			recipe = "biochamber-naufulglebunusilo"
		})
		table.insert(effects, {
			type = "unlock-recipe",
			recipe = "artificial-jellynut-soil-naufulglebunusilo"
		})
		table.insert(effects, {
			type = "unlock-recipe",
			recipe = "artificial-yumako-soil-naufulglebunusilo"
		})
		table.insert(effects, {
			type = "unlock-recipe",
			recipe = "overgrowth-jellynut-soil-naufulglebunusilo"
		})
		table.insert(effects, {
			type = "unlock-recipe",
			recipe = "overgrowth-yumako-soil-naufulglebunusilo"
		})
    end
    return effects
end

return helper
