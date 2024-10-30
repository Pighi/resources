Config = {}

Config.rental_offices = {
  ["Kevins"] = {
    ["coords"] = vector4(85.0385, -807.2058, 31.4409, 246.2798),
    ["blipSettings"] = {
      ["sprite"] = 1,
      ["color"] = 1,
      ["scale"] = 1.0,
      ["name"] = "Kevins",
      ["shortRange"] = true,
      ["use"] = true
    },
    ["pedSettings"] = {
      ["coords"] = vector4(85.0385, -807.2058, 30.4409, 245.2798),
      ["model"] = "a_m_m_business_01",
      ["use"] = true,
      ["anim"] = "WORLD_HUMAN_CLIPBOARD",
    },
    ["target"] = {
      ["label"] = 'Rent a Car at ',
      ["use"] = true,
    },
    ["markerSettings"] = {
      ["type"] = 1,
      ["scale"] = vector3(1.0, 1.0, 1.0),
      ["color"] = vector4(0, 0, 0, 100),
      ["use"] = false,
    },
    ["vehicles"] = {
      {
        name = "Blista",
        model = "blista",
        price = 1000, -- per 15 minutes
      },
      {
        name = "Sanchez",
        model = "sanchez",
        price = 1000, -- per 15 minutes
      },
      {
        name = "elegy",
        model = "elegy",
        price = 1500, -- per 15 minutes
      },
      {
        name = "mesa",
        model = "mesa",
        price = 1000, -- per 15 minutes
      }
    },
    ["previewCoords"] = vector4(73.8706, -794.4054, 31.5611, 215.6631),
    ["camDistance"] = 8,
    ["carSpawnCoords"] = {
      vector3(120.2636, -818.2843, 31.2923),
    }
  },
  ["Airport"] = {
    ["coords"] = vector4(-984.7607, -2641.5715, 13.9730, 147.6771),
    ["blipSettings"] = {
      ["sprite"] = 1,
      ["color"] = 1,
      ["scale"] = 1.0,
      ["name"] = "Airport",
      ["shortRange"] = true,
      ["use"] = true
    },
    ["pedSettings"] = {
      ["coords"] = vector4(-984.7607, -2641.5715, 12.9730, 147.6771),
      ["model"] = "a_m_m_business_01",
      ["use"] = true,
      ["anim"] = "WORLD_HUMAN_CLIPBOARD",
    },
    ["target"] = {
      ["label"] = 'Rent a Car at ',
      ["use"] = true,
    },
    ["markerSettings"] = {
      ["type"] = 1,
      ["scale"] = vector3(1.0, 1.0, 1.0),
      ["color"] = vector4(0, 0, 0, 100),
      ["use"] = false,
    },
    ["vehicles"] = {
      {
        name = "Blista",
        model = "blista",
        price = 1000, -- per 15 minutes
      },
      {
        name = "Sanchez",
        model = "sanchez",
        price = 1000, -- per 15 minutes
      }
    },
    ["previewCoords"] = vector4(7-987.0428, -2645.5549, 13.9747, 144.5687),
    ["camDistance"] = 8,
    ["carSpawnCoords"] = {
      vector3(-978.5678, -2654.4548, 13.8293),
    }
  }
}

Config.Translations = {
  ["pressE"] = "Press E to interact",
  ["missing_parameters"] = "Missing parameters",
  ["office_do_not_exist"] = "Office does not exist",
  ["vehicle_do_not_exist"] = "Vehicle does not exist",
  ["player_do_not_exist"] = "Player does not exist",
  ["too_far_away"] = "You are too far away from the office",
  ["no_free_space"] = "No free space",
  ["not_enough_money"] = "You do not have enough money",
  ["invalid_payment_type"] = "Invalid payment type",
  ["error_while_renting"] = "You rented the vehicle but there was an error while spawning it. Please contact an admin",
  ["successfully_rented"] = "You rented the vehicle successfully",
  ["time_left"] = "You have 1 minute left until your vehicle will get deleted"
}

function Notify(msg)
  ShowNotification(msg)  -- change this to your notification function
end

function ShowTextUI()
  lib.showTextUI(Config.Translations["pressE"]) -- change this to your text ui function
end

function HideTextUI()
  lib.hideTextUI() -- change this to your text ui function
end

function HideHud()
  -- TriggerEvent("mHud:HideHud") -- change this to your hud function
end

function ShowHud()
  -- TriggerEvent("mHud:ShowHud") -- change this to your hud function
end

Config.CustomFuelExport = function(vehicle)
  local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  -- Entity(vehicle).state.fuel = 100 -- ox_fuel
  SetVehicleFuelLevel(vehicle, 100.0) -- fivem native
end

Config.CustomGiveVehicleKeys = function(vehiclePlate)
  -- Custom logic for giving vehicle keys
  print("Custom logic for giving keys for vehicle with plate: " .. vehiclePlate)
  -- Implement your logic to give vehicle keys here
end

Config.CustomRemoveVehicleKeys = function(vehiclePlate)
  -- Custom logic for removing vehicle keys
  print("Custom logic for removing keys for vehicle with plate: " .. vehiclePlate)
  -- Implement your logic to remove vehicle keys here
end 
 
