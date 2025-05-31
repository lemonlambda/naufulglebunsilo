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

  -- New Aquilo stuff
  {
    type = "noise-expression",
    name = "aquilo_segmentation_multiplier",
    expression = "1"
  },
  {
    type = "noise-expression",
    name = "aquilo_angle",
    expression = "map_seed_normalized * 3600"
  },
  {
    type = "noise-expression",
    name = "aquilo_spot_size",
    expression = 30
  },
  {
    type = "noise-expression",
    name = "aquilo_starting_island",
    expression = "1 - distance * (aquilo_segmentation_multiplier / 100)"
  },
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
    name = "aquilo_starting_flourine_vent",
    expression = "starting_spot_at_angle{angle = aquilo_angle + 240, distance = 160, radius = aquilo_spot_size * 0.6, x_distortion = 0, y_distortion = 0}"
  },
  {
    type = "noise-expression",
    name = "aquilo_starting_flourine_vent_tiny", -- single vent as a taste
    expression = "starting_spot_at_angle{angle = aquilo_angle + 240, distance = 80, radius = 1, x_distortion = 0, y_distortion = 0}"
  },
  {
    type = "noise-expression",
    name = "aquilo_starting_mask",
    -- exclude random spots from the inner 300 tiles, 80 tile blur
    expression = "clamp((distance - 300) / 40, -1, 1)"
  },

  {
    type = "noise-function",
    name = "aquilo_spot_noise",
    parameters = {"seed", "count", "skip_offset", "region_size", "density", "radius", "favorability"},
    expression = "spot_noise{x = x,\z
                             y = y,\z
                             seed0 = map_seed,\z
                             seed1 = seed,\z
                             candidate_spot_count = count,\z
                             suggested_minimum_candidate_point_spacing = 128,\z
                             skip_span = 3,\z
                             skip_offset = skip_offset,\z
                             region_size = region_size,\z
                             density_expression = density,\z
                             spot_quantity_expression = radius * radius,\z
                             spot_radius_expression = radius,\z
                             hard_region_target_quantity = 0,\z
                             spot_favorability_expression = favorability,\z
                             basement_value = -1,\z
                             maximum_spot_basement_radius = radius * 2}"
  },
  {
    type = "noise-expression",
    name = "aquilo_crude_oil_spots",
    expression = "aquilo_spot_noise{seed = 567,\z
                                    count = 4,\z
                                    skip_offset = 0,\z
                                    region_size = 600 + 400 / control:aquilo_crude_oil:frequency,\z
                                    density = 1,\z
                                    radius = aquilo_spot_size * sqrt(control:aquilo_crude_oil:size),\z
                                    favorability = 1}"
  },
  {
    type = "noise-expression",
    name = "aquilo_lithium_brine_spots",
    expression = "aquilo_spot_noise{seed = 567,\z
                                    count = 3,\z
                                    skip_offset = 1,\z
                                    region_size = 600 + 400 / control:lithium_brine:frequency,\z
                                    density = 1,\z
                                    radius = aquilo_spot_size * 1.2 * sqrt(control:lithium_brine:size),\z
                                    favorability = 1}"
  },
  {
    type = "noise-expression",
    name = "aquilo_flourine_vent_spots",
    expression = "aquilo_spot_noise{seed = 567,\z
                                    count = 2,\z
                                    skip_offset = 2,\z
                                    region_size = 600 + 400 / control:fluorine_vent:frequency,\z
                                    density = 1,\z
                                    radius = aquilo_spot_size * 1.5 * sqrt(control:fluorine_vent:size),\z
                                    favorability = 1}"
  },

  {
    type = "noise-expression",
    name = "aquilo_crude_oil_probability",
    expression = "(control:aquilo_crude_oil:size > 0)\z
                  * (max(aquilo_starting_crude_oil * 0.02,\z
                         min(aquilo_starting_mask, aquilo_crude_oil_spots) * 0.015))"
  },
  {
    type = "noise-expression",
    name = "aquilo_crude_oil_richness",
    expression = "max(aquilo_starting_crude_oil * 1800000,\z
                      aquilo_crude_oil_spots * 1440000) * control:aquilo_crude_oil:richness"
  },
  {
    type = "noise-expression",
    name = "aquilo_lithium_brine_probability",
    expression = "(control:lithium_brine:size > 0)\z
                  * (max(aquilo_starting_lithium_brine * 0.02,\z
                         min(aquilo_starting_mask, aquilo_lithium_brine_spots) * 0.012))"
  },
  {
    type = "noise-expression",
    name = "aquilo_lithium_brine_richness",
    expression = "max(aquilo_starting_lithium_brine * 480000,\z
                      aquilo_lithium_brine_spots * 720000) * control:lithium_brine:richness"
  },
  {
    type = "noise-expression",
    name = "aquilo_flourine_vent_probability",
    expression = "(control:fluorine_vent:size > 0)\z
                  * (max(aquilo_starting_flourine_vent * 0.02,\z
                         aquilo_starting_flourine_vent_tiny > 0,\z
                         min(aquilo_starting_mask, aquilo_flourine_vent_spots) * 0.008))"
  },
  {
    type = "noise-expression",
    name = "aquilo_flourine_vent_richness",
    expression = "max(aquilo_starting_flourine_vent * 420000,\z
                      (aquilo_starting_flourine_vent_tiny > 0) * 420000,\z
                      aquilo_flourine_vent_spots * 520000) * control:fluorine_vent:richness"
  },

  {
    type = "noise-expression",
    name = "aquilo_island_peaks",
    -- before this point all spots should be in the -1 to 1 range
    expression = "max(1.7 * (0.3 + aquilo_starting_island),\z
                      1.5 * (0.5 + max(aquilo_starting_crude_oil, aquilo_crude_oil_spots,\z
                                     aquilo_starting_lithium_brine, aquilo_lithium_brine_spots,\z
                                     aquilo_starting_flourine_vent, aquilo_flourine_vent_spots)))"
  },


  {
    type = "noise-function",
    name = "aquilo_simple_billows",
    parameters = {"seed1", "octaves", "input_scale"},
    expression = "abs(quick_multioctave_noise{x = x,\z
                                              y = y,\z
                                              seed0 = map_seed,\z
                                              seed1 = seed1,\z
                                              input_scale = input_scale,\z
                                              output_scale = 1,\z
                                              offset_x = 10000,\z
                                              octaves = octaves,\z
                                              octave_input_scale_multiplier = 0.5,\z
                                              octave_output_scale_multiplier = 0.75})" -- octave_output_scale_multiplier is persistance
  },
  {
    type = "noise-expression",
    name = "aquilo_elevation",
    --intended_property = "elevation",
    expression = "lerp(blended, maxed, 0.4)",
    local_expressions = {
      maxed = "max(formation_clumped, formation_broken)",
      blended = "lerp(formation_clumped, formation_broken, 0.4)",
      formation_clumped = "-25\z
                          + 12 * max(aquilo_island_peaks, random_island_peaks)\z
                          + 15 * tri_crack",
      formation_broken  = "-20\z
                          + 8 * max(aquilo_island_peaks * 1.1, min(0., random_island_peaks - 0.2))\z
                          + 13 * (pow(voronoi_large * max(0, voronoi_large_cell * 1.2 - 0.2) + 0.5 * voronoi_small * max(0, aux + 0.1), 0.5))",
      random_island_peaks = "abs(amplitude_corrected_multioctave_noise{x = x,\z
                                                                  y = y,\z
                                                                  seed0 = map_seed,\z
                                                                  seed1 = 1000,\z
                                                                  input_scale = segmentation_mult / 1.2,\z
                                                                  offset_x = -10000,\z
                                                                  octaves = 6,\z
                                                                  persistence = 0.8,\z
                                                                  amplitude = 1})",
      voronoi_large = "voronoi_facet_noise{   x = x + aquilo_wobble_x * 2,\z
                                              y = y + aquilo_wobble_y * 2,\z
                                              seed0 = map_seed,\z
                                              seed1 = 'aquilo-cracks',\z
                                              grid_size = 24,\z
                                              distance_type = 'euclidean',\z
                                              jitter = 1}",
      voronoi_large_cell = "voronoi_cell_id{  x = x + aquilo_wobble_x * 2,\z
                                              y = y + aquilo_wobble_y * 2,\z
                                              seed0 = map_seed,\z
                                              seed1 = 'aquilo-cracks',\z
                                              grid_size = 24,\z
                                              distance_type = 'euclidean',\z
                                              jitter = 1}",
      voronoi_small  = "voronoi_facet_noise{   x = x + aquilo_wobble_x * 2,\z
                                              y = y + aquilo_wobble_y * 2,\z
                                              seed0 = map_seed,\z
                                              seed1 = 'aquilo-cracks',\z
                                              grid_size = 10,\z
                                              distance_type = 'euclidean',\z
                                              jitter = 1}",
      tri_crack = "min(aquilo_simple_billows{seed1 = 2000, octaves = 3, input_scale = segmentation_mult / 1.5},\z
                       aquilo_simple_billows{seed1 = 3000, octaves = 3, input_scale = segmentation_mult / 1.2},\z
                       aquilo_simple_billows{seed1 = 4000, octaves = 3, input_scale = segmentation_mult})",
      segmentation_mult = "aquilo_segmentation_multiplier / 25",
    }
  },
  {
    type = "noise-expression",
    name = "aquilo_segmentation_multiplier",
    expression = 1
  },
  {
    type = "noise-expression",
    name = "aquilo_aux_scale",
    expression = "aquilo_segmentation_multiplier * 1.5"
  },
  {
    type = "noise-expression",
    name = "aquilo_wobble_x",
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    seed0 = map_seed,\z
                                    seed1 = 12243,\z
                                    octaves = 3,\z
                                    persistence = 0.65,\z
                                    input_scale = aquilo_aux_scale / 100,\z
                                    output_scale = 0.35}"
  },
  {
    type = "noise-expression",
    name = "aquilo_wobble_y",
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    seed0 = map_seed,\z
                                    seed1 = 13243,\z
                                    octaves = 3,\z
                                    persistence = 0.65,\z
                                    input_scale = aquilo_aux_scale / 100,\z
                                    output_scale = 0.35}"
  },
  {
    type = "noise-expression",
    name = "aquilo_aux",
    --intended_property = "aux",
    expression = "0.5 + multioctave_noise{x = x + aquilo_wobble_x * 300 / aquilo_aux_scale,\z
                                          y = y + aquilo_wobble_y * 300 / aquilo_aux_scale,\z
                                          seed0 = map_seed,\z
                                          seed1 = 14243,\z
                                          octaves = 3,\z
                                          persistence = 0.7,\z
                                          input_scale = aquilo_aux_scale / 25,\z
                                          output_scale = 1}",
  },
  {
    type = "noise-expression",
    name = "aquilo_temperature",
    --intended_property = "temperature",
    expression = "temperature_basic - 100",
  },
  { -- for rocks & icebergs
    type = "noise-expression",
    name = "aquilo_high_frequency_peaks",
    expression = "abs(multioctave_noise{x = x, y = y, persistence = 0.85, seed0 = map_seed, seed1 = 1, octaves = 3, input_scale = 1/6})"
  },

  -- tiles
  {
    type = "noise-expression",
    name = "aquilo_solid", -- -1 is liquid, +1 is solid
    expression = "-1 + 2 * elevation < 0"
  },
  {
    type = "noise-expression",
    name = "ammoniacal_ocean", -- darker
    expression = "0.01 * (aux - 0.5)"
  },
  {
    type = "noise-expression",
    name = "ammoniacal_ocean_2", -- brighter
    expression = "-0.01 * (aux - 0.5)"
  },
  {
    type = "noise-expression",
    name = "brash_ice",
    expression = "0.05 * (elevation / 5 -aux / 3 + 0.75)"
  },
  {
    type = "noise-expression",
    name = "icebergs",
    expression = "min(1, aquilo_high_frequency_peaks, 2 * ((elevation / 5 - aux / 3) + 1.5))"
  },

  {
    type = "noise-expression",
    name = "aquilo_snow_ice", --negative is snow, positive is ice
    expression = "multioctave_noise{x = x, y = y, persistence = 0.85, seed0 = map_seed, seed1 = 1, octaves = 3, input_scale = 1/12}"
  },
  {
    type = "noise-expression",
    name = "aquilo_tile_variant", -- low is rough or lumpy or patchy, high is flatter.
    expression = "multioctave_noise{x = x, y = y, persistence = 0.85, seed0 = map_seed, seed1 = 100, octaves = 3, input_scale = 1/6}"
  },

  {
    type = "noise-function",
    name = "aquilo_min_elevation",
    parameters = {"min_elevation"},
    expression = "-1 + 2 * (elevation > min_elevation)"
  },


  {
    type = "noise-expression",
    name = "snow_flat",
    expression = "100 * aquilo_min_elevation(1.5) - (aquilo_snow_ice + 0.5) - abs(aquilo_tile_variant - 0.5) + elevation / 25 + 1"
  },
  {
    type = "noise-expression",
    name = "snow_crests",
    expression = "100 * aquilo_min_elevation(1) - abs(aquilo_snow_ice - 0.2) - abs(aquilo_tile_variant - 0.2) + elevation / 25 + 1.2"
  },
  {
    type = "noise-expression",
    name = "snow_lumpy",
    expression = "100 * aquilo_min_elevation(0.5) - abs(aquilo_snow_ice + 0.1) - abs(aquilo_tile_variant + 0.3) + elevation / 25 + 1.2"
  },
  {
    type = "noise-expression",
    name = "snow_patchy",
    expression = "100 * aquilo_min_elevation(0) - abs(aquilo_snow_ice + 0.4) - abs(aquilo_tile_variant + 0.6) + elevation / 25 + 1"
  },
  {
    type = "noise-expression",
    name = "ice_rough",
    expression = "100 * aquilo_min_elevation(-1) + aquilo_snow_ice - abs(aquilo_tile_variant) - elevation / 10  + 0.5"
  },
  {
    type = "noise-expression",
    name = "ice_smooth",
    expression = "100 * aquilo_min_elevation(-1) + aquilo_snow_ice - abs(aquilo_tile_variant + 1) - elevation / 25  + 1"
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
