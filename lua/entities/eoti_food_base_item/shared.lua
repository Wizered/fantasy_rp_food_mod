ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"

ENT.Author			= "Emperor_of_the_Internet (daveSaur@gmail.com)"
ENT.PrintName 		= "Item Base"
ENT.Contact 		= ""
ENT.Purpose 		= ""
ENT.Information 	= ""

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

ENT.WorldModel	 	= ""

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
end