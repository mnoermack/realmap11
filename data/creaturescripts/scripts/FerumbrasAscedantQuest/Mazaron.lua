local config = {
	position = {x = 33585, y = 32699, z = 14}, -- Posição dos teleports.33585, 32699, 14
	position_to_tp_green = {x = 33615, y = 32679, z = 15},
	position_to_tp_blue = {x = 33319, y = 32317, z = 13},
	id_tp_blue = 1387,
	id_tp_green = 25417,
	monster_name = "mazoran",
	time = 3
}

function removeAndCreateTp()
	if(getTileItemById(config.position, config.id_tp_blue).itemid == config.id_tp_blue)then
		tp = getTileItemById(config.position, config.id_tp_blue)
		id = config.id_tp_green
		pos = config.position_to_tp_green
	else
		tp = getTileItemById(config.position, config.id_tp_green)
		id = config.id_tp_blue
		pos = config.position_to_tp_blue
	end
	doRemoveItem(tp.uid, 1)
	local x = Game.createItem(id, 1, config.position)
	if(x:isTeleport())then
		x:setDestination(Position(pos.x, pos.y, pos.z))
	end
	return true
end

function onKill(player, target)
	local monster = target:getMonster()
	if(not monster or monster:getName():lower() ~= config.monster_name)then
		return true
	end
	removeAndCreateTp()
	addEvent(removeAndCreateTp, config.time * 6000)
    return true
end