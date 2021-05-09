TOOL.Category = "Trouble in Terrorist Town"
TOOL.Name = "CC Weapon Placer"
TOOL.Command = nil
TOOL.ConfigName = ""

TOOL.ClientConVar[ "weapon" ] = "weapon_zm_pistol"
TOOL.ClientConVar[ "frozen" ] = "0"
TOOL.ClientConVar[ "replacespawns" ] = "0"

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
	{ name = "reload" }
}

cleanup.Register( "ttt_weapons" )

if CLIENT then
	language.Add( "tool.tttweaponplacer.name", "CC Weapon Placer" )
	language.Add( "tool.tttweaponplacer.desc", "Spawn TTT weapon dummies and export their placement" )
	language.Add( "tool.tttweaponplacer.left", "Spawn an entity." )
	language.Add( "tool.tttweaponplacer.right", "Spawn matching ammo." )
	language.Add( "tool.tttweaponplacer.reload", "Toggle prop for rearm." )
	language.Add( "Cleanup_ttt_weapons", "TTT Dummy Weapons/ammo/spawns" )
	language.Add( "Undone_TTTWeapon", "Undone TTT item" )
end

local weps = { 
	-- Pistols
	weapon_ttt_obrez = { class = "pistol", name = "Obrez", snd = "item_ammo_revolver_ttt" },
	weapon_zm_revolver = { class = "pistol", name = "Deagle", snd = "item_ammo_revolver_ttt" },
	weapon_zm_pistol = { class = "pistol", name = "Makarov", snd = "item_ammo_pistol_ttt" },
	weapon_ttt_tokarev = { class = "pistol", name = "Tokarev", snd = "item_ammo_pistol_ttt" },
	weapon_ttt_glock = { class = "pistol", name = "Glock", snd = "item_ammo_pistol_ttt" },
	weapon_ttt_dual_elites = { class = "pistol", name = "Dual Elites", snd = "item_ammo_pistol_ttt" },
	-- Rifles
	weapon_ttt_m16 = { class = "rifle", name = "M16", snd = "item_ammo_assault_ttt" },
	weapon_ttt_famas = { class = "rifle", name = "FAMAS", snd = "item_ammo_assault_ttt" },
	weapon_ttt_commando = { class = "rifle", name = "Commando", snd = "item_ammo_assault_ttt" },
	-- Shotguns
	weapon_zm_shotgun = { class = "shotgun", name = "QBS-09", snd = "item_box_buckshot_ttt" },
	weapon_ttt_m3super = { class = "shotgun", name = "M3 Super", snd = "item_box_buckshot_ttt" },
	weapon_ttt_slugster = { class = "shotgun", name = "Slugster", snd = "item_box_buckshot_ttt" },
	-- SMGs
	weapon_zm_mac10 = { class = "smg", name = "MAC10", snd = "item_ammo_smg1_ttt" },
	weapon_ttt_navy = { class = "smg", name = "Navy", snd = "item_ammo_smg1_ttt" },
	weapon_ttt_p90 = { class = "smg", name = "P90", snd = "item_ammo_smg1_ttt" },
	-- Snipers
	weapon_zm_rifle = { class = "sniper", name = "Mosin-Nagant", snd = "item_ammo_357_ttt" },
	weapon_ttt_gewehr = { class = "sniper", name = "Gewehr 3", snd = "item_ammo_357_ttt" },
	weapon_ttt_sg550 = { class = "sniper", name = "SG 550", snd = "item_ammo_357_ttt" },
	-- LMGs
	weapon_zm_sledge = { class = "heavy", name = "HUGE-249", snd = nil },
	weapon_ttt_power = { class = "heavy", name = "POW-3R", snd = nil },
	weapon_ttt_bulk = { class = "heavy", name = "BULK-MGL", snd = "ttt_random_nade" },
	-- Grenades
	weapon_ttt_confgrenade = { class = "grenade", name = "Discombobulator", snd = nil },
	weapon_zm_molotov = { class = "grenade", name = "Incendiary Grenade", snd = nil },
	weapon_ttt_molotov = { class = "grenade", name = "Molotov", snd = nil },
	weapon_ttt_smokegrenade = { class = "grenade", name = "Smoke Grenade", snd = nil },
	weapon_ttt_gtfo = { class = "grenade", name = "GTFO", snd = nil },
	-- Other
	ttt_random_weapon = { name = "Random Weapon", snd = "ttt_random_ammo" },
	ttt_random_ammo = { name = "Random Ammo", snd = nil },
	ttt_random_pistol = { class = "pistol", name = "Random Pistol", snd = "item_ammo_pistol_ttt" },
	ttt_random_ar = { class = "rifle", name = "Random Rifle", snd = "item_ammo_assault_ttt" },
	ttt_random_shotty = { class = "shotgun", name = "Random Shotgun", snd = "item_box_buckshot_ttt" },
	ttt_random_smg = { class = "smg", name = "Random SMG", snd = "item_ammo_smg1_ttt" },
	ttt_random_sniper = { class = "sniper", name = "Random Sniper", snd = "item_ammo_357_ttt" },
	ttt_random_lmg = { class = "heavy", name = "Random LMG", snd = nil },
	ttt_random_nade = { class = "grenade", name = "Random Nade", snd = nil },

	ttt_playerspawn = { name = "Player Spawn", snd = nil },
	ttt_mystery_crate = { name = "Mystery Crate", snd = nil },
 }

local mdls = { 
	weapon_ttt_obrez = "models/weapons/w_obrez.mdl",
	weapon_zm_revolver = "models/weapons/w_pist_deagle.mdl",
	weapon_zm_pistol = "models/weapons/w_pist_fiveseven.mdl",
	weapon_ttt_tokarev = "models/weapons/w_pist_p228.mdl",
	weapon_ttt_glock = "models/weapons/w_pist_glock18.mdl",
	weapon_ttt_dual_elites = "models/weapons/w_pist_elite_dropped.mdl",
	
	weapon_ttt_m16 = "models/weapons/w_rif_m4a1.mdl",
	weapon_ttt_famas = "models/weapons/w_rif_famas.mdl",
	weapon_ttt_commando = "models/weapons/w_rif_sg552.mdl",
	
	weapon_zm_shotgun = "models/weapons/w_shot_xm1014.mdl",
	weapon_ttt_m3super = "models/weapons/w_shot_m3super90.mdl",
	weapon_ttt_slugster = "models/weapons/w_shotgun.mdl",
	
	weapon_zm_mac10 = "models/weapons/w_smg_mac10.mdl",
	weapon_ttt_navy = "models/weapons/w_smg_mp5.mdl",
	weapon_ttt_p90 = "models/weapons/w_smg_p90.mdl",
	
	weapon_zm_rifle = "models/weapons/w_snip_scout.mdl",
	weapon_ttt_gewehr = "models/weapons/w_snip_g3sg1.mdl",
	weapon_ttt_sg550 = "models/weapons/w_snip_sg550.mdl",
	
	weapon_zm_sledge = "models/weapons/w_mach_m249para.mdl",
	weapon_ttt_power = "models/weapons/w_negev.mdl",
	weapon_ttt_bulk = "models/weapons/w_rocket_launcher.mdl",
	
	weapon_ttt_confgrenade = "models/weapons/w_eq_fraggrenade.mdl",
	weapon_zm_molotov = "models/weapons/w_eq_flashbang.mdl",
	weapon_ttt_molotov = "models/props_junk/garbage_glassbottle003a.mdl",
	weapon_ttt_smokegrenade = "models/weapons/w_eq_smokegrenade.mdl",
	weapon_ttt_gtfo = "models/weapons/w_eq_fraggrenade.mdl",

	ttt_random_weapon = "models/weapons/w_shotgun.mdl",
	ttt_random_ammo = "models/Items/battery.mdl",
	
	ttt_random_pistol = "models/weapons/w_pist_fiveseven.mdl",
	ttt_random_ar = "models/weapons/w_rif_m4a1.mdl",
	ttt_random_shotty = "models/weapons/w_shot_xm1014.mdl",
	ttt_random_smg = "models/weapons/w_smg_p90.mdl",
	ttt_random_sniper = "models/weapons/w_snip_scout.mdl",
	ttt_random_lmg = "models/weapons/w_mach_m249para.mdl",
	ttt_random_nade = "models/weapons/w_eq_fraggrenade.mdl",
	

	item_ammo_pistol_ttt =  "models/items/boxsrounds.mdl",
	item_ammo_smg1_ttt =  "models/items/boxmrounds.mdl",
	item_ammo_revolver_ttt = "models/items/357ammo.mdl",
	item_ammo_357_ttt = "models/items/357ammo.mdl",
	item_box_buckshot_ttt = "models/items/boxbuckshot.mdl",
	item_ammo_assault_ttt =  "models/items/boxsrounds.mdl",
	
	ttt_mystery_crate = "models/griim/christmas/present_colourable.mdl",
	ttt_playerspawn = "models/player.mdl",
 };

-- special colours for certain ents
local colors = { 
	ttt_random_weapon = Color( 255, 255, 0 ),
	ttt_random_ammo = Color( 0, 255, 0 ),
	
	ttt_random_pistol = Color( 0, 255, 255 ),
	ttt_random_ar = Color( 0, 255, 255 ),
	ttt_random_shotty = Color( 0, 255, 255 ),
	ttt_random_smg = Color( 0, 255, 255 ),
	ttt_random_sniper = Color( 0, 255, 255 ),
	ttt_random_lmg = Color( 0, 255, 255 ),
	ttt_random_nade = Color( 0, 255, 255 ),
	
	item_ammo_revolver_ttt = Color( 255, 100, 100 ),
	item_ammo_assault_ttt = Color( 50, 120, 50 ),
	
	ttt_playerspawn = Color( 0, 255, 0 ),
};

local function DummyInit( s )
	if colors[ s:GetClass() ] then
		local c = colors[ s:GetClass() ]
		s:SetColor( c )
	end

	s:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	s:SetSolid( SOLID_VPHYSICS )
	s:SetMoveType( MOVETYPE_VPHYSICS )

	if s:GetClass() == "ttt_playerspawn" then
		s:PhysicsInitBox( Vector( -18, -18, -0.1 ), Vector( 18, 18, 66 ) )
		s:SetPos( s:GetPos() + Vector( 0, 0, 1 ) )
	else
		s:PhysicsInit( SOLID_VPHYSICS )
	end

	s:SetModel( s.Model )
end

for cls, mdl in pairs( mdls ) do
	local tbl = { 
		Type = "anim",
		Model = Model( mdl ),
		Initialize = DummyInit
	 };

	scripted_ents.Register( tbl, cls, false )
end

function TOOL:SpawnEntity( cls, trace )
	local mdl = mdls[ cls ]

	if not cls or not mdl then return end

	local ent = ents.Create( cls )
	ent:SetModel( mdl )
	ent:SetPos( trace.HitPos )

	local tr = util.TraceEntity( { start = trace.StartPos, endpos = trace.HitPos, filter = self:GetOwner() }, ent )
	if tr.Hit then
		ent:SetPos( tr.HitPos )
	end

	ent:Spawn()

	ent:PhysWake()

	undo.Create( "TTTWeapon" )
	undo.AddEntity( ent )
	undo.SetPlayer( self:GetOwner() )
	undo.Finish()

	self:GetOwner():AddCleanup( "ttt_weapons", ent )
end

function TOOL:LeftClick( trace )
	local cls = self:GetClientInfo( "weapon" )

	self:SpawnEntity( cls, trace )
	return true
end

function TOOL:RightClick( trace )
	local cls = self:GetClientInfo( "weapon" )
	local info = weps[ cls ]
	if not info then return end

	local ammo = info.snd
	if not ammo then
		self:GetOwner():ChatPrint( "No matching ammo for this type!" )
		return
	end

	self:SpawnEntity( info.snd, trace )
	return true
end

if SERVER then
	util.AddNetworkString( "Rearm_AddProp" )
	util.AddNetworkString( "Rearm_RemoveProp" )
	util.AddNetworkString( "Rearm_ClearProps" )
	
	hook.Add( "EntityRemoved", "Rearm_ClearProps", function( ent )
		if ent:GetVar( "rearm" ) then
			net.Start( "Rearm_ClearProps" )
			net.Broadcast()
		end
	end )
end

local rearmedProps = {}

function TOOL:Reload( trace )
	if trace.Hit then
		local ent = trace.Entity
		if !ent:IsValid() then return end
		
		if ent:GetVar( "rearm" ) then
			ent:SetVar( "rearm", false )
			net.Start( "Rearm_RemoveProp" )
				net.WriteEntity( ent )
			net.Broadcast()
			--ent:SetColor( Color( 255, 255, 255, 255 ) )
			--ent:SetRenderMode( RENDERMODE_TRANSALPHA )
			return true
		else
			ent:SetVar( "rearm", true )
			net.Start( "Rearm_AddProp" )
				net.WriteEntity( ent )
			net.Broadcast()
			--ent:SetColor( Color( 255, 127, 127, 255 ) )
			--ent:SetRenderMode( RENDERMODE_TRANSALPHA )
			return true
		end
	end
end

if CLIENT then
	net.Receive( "Rearm_AddProp", function()
		local ent = net.ReadEntity()
		table.insert( rearmedProps, ent )
	end )
	
	net.Receive( "Rearm_RemoveProp", function()
		local ent = net.ReadEntity()
		table.RemoveByValue( rearmedProps, ent )
	end )
	
	net.Receive( "Rearm_ClearProps", function()
		for k, v in pairs( rearmedProps ) do
			if !IsValid( v ) then
				rearmedProps[ k ] = nil
			end
		end
	end )
	
	hook.Add( "PreDrawHalos", "AddPropHalos", function()
		halo.Add( rearmedProps, Color( 255, 0, 0 ), 1, 1, 2, true, true )
	end )
end

function TOOL.BuildCPanel( panel ) -- note that this is not a method, REAL NICE
	local label = vgui.Create( "DLabel", panel )
	label:SetColor( Color( 3, 3, 3 ) )
	label:SetText( language.GetPhrase( "tool.tttweaponplacer.desc" ) )
	panel:AddPanel( label )
	
	local tree = vgui.Create( "DTree", panel )
	tree:Dock( TOP )
	tree:SetHeight( 200 )

	local pistols = tree:AddNode( "Pistols" )
	local rifles = tree:AddNode( "Rifles" )
	local shotguns = tree:AddNode( "Shotguns" )
	local smgs = tree:AddNode( "SMGs" )
	local snipers = tree:AddNode( "Snipers" )
	local heavy = tree:AddNode( "Heavy" )
	local grenades = tree:AddNode( "Grenades" )
	local other = tree:AddNode( "Other" )
	
	for k, v in pairs( weps ) do
		local node
		local class = v.class
		local icon = "icon16/bomb.png"
		
		if string.StartWith( v.name, "Random" ) then
			icon = "icon16/help.png"
		end
		
		if class == "pistol" then
			node = pistols:AddNode( v.name, icon )
		elseif class == "rifle" then
			node = rifles:AddNode( v.name, icon )
		elseif class == "shotgun" then
			node = shotguns:AddNode( v.name, icon )
		elseif class == "smg" then
			node = smgs:AddNode( v.name, icon )
		elseif class == "sniper" then
			node = snipers:AddNode( v.name, icon )
		elseif class == "heavy" then
			node = heavy:AddNode( v.name, icon )
		elseif class == "grenade" then
			node = grenades:AddNode( v.name, icon )
		elseif v.name == "Player Spawn" then
			node = other:AddNode( v.name, "icon16/status_online.png" )
		elseif v.name == "Mystery Crate" then
			node = other:AddNode( v.name, "icon16/package.png" )
		else
			node = other:AddNode( v.name, icon )
		end
		
		node.DoClick = function()
			RunConsoleCommand( "tttweaponplacer_weapon", k )
		end
	end
	panel:AddPanel( tree )
	
	local button = vgui.Create( "DButton", panel )
	button:SetText( "Report counts" )
	button.DoClick = function()
		RunConsoleCommand( "tttweaponplacer_count" )
	end
	panel:AddPanel( button )
	
	local checkbox = vgui.Create( "DCheckBoxLabel", panel )
	checkbox:SetTextColor( Color( 3, 3, 3 ) )
	checkbox:SetText( "Replace existing player spawnpoints" )
	checkbox:SetConVar( "tttweaponplacer_replacespawns" )
	panel:AddPanel( checkbox )
	
	local button = vgui.Create( "DButton", panel )
	--button:SetWidth( 137 )
	--button:SetPos( 10, 327 )
	button:SetText( "Export" )
	button.DoClick = function()
		RunConsoleCommand( "tttweaponplacer_queryexport" )
	end
	panel:AddPanel( button )
	
	local button = vgui.Create( "DButton", panel )
	--button:SetWidth( 137 )
	--button:SetPos( 157, 327 )
	button:SetText( "Import" )
	button.DoClick = function()
		RunConsoleCommand( "tttweaponplacer_queryimport" )
	end
	panel:AddPanel( button )
	
	local button = vgui.Create( "DButton", panel )
	button:DockMargin( 0, 10, 0, 0 )
	button:SetText( "Convert HL2 entities" )
	button.DoClick = function()
		RunConsoleCommand( "tttweaponplacer_replacehl2" )
	end
	panel:AddPanel( button )
	
	local button = vgui.Create( "DButton", panel )
	button:SetText( "Remove all weapon/ammo" )
	button.DoClick = function()
		RunConsoleCommand( "tttweaponplacer_removeall" )
	end
	panel:AddPanel( button )
	
	local button = vgui.Create( "DButton", panel )
	button:SetText( "Remove all player spawns" )
	button.DoClick = function()
		RunConsoleCommand( "tttweaponplacer_removeallspawns" )
	end
	panel:AddPanel( button )
	
	local button = vgui.Create( "DButton", panel )
	button:SetText( "Remove all mystery crates" )
	button.DoClick = function()
		RunConsoleCommand( "tttweaponplacer_removeallcrate" )
	end
	panel:AddPanel( button )
	
	local button = vgui.Create( "DButton", panel )
	button:SetText( "Remove all rearmed props" )
	button.DoClick = function()
		RunConsoleCommand( "tttweaponplacer_removeallprops" )
	end
	panel:AddPanel( button )
end

-- STOOLs not being loaded on client = headache bonanza
if CLIENT then
	function QueryFileExists()

		local map = string.lower( game.GetMap() )
		if not map then return end

		local fname = "ttt/maps/" .. map .. "_ttt.txt"

		if file.Exists( fname, "DATA" ) then
			Derma_StringRequest( "File exists", "The file \"" .. fname .. "\" already exists. Save under a different filename? Leave unchanged to overwrite.", fname,
			function( txt )
				RunConsoleCommand( "tttweaponplacer_export", txt )
			end )
		else
			RunConsoleCommand( "tttweaponplacer_export" )
		end
	end

	function QueryImportName()
		local map = string.lower( game.GetMap() )
		if not map then return end

		local fname = "ttt/maps/" .. map .. "_ttt.txt"

		Derma_StringRequest( "Import", "What file do you want to import? Note that files meant for other maps will result in crazy things happening.", fname,
		function( txt )
			RunConsoleCommand( "tttweaponplacer_import", txt )
		end )
	end
else
	-- again, hilarious things happen when this shit is used in mp
	concommand.Add( "tttweaponplacer_queryexport", function() BroadcastLua( "QueryFileExists()" ) end )
	concommand.Add( "tttweaponplacer_queryimport", function() BroadcastLua( "QueryImportName()" ) end )
end

WEAPON_PISTOL = 1
WEAPON_RIFLE = 2
WEAPON_SHOTGUN = 3
WEAPON_SMG = 4
WEAPON_SNIPER = 5
WEAPON_LMG = 6
WEAPON_MGL = 7

WEAPON_NADE = 8
WEAPON_RANDOM = 9
AMMO = 10

PLAYERSPAWN = 11
MYSTERYCRATE = 12

local enttypes = { 
	weapon_ttt_obrez = WEAPON_PISTOL,
	weapon_zm_revolver = WEAPON_PISTOL,
	weapon_zm_pistol = WEAPON_PISTOL,
	weapon_ttt_tokarev = WEAPON_PISTOL,
	weapon_ttt_glock = WEAPON_PISTOL,
	weapon_ttt_duel_elites = WEAPON_PISTOL,

	weapon_ttt_m16 = WEAPON_RIFLE,
	weapon_ttt_famas = WEAPON_RIFLE,
	weapon_ttt_commando = WEAPON_RIFLE,
	
	weapon_zm_shotgun = WEAPON_SHOTGUN,
	weapon_ttt_m3super = WEAPON_SHOTGUN,
	weapon_ttt_slugster = WEAPON_SHOTGUN,
	
	weapon_zm_mac10 = WEAPON_SMG,
	weapon_ttt_navy = WEAPON_SMG,
	weapon_ttt_p90 = WEAPON_SMG,
	
	weapon_zm_rifle = WEAPON_SNIPER,
	weapon_ttt_gewehr = WEAPON_SNIPER,
	weapon_ttt_sg550 = WEAPON_SNIPER,
	
	weapon_zm_sledge = WEAPON_LMG,
	weapon_ttt_power = WEAPON_LMG,
	weapon_ttt_bulk = WEAPON_MGL,

	weapon_ttt_confgrenade = WEAPON_NADE,
	weapon_zm_molotov = WEAPON_NADE,
	weapon_ttt_molotov = WEAPON_NADE,
	weapon_ttt_smokegrenade = WEAPON_NADE,
	weapon_ttt_gtfo = WEAPON_NADE,

	ttt_random_weapon = WEAPON_RANDOM,
	ttt_random_ammo = AMMO,
	
	ttt_random_pistol = WEAPON_PISTOL,
	ttt_random_ar = WEAPON_RIFLE,
	ttt_random_shotty = WEAPON_SHOTGUN,
	ttt_random_smg = WEAPON_SMG,
	ttt_random_sniper = WEAPON_SNIPER,
	ttt_random_lmg = WEAPON_LMG,
	ttt_random_nade = WEAPON_NADE,

	item_ammo_pistol_ttt =  AMMO,
	item_ammo_smg1_ttt =  AMMO,
	item_ammo_revolver_ttt = AMMO,
	item_ammo_357_ttt = AMMO,
	item_box_buckshot_ttt = AMMO,
	item_ammo_assault_ttt =  AMMO,
	
	ttt_playerspawn = PLAYERSPAWN,
	ttt_mystery_crate = MYSTERYCRATE,
 };

local function PrintCount( ply )
	local count = { 
		[ WEAPON_PISTOL ] = 0,
		[ WEAPON_RIFLE ] = 0,
		[ WEAPON_SHOTGUN ] = 0,
		[ WEAPON_SMG ] = 0,
		[ WEAPON_SNIPER ] = 0,
		[ WEAPON_LMG ] = 0,
		[ WEAPON_MGL ] = 0,
	  
		[ WEAPON_NADE ] = 0,
		[ WEAPON_RANDOM ] = 0,
		[ AMMO ] = 0,
	  
		[ PLAYERSPAWN ] = 0,
		[ MYSTERYCRATE ] = 0,
	 };

	for cls, t in pairs( enttypes ) do
		for _, ent in pairs( ents.FindByClass( cls ) ) do
			count[ t ] = count[ t ] + 1
		end
	end

	ply:ChatPrint( "Entity count ( use report_entities in console for more detail ):" )
	ply:ChatPrint( "Pistols: " .. count[ WEAPON_PISTOL ] )
	ply:ChatPrint( "Rifles: " .. count[ WEAPON_RIFLE ] )
	ply:ChatPrint( "Shotguns: " .. count[ WEAPON_SHOTGUN ] )
	ply:ChatPrint( "SMGs: " .. count[ WEAPON_SMG ] )
	ply:ChatPrint( "Snipers: " .. count[ WEAPON_SNIPER ] )
	ply:ChatPrint( "LMGs: " .. count[ WEAPON_LMG ] )
	ply:ChatPrint( "MGLs: " .. count[ WEAPON_MGL ] )
	ply:ChatPrint( "Nades: " .. count[ WEAPON_NADE ] )
	ply:ChatPrint( "Random weps: " .. count[ WEAPON_RANDOM ] )
	ply:ChatPrint( "Ammo: " .. count[ AMMO ] )
	ply:ChatPrint( "Player spawns: " .. count[ PLAYERSPAWN ] )
	ply:ChatPrint( "Mystery crates: " .. count[ MYSTERYCRATE ] )
end
concommand.Add( "tttweaponplacer_count", PrintCount )

-- This shit will break terribly in MP
if SERVER or CLIENT then
	-- Could just do a GLON dump, but it's nice if the "scripts" are sort of
	-- human-readable so it's easy to go in and delete all pistols or something.
	local function Export( ply, cmd, args )
		if not IsValid( ply ) then return end

		local map = string.lower( game.GetMap() )

		if not map then return end

		--local frozen_only = GetConVar( "tttweaponplacer_frozen" ):GetBool()
		local frozen_only = false

		-- Nice header, # is comment
		local buf =  "# Trouble in Terrorist Town weapon/ammo placement overrides\n"
		buf = buf .. "# For map: " .. map .. "\n"
		buf = buf .. "# Exported by: " .. ply:Nick() .. "\n"

		-- Write settings ( "setting: <name> <value>" )
		local rspwns = GetConVar( "tttweaponplacer_replacespawns" ):GetBool() and "1" or "0"
		buf = buf .. "setting:\treplacespawns " .. rspwns .. "\n"

		local num = 0
		for cls, mdl in pairs( mdls ) do
			for _, ent in pairs( ents.FindByClass( cls ) ) do
				if IsValid( ent ) then
					if not frozen_only or not ent:GetPhysicsObject():IsMoveable() then
						num = num + 1
						buf = buf .. Format( "%s\t%s\t%s\n", cls, tostring( ent:GetPos() ), tostring( ent:GetAngles() ) )
					end
				end
			end
		end
	  
	  local entable = ents.GetAll()
	  
	  for i,ent in pairs( entable ) do
		if ent:GetVar( "rearm", false ) then
			local static = false
			if ent:GetMoveType() ==  MOVETYPE_NONE or not ent:GetPhysicsObject():IsMotionEnabled() then
				static = true
			end
			
			num = num + 1
			buf = buf .. Format( "%s\t%s\t%s\t%s\n", ent:GetModel(), tostring( ent:GetPos() ), tostring( ent:GetAngles() ), static )
		end
	  end

		local fname = "ttt/maps/" .. map .. "_ttt.txt"

		if args[ 1 ] then
			fname = args[ 1 ]
		end

		file.CreateDir( "ttt/maps" )
		file.Write( fname, buf )

		if not file.Exists( fname, "DATA" ) then
			ErrorNoHalt( "Exported file not found. Bug?\n" )
		end

		ply:ChatPrint( num .. " placements saved to /garrysmod/data/" .. fname )
	end
	concommand.Add( "tttweaponplacer_export", Export )

	local function SpawnDummyEnt( cls, pos, ang )
		if not cls or not pos or not ang then return false end

		local mdl = mdls[ cls ]
		if not mdl then return end

		local ent = ents.Create( cls )
		ent:SetModel( mdl )
		ent:SetPos( pos )
		ent:SetAngles( ang )
		ent:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		ent:SetSolid( SOLID_VPHYSICS )
		ent:SetMoveType( MOVETYPE_VPHYSICS )
		ent:PhysicsInit( SOLID_VPHYSICS )

		ent:Spawn()

		local phys = ent:GetPhysicsObject()
		if IsValid( phys ) then
			phys:SetAngles( ang )
		end
	end

	local function Import( ply, cmd, args )
		if not IsValid( ply ) then return end
		local map = string.lower( game.GetMap() )
		if not map then return end

		local fname = "ttt/maps/" .. map .. "_ttt.txt"

		if args[ 1 ] then
			fname = args[ 1 ]
		end

		if not file.Exists( fname, "DATA" ) then
			ply:ChatPrint( fname .. " not found!" )
			return
		end

		local buf = file.Read( fname, "DATA" )
		local lines = string.Explode( "\n", buf )
		local num = 0
		for k, line in ipairs( lines ) do
			if not string.match( line, "^#" ) and line !=  "" then
				local data = string.Explode( "\t", line )

				local fail = true -- pessimism

				if #data > 0 then
					if data[ 1 ] ==  "setting:" and tostring( data[ 2 ] ) then
						local raw = string.Explode( " ", data[ 2 ] )
						RunConsoleCommand( "tttweaponplacer_" .. raw[ 1 ], tonumber( raw[ 2 ] ) )

						fail = false
						num = num - 1
					elseif #data ==  3 or #data ==  4 then
						local cls = data[ 1 ]
						local ang = nil
						local pos = nil
						local static = false

						local posraw = string.Explode( " ", data[ 2 ] )
						pos = Vector( tonumber( posraw[ 1 ] ), tonumber( posraw[ 2 ] ), tonumber( posraw[ 3 ] ) )

						local angraw = string.Explode( " ", data[ 3 ] )
						ang = Angle( tonumber( angraw[ 1 ] ), tonumber( angraw[ 2 ] ), tonumber( angraw[ 3 ] ) )
				  
				  
						-- Interrupt if regular model is found
						if string.find( cls, ".mdl" ) then
							if data[ 4 ] ==  "true" then
								static = true
							end

							local ent = ents.Create( "prop_physics" )
							ent:SetModel( cls )
							ent:SetPos( pos )
							ent:SetAngles( ang )
							ent:SetCollisionGroup( COLLISION_GROUP_NONE )
							ent:SetSolid( SOLID_VPHYSICS )
							if static then
								ent:SetMoveType( MOVETYPE_NONE )
							else
								ent:SetMoveType( MOVETYPE_VPHYSICS )
							end
							ent:PhysicsInit( SOLID_VPHYSICS )

							ent:Spawn()

							ent:SetVar( "rearm", true )
							net.Start( "Rearm_AddProp" )
								net.WriteEntity( ent )
							net.Broadcast()
							--ent:SetColor( Color( 255, 127, 127, 255 ) )
							--ent:SetRenderMode( RENDERMODE_TRANSALPHA )

							local phys = ent:GetPhysicsObject()
							if IsValid( phys ) then
								phys:SetAngles( ang )
								if static then phys:EnableMotion( false ) end
							end

							fail = false
						else
							fail = SpawnDummyEnt( cls, pos, ang ) --else spawn as normal
						end
					end
				end

				if fail then
					ErrorNoHalt( "Invalid line " .. k .. " in " .. fname .. "\n" )
				else
					num = num + 1
				end
			end
		end

		ply:ChatPrint( "Spawned " .. num .. " dummy ents" )
	end
	concommand.Add( "tttweaponplacer_import", Import )

	local function RemoveAll( ply, cmd, args )
		if not IsValid( ply ) then return end

		local num = 0
		local delete = function( ent )
			if not IsValid( ent ) then return end
			print( "\tRemoving", ent, ent:GetClass() )
			ent:Remove()
			num = num + 1
		end

		print( "Removing ammo..." )
		for k, ent in pairs( ents.FindByClass( "item_*" ) ) do
			delete( ent )
		end
		for k, ent in pairs( ents.FindByClass( "ttt_random_ammo" ) ) do
			delete( ent )
		end

		print( "Removing weapons..." )
		for k, ent in pairs( ents.FindByClass( "weapon_*" ) ) do
			delete( ent )
		end
		for k, ent in pairs( ents.FindByClass( "ttt_random_*" ) ) do
			delete( ent )
		end

		ply:ChatPrint( "Removed " .. num .. " weapon/ammo ents" )
	end
	
	local function RemoveAllSpawns( ply, cmd, args )
		if not IsValid( ply ) then return end

		local num = 0
		local delete = function( ent )
								if not IsValid( ent ) then return end
								print( "\tRemoving", ent, ent:GetClass() )
								ent:Remove()
								num = num + 1
							end

		
		print( "Removing spawns..." )
		for k, ent in pairs( ents.FindByClass( "ttt_playerspawn" ) ) do
			delete( ent )
		end

		ply:ChatPrint( "Removed " .. num .. " spawn ents" )
	end
	
	local function RemoveAllCrates( ply, cmd, args )
		if not IsValid( ply ) then return end

		local num = 0
		local delete = function( ent )
			if not IsValid( ent ) then return end
			print( "\tRemoving", ent, ent:GetClass() )
			ent:Remove()
			num = num + 1
		end

		
		print( "Removing crates..." )
		for k, ent in pairs( ents.FindByClass( "ttt_mystery_crate" ) ) do
			delete( ent )
		end

		ply:ChatPrint( "Removed " .. num .. " crate ents" )
	end
	
	local function RemoveAllProps( ply, cmd, args )
		if not IsValid( ply ) then return end

		local num = 0
		local delete = function( ent )
			if not IsValid( ent ) then return end
			print( "\tRemoving", ent, ent:GetClass() )
			ent:Remove()
			num = num + 1
		end

		
		print( "Removing rearmed props..." )
		local entable = ents.GetAll()
	  
		for i,ent in pairs( entable ) do
			if ent:GetVar( "rearm", false ) then
				delete( ent )
			end
		end

		ply:ChatPrint( "Removed " .. num .. " rearms props" )
	end
	concommand.Add( "tttweaponplacer_removeall", RemoveAll )
	concommand.Add( "tttweaponplacer_removeallspawns", RemoveAllSpawns )
	concommand.Add( "tttweaponplacer_removeallcrate", RemoveAllCrates )
	concommand.Add( "tttweaponplacer_removeallprops", RemoveAllProps )

	local hl2_replace = { 
		[ "item_ammo_pistol" ] = "item_ammo_pistol_ttt",
		[ "item_box_buckshot" ] = "item_box_buckshot_ttt",
		[ "item_ammo_smg1" ] = "item_ammo_smg1_ttt",
		[ "item_ammo_357" ] = "item_ammo_357_ttt",
		[ "item_ammo_357_large" ] = "item_ammo_357_ttt",
		[ "item_ammo_revolver" ] = "item_ammo_revolver_ttt", -- zm
		[ "item_ammo_ar2" ] = "item_ammo_pistol_ttt",
		[ "item_ammo_ar2_large" ] = "item_ammo_smg1_ttt",
		[ "item_ammo_smg1_grenade" ] = "weapon_zm_pistol",
		[ "item_battery" ] = "item_ammo_357_ttt",
		[ "item_healthkit" ] = "weapon_zm_shotgun",
		[ "item_suitcharger" ] = "weapon_zm_mac10",
		[ "item_ammo_ar2_altfire" ] = "weapon_zm_mac10",
		[ "item_rpg_round" ] = "item_ammo_357_ttt",
		[ "item_ammo_crossbow" ] = "item_box_buckshot_ttt",
		[ "item_healthvial" ] = "weapon_zm_molotov",
		[ "item_healthcharger" ] = "item_ammo_revolver_ttt",
		[ "item_ammo_crate" ] = "weapon_ttt_confgrenade",
		[ "item_item_crate" ] = "ttt_random_ammo",
		[ "weapon_smg1" ] = "weapon_zm_mac10",
		[ "weapon_shotgun" ] = "weapon_zm_shotgun",
		[ "weapon_ar2" ] = "weapon_ttt_m16",
		[ "weapon_357" ] = "weapon_zm_rifle",
		[ "weapon_crossbow" ] = "weapon_zm_pistol",
		[ "weapon_rpg" ] = "weapon_zm_sledge",
		[ "weapon_slam" ] = "item_ammo_pistol_ttt",
		[ "weapon_frag" ] = "weapon_zm_revolver",
		[ "weapon_crowbar" ] = "weapon_zm_molotov"
	};

	local function ReplaceSingle( ent, newname )
		if ent:GetPos() ==  vector_origin then
			return false
		end

		if ent:IsWeapon() and IsValid( ent:GetOwner() ) and ent:GetOwner():IsPlayer() then
			return false
		end

		ent:SetSolid( SOLID_NONE )

		local rent = ents.Create( newname )
		rent:SetModel( mdls[ newname ] )
		rent:SetPos( ent:GetPos() )
		rent:SetAngles( ent:GetAngles() )
		rent:Spawn()

		rent:Activate()
		rent:PhysWake()

		ent:Remove()
		return true
	end

	local function ReplaceHL2Ents( ply, cmd, args )
		if not IsValid( ply ) then return end

		local c = 0
		for _, ent in pairs( ents.GetAll() ) do
			local rpl = hl2_replace[ ent:GetClass() ]
			if rpl then
				local success = ReplaceSingle( ent, rpl )
				if success then
					c = c + 1
				end
			end
		end

		ply:ChatPrint( "Replaced " .. c .. " HL2 entities with TTT versions." )
	end
	concommand.Add( "tttweaponplacer_replacehl2", ReplaceHL2Ents )
end