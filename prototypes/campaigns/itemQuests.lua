itemQuestLines = {
    ["iron-plate"] = {
        name = "iron-plate",
        description = "Create iron-plates",
        quests =
        {
            ["iron-plate-10"] = {
                name = "iron-plate-10",
                description = "Create 10 iron-plates",
                goals = {
                    {
                        functionName = "items_created",
                        value = "iron-plate",
                        amount = 10
                    }
                },
                rewards = {
                    {
                        functionName = "items",
                        value = "steel-plate",
                        amount = 20
                    }
                },
            },
            ["iron-plate-100"] = {
                name = "iron-plate-100",
                description = "Create 100 iron-plates",
                goals = {
                    {
                        functionName = "items_created",
                        value = "iron-plate",
                        amount = 100
                    }
                },
                rewards = {
                    {
                        functionName = "items",
                        value = "steel-plate",
                        amount = 200
                    }
                },
            },
        }
    },

    ["copper-plate"] = {
        name = "copper-plate",
        description = "Create copper-plates",
        quests =
        {
            ["copper-plate-10"] = {
                name = "copper-plate-10",
                description = "Create 10 copper-plates",
                goals = {
                    {
                        functionName = "items_created",
                        value = "copper-plate",
                        amount = 10
                    }
                },
                rewards = {
                    {
                        functionName = "items",
                        value = "copper-plate",
                        amount = 20
                    }
                },
            },
            ["copper-plate-100"] = {
                name = "copper-plate-100",
                description = "Create 100 copper-plates",
                goals = {
                    {
                        functionName = "items_created",
                        value = "copper-plate",
                        amount = 100
                    }
                },
                rewards = {
                    {
                        functionName = "items",
                        value = "copper-plate",
                        amount = 200
                    }
                },
            },
        }
    },

}


campaignVanilla = {

    name = "vanilla",
    description = "Vanilla campaign (this is for beta testing only)",
    questLines = itemQuestLines
}
