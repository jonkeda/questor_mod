function bootstrap_migration_on_first_tick(event)
    LOGGER.log("Running first tick migrations...")
    local forces = game.forces

    runOnceCheck(forces)
    global_ensureTablesExist()
    ses_statistics.sessionStartTick = game.tick

    for fkey, force in pairs(forces) do
        if force.name ~= "enemy" and force.name ~= "neutral" then
            migrateForce(fkey, force)
        end
    end

    --check if we have grab artifacts enabled - if we do, but it was added after the game started, and the force has military 1 researched
    --then lets force the recipe to be enabled (because they have missed the usual trigger)
    if(GRAB_ARTIFACTS == 1) then
        for fkey, force in pairs(forces) do
            if(force.technologies["military"].researched == true) then
                force.recipes["loot-chest"].enabled = true
            end
        end
    else  -- else force-disable it if it's been disabled part-way through a game.
        for fkey, force in pairs(forces) do
            force.recipes["loot-chest"].enabled = false
        end

    end

    for i,player in pairs(game.players) do
        gui_init(player)
    end
    -- substitute the 'normal' tick handler, and run it manually this time
    script.on_event(defines.events.on_tick, handleTick)
    handleTick(event)
end