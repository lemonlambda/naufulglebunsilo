local ammonia_lava = table.deepcopy(data.raw["tile"]["ammoniacal-ocean"])
ammonia_lava.name = "ammonia-lava"
ammonia_lava.autoplace = data.raw["tile"]["lava"].autoplace

data:extend{ammonia_lava}