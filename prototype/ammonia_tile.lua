local ammonia_lava = table.deepcopy(data.raw["tile"]["ammoniacal-ocean"])
ammonia_lava.name = "ammonia-lava"
ammonia_lava.autoplace = data.raw["tile"]["lava"].autoplace
table.insert(data.raw["item"]["ice-platform"].place_as_tile.tile_condition, "ammonia-lava");

data:extend{ammonia_lava}
