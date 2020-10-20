function PlayerPickup(ply, ent)
	if string.sub(ent:GetClass(),1,4) == "eoti" and ply == ent:Getowning_ent() then
		return true -- Allow pickup
	end
	
end
hook.Add("PhysgunPickup", "AllowPhysgunOfOwnProps", PlayerPickup)