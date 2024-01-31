local QBCore = exports[Corestore.Core]:GetCoreObject()
local playerData = QBCore.Functions.GetPlayerData()
CreateThread(function()
    while true do
        Wait(Corestore.Minutes * 60 * 1000)
        if playerData.job.name == 'police' and playerData.job.onduty then
            TriggerServerEvent('core-police:addpoints', Corestore.Points)
        end
    end
end)
RegisterNetEvent('core-policepoints:client:openmenu', function(data)
    QBCore.Functions.TriggerCallback('core-playermanagement:server:getpoliceofficers', function(playerss)
        local options = {}
        for k, v in pairs(playerss) do
            table.insert(options, {
                title = v.firstname .. " " .. v.lastname,
                description = "grade: " .. v.grade .. " \n Points: " .. v.ppoints,
                icon = 'user-circle',
                event = 'core-policepoints:manageplayers',
                arrow = true,
                args = {
                    fullname = v.firstname .. " " .. v.lastname,
                    id = v.cid,
                    jj = v.job,
                }
            })
        end
        lib.registerContext({
            id = 'police_menuu',
            title = 'Player Points',
            options = options
        })
        lib.showContext('police_menuu')
    end)
end)
RegisterNetEvent('core-policepoints:manageplayers', function(data)
    lib.registerContext({
        id = 'policemana',
        title = 'Player Points',
        menu = 'police_menuu',
        options = {
            {
                title = 'Give Police points',
                description = "Click here to give " .. data.fullname .. " Police points",
                icon = 'plus',
                onSelect = function()
                    Givecashinput(data.id)
                end,


            },
            {
                title = 'Remove Police points',
                description = "Click here to Remove " .. data.fullname .. " Police points",
                icon = 'minus',
                onSelect = function()
                    REmovepp(data.id)
                end

            },
            {
                title = 'Remove all Police points',
                description = "Click here to remove  " .. data.fullname .. " all Police points",
                icon = 'minus',
                event = 'core-police:allloppo',
                args = {
                    icd = data.id
                }
            }

        }
    })
    lib.showContext('policemana')
end)
RegisterNetEvent('core-police:allloppo', function(data)
    TriggerServerEvent('core-police:rmvallppp', data.icd)
end)
function Givecashinput(data)
    local input = lib.inputDialog('Give Policepoints',
        { { type = 'number', label = 'Points amount ', description = 'Put your amount here', icon = 'plus' } })
    if not input then return end
    TriggerServerEvent('core-police:giveppoints', data, input[1])
end

function REmovepp(data)
    local input = lib.inputDialog('Remove Policepoints',
        { { type = 'number', label = 'Points amount ', description = 'Put your amount here', icon = 'plus' } })
    if not input then return end
    TriggerServerEvent('core-police:rmvppoints', data, input[1])
end
