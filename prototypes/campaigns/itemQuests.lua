itemQuestLines = {
    ["iron-ore"] = {
        name = "iron-ore",
        description = "Mine iron-ore",
        quests =
        {
            ["iron-ore-1"] = {
                name = "iron-ore-1",
                description = "Mine 1 iron-ore",
                goals = {
                    {
                        functionName = "items_created",
                        value = "iron-ore",
                        amount = 1
                    }
                },
                rewards = {
                    {
                        functionName = "items",
                        value = "steel-plate",
                        amount = 5
                    },
                    {
                        functionName = "technology",
                        value = "steel-processing"
                    },
                    {
                        functionName = "recipe",
                        value = "plastic-bar"
                    },

                    {
                        functionName = "force",
                        value = "character_trash_slot_count",
                        amount = 25
                    },

                    {
                        functionName = "player",
                        value = "character_logistic_slot_count_bonus",
                        amount = 25
                    },

                    },
                },

            ["iron-ore-1-pm"] = {
                name = "iron-ore-1-pm",
                description = "Mine 1 iron-ore per minute",
                goals = {
                    {
                        functionName = "items_created_per_minute",
                        value = "iron-ore",
                        amount = 1
                    }
                },
                rewards = {
                    {
                        functionName = "items",
                        value = "steel-plate",
                        amount = 5
                    },
                 },
            },

        }
    },

    ["burner-mining-drill"] = {
    name = "burner-mining-drill",
    description = "Deploy burner mining drills",
    quests =
        {
            ["burner-mining-drill-1"] = {
                name = "burner-mining-drill-1",
                description = "Deploy 1 burner mining drills",
                goals = {
                    {
                        functionName = "entities_created",
                        value = "burner-mining-drill",
                        amount = 1
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
        },
    },

    ["water"] = {
        name = "water",
        description = "Pump water",
        quests =
        {
            ["water-1"] = {
                name = "water-1",
                description = "Pump 1 water",
                goals = {
                    {
                        functionName = "fluids_created",
                        value = "water",
                        amount = 1
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

            ["water-1-pm"] = {
                name = "water-1-pm",
                description = "Pump 1 water per minute",
                goals = {
                    {
                        functionName = "fluids_created_per_minute",
                        value = "water",
                        amount = 1
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
        },
    },

    ["technology"] = {
        name = "technology",
        description = "Research technology",
        quests =
        {
            ["technology-1"] = {
                name = "technology-1",
                description = "Research steel-processing",
                goals = {
                    {
                        functionName = "technology_researched",
                        value = "steel-processing"
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
            ["technologies-1"] = {
                name = "technologies-1",
                description = "Research 1 technologies",
                goals = {
                    {
                        functionName = "technologies_researched",
                        amount = 1
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
        },
    },

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
