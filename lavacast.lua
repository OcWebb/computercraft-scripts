function ensureFuel(moves)
    while turtle.getFuelLevel() < moves do
        turtle.select(1)
        if turtle.getItemCount(1) == 0 then
            print("Out of fuel!")
            break
        end
            turtle.refuel(1)
    end
end

function create_layer(layer_height)
    -- place lava and cobble
    ensureFuel(2)
    turtle.select(3)
    turtle.placeDown()
    turtle.up()
    turtle.select(2)
    turtle.placeDown()
    turtle.up()
    -- wait for lava
    local sleep_time = (1.5 * layer_height)
    sleep(sleep_time)
    -- place water
    turtle.select(4)
    turtle.placeDown()
    sleep(4)
    turtle.placeDown()
    -- salvage lava
    sleep(2)
    turtle.down()
    turtle.digDown()
    turtle.down()
    turtle.select(3)
    turtle.placeDown()
end

function return_to_ground (height)
    -- go back to ground
    for h = 1, height do
        ensureFuel(1)
        turtle.down()
    end
end

function find_lava()
    local lava_slots = {}
    for i = 1, 16 do
        local slot = turtle.getItemDetail(i)
        if slot then
            if slot.name == 'minecraft:lava_bucket' then
                table.insert(lava_slots, i)
            end
        end
    end
    return lava_slots
end

function tower(height)
    -- get to height
    for h = 1, height do
        ensureFuel(1)
        turtle.up()
    end
    create_layer(height - 1)
end

function pyramid(height)
    -- build starting shape
    ensureFuel(3)
    turtle.forward()
    turtle.select(2)
    turtle.place()
    turtle.turnLeft()
    turtle.place()
    turtle.turnLeft()
    turtle.place()
    turtle.turnLeft()
    turtle.place()
    turtle.turnLeft()
    turtle.up()
    turtle.placeDown()

    local total_height = 1
    -- loop over all layers
    for layer = 2, height do
        print('Placing layer ' .. layer)
        ensureFuel(3)
        turtle.up()
        total_height = total_height + 2
        turtle.select(2)
        turtle.placeDown()
        turtle.up()
        create_layer(total_height*2)
    end

    for h = 0, height+2 do
        ensureFuel(1)
        turtle.back()
    end
    return_to_ground(total_height * 2)
end


function wall(height, length)
    lava_slots = find_lava()
    lava_count = #lava_slots

    if lava_count == 0 then 
        print('please insert at least one lava bucket in any slot but the first or second')
    end

    for h = 0, height do
        ensureFuel(1)
        turtle.up()
    end

    for i=0, length, lava_count do
        -- place cobble below lava
        for i=1, lava_count do
            ensureFuel(1)
            turtle.select(2)
            turtle.placeDown()
            if i ~= length then
                turtle.forward()
            end
        end
        -- turn around
        turtle.turnLeft()
        turtle.turnLeft()

        turtle.up()

        -- place lava
        for i=1, lava_count do
            ensureFuel(1)
            turtle.select(lava_slots[i])
            turtle.placeDown()
            turtle.forward()
        end

        -- place stopper
        turtle.forward()
        turtle.select(2)
        turtle.placeDown()
        turtle.back()

        -- turn around
        turtle.turnLeft()
        turtle.turnLeft()

        -- place stone above lava
        turtle.up()
        for i=1, lava_count do
            ensureFuel(1)
            turtle.select(2)
            turtle.placeDown()
            turtle.forward()
        end

        -- turn around
        turtle.turnLeft()
        turtle.turnLeft()

        -- wait for lava
        sleep(1.5 * height - lava_count)

        -- place water
        turtle.up()
        for i=1, lava_count do
            ensureFuel(1)
            turtle.forward()
            turtle.select(3)
            if (i-1) % 3 == 0 then
                turtle.placeDown()
                sleep(2)
                turtle.placeDown()
            end
        end

        -- turn around
        turtle.turnLeft()
        turtle.turnLeft()

        -- collect lava
        sleep(1)
        turtle.down()
        turtle.digDown()
        turtle.down()
        for i=1, lava_count do
            ensureFuel(1)
            turtle.forward()
            turtle.select(lava_slots[i])
            turtle.placeDown()
            turtle.dig()
        end

        -- mine stopper and reset
        turtle.forward()
        turtle.digDown()
        turtle.down()
    end

    -- return
    turtle.forward()
    turtle.forward()
    return_to_ground(height)
end


local type, height, length = ...
height = tonumber(height)
length = tonumber(length)

if type == 'tower' then
    if not height then
        print('usage: lavacast tower <height>')
    else
        tower(height)
        for i = 0, 4 do
            turtle.back()
        end
        return_to_ground(height*1.5)
    end

elseif type == 'pyramid' then
    if not height then
        print('usage: lavacast pyramid <height>')
    else
        pyramid(height)
    end
elseif type == 'wall' then
    if not height or not length then
        print('usage: lavacast wall <height> <length>')
    else
        wall(height, length)
    end
else
    print('usage: lavacast <type>')
    print('types: tower, pyramid, wall')
end




