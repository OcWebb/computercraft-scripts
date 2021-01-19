function ensureFuel(moves)
    turtle.select(1)
    while (turtle.getFuelLevel() < moves) do
        if turtle.getItemCount(1) == 0 then
            print("Out of fuel!")
            break
        end
        turtle.refuel(1)
    end
end

function isFull()
    local empty_slots = 0
    for i = 1, 16 do
        if turtle.getItemCount(i) == 0 then
            
            empty_slots = empty_slots + 1
        end
    end

    print('empty slots ' .. empty_slots)

    if empty_slots <= 4 then 
        return true 
    end 

    return false
end

function emptyInventory()
    for i = 2, 16 do
        turtle.select(i)
        turtle.drop()
    end
end


function goForward()
    ensureFuel(1)
    while not turtle.forward() do
        turtle.dig()
    end
end

function goUp()
    ensureFuel(1)
    while not turtle.up() do
        turtle.digUp()
    end
end

function goBack()
    ensureFuel(1)
    while not turtle.back() do
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.dig()
        turtle.turnLeft()
        turtle.turnLeft()
    end
end

function oreCheck()
    -- check sides
    for i=1,4 do
        local success, data = turtle.inspect()
        if success and string.find(data.name, 'ore') then
            goForward()
            -- recurse
            oreCheck()
            goBack()
        end
        turtle.turnLeft()
    end

    local success, data = turtle.inspectUp()
    if success and string.find(data.name, 'ore') then
        goUp()
        -- recurse
        oreCheck()
        turtle.down()
    end

    local success, data = turtle.inspectDown()
    if success and string.find(data.name, 'ore') then
        turtle.digDown()
        turtle.down()
        -- recurse
        oreCheck()
        goUp()
    end
end

function mine_to_bedrock()
    local success, data = turtle.inspectDown()
    while (data.name ~= 'minecraft:bedrock') do
        turtle.digDown()
        ensureFuel(1)
        if turtle.down() then
            y = y - 1
            oreCheck()
        end
        success, data = turtle.inspectDown()
    end
end

function returnToSurface()
    local success, data = turtle.inspectUp()
    while (y < 0 or data.name ~= null) do
        turtle.digUp()
        ensureFuel(1)
        if turtle.up() then
            y = y + 1
            oreCheck()
        end
        success, data = turtle.inspectUp()
    end
end



-- mine 1x1 to bedrock
-- recursivly mine veins on the way
--  getting back up: go back to original height (stored) and continue up until air is above
y = 0
x = 0
local dist = ...
dist = tonumber(dist)

for i=1, dist do
    mine_to_bedrock()

    -- move to next location
    for u=0, 4 do
        ensureFuel(1)
        if turtle.up() then
            y = y + 1
        end
    end
    for u=1, 3 do
        turtle.dig()
        goForward()
        x = x + 1
    end

    returnToSurface()

    -- empty items into chest if full
    -- if isFull() then
    print('Emptying Items')
    turtle.turnLeft()
    turtle.turnLeft()

    -- move to chest
    for r=1, x do
        goForward()
    end

    -- get to chest height
    if y > 0 then
        for i=1, y do
            turtle.down()
        end
    end

    local success, data = turtle.inspectDown()
    if success and string.find(data.name, 'ore') then

    -- at chest, empty inventory
    emptyInventory()

    turtle.turnLeft()
    turtle.turnLeft()

    -- move to where we were before
    if y > 0 then
        for i=1, y do
            turtle.up()
        end
    end

    for r=1, x do
        goForward()
    end
    
    -- move to next location or return to start
    if i == dist then
        turtle.turnLeft()
        turtle.turnLeft()
        for r=1, x do
            goForward()
        end
        emptyInventory()
        return
    end
    for u=1, 3 do
        goForward()
        x = x + 1
    end
end