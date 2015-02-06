CLASS.name = "Civil Protection Scanner"
CLASS.desc = "A robotic, metal scanner for observing the city."
CLASS.faction = FACTION_CP

function CLASS:onCanBe(client)
	return client:isCombineRank(SCHEMA.scnRanks)
end

local scanner = nut.plugin.list.scanner

if (scanner) then
	function CLASS:onSet(client)
		scanner:createScanner(client, client:getCombineRank() == "CLAW.SCN" and "npc_clawscanner" or nil)
	end

	function CLASS:onLeave(client)
		if (IsValid(client.nutScn)) then
			local data = {}
				data.start = client.nutScn:GetPos()
				data.endpos = data.start - Vector(0, 0, 1024)
				data.filter = {client, client.nutScn}
			local position = util.TraceLine(data).HitPos

			client.nutScn.spawn = position
			client.nutScn:Remove()
		end
	end
end

CLASS_CP_SCN = CLASS.index