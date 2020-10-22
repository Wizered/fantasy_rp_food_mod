if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.Category 		= "FantasyRP Food v1.1"

ENT.Base		= "eoti_food_base"
ENT.PrintName 	= "Blood Ale"
ENT.WorldModel  = "models/food/potion/life_potion.mdl"
ENT.Charges	 	= 5
ENT.IsFood 		= false
ENT.HealMax 	= 50
ENT.HealAmount 	= 25
ENT.HungerFill 	= 5
ENT.Information = "Health: "..ENT.Charges*ENT.HealAmount.."% (Upto "..ENT.HealMax.."% Over Max)  --  Hunger: "..ENT.Charges*ENT.HungerFill.."%"
--ENT.CustomInit	= true
--ENT.FoodEffect	= true
--ENT.NoFloat			= true
--ENT.SelfDeleteTime	= 90

function ENT:Init()
	--Custom code ran to ensure the item model is the right size, can run other code as well.
	self:SetModelScale(1.1,0)
	self:Activate()
end

function ENT:UniqueFoodEffect(activator)
	--Custom Code run everytime a user uses a charge.
end

--ENT.Base			= File based off of this file.
--ENT.PrintName 	= Purchase Title
--ENT.WorldModel  	= World Model
--ENT.Charges	 	= Number of Uses Per Food Item
--ENT.IsFood 		= Sound played; false = gulping noise; true = eating noise
--ENT.HealMax 		= Amount of maximum hp healed above MaxHealth() or 100 [Default is 100 in GMOD]
--ENT.HealAmount 	= Amount of health healed per bite or sip.
--ENT.HungerFill 	= Amount of energy restored (DarkRP Var)
--ENT.Information 	= Information on the Entity purchase screen, adjusts automatically to inputted variables.
--ENT.CustomInit	= Custom code which is executed when the item is created or bought.
--ENT.FoodEffect	= Custom code which is executed everytime the item is used.
--ENT.SelfDeleteTime= If variable is present, it will delete after the time.
--ENT.NoFloat		= Does it float 15 units above the ground when spawned?
