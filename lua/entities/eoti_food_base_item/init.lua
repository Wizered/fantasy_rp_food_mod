AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

--Basic code required to create the file--
function ENT:SpawnFunction( ply, tr, class )
	if ( !tr.Hit ) then return end
	local pos = tr.HitPos + tr.HitNormal * 4
	local ent = ents.Create( class )
	ent:SetPos( pos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()

	--Basic code required to create the file--
	self:SetModel( self.WorldModel )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetUseType( SIMPLE_USE )
	
	--Custom Initialize Code--
	if self.CustomInit != nil then
		self:Init()
	end
	
	local phys = self:GetPhysicsObject()
	self.nodupe = true
	self.ShareGravgun = true

	phys:Wake()
	
	--Determine if the object floats above the ground on create--
	if self.NoFloat == nil then
		local v = self:GetPos()
		self:SetPos( Vector(v.X, v.Y, v.Z + 15) )
	end
	
	--Time for object to delete itself after being created, object stays until destroyed if no SelfDeleteTime variable is found.--
	if self.SelfDeleteTime != nil then
		timer.Simple( self.SelfDeleteTime,function()
			if IsValid(self) then self:Remove() end
		end)
	end
end

function ENT:Think()

	--Destroys object if collision with water--
	if self:WaterLevel() > 0 then
		self:Remove()
	end
end