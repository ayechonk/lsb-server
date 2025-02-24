-----------------------------------
-- ID: 16154
-- Karura Hachigane
-- Pet mod via latent effect
-----------------------------------
local itemObject = {}
local listenerPrefix = 'PET_MOD_LATENT'
local latentPetId = xi.petId.GARUDA
local latentMods =
{
    { xi.mod.ATT, 10 },
    { xi.mod.DEF, 10 },
}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemEquip  = function(user, item)
    local listenerName = fmt('{}_{}', listenerPrefix, item:getID())
    xi.itemUtils.handlePetLatentMods(user, latentPetId, latentMods, true)

    user:addListener('MAGIC_STATE_EXIT', listenerName, function(player, spell)
        if spell:getSpellGroup() == xi.magic.spellGroup.SUMMONING then
            xi.itemUtils.handlePetLatentMods(user, latentPetId, latentMods, true)
        end
    end)
end

itemObject.onItemUnequip = function(user, item)
    local listenerName = fmt('{}_{}', listenerPrefix, item:getID())
    xi.itemUtils.handlePetLatentMods(user, latentPetId, latentMods, false)

    user:removeListener(listenerName)
end

return itemObject
