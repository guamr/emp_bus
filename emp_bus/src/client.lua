local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
local vRP = Proxy.getInterface('vRP')
local vRPSERVER = Tunnel.getInterface('vRP')
func = Tunnel.getInterface('EmpBus')
local bus = { 
	inService = false;
	routeInCourse = false;
	indexSeeMarkerRoute = false;
}

bus.startAndRenderMarker = Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local player = PlayerPedId()
		local coord = GetEntityCoords(player)
		local dist = #(coord - vec3(table.unpack(Config['start job']['pos'])))
		if dist <= 10 then
			sleep = 0
			DrawMarker(Config['start job']['marker'], vec3(table.unpack(Config['start job']['pos'])), 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, 255, 0, 0, 300, 0, 1, 0, 1)
			if dist <= 1.1 then
				bus.drawTxt('PRESSIONE ~r~'..Config['key for action']['keyName']..'~w~ PARA TRABALHAR DE MOTORISTA!', 0.5, 0.92, 4, 0.6, 255, 255, 255)
				if IsControlJustPressed(0, Config['key for action']['keyID']) then 
					if not bus.inService then 
						bus.inService = true
						bus.textService ( )
						bus.generateRoute ( )
						bus.indexSeeMarkerRoute = 1
						TriggerEvent('Notify', 'sucesso', 'Você iniciou o emprego de motorista! Pegue seu ônibus.')
						bus.createBlip(Config['routes'][bus.routeInCourse]['locates'][bus.indexSeeMarkerRoute]['x'], Config['routes'][bus.routeInCourse]['locates'][bus.indexSeeMarkerRoute]['y'], Config['routes'][bus.routeInCourse]['locates'][bus.indexSeeMarkerRoute]['z'])
					else 
						TriggerEvent('Notify', 'negado', 'Você já possui uma rota ativa!')
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

bus.deliveryRoute = function ( vehicle )
	if IsEntityAVehicle(vehicle) then 
		SetVehicleDoorOpen(vehicle, 0)
		SetVehicleDoorOpen(vehicle, 1)
	end
	Wait(1000)
	if IsEntityAVehicle(vehicle) then 
		SetVehicleDoorShut(vehicle, 0)
		SetVehicleDoorShut(vehicle, 1)
	end
	func.paymentCheckpoint(bus.routeInCourse)
	if Config['routes'][bus.routeInCourse]['locates'][bus.indexSeeMarkerRoute + 1] then 
		bus.indexSeeMarkerRoute = bus.indexSeeMarkerRoute + 1
		bus.createBlip(Config['routes'][bus.routeInCourse]['locates'][bus.indexSeeMarkerRoute]['x'], Config['routes'][bus.routeInCourse]['locates'][bus.indexSeeMarkerRoute]['y'], Config['routes'][bus.routeInCourse]['locates'][bus.indexSeeMarkerRoute]['z'])
		TriggerEvent('Notify', 'importante', 'Siga para o próximo checkpoint!')
	else 
		bus.inService = nil
		TriggerEvent('Notify', 'sucesso', 'Você concluiu a rota do emprego!')
	end
end

bus.textService = function ( )
	Citizen.CreateThread(function()
		while bus.inService do 
			local sleep = 0 
			local player = PlayerPedId()
			local coord = GetEntityCoords(player)
			bus.drawTxt('Você está fazendo uma rota do emprego de motorista!', 0.15, 0.7, 4, 0.6, 255, 255, 255)
			bus.drawTxt('Siga os checkpoints ou caso queira cancelar pressione '..Config['key for cancel']['keyName']..'!', 0.16, 0.74, 4, 0.6, 255, 255, 255)
			if IsControlJustPressed(0, Config['key for cancel']['keyID']) then 
				bus.cancelService ( )
			end
			local v = Config['routes'][bus.routeInCourse]['locates'][bus.indexSeeMarkerRoute]
			local dist = #(coord - vec3(v['x'], v['y'], v['z']))
			if dist <= Config['route checkpoint']['distanceForView'] then
				DrawMarker(Config['route checkpoint']['marker'], v['x'], v['y'], v['z'] - Config['route checkpoint']['subtractZinPosition'], 0, 0, 0, 0, 0, 0, Config['route checkpoint']['size'], Config['route checkpoint']['size'], Config['route checkpoint']['size'], 255, 0, 0, 300, 0, 1, 0, 1)
				if dist <= 5 then
					local vehicle, vnetid, placa, vname, lock, banned = vRP.vehList(player, 5)
					if IsEntityAVehicle(vehicle) and (GetPedInVehicleSeat(vehicle, -1) == player) then 
						bus.drawTxt('PRESSIONE ~r~'..Config['key for action']['keyName']..'~w~ PARA ENTREGAR OS PASSAGEIROS!', 0.5, 0.92, 4, 0.6, 255, 255, 255)
					end
					if IsControlJustPressed(0, Config['key for action']['keyID']) then 
						local userId = func.getUserId( )
						if IsEntityAVehicle(vehicle) then 
							if GetPedInVehicleSeat(vehicle, -1) == player then
								if Config['vehicles job'][GetEntityModel(vehicle)] then
									local kmh = GetEntitySpeed(vehicle)*3.6 
									if kmh < 1 then
										local platePlayer = func.getOwnerVeh(placa)
										if userId == platePlayer then
											bus.deliveryRoute ( vehicle )
										else 
											TriggerEvent('Notify', 'negado', 'Você não é o proprietário desse ônibus!')
										end
									else 										
										TriggerEvent('Notify', 'negado', 'Pare o onibus para entregar os passageiros!')
									end
								else 
									TriggerEvent('Notify', 'negado', 'Você deve estar dirigindo um ônibus para fazer isso!')
								end
							else 
								TriggerEvent('Notify', 'negado', 'Você deve estar dirigindo esse veículo para fazer isso!')
							end
						else 
							TriggerEvent('Notify', 'negado', 'Você deve estar em um veículo para fazer isso!')
						end
					end
				end
			end 
			Wait(sleep)
		end
	end)
end

bus.generateRoute = function ( )
	if not bus.routeInCourse then 
		bus.routeInCourse = math.floor(#Config['routes'])
	else 
		local newRouteJob = math.floor(#Config['routes'])
		while bus.routeInCourse == newRouteJob do 
			newRouteJob = math.floor(#Config['routes']) 
		end
		bus.routeInCourse = newRouteJob
	end
end

bus.cancelService = function ( )
	bus.inService = nil
	TriggerEvent('Notify', 'importante', 'Você parou de fazer rota do emprego de ônibus!')
end

bus.drawTxt = function ( text, x, y, font, scale, r, g, b, a, not_center )
	local font = font or 1
	local scale = scale or 0.8
	local r = r or 255 
	local g = g or 255 
	local b = b or 255 
	local a = a or 255
	SetTextFont(font)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry('STRING')
	AddTextComponentString(text)
	DrawText(x, y)
end

bus.createBlip = function (x, y, z)
	if DoesBlipExist(bus.blipCheck) then
		RemoveBlip(bus.blipCheck)
	end
	bus.blipCheck = AddBlipForCoord(x, y, z)
	SetBlipSprite(bus.blipCheck, 1)
	SetBlipColour(bus.blipCheck, 5)
	SetBlipScale(bus.blipCheck, 0.4)
	SetBlipAsShortRange(bus.blipCheck, false)
	SetBlipRoute(bus.blipCheck, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Próximo Ponto')
	EndTextCommandSetBlipName(bus.blipCheck)
end