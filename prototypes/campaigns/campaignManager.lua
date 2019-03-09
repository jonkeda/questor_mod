require("prototypes.campaigns.itemQuests")
require("prototypes.gui.gui_setup")

campaignManager = {}

campaignManager.campaigns = {}

campaignManager.addCampaign = function(campaign)

    table.insert(campaignManager.campaigns, campaign)

end

campaignManager.checkDependencies = function(dependencies)
    if dependencies == nil then return true end

end

campaignManager.getReward_enable_technology = function(player, reward)
    -- Game.print_all("get reward technology "..reward.value)

    local force = player.force
    local technology = force.technologies[reward.value]
    if technology ~= nil then
        technology.enabled = true
    end
end


campaignManager.getReward_technology = function(player, reward)
    -- Game.print_all("get reward technology "..reward.value)

    local force = player.force
    local technology = force.technologies[reward.value]
    if technology ~= nil then
        technology.researched = true
    end
end

campaignManager.getReward_recipe = function(player, reward)
    --Game.print_all("get reward technology "..reward.value)

    local force = player.force
    local recipe = force.recipes[reward.value]
    if recipe ~= nil then
        recipe.enabled = true
    end
end

campaignManager.getReward_force = function(player, reward)
    local force = player.force
    local modifier = force[reward.value]
    if modifier ~= nil then
        force[reward.value] = modifier + reward.amount
    end
end

campaignManager.getReward_player = function(player, reward)
    local modifier = player[reward.value]
    if modifier ~= nil then
        player[reward.value] = modifier + reward.amount
    end
end

campaignManager.getReward_items = function(player, reward)
    -- Game.print_all("get reward items "..reward.value)

    local inv = player.get_inventory(defines.inventory.player_main)
    inv.insert({ name=reward.value, count=reward.amount })
end

campaignManager.getRewards = function(player, quest)
    local rewards = quest.rewards
    if rewards ~= nil then
        for ig,reward in pairs(rewards) do
            if reward.functionName == "items" then
                campaignManager.getReward_items(player, reward)

            elseif reward.functionName == "technology" then
                campaignManager.getReward_technology(player, reward)

            elseif reward.functionName == "enable_technology" then
                campaignManager.getReward_enable_technology(player, reward)

            elseif reward.functionName == "recipe" then
                campaignManager.getReward_recipe(player, reward)

            elseif reward.functionName == "force" then
                campaignManager.getReward_force(player, reward)

            elseif reward.functionName == "player" then
                campaignManager.getReward_player(player, reward)

            end
        end
    end
end

campaignManager.onGuiClick = function(event)
    if not event.element.valid then return end

    local event_name = event.element.name
    local playerData = global.questor[event.player_index]
    local player = game.players[event.player_index]

    local key = 'desc_flow'..event_name

    local parent = campaignManager.getGuiRoot(player)
    if parent[key] ~= nil then
        parent[key].clear()
    end

    local quest = playerData.runningQuests[event_name]
    if quest ~= nil then
        campaignManager.getRewards(player, quest.quest)
        quest.finished = true
        playerData.runningQuests[event_name] = nil
    end
end


function campaignManager.updateQuestGui(parent, code, quest)

    local key = 'desc_flow'..code

    if parent[key] == nil then
        local flow = parent.add
            {
                type = 'flow',
                direction='vertical',
                name = key,
                --style= 'quest_item_description_wrapper'
            }
        flow.add
            {
                type = 'label',
                style = 'questor_item_description',
                caption = quest.quest.description,
                name = "inner"
            }
        for ig,g in pairs(quest.quest.goals) do
            if g.amount ~= nil then
                flow.add
                {
                    type = 'progressbar',
                    style = "questor_item_description_progressbar",
                    name = "pbValue"..ig,
                    value =  0,
                }
            end
        end
    elseif quest.goalsPassed then
        local flow = parent[key]
        flow.clear()
        flow.add
            {
                type = 'label',
                style = 'questor_item_description',
                caption = quest.quest.description,
                name = "inner"
            }
        flow.add
            {
                type = 'button',
                caption = "Claim",
                name = code
            }
    else
        local flow = parent[key]
        for ig,g in pairs(quest.quest.goals) do
            if g.amount ~= nil then
                local current = g.current
                if current == nil then current = 0 end
                local value
                if current > g.amount then
                    value = 1
                else
                    value = current / g.amount
                end
                local pb = flow["pbValue"..ig]
                if pb ~= nil then
                    pb.value = value
                end
            end
        end
    end
end

campaignManager.getGuiRoot = function(player)
    return player.gui.left.questor.frmQuest.tblQuests
end

campaignManager.updateGui = function(i, player, playerData)
    if playerData.runningQuestsChanged then
        for iq,q in pairs(playerData.runningQuests) do
            campaignManager.updateQuestGui(campaignManager.getGuiRoot(player), iq, q)
        end
    end
    playerData.runningQuestsChanged = false
end

campaignManager.addQuests = function(questLines, gQuestLines, id, playerData)

    --Game.print_all("ql "..questLines.name)
    for iq,q in pairs(questLines.quests) do

        local gQuest = gQuestLines.quests[iq]
        if gQuest == nil then
            gQuest = { finished = false, quest = q }
            gQuestLines.quests[iq] = gQuest

            playerData.runningQuests[id..":"..iq] = gQuest
            playerData.runningQuestsChanged = true
        end

        if not gQuest.finished then
            return false
        end

    end
    return true
end

campaignManager.addQuestLines = function(campaign, gCampaign, id, playerData)
    local allFinished = true
    for iql,ql in pairs(campaign.questLines) do

        local gQuestLine = gCampaign.questLines[iql]
        if gQuestLine == nil then
            gQuestLine = { finished = false, quests = {} }
            gCampaign.questLines[iql] = gQuestLine
        end

        if not gQuestLine.finished then
            gQuestLine.finished = campaignManager.addQuests(ql, gQuestLine, id..":"..ql.name, playerData)
        end

        if not gQuestLine.finished then
            allFinished = false
        end

    end
    return allFinished
end

campaignManager.addCampaigns = function(player_index, player, playerData)

    for ic,c in pairs(campaignManager.campaigns) do

        local gCampaign = playerData.campaigns[ic]
        if gCampaign == nil then
            gCampaign = { finished = false, questLines = {} }
            playerData.campaigns[ic] = gCampaign
        end
        if not gCampaign.finished then
            gCampaign.finished = campaignManager.addQuestLines(c, gCampaign, c.name, playerData)
        end
    end

end

campaignManager.goal_items_created = function(player, playerData, goal)
    local force = player.force
    local current = force.item_production_statistics.get_input_count(goal.value)
    if current ~= goal.current then
        playerData.runningQuestsChanged = true
        goal.current = current
    end
    return goal.current >= goal.amount
end

campaignManager.goal_entities_created = function(player, playerData, goal)
    local force = player.force
    local current = force.entity_build_count_statistics.get_input_count(goal.value)
    if current ~= goal.current then
        playerData.runningQuestsChanged = true
        goal.current = current
    end
    return goal.current >= goal.amount
end

campaignManager.goal_fluids_created = function(player, playerData, goal)
    local force = player.force
    local current = force.fluid_production_statistics.get_input_count(goal.value)
    if current ~= goal.current then
        playerData.runningQuestsChanged = true
        goal.current = current
    end
    return goal.current >= goal.amount
end

campaignManager.goal_technology_researched = function(player, playerData, goal)
    local force = player.force
    local technology = force.technologies[goal.value]
    if technology == nil then return false end
    local current = technology.researched
    if current ~= goal.current then
        playerData.runningQuestsChanged = true
        goal.current = current
    end
    return current
end

campaignManager.goal_items_created_per_minute = function(player, playerData, goal)
    local force = player.force
    local current = force.item_production_statistics.get_flow_count({ name = goal.value, input = true, precision_index = defines.flow_precision_index.one_minute})
    if current ~= goal.current then
        playerData.runningQuestsChanged = true
        goal.current = current
    end
    return goal.current >= goal.amount
end

campaignManager.goal_fluids_created_per_minute = function(player, playerData, goal)
    local force = player.force
    local current = force.fluid_production_statistics.get_flow_count({ name = goal.value, input = true, precision_index = defines.flow_precision_index.one_minute})
    if current ~= goal.current then
        playerData.runningQuestsChanged = true
        goal.current = current
    end
    return goal.current >= goal.amount
end

campaignManager.goal_technologies_researched = function(player, playerData, goal)
    local force = player.force
    local current = 0
    for ig,technology in pairs(force.technologies) do
        if technology.researched then
            current = current + 1
        end
    end
    if current ~= goal.current then
        playerData.runningQuestsChanged = true
        goal.current = current
    end
    return goal.current >= goal.amount
end


campaignManager.checkQuestGoal = function(player, playerData, quest)
    if quest.goalsPassed then return end
    local goals = quest.quest.goals
    if goals ~= nil then
        local goalsPassed = true
        for ig,goal in pairs(goals) do
            if goal.functionName == "items_created" then
                goalsPassed = goalsPassed and campaignManager.goal_items_created(player, playerData, goal)

            elseif goal.functionName == "items_created_per_minute" then
                goalsPassed = goalsPassed and campaignManager.goal_items_created_per_minute(player, playerData, goal)

            elseif goal.functionName == "entities_created" then
                goalsPassed = goalsPassed and campaignManager.goal_entities_created(player, playerData, goal)

            elseif goal.functionName == "fluids_created" then
                goalsPassed = goalsPassed and campaignManager.goal_fluids_created(player, playerData, goal)

            elseif goal.functionName == "fluids_created_per_minute" then
                goalsPassed = goalsPassed and campaignManager.goal_fluids_created_per_minute(player, playerData, goal)

            elseif goal.functionName == "technology_researched" then
                goalsPassed = goalsPassed and campaignManager.goal_technology_researched(player, playerData, goal)

            elseif goal.functionName == "technologies_researched" then
                goalsPassed = goalsPassed and campaignManager.goal_technologies_researched(player, playerData, goal)

            end

         end
         quest.goalsPassed = goalsPassed
    end
end

campaignManager.updateRunningQuests = function(player_index, player, playerData)

    for iq,q in pairs(playerData.runningQuests) do
        campaignManager.checkQuestGoal(player, playerData, q)
    end

end

campaignManager.onTick = function()

    if game.tick % 20 ~= 0 then return end

    for player_index,player in pairs(game.players) do

        local playerData = global.questor[player_index]

        campaignManager.addCampaigns(player_index, player, playerData)

        campaignManager.updateRunningQuests(player_index, player, playerData)

        campaignManager.updateGui(player_index, player, playerData)
    end
end

campaignManager.initPlayer = function(index, player)

    if not global.questor[index]                then global.questor[index] = {} end
    if not global.questor[index].campaigns      then global.questor[index].campaigns = {} end
    if not global.questor[index].runningQuests  then global.questor[index].runningQuests = {} end
    if not global.questor[index].runningQuestsChanged then global.questor[index].runningQuestsChanged = false end
end

campaignManager.initCampaign = function()

    if global ~= nil then

        if not global.questor then global.questor = {} end


    end

    table.insert(questor.ticks, campaignManager.onTick)
    table.insert(questor.guiClick, campaignManager.onGuiClick)

    campaignManager.addCampaign(campaignVanilla)

end
