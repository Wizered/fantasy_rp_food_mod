if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

ENT.Base		= "eoti_food_base_item"
ENT.Category 	= "FantasyRP Food v1.1"
ENT.Purpose 	= ""
ENT.Information = ""

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

local NextUsage = 0
function ENT:Use( activator )
	--Time Delay Between Usages on Server--
	if CurTime() < NextUsage then 
		if(DarkRP != nil) then
			DarkRP.notify(activator, 1, 4, "You must wait "..math.ceil(NextUsage-CurTime()).." seconds.") 
		end
		return 
	end
	
	NextUsage = CurTime() + 2 --Time delay between bites or sips.
	
	local hp, maxhp, sethp, energy, info
	
	--Unique Food Effect and FoodEffect--
	if self.FoodEffect != nil then
		self:UniqueFoodEffect(activator)
	end
	
	--Health--
	if self.HealAmount > 0 then
		hp = activator:Health()
		maxhp = (activator:GetMaxHealth() or 100) + self.HealMax
		sethp = math.Clamp( hp + self.HealAmount, 0, maxhp )
		if maxhp <= hp 
			then sethp = false
			else activator:SetHealth( sethp )
		end
	else sethp = false end
	
	--Hunger--
	if DarkRP != nil and self.HungerFill > 0 then
		energy = (activator:getDarkRPVar("Energy") or 100)
		if energy >= 100 then energy = false
		else activator:setSelfDarkRPVar( "Energy", math.Clamp( (energy or 100) + self.HungerFill, 0, 100 ) ) end
	else energy = false end
	
	if (energy == false and sethp == false) then
		info = "[HP: "..activator:Health().."/"..maxhp.." (+"..self.HealMax.."max)]" or ""
		if self.IsFood == false
			then activator:ChatPrint("You are too full to take a sip of "..self.PrintName..". "..info)
			else activator:ChatPrint("You are too full to take a bite of "..self.PrintName..". "..info)
		end
		return
	end
	
	--SoundFX and Chat Message (IsFood var)--
	info = "[HP: "..activator:Health().."/"..maxhp.." (+"..self.HealAmount.."hp)]" or ""
	if energy != false and energy != 0 then 
		info = info.." [HGR: "..activator:getDarkRPVar("Energy").."/100]" end
	
	if self.IsFood == false then 
		sound.Play( "food/slurp.wav", activator:GetPos() )
		activator:ChatPrint("You take a sip of the "..self.PrintName..". "..info)
	else 
		sound.Play( "food/eating.wav", activator:GetPos() )
		activator:ChatPrint("You take a bite of the "..self.PrintName..". "..info)
	end
	
	--Use Charges and Item Delete--
	self.Charges = self.Charges - 1
	if self.Charges <= 0 then
		if self.IsFood == false
			then activator:ChatPrint("You finish drinking the "..self.PrintName..".")
			else activator:ChatPrint("You finish eating the "..self.PrintName..".")
		end
		
		self:Remove()
	end
end