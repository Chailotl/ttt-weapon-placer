AddCSLuaFile()

SWEP.Category	= "Chai's Scripted Stuff"
SWEP.PrintName		= "Test H.U.G.E.-249"
SWEP.Author			= "Chai"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.HoldType	= "shotgun"
SWEP.HipHold	= "hip-ar2"
SWEP.AimHold	= "ar2"
SWEP.ReloadHold	= "ar2"

SWEP.Base = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind		= WEAPON_HEAVY
SWEP.WeaponID	= AMMO_M249

SWEP.Primary.Recoil			= 1.5 --1.9
SWEP.Primary.Damage			= 7
SWEP.Primary.Delay			= 0.06
SWEP.Primary.Cone			= 0.09
SWEP.Primary.ClipSize		= 150
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.ClipMax		= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AirboatGun"
SWEP.Primary.Sound			= Sound( "Weapon_m249.Single" )

SWEP.HeadshotMultiplier		= 2.2
SWEP.Force					= 30

SWEP.AutoSpawnable	= true

SWEP.UseHands		= true
SWEP.ViewModelFlip	= false
SWEP.ViewModelFOV	= 54
SWEP.ViewModel		= "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel		= "models/weapons/w_mach_m249para.mdl"

SWEP.IronSightsPos	= Vector( -5.96, -5.119, 2.349 )
SWEP.IronSightsAng	= Vector( 0, 0, 0 )

function SWEP:ShootBullet( dmg, recoil, numbul, cone )
	self.BaseClass.ShootBullet( self, dmg, recoil, numbul, cone )
	
	local ply = self:GetOwner()
	ply:SetVelocity( ply:GetAimVector() * self.Force * -1 )
end

function SWEP:Reload()
	self:SetClip1( 150 )
end

function SWEP:Deploy()
	local owner = self:GetOwner()
	owner:SetJumpPower( 160 )
	owner:SetRunSpeed( 220 )
	owner:SetWalkSpeed( 220 )
	return true
end

function SWEP:Holster( wep )
	local owner = self:GetOwner()
	owner:SetJumpPower( 200 )
	owner:SetRunSpeed( 400 )
	owner:SetWalkSpeed( 200 )
	return true
end