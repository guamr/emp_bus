local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
local vRP = Proxy.getInterface('vRP')
local bus = { }
Tunnel.bindInterface('EmpBus', bus)

bus.paymentCheckpoint = function ( routeInCourse )
	local player = source 
	local userId = vRP.getUserId(player)
	if not userId then return false end
	local randmoney = math.random(Config['routes'][routeInCourse]['valuePerCheckPoint'][1], Config['routes'][routeInCourse]['valuePerCheckPoint'][2])
	vRP.giveMoney(userId, parseInt(randmoney))
	TriggerClientEvent('vrp_sound:source', player, 'coins', 0.5)
	TriggerClientEvent('Notify', player, 'sucesso', 'Você recebeu <b>$'..vRP.format(parseInt(randmoney))..' reais!</b>.')
	return true
end

bus.getOwnerVeh = function ( plate )
	if not plate then return false end
	return vRP.getUserByRegistration(plate)
end

bus.getUserId = function ( )
	local player = source 
	local userId = vRP.getUserId(player)
	return userId
end