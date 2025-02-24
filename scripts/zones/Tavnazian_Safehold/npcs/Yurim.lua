-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Yurim
-- !pos 83.697 -25.000 3.250 26
-----------------------------------
local entity = {}

-- base items
local earring = 13327
local obi     = 13205
local gorget  = 13080

-- chips
local red     = 474
local blue    = 475
local yellow  = 476
local green   = 477
local clear   = 478
local purple  = 479
local white   = 480
local black   = 481

-- organs
local lumin   = 1783
local phuabo  = 1784
local xzomit  = 1785
local aern    = 1786
local hpemde  = 1787
local yovra   = 1788
local euvhi   = 1818

local nosTrades =
{
    [14791] = { hint = 17, base = { earring, white }, organs = { { lumin,   5 }, { euvhi,  5 }                              } }, -- Sanative Earring
    [14792] = { hint = 17, base = { earring, black }, organs = { { lumin,   5 }, { euvhi,  5 }                              } }, -- Relaxing Earring

    [15435] = { hint =  1, base = { obi, red       }, organs = { { phuabo,  7 }, { xzomit, 3 }, { lumin,  3 }               } }, -- Karin Obi (Fire)
    [15436] = { hint =  2, base = { obi, clear     }, organs = { { xzomit,  7 }, { phuabo, 3 }, { lumin,  3 }               } }, -- Hyorin Obi (Ice)
    [15437] = { hint =  3, base = { obi, green     }, organs = { { aern,    7 }, { hpemde, 3 }, { lumin,  3 }               } }, -- Furin Obi (Wind)
    [15438] = { hint =  4, base = { obi, yellow    }, organs = { { hpemde,  7 }, { aern,   3 }, { lumin,  3 }               } }, -- Dorin Obi (Earth)
    [15439] = { hint =  5, base = { obi, purple    }, organs = { { phuabo,  7 }, { hpemde, 3 }, { lumin,  3 }               } }, -- Rairin Obi (Thunder)
    [15440] = { hint =  6, base = { obi, blue      }, organs = { { hpemde,  7 }, { phuabo, 3 }, { lumin,  3 }               } }, -- Suirin Obi (Water)
    [15441] = { hint =  7, base = { obi, white     }, organs = { { xzomit,  7 }, { aern,   3 }, { lumin,  3 }               } }, -- Korin Obi (Light)
    [15442] = { hint =  8, base = { obi, black     }, organs = { { aern,    7 }, { xzomit, 3 }, { lumin,  3 }               } }, -- Anrin Obi (Dark)

    [15495] = { hint =  9, base = { gorget, red    }, organs = { { phuabo, 10 }, { xzomit, 5 }, { yovra,  1 }               } }, -- Flame Gorget
    [15496] = { hint = 10, base = { gorget, clear  }, organs = { { phuabo, 10 }, { aern,   5 }, { yovra,  1 }               } }, -- Snow Gorget
    [15497] = { hint = 11, base = { gorget, green  }, organs = { { phuabo, 10 }, { hpemde, 5 }, { yovra,  1 }               } }, -- Breeze Gorget
    [15498] = { hint = 12, base = { gorget, yellow }, organs = { { xzomit, 10 }, { aern,   5 }, { yovra,  1 }               } }, -- Soil Gorget
    [15499] = { hint = 13, base = { gorget, purple }, organs = { { xzomit, 10 }, { hpemde, 5 }, { yovra,  1 }               } }, -- Thunder Gorget
    [15500] = { hint = 14, base = { gorget, blue   }, organs = { { aern,   10 }, { hpemde, 5 }, { yovra,  1 }               } }, -- Aqua Gorget
    [15501] = { hint = 15, base = { gorget, white  }, organs = { { aern,    7 }, { phuabo, 3 }, { hpemde, 3 }, { yovra, 2 } } }, -- Light Gorget
    [15502] = { hint = 16, base = { gorget, black  }, organs = { { hpemde,  7 }, { phuabo, 3 }, { aern,   3 }, { yovra, 2 } } }, -- Shadow Gorget
}

entity.onTrade = function(player, npc, trade)
    local nameOfScience  = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.IN_THE_NAME_OF_SCIENCE)
    local itemInProgress = player:getCharVar('NAME_OF_SCIENCE_target')

    if
        itemInProgress > 0 and
        npcUtil.tradeHas(trade, nosTrades[itemInProgress].organs)
    then
        player:startEvent(529, gorget, earring, obi)
    elseif
        (nameOfScience == xi.questStatus.QUEST_ACCEPTED or nameOfScience == xi.questStatus.QUEST_COMPLETED) and
        npcUtil.tradeHas(trade, xi.item.APPLE_PIE) and
        itemInProgress > 0
    then
        -- apple pie hint
        player:startEvent(531, 4413, 0, nosTrades[itemInProgress].hint)
    elseif
        (nameOfScience == xi.questStatus.QUEST_ACCEPTED or nameOfScience == xi.questStatus.QUEST_COMPLETED) and
        itemInProgress == 0
    then
        for k, v in pairs(nosTrades) do
            if npcUtil.tradeHas(trade, v.base) then
                player:setCharVar('NAME_OF_SCIENCE_target', k)
                player:startEvent(526, unpack(v.base))
                break
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    -- IN THE NAME OF SCIENCE
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH) then
        local nameOfScience  = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.IN_THE_NAME_OF_SCIENCE)
        local itemInProgress = player:getCharVar('NAME_OF_SCIENCE_target')

        if nameOfScience == xi.questStatus.QUEST_AVAILABLE then
            player:startEvent(524, obi, earring, gorget)
        elseif
            (nameOfScience == xi.questStatus.QUEST_ACCEPTED or nameOfScience == xi.questStatus.QUEST_COMPLETED) and
            itemInProgress == 0
        then
            player:startEvent(525, obi, earring, gorget)
        elseif
            nameOfScience == xi.questStatus.QUEST_ACCEPTED or
            nameOfScience == xi.questStatus.QUEST_COMPLETED
        then
            if math.random(1, 100) <= 30 then
                player:startEvent(532, unpack(nosTrades[itemInProgress].base))
            else
                player:startEvent(528, unpack(nosTrades[itemInProgress].base))
            end
        end

    -- STANDARD DIALOG
    -- TODO: This is not a true default action, and needs to be verified for when this begins to be displayed
    -- else
    --    player:startEvent(519)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 524 then
        player:addQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.IN_THE_NAME_OF_SCIENCE)
    elseif csid == 531 then
        player:confirmTrade()
    elseif csid == 526 then
        player:confirmTrade()
    elseif csid == 529 then
        local itemInProgress = player:getCharVar('NAME_OF_SCIENCE_target')
        if npcUtil.completeQuest(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.IN_THE_NAME_OF_SCIENCE, { item = itemInProgress, var = { 'NAME_OF_SCIENCE_target' } }) then
            player:confirmTrade()
        end
    end
end

return entity
