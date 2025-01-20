require 'common'
require 'timer'	
require("stringex")

local os = require('os');

packer_index = {
}

GetString = {
}

EquipmentSlots = {Main = 0,Sub = 1,Range = 2,Ammo = 3,Head = 4,Body = 5,Hands = 6,Legs = 7,Feet = 8,Neck = 9,Waist = 10,Ear1 = 11,Ear2 = 12,Ring1 = 13,Ring2 = 14,Back = 15,};
Packet_Types = {
    --Packet Data Types
    unsigned_short  = 'H',
    unsigned_int    = 'I',
    unsigned_long   = 'L',
    signed_char     = 'c',
    signed_short    = 'h',
    signed_int      = 'i',
    signed_long     = 'L',
    char            = 'c',
    short           = 'h',
    int             = 'i',
    long            = 'l',
    float           = 'f',
    double          = 'd',
    data            = 'A'

}

Skills = 
{
    [0] = "(N/A)",
    [1] = "Hand-to-Hand",
    [2] = "Dagger",
    [3] = "Sword",
    [4] = "Great Sword",
    [5] = "Axe",
    [6] = "Great Axe",
    [7] = "Scythe",
    [8] = "Polearm",
    [9] = "Katana",
    [10] = "Great Katana",
    [11] = "Club",[12] = "Staff",[22] = "Automaton Melee",[23] = "Automaton Archery",[24] = "Automaton Magic",[25] = "Archery",[26] = "Marksmanship",[27] = "Throwing",[28] = "Guard",[29] = "Evasion",[30] = "Shield",[31] = "Parrying",[32] = "Divine Magic",[33] = "Healing Magic",[34] = "Enhancing Magic",[35] = "Enfeebling Magic",[36] = "Elemental Magic",[37] = "Dark Magic",[38] = "Summoning Magic",[39] = "Ninjutsu",[40] = "Singing",[41] = "Stringed Instrument",[42] = "Wind Instrument",[43] = "Blue Magic",    [44] = "Geomancy",[45] = "Handbell",[48] = "Fishing",[49] = "Woodworking",[50] = "Smithing",[51] = "Goldsmithing",[52] = "Clothcraft",[53] = "Leathercraft",[54] = "Bonecraft",[55] = "Alchemy",[56] = "Cooking",[57] = "Synergy"}   

Jobs_Full =
{
    [0] = "none",
    [1] = "Warrior",
    [2] = "Monk",
    [3] = "White Mage",
    [4] = "Black Mage",
    [5] = "Red Mage",
    [6] = "Thief",
    [7] = "Paladin",
    [8] = "Dark Knight",
    [9] = "Beastmaster",
    [10] = "Bard",
    [11] = "Ranger",
    [12] = "Samurai",
    [13] = "Ninja",
    [14] = "Dragoon",
    [15] = "Summoner",
    [16] = "Blue Mage",
    [17] = "Corsair",
    [18] = "Puppetmaster"
};

JobMask =  {
    WAR = 1,--
    MNK = 2,--
    WHM = 3,--
    BLM = 4,--
    RDM = 5,--
    THF = 6,--
    PLD = 7,--
    DRK = 8,--
    BST = 9,--
    BRD = 10, --
    RNG = 11,--
    SAM = 12,--
    NIN = 13,--
    DRG = 14,--
    SMN = 15,--
    BLU = 16,--
    COR = 17,--
    PUP = 18
	};

Item_Timers = {}

Test_Items = {
    11469,15074,15075,15076,15077,15078,15079,15080,15081,15082,15083,15084,
    15085,15086,15087,15088,15089,15090,15091,15092,15093,15094,15095,15096,15097,
    15098,15099,15100,15101,15102,15103,15104,15105,15106,15107,15108,15109,15110,
    15111,15112,15113,15114,15115,15116,15117,15118,15119,15120,15121,15122,15123,
    15124,15125,15126,15127,15128,15129,15130,15131,15132,15133,15134,15135,15136,
    15137,15138,15139,15140,15141,15142,15143,15144,15145,15146,15147,15479
}
--749,750,1450,1451,1452,1453,1455,1456,1457,1465,1467,1470,1517,1518,1519,1520,1521,



Lot_Order = {
    [0] = "70+",
    [1] = "65+",
    [2] = "Free"
}
local Timer_loops = {
    0,0,0,0,0,0,0,0,0,0
}

function MaskToFull(Job)
    for key, value in pairs(JobMask) do
        if(key == Job) then
            return Jobs_Full[value]
        end
    end
end

function Check_Dyna_Drop(item)
    
    if (item == 1450 or item == 1456 or item == 1453) then
        return false
    else
        for index, value in ipairs(Dyna_Items) do
            if(item == value) then
                if(CheckNeg_Job(value) == nil) then
                    local c_item = GetItem(item)
                    local c_jobs = CheckItem_Job(c_item.Jobs)
                end
            end
        end
    end
    
end
TreasurePool = {
    {

    }
}

function CountTreasurePool()
	
    local Count = 0
	if (debug == true) then --For Debug Insert Testing Data
		for i = 0, 9, 1 do
			if(Test_Table[i]~= nil) then
        		local test_item = Test_Table[i]
        		if(test_item.ItemId ~= 0) then
                    local loot_name = GetItem(test_item.ItemId)
                    --print(string.format("[%i] - %s",i,loot_name.Name[0]))
                    Count=Count +1
                end 
            end
		end
	else
        for i = 0, 9, 1 do --Non Debug
			if(GetTreasure(i)~= nil) then
                local test_item = GetTreasure(i)
                if(test_item.ItemId ~= 0) then
                    local loot_name = GetItem(test_item.ItemId)
                    --print(string.format("[%i] - %s",i,loot_name.Name[0]))
                    Count=Count +1
                end
            end
		end
	end
    return Count
	
end
----------------------------------------------------------------------------------------------------
-- func: EntityName(id)
-- desc: Get Name of Entity by id
----------------------------------------------------------------------------------------------------
function GetEntityName(id)
    return AshitaCore:GetDataManager():GetEntity():GetName(id)  
end


function Get_Area()
    local area = AshitaCore:GetResourceManager():GetString("areas",AshitaCore:GetDataManager():GetParty():GetMemberZone(0))
	return area
end

function Time_stamp(msg)
    local timestamp = os.date(string.format('[%s]', config.format));
    
    return string.format("%s %s",timestamp,msg)
end

function New_Log()
    
end

function WriteToLog(msg)
    local area = AshitaCore:GetResourceManager():GetString("areas",AshitaCore:GetDataManager():GetParty():GetMemberZone(0))
	local date = string.gsub((os.date("%x")),"/","-")
    local data_dir = _addon.path .. '/data/'
	data_file = io.open(string.format("%s%s-%s.txt",data_dir,area,date),"a+")
	io.output(data_file)
	io.write(Time_stamp(msg .. "\n"))
	io.close(data_file)
end
----------------------------------------------------------------------------------------------------
-- func: GetTreasure(index)
-- desc: Get Item from TreasurePool by Index (starts at 0)
----------------------------------------------------------------------------------------------------
function GetTreasure(index)
    return AshitaCore:GetDataManager():GetInventory():GetTreasureItem(index)
end


----------------------------------------------------------------------------------------------------
-- func: GetItem(id)
-- desc: Get Item Resource by id
----------------------------------------------------------------------------------------------------
function GetItem(id)
	return AshitaCore:GetResourceManager():GetItemById(id)
end




----------------------------------------------------------------------------------------------------
-- func: DropTest
-- desc: Create Random Item to for testing
----------------------------------------------------------------------------------------------------
function DropTest()
	local randomIndex = math.random(1,#Test_Items)
	local randomElement = Test_Items[randomIndex]
	--local testitem = GetItem(randomElement)
	--print(testitem)
	return randomElement
end



function DropTest_Equip()
	item = DropTest()
    print("Got item")
    if(CheckItem_Job(item))then
        print("Not Relic")
        DropTest_Equip()
    else
        print('Got Relic')
        return item
    end
    
end


function Populate_treasure_pool()
    print("Items Updated")
    for i = 0, 9, 1 do
        if(GetTreasure(i)~=nil)then
            table.insert(Track_items,i,GetTreasure(i))
        end
    end
end

function Add_TreasurePool(...)
    local options = {...}
    local Name = options.Name
    local ItemId = options.ItemId
    local Job = options.Job or nil
    local Flags = options.Flags or false
    local WinningLot = options.WinningLot or 0
    local WinningLotterName = options.WinningLotterName or nil
    local DropTime = options.DropTime or 0
    local Index = options.Index or nil
    local size = 0
    for key, value in pairs(TreasurePool) do
        size = size+1
    end
    table.insert( TreasurePool, size,
    {
        Name = Name,
        ItemId = ItemId,
        Index = Index,
        Job = Job,
        Flags = Flags,
        WinningLot = WinningLot,
        WinningLotterName = WinningLotterName,
        DropTime = DropTime
    })
end


----------------------------------------------------------------------------------------------------
-- func: GetItemById(ItemId)
-- desc: Get Item data by Item ID
----------------------------------------------------------------------------------------------------
function GetItemById(GetId)
	return AshitaCore:GetResourceManager():GetItemById(GetId)
end


----------------------------------------------------------------------------------------------------
-- func: SendChat(msg)
-- desc: Send Command to Game
----------------------------------------------------------------------------------------------------
function SendChat(msg)
	AshitaCore:GetChatManager():QueueCommand(msg, 1);
end


----------------------------------------------------------------------------------------------------
-- func: CheckItem_Equip(item by ID)
-- desc: Check That Item can be Equiped
----------------------------------------------------------------------------------------------------
function CheckItem_Equip(item) -- Checks Item by ID if it can be equiped
	local item = AshitaCore:GetResourceManager():GetItemById(item)
    
    if(item==nil)then
        return false
    else
        return true
    end
    --[[if (bit.band(item.Flags, 0x800) == 0) then
        print("here2")
        return false
    else
        return true
    end]]--
end

function Get_Item_Slot(Id)
    local r_slot = nil
    
    local item = GetItem(Id)
    --lprint(item.Name[0])
    if(item==nil)then
        return nil
    end
    if(string.endswith(item.Name[0],"-1"))then
        n_item = string.gsub(item.LogNameSingular[0],"-1","")
        n_item = string.trimend(n_item)
        lprint(n_item)
        --Smn Item causes error
        item = AshitaCore:GetResourceManager():GetItemByName(n_item,0)
        --lprint(item.Name[0])
        local slot = item.Slots
        if(slot)then
            for key, value in pairs(EquipmentSlots) do --Check what jobs can use item
                if(bit.band(slot, math.pow(2,value))>0)	then  --
                    r_slot = key
                end
            end
        end
    else
        if(CheckItem_Equip(item.ItemId)==true)then
            local item = GetItem(item.ItemId)
            local slot = item.Slots
            for key, value in pairs(EquipmentSlots) do --Check what jobs can use item
                if(bit.band(slot, math.pow(2,value))>0)	then  --
                    r_slot = key
                end
            end
        else
            r_slot = nil
        end
    end
    return r_slot
end

----------------------------------------------------------------------------------------------------
-- func: CheckItem_Job(item by ID)
-- desc: Check What Jobs can use <item>
-- If Debug add test item
----------------------------------------------------------------------------------------------------

function CheckItem_Job(ItemId)
    local item = GetItem(ItemId)
    if(item == nil)then
        return nil
    end
    local Jobs_Bit = item.Jobs
    if(Jobs_Bit == 0 or Jobs_Bit ==nil) then
        local neg_job = CheckNeg_Job(ItemId)
        return neg_job
    else
        for key, value in pairs(JobMask) do --Check what jobs can use item
            if(bit.band(Jobs_Bit, math.pow(2,value))>0)	then  --
                return key
            end
        end
    end
end

function Check_Job(ItemId)
    local item = GetItem(ItemId)
    
    if(item == nil) then
        return nil
    else
        if(string.endswith(item.Name[0],"-1"))then
            
            n_item = string.gsub(item.LogNameSingular[0],"-1","")
            n_item = string.trimend(n_item)
            
            item = AshitaCore:GetResourceManager():GetItemByName(n_item,0)
		end
        --lprint(item.Name[0])
        if(item~=nil)then

            local Job_Bits = item.Jobs
                if((Job_Bits ~= 0) or (Job_Bits ~= nil))then
                    for key,value in pairs(JobMask) do 
                        if(bit.band(Job_Bits,math.pow(2,value))>0) then
                            return key
                        end
                    end
                end
        end
    end
end

function Announce_linkshell(msg)
    local out = string.format("/linkshell %s",msg)
    
    ashita.timer.once(5,function ()
        AshitaCore:GetChatManager():QueueCommand(out, 1);
    end)
end

function Announce_linkshell2(msg)
    local out = string.format("/linkshell2 %s",msg)
    
    ashita.timer.once(4,function ()
        AshitaCore:GetChatManager():QueueCommand(out, 1);
    end)
end

function Announce_outside(msg)
    local out = string.format("/sh %s",msg)
    
    ashita.timer.once(4,function ()
        AshitaCore:GetChatManager():QueueCommand(out, 1);
    end)
end

function Announce_inside(msg)
    local out = string.format("/p %s",msg)
    
    ashita.timer.once(2,function ()
        AshitaCore:GetChatManager():QueueCommand(out, 1);
    end)
end

function Dyna_Announce(msg)
    local mode = nil


    
    ashita.timer.once(1,function ()

    if(config.linkshell == true) then
        Announce_linkshell(msg)
    end
    if(config.linkshell2 == true) then
        Announce_linkshell2(msg)
    end
    if(config.outside_party == true) then
        Announce_outside(msg)
    end
    if(config.inside_party == true) then
        Announce_inside(msg)
    end
    end)

    
    
    --[[if(config.outside_party == true) then
        mode = 'both'
    else
        mode = 'p'
    end
    
    if(mode == 'p') then
        AshitaCore:GetChatManager():QueueCommand(p_msg, 1);
    elseif (mode == 'sh') then
        AshitaCore:GetChatManager():QueueCommand(sh_msg, 1);
    elseif (mode == 'both') then
        AshitaCore:GetChatManager():QueueCommand(p_msg, 1);
        ashita.timer.once(3,function ()
        AshitaCore:GetChatManager():QueueCommand(sh_msg, 1);
        end);
        
    end
    ]]--
end



----------------------------------------------------------------------------------------------------
-- func: ColorText(color,text)
-- desc: imgui helper for Colored Text.
----------------------------------------------------------------------------------------------------
function ColorText(color,Text)
    if(color == 'Green') then
        imgui.TextColored(0, 1, 0, 1, Text);
        return;
    end
    if(color=='Red') then
        imgui.TextColored(1, 0, 0, 1, Text); 
        return;
    end
    if(color=="Blue") then
        imgui.TextColored(0.156, 0.907, 0.920, 1, Text);    
        return;
    end
    if(color=="Yellow") then
        imgui.TextColored(0.869,0.920,0.156, 1, Text);    
        return;
    end
    if(color=="White") then
        imgui.TextColored(1, 1, 1, 1, Text);    
        return;
    end
    if(color=="Purple") then
        imgui.TextColored(0.920, 0.156, 0.831, 1, Text);    
        return;
    end
end

function HowLongAgo(color,date)
    local msg = "";
    local now = os.time();
    local past = date;
    local diff = now - past;
    local dTime = 86400;
    local hTime = 3600;
    local days = math.floor(diff / dTime );
    local hours = math.floor((diff - days * dTime) / hTime);
    local minutes = math.floor((diff - days * (dTime) - hours * (hTime)) / 60);



    
    if(days>0) then
        if days>1 then
        msg = days .. ' days ,';
        else
        msg = days .. ' day ,';
        end
    end
    if(hours>0) then
        if hours>1 then
        msg = msg .. hours .. ' hours ,'
        else
        msg = msg .. hours .. ' hour ,'
        end
    end

    if minutes then
        msg = msg .. minutes .. ' minutes';
    end
    ColorText(color,(msg .. ' ago'));
end

----------------------------------------------------------------------------------------------------
-- func: DrawTreasurePool
-- desc: Used to populate the Treasure Pool
----------------------------------------------------------------------------------------------------
function DrawTreasurePool()
    local player = GetPlayerEntity();
    
    local Treasure_time
    local Treasure_index
    local Treasure_item
    local Treasure_Job 
    local count = 0

    if (player == nil) then
        return;
    end
    for key, value in pairs(TreasurePool) do
        count = count +1
        
    end
    if(count == 1 and TreasurePool[0] == nil) then
        ColorText("Red","No Item")
        return;
    else
        print("Pool Count = ".. count)
    end
    
    for key, value in pairs(TreasurePool) do
        if (imgui.TreeNodeEx(count,ImGuiTreeNodeFlags_Bullet)) then
            if(TreasurePool[count].Name[0])then
                msg = string.format("%s - %s",TreasurePool[count].WinningLotterName,TreasurePool[count].WinningLot)   
                ColorText("Yellow",TreasurePool[count].WinningLot)
            end
        end
        imgui.TreePop()  
        Treasure_count = Treasure_count + 1
    end
end --End Function

----------------------------------------------------------------------------------------------------
-- func: CheckNeg_Job(ItemID)
-- desc: Check -1 Dyna Items for Jobs. They are not equiped so Item.Jobs doesnt work.
----------------------------------------------------------------------------------------------------
function CheckNeg_Job(ItemId)
    if(ItemId == 2033 or ItemId == 2034 or ItemId == 2035 or ItemId == 2036 or ItemId == 2037) then
        return 'WAR'
    elseif (ItemId == 2038 or ItemId == 2039 or ItemId == 2040 or ItemId == 2041 or ItemId == 2042) then
        return 'MNK'
    elseif (ItemId == 2043 or ItemId == 2044 or ItemId == 2045 or ItemId == 2046 or ItemId == 2047) then
        return 'WHM'
    elseif (ItemId == 2048 or ItemId == 2049 or ItemId == 2050 or ItemId == 2051 or ItemId == 2052) then
        return 'BLM'
    elseif (ItemId == 2053 or ItemId == 2054 or ItemId == 2055 or ItemId == 2056 or ItemId == 2057) then
        return 'RDM'
    elseif (ItemId == 2058 or ItemId == 2059 or ItemId == 2060 or ItemId == 2061 or ItemId == 2062) then
        return 'THF'
    elseif (ItemId == 2063 or ItemId == 2064 or ItemId == 2065 or ItemId == 2066 or ItemId == 2067) then
        return 'PLD'
    elseif (ItemId == 2068 or ItemId == 2069 or ItemId == 2070 or ItemId == 2071 or ItemId == 2072) then
        return 'DRK'
    elseif (ItemId == 2073 or ItemId == 2074 or ItemId == 2075 or ItemId == 2076 or ItemId == 2077) then
        return 'BST'
    elseif (ItemId == 2078 or ItemId == 2079 or ItemId == 2080 or ItemId == 2081 or ItemId == 2082) then
        return 'BRD'
    elseif (ItemId == 2083 or ItemId == 2084 or ItemId == 2085 or ItemId == 2086 or ItemId == 2087) then
        return 'RNG'
    elseif (ItemId == 2088 or ItemId == 2089 or ItemId == 2090 or ItemId == 2091 or ItemId == 2092) then
        return 'SAM'
    elseif (ItemId == 2093 or ItemId == 2094 or ItemId == 2095 or ItemId == 2096 or ItemId == 2097) then
        return 'NIN'
    elseif (ItemId == 2098 or ItemId == 2099 or ItemId == 2100 or ItemId == 2101 or ItemId == 2102) then
        return 'DRG'
    elseif (ItemId == 2103 or ItemId == 2104 or ItemId == 2105 or ItemId == 2106 or ItemId == 2107) then
        return 'SMN'
    elseif (ItemId == 2667 or ItemId == 2668 or ItemId == 2669 or ItemId == 2670 or ItemId == 2671) then
        return 'COR'
    elseif (ItemId == 2672 or ItemId == 2673 or ItemId == 2674 or ItemId == 2675 or ItemId == 2676) then
        return 'PUP'
    else
        return nil
    end
end

char_to_hex = function(c)
    return string.format("%%%02X", string.byte(c))
end

function urlencode(url)
    if url == nil then
        return
    end
    url = url:gsub("\n", "\r\n")
    url = url:gsub("([^%w ])", char_to_hex)
    url = url:gsub(" ", "+")
    return url
end

hex_to_char = function(x)
    return string.char(tonumber(x, 16))
end

urldecode = function(url)
    if url == nil then
        return
    end
    url = url:gsub("+", " ")
    url = url:gsub("%%(%x%x)", hex_to_char)
    return url
end




--[[for i = 2033, 2101, 1 do
    print(string.format("%i,",i))
end]]--
--[[
war = 2033 -2037
mnk = 2038 -2042
whm 2043 - 2047
blm - 2048 -2052
rdm - 2053 -2057
thf = 2058 - 2062
pld = 2063 - 2067
drk =2068 - 2072
bst = 2073 - 2077
brd =2078- 2082
rng =2083 - 2087
sam =2088 - 2092
nin = 2093 - 2097
drg = 2098 - 2102
smn = 2103 - 2107
cor = 2667 -2671
pup = 2672 -2676
]]--

----------------------------------------------------------------------------------------------------
-- func: Ashita Render Function
-- desc: Check -1 Dyna Items for Jobs. They are not equiped so Item.Jobs doesnt work.
----------------------------------------------------------------------------------------------------
function dyna_lot_unload()
    -- Update the configuration position..
    config.version = config.version + .01

    -- Save the configuration file..
    print(string.format("Auto-Version Update: %.2f",config.version))
    ashita.settings.save(_addon.path .. '/settings/dyna_lot.json', config);

    -- Delete the font object..
end

function dyna_lot_load()
    AshitaCore:GetChatManager():QueueCommand('/addon load timers', 1);
	if (debug==true) then
		T_Debug()
	end
end

function dyna_lot_commands(command,ntype)
    count=0;
    local args = command:args();
    if(args[1] == nil) then
        return false;
    end;
    local cmd = args[1];
    cmd = cmd:lower();
    
	Jobs_Cmd(cmd)
	if(cmd == '/lmsg')then
		msg = table.concat( args, " ", 2, #args )
		msg = string.format("/lsmes set %s | %s",msg,discord_msg)
		AshitaCore:GetChatManager():QueueCommand(msg, 1);
		--[[for key, value in pairs(args) do
			print(value)
		end]]--
		return false
	end
	if(cmd=='/debug')then
		if(debug == false) then
			debug = true
			T_Debug()
			print("Debug Enabled")
			return
		elseif (debug== true) then
			debug = false
			print("Debug Disabled")
			return
		end
	return false
	end
	if(cmd=='/lot')then
		print("test")
		temp = T_Debug()
		return true
	else
	return false
	end
end
function Get_Option(var)
    return imgui.GetVarValue(options[var][1])
end

function Set_Option(var,value)
    imgui.SetVarValue(options[var][1],value)
end

function ShowOptions()
    if(imgui.BeginChild("Options")) then
    end
    imgui.EndChild()
end