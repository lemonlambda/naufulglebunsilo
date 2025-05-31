-- To add a new ore:
-- 1. Add any needed constants (like spacing) to the Constants section
-- 2. Add probability and richness expressions following the existing patterns based on each planet's ores

data:extend{
-- Constants
{
type = "noise-expression",
name = "vulcanus_ore_spacing",
expression = 128
},
-- Resource noise helpers
{
type = "noise-expression",
name = "vulcanus_resource_wobble_x",
expression = "vulcanus_wobble_x + 0.25 * vulcanus_wobble_large_x"
},
{
type = "noise-expression",
name = "vulcanus_resource_wobble_y",
expression = "vulcanus_wobble_y + 0.25 * vulcanus_wobble_large_y"
},
-- Vulcanus Ore richness and probabilities
{
type = "noise-expression",
name = "vulcanus_tungsten_ore_probability",
expression = "(control:tungsten_ore:size > 0) * (1000 * ((1 + vulcanus_tungsten_ore_region) * random_penalty_between(0.9, 1, 1) - 1))"
},
{
type = "noise-expression",
name = "vulcanus_tungsten_ore_richness",
expression = "vulcanus_tungsten_ore_region * random_penalty_between(0.9, 1, 1) * 10000"
},
{
type = "noise-expression",
name = "vulcanus_coal_probability",
expression = "(control:vulcanus_coal:size > 0) * (1000 * ((1 + vulcanus_coal_region) * random_penalty_between(0.9, 1, 1) - 1))"
},
{
type = "noise-expression",
name = "vulcanus_coal_richness",
expression = "vulcanus_coal_region * random_penalty_between(0.9, 1, 1) * 18000"
},
{
type = "noise-expression",
name = "vulcanus_calcite_probability",
expression = "(control:calcite:size > 0) * (1000 * ((1 + vulcanus_calcite_region) * random_penalty_between(0.9, 1, 1) - 1))"
},
{
type = "noise-expression",
name = "vulcanus_calcite_richness",
expression = "vulcanus_calcite_region * random_penalty_between(0.9, 1, 1) * 24000"
},
{
type = "noise-expression",
name = "vulcanus_sulfuric_acid_geyser_probability",
expression = "(control:sulfuric_acid_geyser:size > 0) * (0.025 * ((vulcanus_sulfuric_acid_region_patchy > 0) + 2 * vulcanus_sulfuric_acid_region_patchy))"
},
{
type = "noise-expression",
name = "vulcanus_sulfuric_acid_geyser_richness",
expression = "(vulcanus_sulfuric_acid_region > 0) * random_penalty_between(0.5, 1, 1) * 80000 * 40"
},

-- Aquilo Resource Constants
{
type = "noise-expression",
name = "aquilo_spot_size",
expression = 30
},
{
type = "noise-expression",
name = "aquilo_angle",
expression = "map_seed_normalized * 3600"
},

-- Aquilo Starting Resource Spots
{
type = "noise-expression",
name = "aquilo_starting_crude_oil",
expression = "starting_spot_at_angle{angle = aquilo_angle, distance = 40, radius = aquilo_spot_size * 0.8, x_distortion = 0, y_distortion = 0}"
},
{
type = "noise-expression",
name = "aquilo_starting_lithium_brine",
expression = "starting_spot_at_angle{angle = aquilo_angle + 120, distance = 80, radius = aquilo_spot_size * 0.6, x_distortion = 0, y_distortion = 0}"
},
{
type = "noise-expression",
name = "aquilo_starting_fluorine_vent",
expression = "starting_spot_at_angle{angle = aquilo_angle + 240, distance = 160, radius = aquilo_spot_size * 0.6, x_distortion = 0, y_distortion = 0}"
},

-- Aquilo Resource Probabilities and Richness
{
type = "noise-expression",
name = "aquilo_crude_oil_probability",
expression = "(control:aquilo_crude_oil:size > 0) * (0.015 * aquilo_starting_crude_oil)"
},
{
type = "noise-expression",
name = "aquilo_crude_oil_richness",
expression = "aquilo_starting_crude_oil * 1440000 * control:aquilo_crude_oil:richness"
},
{
type = "noise-expression",
name = "aquilo_lithium_brine_probability",
expression = "(control:lithium_brine:size > 0) * (0.012 * aquilo_starting_lithium_brine)"
},
{
type = "noise-expression",
name = "aquilo_lithium_brine_richness",
expression = "aquilo_starting_lithium_brine * 720000 * control:lithium_brine:richness"
},
{
type = "noise-expression",
name = "aquilo_fluorine_vent_probability",
expression = "(control:fluorine_vent:size > 0) * (0.008 * aquilo_starting_fluorine_vent)"
},
{
type = "noise-expression",
name = "aquilo_fluorine_vent_richness",
expression = "aquilo_starting_fluorine_vent * 520000 * control:fluorine_vent:richness"
},

-- Nauvis vanilla ores using correct control names
{
type = "noise-expression",
name = "nauvis_iron_ore_probability",
expression = "(control:iron-ore:size > 0) * iron_ore_probability"
},
{
type = "noise-expression",
name = "nauvis_iron_ore_richness",
expression = "iron_ore_richness_expression * control:iron-ore:richness"
},
{
type = "noise-expression",
name = "nauvis_copper_ore_probability",
expression = "(control:copper-ore:size > 0) * copper_ore_probability"
},
{
type = "noise-expression",
name = "nauvis_copper_ore_richness",
expression = "copper_ore_richness_expression * control:copper-ore:richness"
},
{
type = "noise-expression",
name = "nauvis_stone_probability",
expression = "(control:stone:size > 0) * stone_probability"
},
{
type = "noise-expression",
name = "nauvis_stone_richness",
expression = "stone_richness_expression * control:stone:richness"
},
{
type = "noise-expression",
name = "nauvis_uranium_ore_probability",
expression = "(control:uranium-ore:size > 0) * uranium_ore_probability"
},
{
type = "noise-expression",
name = "nauvis_uranium_ore_richness",
expression = "uranium_ore_richness_expression * control:uranium-ore:richness"
}
}
