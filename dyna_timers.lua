require("functions")
Timer_loops = {
    0,0,0,0,0,0,0,0,0,0
}
Active_Timers = {
    false,false,false,false,false,false,false,false,false,false,
}



dyna_timers = {}



function Start_Timer_0 ()
    Timer_loops[0] = 0
    local timer_name = "timer_0"
    print(string.format("Timer:%i [Started]",0))
        ashita.timer.create(timer_name,30,3,function ()
            local treasure_item = AshitaCore:GetDataManager():GetInventory():GetTreasureItem(0)
            local lotter = treasure_item.WinningLotterName
            local game_item = AshitaCore:GetResourceManager():GetItemById(treasure_item.ItemId)
            local item = {
                Name = game_item.Name[0],
                ItemId = game_item.ItemId,
            Job =  CheckItem_Job(treasure_item.ItemId),
                slot = Get_Item_Slot(treasure_item.ItemId),
                lotter = treasure_item.WinningLotterName
            }
            msg = string.format("Item:%s Job:%s Slot:%s User:%s",item.Name,item.Job,item.slot,item.lotter)
            --print(msg)
            --print(string.len(item.lotter))
            
            if(string.len(lotter) == 0)then
                
                if(Timer_loops[0] ~= 2)then
                    t_msg =  string.format("%s [%s] - %s %s can Lot<call20>",item.Name, item.slot,item.Job,Lot_Order[Timer_loops[0]])
                    Dyna_Announce(t_msg)
                    Timer_loops[0] = Timer_loops[0] + 1
                elseif (Timer_loops[0] == 2) then
                    t_msg = string.format("%s [%s] - %s Free Lot<call20>",item.Name, item.slot,item.Job)
                    Dyna_Announce(t_msg)
                else
                    --print(string.format("Timer:%s [Removed]",timer_name))
                    ashita.timer.remove_timer(timer_name)
                    Active_Timers[0]=false
                    Active_Timers[0]=false
                end
            else
                --print(string.format("Timer:%s [Removed]",timer_name))
                ashita.timer.remove_timer(timer_name)
                Active_Timers[0]=false
                Active_Timers[0]=false
            end
        end);
end

------------------------------------------------------------------------------------------------------------------------
function Start_Timer_1 ()
    Timer_loops[1] = 0
    local timer_name = "timer_1"
    print(string.format("Timer:%i [Started]",1))
        ashita.timer.create(timer_name,30,3,function ()
            local treasure_item = AshitaCore:GetDataManager():GetInventory():GetTreasureItem(1)
            local lotter = treasure_item.WinningLotterName
            local game_item = AshitaCore:GetResourceManager():GetItemById(treasure_item.ItemId)
            local item = {
                Name = game_item.Name[0],
                ItemId = game_item.ItemId,
                Job =  CheckItem_Job(treasure_item.ItemId),
                slot = Get_Item_Slot(treasure_item.ItemId),
                lotter = treasure_item.WinningLotterName
            }
            msg = string.format("Item:%s Job:%s Slot:%s User:%s",item.Name,item.Job,item.slot,item.lotter)
            --print(msg)
            --print(string.len(item.lotter))
            
            if(string.len(lotter) == 0)then
                if(Timer_loops[1] ~= 2)then
                    t_msg =  string.format("%s [%s] - %s %s can Lot<call20>",item.Name, item.slot,item.Job,Lot_Order[Timer_loops[1]])
                    Dyna_Announce(t_msg)
                    Timer_loops[1] = Timer_loops[1] + 1
                elseif (Timer_loops[1] == 2) then
                    t_msg = string.format("%s [%s] - %s Free Lot<call20>",item.Name, item.slot,item.Job)
                    Dyna_Announce(t_msg)
                else
                    --print(string.format("Timer:%s [Removed]",timer_name))
                    ashita.timer.remove_timer(timer_name)
                    Active_Timers[1]=false
                end
            else
                --print(string.format("Timer:%s [Removed]",timer_name))
                ashita.timer.remove_timer(timer_name)
                Active_Timers[1]=false
            end
        end);
    end

------------------------------------------------------------------------------------------------------------------------
function Start_Timer_2 ()
    Timer_loops[2] = 0
    local timer_name = "timer_2"
    print(string.format("Timer:%i [Started]",2))
        ashita.timer.create(timer_name,30,3,function ()
            local treasure_item = AshitaCore:GetDataManager():GetInventory():GetTreasureItem(2)
            local lotter = treasure_item.WinningLotterName
            local game_item = AshitaCore:GetResourceManager():GetItemById(treasure_item.ItemId)
            local item = {
                Name = game_item.Name[0],
                ItemId = game_item.ItemId,
                Job =  CheckItem_Job(treasure_item.ItemId),
                slot = Get_Item_Slot(treasure_item.ItemId),
                lotter = treasure_item.WinningLotterName
            }
            msg = string.format("Item:%s Job:%s Slot:%s User:%s",item.Name,item.Job,item.slot,item.lotter)
            --print(msg)
            --print(string.len(item.lotter))
            
            if(string.len(lotter) == 0)then
                if(Timer_loops[2] ~= 2)then
                    t_msg =  string.format("%s [%s] - %s %s can Lot<call20>",item.Name, item.slot,item.Job,Lot_Order[Timer_loops[2]])
                    Dyna_Announce(t_msg)
                    Timer_loops[2] = Timer_loops[2] + 1
                elseif (Timer_loops[2] == 2) then
                    t_msg = string.format("%s [%s] - %s Free Lot<call20>",item.Name, item.slot,item.Job)
                    Dyna_Announce(t_msg)
                else
                    --print(string.format("Timer:%s [Removed]",timer_name))
                    ashita.timer.remove_timer(timer_name)
                    Active_Timers[2]=false
                end
            else
                --print(string.format("Timer:%s [Removed]",timer_name))
                ashita.timer.remove_timer(timer_name)
                Active_Timers[2]=false
            end
        end);
    end

------------------------------------------------------------------------------------------------------------------------
function Start_Timer_3 ()
    Timer_loops[3] = 0
    local timer_name = "timer_3"
    print(string.format("Timer:%i [Started]",3))
        ashita.timer.create(timer_name,30,3,function ()
            local treasure_item = AshitaCore:GetDataManager():GetInventory():GetTreasureItem(3)
            local lotter = treasure_item.WinningLotterName
            local game_item = AshitaCore:GetResourceManager():GetItemById(treasure_item.ItemId)
            local item = {
                Name = game_item.Name[0],
                ItemId = game_item.ItemId,
                Job =  CheckItem_Job(treasure_item.ItemId),
                slot = Get_Item_Slot(treasure_item.ItemId),
                lotter = treasure_item.WinningLotterName
            }
            msg = string.format("Item:%s Job:%s Slot:%s User:%s",item.Name,item.Job,item.slot,item.lotter)
            --print(msg)
            --print(string.len(item.lotter))
            
            if(string.len(lotter) == 0)then
                if(Timer_loops[3] ~= 2)then
                    t_msg =  string.format("%s [%s] - %s %s can Lot<call20>",item.Name, item.slot,item.Job,Lot_Order[Timer_loops[3]])
                    Dyna_Announce(t_msg)
                    Timer_loops[3] = Timer_loops[3] + 1
                elseif (Timer_loops[3] == 2) then
                    t_msg = string.format("%s [%s] - %s Free Lot<call20>",item.Name, item.slot,item.Job)
                    Dyna_Announce(t_msg)
                else
                    --print(string.format("Timer:%s [Removed]",timer_name))
                    ashita.timer.remove_timer(timer_name)
                    Active_Timers[3]=false
                end
            else
                --print(string.format("Timer:%s [Removed]",timer_name))
                ashita.timer.remove_timer(timer_name)
                Active_Timers[3]=false
            end
        end);
    end

------------------------------------------------------------------------------------------------------------------------
function Start_Timer_4 ()
    Timer_loops[4] = 0
    local timer_name = "timer_4"
    print(string.format("Timer:%i [Started]",4))
        ashita.timer.create(timer_name,30,3,function ()
            local treasure_item = AshitaCore:GetDataManager():GetInventory():GetTreasureItem(4)
            local lotter = treasure_item.WinningLotterName
            local game_item = AshitaCore:GetResourceManager():GetItemById(treasure_item.ItemId)
            local item = {
                Name = game_item.Name[0],
                ItemId = game_item.ItemId,
                Job =  CheckItem_Job(treasure_item.ItemId),
                slot = Get_Item_Slot(treasure_item.ItemId),
                lotter = treasure_item.WinningLotterName
            }
            msg = string.format("Item:%s Job:%s Slot:%s User:%s",item.Name,item.Job,item.slot,item.lotter)
            --print(msg)
            --print(string.len(item.lotter))
            
            if(string.len(lotter) == 0)then
                if(Timer_loops[4] ~= 2)then
                    t_msg =  string.format("%s [%s] - %s %s can Lot<call20>",item.Name, item.slot,item.Job,Lot_Order[Timer_loops[4]])
                    Dyna_Announce(t_msg)
                    Timer_loops[4] = Timer_loops[4] + 1
                elseif (Timer_loops[4] == 2) then
                    t_msg = string.format("%s [%s] - %s Free Lot<call20>",item.Name, item.slot,item.Job)
                    Dyna_Announce(t_msg)
                else
                    --print(string.format("Timer:%s [Removed]",timer_name))
                    ashita.timer.remove_timer(timer_name)
                    Active_Timers[4]=false
                end
            else
                --print(string.format("Timer:%s [Removed]",timer_name))
                ashita.timer.remove_timer(timer_name)
                Active_Timers[4]=false
            end
        end);
    end

------------------------------------------------------------------------------------------------------------------------
function Start_Timer_5 ()
    Timer_loops[5] = 0
    local timer_name = "timer_5"
    print(string.format("Timer:%i [Started]",5))
        ashita.timer.create(timer_name,30,3,function ()
            local treasure_item = AshitaCore:GetDataManager():GetInventory():GetTreasureItem(5)
            local lotter = treasure_item.WinningLotterName
            local game_item = AshitaCore:GetResourceManager():GetItemById(treasure_item.ItemId)
            local item = {
                Name = game_item.Name[0],
                ItemId = game_item.ItemId,
                Job =  CheckItem_Job(treasure_item.ItemId),
                slot = Get_Item_Slot(treasure_item.ItemId),
                lotter = treasure_item.WinningLotterName
            }
            msg = string.format("Item:%s Job:%s Slot:%s User:%s",item.Name,item.Job,item.slot,item.lotter)
            --print(msg)
            --print(string.len(item.lotter))
            
            if(string.len(lotter) == 0)then
                if(Timer_loops[5] ~= 2)then
                    t_msg =  string.format("%s [%s] - %s %s can Lot<call20>",item.Name, item.slot,item.Job,Lot_Order[Timer_loops[5]])
                    Dyna_Announce(t_msg)
                    Timer_loops[5] = Timer_loops[5] + 1
                elseif (Timer_loops[5] == 2) then
                    t_msg = string.format("%s [%s] - %s Free Lot<call20>",item.Name, item.slot,item.Job)
                    Dyna_Announce(t_msg)
                else
                    --print(string.format("Timer:%s [Removed]",timer_name))
                    ashita.timer.remove_timer(timer_name)
                    Active_Timers[5]=false
                end
            else
                --print(string.format("Timer:%s [Removed]",timer_name))
                ashita.timer.remove_timer(timer_name)
                Active_Timers[5]=false
            end
        end);
    end


------------------------------------------------------------------------------------------------------------------------
function Start_Timer_6 ()
    Timer_loops[6] = 0
    local timer_name = "timer_6"
    print(string.format("Timer:%i [Started]",6))
        ashita.timer.create(timer_name,30,3,function ()
            local treasure_item = AshitaCore:GetDataManager():GetInventory():GetTreasureItem(6)
            local lotter = treasure_item.WinningLotterName
            local game_item = AshitaCore:GetResourceManager():GetItemById(treasure_item.ItemId)
            local item = {
                Name = game_item.Name[0],
                ItemId = game_item.ItemId,
                Job =  CheckItem_Job(treasure_item.ItemId),
                slot = Get_Item_Slot(treasure_item.ItemId),
                lotter = treasure_item.WinningLotterName
            }
            msg = string.format("Item:%s Job:%s Slot:%s User:%s",item.Name,item.Job,item.slot,item.lotter)
            --print(msg)
            --print(string.len(item.lotter))
            
            if(string.len(lotter) == 0)then
                if(Timer_loops[6] ~= 2)then
                    t_msg =  string.format("%s [%s] - %s %s can Lot<call20>",item.Name, item.slot,item.Job,Lot_Order[Timer_loops[6]])
                    Dyna_Announce(t_msg)
                    Timer_loops[6] = Timer_loops[6] + 1
                elseif (Timer_loops[6] == 2) then
                    t_msg = string.format("%s [%s] - %s Free Lot<call20>",item.Name, item.slot,item.Job)
                    Dyna_Announce(t_msg)
                else
                    --print(string.format("Timer:%s [Removed]",timer_name))
                    ashita.timer.remove_timer(timer_name)
                    Active_Timers[6]=false
                end
            else
                --print(string.format("Timer:%s [Removed]",timer_name))
                ashita.timer.remove_timer(timer_name)
                Active_Timers[6]=false
            end
        end);
    end

------------------------------------------------------------------------------------------------------------------------
function Start_Timer_7 ()
    Timer_loops[7] = 0
    local timer_name = "timer_7"
    print(string.format("Timer:%i [Started]",7))
        ashita.timer.create(timer_name,30,3,function ()
            local treasure_item = AshitaCore:GetDataManager():GetInventory():GetTreasureItem(7)
            local lotter = treasure_item.WinningLotterName
            local game_item = AshitaCore:GetResourceManager():GetItemById(treasure_item.ItemId)
            local item = {
                Name = game_item.Name[0],
                ItemId = game_item.ItemId,
                Job =  CheckItem_Job(treasure_item.ItemId),
                slot = Get_Item_Slot(treasure_item.ItemId),
                lotter = treasure_item.WinningLotterName
            }
            msg = string.format("Item:%s Job:%s Slot:%s User:%s",item.Name,item.Job,item.slot,item.lotter)
            --print(msg)
            --print(string.len(item.lotter))
            
            if(string.len(lotter) == 0)then
                if(Timer_loops[7] ~= 2)then
                    t_msg =  string.format("%s [%s] - %s %s can Lot<call20>",item.Name, item.slot,item.Job,Lot_Order[Timer_loops[7]])
                    Dyna_Announce(t_msg)
                    Timer_loops[7] = Timer_loops[7] + 1
                elseif (Timer_loops[7] == 2) then
                    t_msg = string.format("%s [%s] - %s Free Lot<call20>",item.Name, item.slot,item.Job)
                    Dyna_Announce(t_msg)
                else
                    --print(string.format("Timer:%s [Removed]",timer_name))
                    ashita.timer.remove_timer(timer_name)
                    Active_Timers[7]=false
                end
            else
                --print(string.format("Timer:%s [Removed]",timer_name))
                ashita.timer.remove_timer(timer_name)
                Active_Timers[7]=false
            end
        end);
    end

------------------------------------------------------------------------------------------------------------------------
function Start_Timer_8 ()
    Timer_loops[8] = 0
    local timer_name = "timer_8"
    print(string.format("Timer:%i [Started]",8))
        ashita.timer.create(timer_name,30,3,function ()
            local treasure_item = AshitaCore:GetDataManager():GetInventory():GetTreasureItem(8)
            local lotter = treasure_item.WinningLotterName
            local game_item = AshitaCore:GetResourceManager():GetItemById(treasure_item.ItemId)
            local item = {
                Name = game_item.Name[0],
                ItemId = game_item.ItemId,
            Job =  CheckItem_Job(treasure_item.ItemId),
                slot = Get_Item_Slot(treasure_item.ItemId),
                lotter = treasure_item.WinningLotterName
            }
            msg = string.format("Item:%s Job:%s Slot:%s User:%s",item.Name,item.Job,item.slot,item.lotter)
            --print(msg)
            --print(string.len(item.lotter))
            
            if(string.len(lotter) == 0)then
                if(Timer_loops[8] ~= 2)then
                    t_msg =  string.format("%s [%s] - %s %s can Lot<call20>",item.Name, item.slot,item.Job,Lot_Order[Timer_loops[8]])
                    Dyna_Announce(t_msg)
                    Timer_loops[8] = Timer_loops[8] + 1
                elseif (Timer_loops[8] == 2) then
                    t_msg = string.format("%s [%s] - %s Free Lot<call20>",item.Name, item.slot,item.Job)
                    Dyna_Announce(t_msg)
                else
                    --print(string.format("Timer:%s [Removed]",timer_name))
                    ashita.timer.remove_timer(timer_name)
                    Active_Timers[8]=false
                end
            else
                --print(string.format("Timer:%s [Removed]",timer_name))
                ashita.timer.remove_timer(timer_name)
                Active_Timers[8]=false
            end
        end);
    end

------------------------------------------------------------------------------------------------------------------------
function Start_Timer_9 ()
    Timer_loops[9] = 0
    local timer_name = "timer_9"
    --print(string.format("Timer:%i [Started]",9))
        ashita.timer.create(timer_name,30,3,function ()
            local treasure_item = AshitaCore:GetDataManager():GetInventory():GetTreasureItem(9)
            local lotter = treasure_item.WinningLotterName
            local game_item = AshitaCore:GetResourceManager():GetItemById(treasure_item.ItemId)
            local item = {
                Name = game_item.Name[0],
                ItemId = game_item.ItemId,
                Job =  CheckItem_Job(treasure_item.ItemId),
                slot = Get_Item_Slot(treasure_item.ItemId),
                lotter = treasure_item.WinningLotterName
            }
            msg = string.format("Item:%s Job:%s Slot:%s User:%s",item.Name,item.Job,item.slot,item.lotter)
            --print(msg)
            --print(string.len(item.lotter))
            
            if(string.len(lotter) == 0)then
                if(Timer_loops[9] ~= 2)then
                    t_msg =  string.format("%s [%s] - %s %s can Lot<call20>",item.Name, item.slot,item.Job,Lot_Order[Timer_loops[9]])
                    Dyna_Announce(t_msg)
                    Timer_loops[9] = Timer_loops[9] + 1
                elseif (Timer_loops[9] == 2) then
                    t_msg = string.format("%s [%s] - %s Free Lot<call20>",item.Name, item.slot,item.Job)
                    Dyna_Announce(t_msg)
                else
                    --print(string.format("Timer:%s [Removed]",timer_name))
                    ashita.timer.remove_timer(timer_name)
                    Active_Timers[9]=false
                end
            else
                --print(string.format("Timer:%s [Removed]",timer_name))
                ashita.timer.remove_timer(timer_name)
                Active_Timers[9]=false
            end
        end);
    end

------------------------------------------------------------------------------------------------------------------------
function Start_Timer_10 ()
    Timer_loops[10] = 0
    local timer_name = "timer_10"
    print(string.format("Timer:%i [Started]",10))
        ashita.timer.create(timer_name,30,3,function ()
            local treasure_item = AshitaCore:GetDataManager():GetInventory():GetTreasureItem(1)
            local lotter = treasure_item.WinningLotterName
            local game_item = AshitaCore:GetResourceManager():GetItemById(treasure_item.ItemId)
            local item = {
                Name = game_item.Name[0],
                ItemId = game_item.ItemId,
            Job =  CheckItem_Job(treasure_item.ItemId),
                slot = Get_Item_Slot(treasure_item.ItemId),
                lotter = treasure_item.WinningLotterName
            }
            msg = string.format("Item:%s Job:%s Slot:%s User:%s",item.Name,item.Job,item.slot,item.lotter)
            --print(msg)
            --print(string.len(item.lotter))
            if(string.len(lotter) == 0)then
                if(Timer_loops[10] ~= 2)then
                    t_msg =  string.format("%s [%s] - %s %s can Lot<call20>",item.Name, item.slot,item.Job,Lot_Order[Timer_loops[10]])
                    Dyna_Announce(t_msg)
                    Timer_loops[10] = Timer_loops[10] + 1
                elseif (Timer_loops[10] == 2) then
                    t_msg = string.format("%s [%s] - %s Free Lot<call20>",item.Name, item.slot,item.Job)
                    Dyna_Announce(t_msg)
                else
                    --print(string.format("Timer:%s [Removed]",timer_name))
                    ashita.timer.remove_timer(timer_name)
                    Active_Timers[10]=false
                end
            else
                --print(string.format("Timer:%s [Removed]",timer_name))
                ashita.timer.remove_timer(timer_name)
                Active_Timers[10]=false
            end
        end);
end

dyna_timers.timer1 = Start_Timer_1
dyna_timers.timer2 = Start_Timer_2
dyna_timers.timer3 = Start_Timer_3
dyna_timers.timer4 = Start_Timer_4
dyna_timers.timer5 = Start_Timer_5
dyna_timers.timer6 = Start_Timer_6
dyna_timers.timer7 = Start_Timer_7
dyna_timers.timer8 = Start_Timer_8
dyna_timers.timer9 = Start_Timer_9
dyna_timers.timer0 = Start_Timer_0