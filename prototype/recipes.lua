local helper = require("helpers")

local mod_settings = helper.load_settings()

if mod_settings.all_buildings == false then
    return
end

local cryogenic_plant_copy = table.deepcopy(data.raw["recipe"]["cryogenic-plant"])
local foundry_copy = table.deepcopy(data.raw["recipe"]["foundry"])
local biochamber_copy = table.deepcopy(data.raw["recipe"]["biochamber"])
local overgrowth_jellynut_copy = table.deepcopy(data.raw["recipe"]["overgrowth-jellynut-soil"])
local overgrowth_yumako_copy = table.deepcopy(data.raw["recipe"]["overgrowth-yumako-soil"])
local jellynut_copy = table.deepcopy(data.raw["recipe"]["artificial-jellynut-soil"])
local yumako_copy = table.deepcopy(data.raw["recipe"]["artificial-yumako-soil"])

local copies = {
    ["Cryogenic Plant"] = cryogenic_plant_copy,
    ["Foundry"] = foundry_copy,
    ["Biochamber"] = biochamber_copy,
    ["Overgrowth jellynut soil"] = overgrowth_jellynut_copy,
    ["Overgrowth yumako soil"] = overgrowth_yumako_copy,
    ["Artificial jellynut soil"] = jellynut_copy,
    ["Artificial yumako soil"] = yumako_copy
}

for k,v in pairs(copies) do
    v.name = v.name .. "-naufulglebunusilo"
    v.localised_name = "Alternative " .. k
    v.enabled = false
    v.surface_conditions = { {property = "pressure", min = 900, max = 900 } }
end

local only_recipe = {}

for k,v in pairs(copies) do
    table.insert(only_recipe, v)
end

data:extend(only_recipe)