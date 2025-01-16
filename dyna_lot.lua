--[[
* dyna_lot.lua
* Handles Dynamis lot management and announcements for FFXI
*
* @addon dyna_lot
* @version 1.0
* @author Unknown
* @repo Unknown
*
* @event incoming_packet
* Processes various packet types:
* - 0x029: Action Message Packet (Dynamis time extensions)
* - 0x0D2: Item Drop Packet (Treasure pool additions)
* - 0x0D3: Item Lot/Drop Packet (Lot results and item claims)
*
* @event render
* Renders the addon's GUI windows:
* - Main Treasure Log window with drop listings
* - Options window for configuration settings
*
* @event unload
* Saves configuration settings when addon is unloaded
*
* @features
* - Tracks and announces Dynamis time extensions
* - Monitors treasure pool items and their job requirements
* - Creates timers for dropped items
* - Announces items to party/linkshell channels
* - Configurable announcement options
* - GUI interface for item management
*
* @configuration
* Settings stored in settings/dyna_lot.json:
* - discord: Discord integration toggle
* - say_hundo: Announce 100 piece drops
* - outside_party: Enable shout announcements
* - inside_party: Enable party announcements
* - say_te: Announce time extensions
* - currency: Currency tracking
* - linkshell: Enable linkshell announcements
* - linkshell2: Enable linkshell2 announcements
--]]

_addon.author = 'Mapi';
_addon.name = 'VG Lotting Helper';
_addon.version = "2.5.6"

require 'settings'
require 'common'
require 'ffxi.targets' 
require 'timer'
require 'imguidef'
require 'functions'
require 'stringex'
require 'ffxi.enums'
require 'dyna_items'
require 'dyna_timers'


chat = require("chat")

local timer_list = {}
local Item_Pool = {}
local default_settings = {
	color           = 200,
    format          = '%H:%M:%S',
    open_bracket    = '[',
    close_bracket   = ']',	
	say_hundo = false,
	say_te = false,
	say_item_drop = false,
	auto_announce = false,
	debug_auto = true,
	inside_party = true,
	outside_party = true,
	discord = true,
	export = true,
	linkshell = false,
	linkshell2 = false,
	show_options = false,
	use_timers = false

}
config = default_settings
config = ashita.settings.load_merged(_addon.path .. '/settings/dyna_lot.json',config);
ashita.settings.save(_addon.path .. '/settings/dyna_options.json', options);
local drop_tracker = {
	Currency = {
		White 		= 0, --Single
		Jade		= 0, --hundo

		Bronze 		= 0, --Single
		Silver		= 0, --Hundo

		Byne 		= 0, --Single
		Byne_100 	= 0  --Hundo

	},
	Relics ={}
}

local options ={
	['var_hundo']                  = { nil, ImGuiVar_BOOLCPP },
	['var_outsideparty']           = { nil, ImGuiVar_BOOLCPP },
	['var_insideparty']           = { nil, ImGuiVar_BOOLCPP },
	['var_time_ext']               = { nil, ImGuiVar_BOOLCPP },
	['var_discord']                = { nil, ImGuiVar_BOOLCPP },
	['var_currency']                = { nil, ImGuiVar_BOOLCPP },
	['var_export']                = { nil, ImGuiVar_BOOLCPP },
	['var_ls']                = { nil, ImGuiVar_BOOLCPP },
	['var_ls2']                = { nil, ImGuiVar_BOOLCPP },
	['show_options']                = { nil, ImGuiVar_BOOLCPP },
	['use_timers']				= { nil, ImGuiVar_BOOLCPP }}

function lprint(msg)
	local timestamp = os.date(string.format('\31\%c[%s]\30\01 ', config.color, config.format));
    local header = timestamp .. chat.header("Dyna-Lot")
	if(msg ==nil)then
		
		print(string.format("%sError: Nil Value",header))
		else
		print(string.format("%s%s",header,tostring(msg)))
	end
end


function Get_Option(var)
    return imgui.GetVarValue(options[var][1])
end

function Set_Option(var,value)
    imgui.SetVarValue(options[var][1],value)
end
ashita.register_event('load', function()
	AshitaCore:GetChatManager():QueueCommand('/addon load timers', 1);
	for k, v in pairs(options) do
        -- Create the variable..
        if (v[2] >= ImGuiVar_CDSTRING) then 
            options[k][1] = imgui.CreateVar(options[k][2], options[k][3]);
        else
            options[k][1] = imgui.CreateVar(options[k][2]);
        end 
        -- Set a default value if present..
        if (#v > 2 and v[2] < ImGuiVar_CDSTRING) then
            imgui.SetVarValue(options[k][1], options[k][3]);
        end        
    end
	imgui.SetVarValue(options['var_discord'][1],config.discord)
	imgui.SetVarValue(options['var_hundo'][1],config.say_hundo)
	imgui.SetVarValue(options['var_outsideparty'][1],config.outside_party)
	imgui.SetVarValue(options['var_insideparty'][1],config.inside_party)
	imgui.SetVarValue(options['var_time_ext'][1],config.say_te)
	imgui.SetVarValue(options['var_currency'][1],config.currency)
	imgui.SetVarValue(options['var_export'][1],config.export)
	imgui.SetVarValue(options['var_ls'][1],config.linkshell)
	imgui.SetVarValue(options['var_ls2'][1],config.linkshell2)
	imgui.SetVarValue(options['use_timers'][1],config.use_timers)
	imgui.SetVarValue(options['show_options'][1],false)
	config.show_options = false
end);

ashita.register_event('command', function(command, ntype)
    count=0;
    local args = command:args();
    if(args[1] == nil) then
        return false;
    end;
    local cmd = args[1];
    cmd = cmd:lower();
	
	if(cmd == '/neg')then
		print(MaskToFull("BST"))
		
		--[[item = AshitaCore:GetResourceManager():GetItemById(2075)
		if(string.endswith(item.LogNameSingular[0],"-1"))then
			lprint("Neg")
		end
		local n_item = string.gsub(item.LogNameSingular[0],"-1","")
		n_item = string.trimend(n_item)
		lprint("["..n_item.."]")
		item2 = AshitaCore:GetResourceManager():GetItemByName(n_item,0)
		lprint(item2.Jobs)]]--
	end
    if(cmd == '/dyna_lot')then
		subcmd = args[2]:lower()
		if(subcmd == nil) then
			return false	
		elseif (subcmd == 'start') then
			WriteToLog("Start")
		elseif(subcmd == 'hundo')then
			if(config.say_hundo == true)then
				config.say_hundo=false
			else
				config.say_hundo=true
			end
		elseif(subcmd == 'te')then
			if(config.say_te == true)then
				config.say_te=false
			else
				config.say_te=true
			end
		elseif(subcmd == "auto")then
			if(config.auto_announce == true)then
				config.auto_announce=false
			else
				config.auto_announce=true
			end
		end
	elseif (cmd == "/test") then
		lprint(string.format("%s Test %s",chat.symbols.unicode.BlackStar,chat.symbols.unicode.BlackStar))
	end
	return false
end);


ashita.register_event('incoming_packet', function(id, size, packet, packet_modified, blocked)
	local playerEntity = GetPlayerEntity()
	local area = AshitaCore:GetResourceManager():GetString("areas",AshitaCore:GetDataManager():GetParty():GetMemberZone(0))
	local in_dyna = string.startswith(area,"Dyna")
	
    if (playerEntity == nil or in_dyna == false) then
		return false
	end

	--// Action Message Packet
	if (id == 0x029) then --Action Message Packet
		if (playerEntity == nil or in_dyna == false) then
			return false
		end
		local pack_data = {
			Actor = struct.unpack('I', packet, 0x04),
			Target = struct.unpack('I', packet, 0x08),
			Param_1 = struct.unpack('I', packet, 0x0C +1),
			Param_2 = struct.unpack('I', packet, 0x10 +1),
			Actor_Index = struct.unpack('H', packet,0x14 ),
			Target_Index = struct.unpack('H', packet,0x16 ),
			Message = struct.unpack('H', packet,0x18 +1)
		}
		--Dynamis Time Extended
		if(pack_data.Message == 448 ) then
			WriteToLog(string.format("Time Extension: +%i minutes",pack_data.Param_1))
			if(config.use_timers == true)then
				ext_msg = string.format("/timers extend Dyna %im",tonumber(pack_data.Param_1))
				AshitaCore:GetChatManager():QueueCommand(ext_msg, 1);
			end
			lprint(config.say_te)
			if(config.say_te == true and config.inside_party == true)then
				ext_msg = string.format("Dynamis Time Extended by %s minutes",pack_data.Param_1)
				Dyna_Announce(ext_msg)
				return false
			end
		end
		

		if(pack_data.Message == 449) then
			lprint(string.format("Dynamis Time Left: %s",tostring(pack_data.Param_1)))
			
			
			if config.use_timers == true then
				AshitaCore:GetChatManager():QueueCommand("/timers remove Dyna", 1);	
				AshitaCore:GetChatManager():QueueCommand(string.format("/timers add %sm Dyna",tostring(pack_data.Param_1)), 1);
			end
			
		end
		pack_data = nil
		return false
	end


	--// Item Drop Packet
	if (id == 0x0D2) then --Item Dropped Packet
		if (playerEntity == nil or in_dyna == false) then
			return false
		end
		local pack_data = {
			Dropper = struct.unpack('I', packet, 0x08),
			Count = struct.unpack('I', packet, 0x0C),
			Item = struct.unpack('H', packet, 0x10+1),
			Dropper_Index = struct.unpack('H', packet, 0x12),
			Index = struct.unpack('h', packet, 0x14+1)
		}
		
		--lprint(string.format("Testing Lib: ItemId: %s",packet_data.ItemId(packet)))
		local treasure = GetItemById(pack_data.Item)	--Get Item data
		if(treasure ~=nil)then --Check if there is a valid item
			if(Check_Job(treasure.ItemId)~=nil)then --Does the Item has a Job
				local time_slot = Get_Item_Slot(treasure.ItemId)
				if((time_slot == "Main") or (time_slot =="Sub") or (time_slot == "Range")) then
				else
					local timer_item = {
						name = treasure.Name[0],
						slot = Get_Item_Slot(treasure.ItemId),
						job = Check_Job(treasure.ItemId)
					}
					if(config.use_timers == true)then
						AshitaCore:GetChatManager():QueueCommand(string.format('/timers add 5m "%s %s"',treasure.Name[0],Check_Job(treasure.ItemId)),1)
					end
					lprint(treasure.Name[0],timer_item.slot)
					if (config.inside_party == true) then
						Dyna_Announce(string.format("%s [%s] - %s 75 can Lot <call20>",treasure.Name[0],timer_item.slot, Check_Job(treasure.ItemId))) --Announce to Party and outside party
					end
					--Make_Timer(pack_data.Index)
					
					if(pack_data.Index == 0) then -- Which Treasure Index dropped
						dyna_timers.timer0()
						Active_Timers[0]=true
					elseif(pack_data.Index == 1) then
						dyna_timers.timer1()
						Active_Timers[1]=true
					elseif(pack_data.Index == 2) then
						dyna_timers.timer2()
						Active_Timers[2]=true
					elseif(pack_data.Index == 3) then
						dyna_timers.timer3()
						Active_Timers[3]=true
					elseif(pack_data.Index == 4) then
						dyna_timers.timer4()
						Active_Timers[4]=true
					elseif(pack_data.Index == 5) then
						dyna_timers.timer5()
						Active_Timers[5]=true
					elseif(pack_data.Index == 6) then
						dyna_timers.timer6()
						Active_Timers[6]=true
					elseif(pack_data.Index == 7) then
						dyna_timers.timer7()
						Active_Timers[7]=true
					elseif(pack_data.Index == 8) then
						dyna_timers.timer8()
						Active_Timers[8]=true
					elseif(pack_data.Index == 9) then
						dyna_timers.timer9()
						Active_Timers[9]=true
					end
				end
			end
			if ((treasure.ItemId == 1450) or (treasure.ItemId == 1456) or (treasure.ItemId == 1453)) then
				if(config.say_hundo == true and config.inside_party == true) then
					Dyna_Announce("Hundo!<call20>")
				end
			end
		else
			return false
		end
		pack_data = nil
		return false
	end
	
	--// Item Lotted or Dropped from Pool
	if( id == 0x0D3) then --Item Lotted / Dropped Packet
		if (playerEntity == nil or in_dyna == false) then
			return false
			
		end
		local pack_data = T{
			Highest_Lotter = 		struct.unpack("I",packet,0x04 + 1),
			Current_Lotter = 		struct.unpack("I",packet,0x08 + 1),
			Highest_Lotter_Index = 	struct.unpack("H",packet,0x0c + 1),
			Highest_Lot = 			struct.unpack("H",packet,0x0E + 1),
			Current_Lotter_Index = 	struct.unpack("b",packet,0x10 + 1),
			Current_Lot = 			struct.unpack("H",packet,0x12 + 1),
			Index = 				struct.unpack("b",packet,0x14 +1),
			Drop = 					struct.unpack("B",packet,0x15 +1),
			Highest_Lotter_Name = 	struct.unpack("s",packet,0x16),
			Current_Lotter_Name =	struct.unpack("c16",packet,0x26 + 1),
			Job =					nil,
			Slot =					nil,
			ItemId =				nil,
			Area 	=				AshitaCore:GetResourceManager():GetString("areas",AshitaCore:GetDataManager():GetParty():GetMemberZone(0)),
			Name =					nil,
			WinningLotterName =		nil,
			LongName		=		nil
		}
		local treasure = AshitaCore:GetDataManager():GetInventory():GetTreasureItem(pack_data.Index)
		pack_data.ItemId =	treasure.ItemId
		pack_data.Slot =	Get_Item_Slot(pack_data.ItemId)
		
		local item = GetItemById(pack_data.ItemId)
		
		if(item~=nil)then
			pack_data.Name = item.Name[0]
			pack_data.LongName = string.upperfirst(item.LogNameSingular[0])
		end
		
		pack_data.WinningLotterName = string.remove(treasure.WinningLotterName,1)
		pack_data.Job = Check_Job(pack_data.ItemId)
		
		if(pack_data.Drop == 1 ) then
			if(pack_data.Job ~= nil )then
				if((pack_data.Slot == "Main") or (pack_data.Slot == "Sub") or (pack_data.Slot == "Range")) then
					--Do nothing in Drop is Weapon. Who cares
				else
					log_name = string.remove(pack_data.Highest_Lotter_Name,1)
					
					full_job = MaskToFull(pack_data.Job)
					
					msg = string.format("%s: Got %s - %s - %s",log_name,pack_data.LongName,pack_data.Slot,MaskToFull(pack_data.Job))
					WriteToLog(msg)
					if(config.inside_party == true)then
						Dyna_Announce(msg)
					end
				end
			end
		end
		return false
	end
return false
end);



ashita.register_event('render', function()
	local player = GetPlayerEntity();
    if (player == nil) then
        return;
    end
	
	imgui.SetNextWindowSize(300, 300, ImGuiSetCond_Always)
	--Main Window

	if (imgui.Begin('Treasure Log')) then
		
        -- Early out if the window is collapsed, as an optimization..
		if(imgui.Button('Show Options'))then
			if(config.show_options == true)then
				config.show_options = false
			else
				config.show_options = true
			end
		end

		imgui.SameLine()
		if(imgui.Button("PANIC!")) then
			for i = 0, 10, 1 do
				ashita.timer.remove_timer(string.format("timer_%i",i))
				Active_Timers[i]=false
			end
			lprint("All timers stopped!!")
		end
		imgui.SameLine()
		if (imgui.Button('Exit')) then
			AshitaCore:GetChatManager():QueueCommand('/addon unload dyna_lot', 1);
		end
		imgui.SameLine()
		if (imgui.Button('ReLoad')) then
			AshitaCore:GetChatManager():QueueCommand('/addon reload dyna_lot', 1);
		end
		imgui.Separator();
		if (imgui.TreeNodeEx('Drops',ImGuiTreeNodeFlags_Framed)) then
			local p_count
			if (player == nil) then
				return;
			else
				for i = 0, 9, 1 do
					local p_count 
					local drop_item = AshitaCore:GetDataManager():GetInventory():GetTreasureItem(i)
					if(drop_item ~= nil) then
						local item = GetItem(drop_item.ItemId)
						if(item ~=nil) then
							local item_job = Check_Job(item.ItemId)
							local item_slot = Get_Item_Slot(item.ItemId)
							if(item_job == nil) then
								--ColorText("White",string.format("[%i] %s",i,item.Name[0]))
							elseif(( item_slot == "Main") or ( item_slot == "Sub") or ( item_slot == "Range")) then
								--ColorText("White",string.format("[%i] %s",i,item.Name[0]))
							else					
							if(imgui.BeginMenu(string.format("[%i] %s",i,item.Name[0]))) then
								if(imgui.Button(string.format("%s 75",item_job)))then
									cmd = string.format("%s - %s 75 can Lot",item.Name[0],item_job)
									Dyna_Announce(cmd)
									cmd = string.format('/timers add 30s "%s 75"',item_job)
									AshitaCore:GetChatManager():QueueCommand(cmd,1)
								end
								if(imgui.Button(string.format("%s 70",item_job)))then
									cmd = string.format("%s - %s 70 can Lot",item.Name[0],item_job)
									Dyna_Announce(cmd)
									cmd = string.format('/timers add 30s "%s 70"',item_job)
									AshitaCore:GetChatManager():QueueCommand(cmd,1)
								end
								if(imgui.Button(string.format("%s 65",item_job)))then
									cmd = string.format("%s - %s 65 can Lot",item.Name[0],item_job)
									Dyna_Announce(cmd)
									cmd = string.format('/timers add 30s "%s 65"',item_job)
									AshitaCore:GetChatManager():QueueCommand(cmd,1)
								end
								if(imgui.Button(string.format("%s Free",item_job)))then
									cmd = string.format("%s - %s Free Lot",item.Name[0],item_job)
									Dyna_Announce(cmd)
								end
								if(Active_Timers[i]==true)then
									if(imgui.Button("Stop Timer"))then
									Active_Timers[i]=false
									end
								end
								if(drop_item.WinningLot ~= 0) then
									local text = string.format("%s is winning with: %i",drop_item.WinningLotterName,drop_item.WinningLot)
								end
								imgui.EndMenu()
							end
							imgui.Separator();
							end
						end
					end
				end	
				imgui.TreePop();
			end
		end
	imgui.End();
	else
	imgui.End();
	end
	
	--Options Window
	if(config.show_options == true) then
		if ((imgui.Begin('Options',1,imgui.bor(32)))) then
			if(imgui.Button("Close")) then
				config.show_options = false
			end
			imgui.Separator();
			if(imgui.Checkbox('Use Timers Addon', options['use_timers'][1]))then
				config.use_timers = imgui.GetVarValue(options['use_timers'][1])
				if(config.use_timers == true)then
					lprint(chat.success("Will Use Timers Addon"))
				else
					lprint(chat.critical("Will Not Use Timers Addon"))
				end
			end
			if(imgui.Checkbox('Time Extension', options['var_time_ext'][1]))then
				config.say_te = imgui.GetVarValue(options['var_time_ext'][1])
				if(config.say_te == true)then
					lprint(chat.success("Will Auto Announce Time-extension"))
				else
				lprint(chat.critical("Will Not Auto Announce Time-extension"))
				end
			end
			if (imgui.IsItemHovered()) then
				imgui.SetTooltip('Will set Announce of Time Extensions');
			end
			if(imgui.Checkbox('Hundo Announce', options['var_hundo'][1])) then
				config.say_hundo = Get_Option('var_hundo')
				if(config.say_hundo == true)then
					lprint(chat.success("Will Auto Announce Hundo Drops"))
				else
					lprint(chat.critical("Will Not Auto Announce Hundo Drops"))
				end
			end
			imgui.Separator();

			if (imgui.IsItemHovered()) then
				imgui.SetTooltip('Will set Announce of Hundo Drops');
			end
			if(imgui.Checkbox('Outside Party', options['var_outsideparty'][1])) then
				config.outside_party = Get_Option('var_outsideparty')
				if(config.outside_party == true)then
					lprint(chat.success("Will Send All Auto Announcements to /p and /sh"))
				else
					lprint(chat.critical("Will Send All Auto Announcements to /p"))
				end
			end
			if(imgui.Checkbox('Inside Party', options['var_insideparty'][1])) then
				config.inside_party = Get_Option('var_insideparty')
				if(config.inside_party == true)then
					lprint(chat.success("Will Send Auto Announcements to /p"))
				else
					lprint(chat.critical("Will Not Send Auto Announcements to /p"))
				end
			end
			if(imgui.Checkbox('Linkshell Announce', options['var_ls'][1])) then
				config.inside_party = Get_Option('var_ls')
				if(config.inside_party == true)then
					lprint(chat.success("Will Send Auto Announcements to /linkshell"))
				else
					lprint(chat.critical("Will Not Send Auto Announcements to /linkshell"))
				end
			end
			if(imgui.Checkbox('Linkshell2 Announce', options['var_ls2'][1])) then
				config.inside_party = Get_Option('var_ls2')
				if(config.inside_party == true)then
					lprint(chat.success("Will Send Auto Announcements to /linkshell2"))
				else
					lprint(chat.critical("Will Not Send Auto Announcements to /linkshell2"))
				end
			end
			
			imgui.End();
		else
			imgui.End();
		end
	end

	
end);




ashita.register_event('unload', function()
	-- Update the configuration position..
	config.discord = imgui.GetVarValue(options['var_discord'][1])
	config.say_hundo = imgui.GetVarValue(options['var_hundo'][1])
	config.outside_party = imgui.GetVarValue(options['var_outsideparty'][1])
	config.inside_party = imgui.GetVarValue(options['var_insideparty'][1])
	config.say_te = imgui.GetVarValue(options['var_time_ext'][1])
    config.currency = Get_Option('var_currency')
	config.linkshell = Get_Option('var_ls')
	config.linkshell2 = Get_Option('var_ls2')

	default_settings.export = Get_Option('var_export')
    -- Save the configuration file..
    ashita.settings.save(_addon.path .. '/settings/dyna_lot.json', config);
end);