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

function goForward()
    """
    Lets not let sand stop us.
    """
    ensureFuel(1)
    while not turtle.forward() do
        turtle.dig()
    end
end

function createGround()
    if not(turtle.detectDown()) then
        turtle.select(2)
        turtle.placeDown()
    end
end

local len, width, height = ...
print("usage: clear <amount_forward> <amount_left> <amount_up>")

local turn = true
for h = 0, height-1, 1 do
    for x = 0, len-1, 1 do
        for y = 0, width-2, 1 do
            turtle.dig()
            goForward()
            if h == 0 then
                createGround()
            end
        end

        if x == len-1 then break end

        if turn then
            turtle.turnLeft()
            turtle.dig()
            goForward()
            if h == 0 then
                createGround()
            end
            turtle.turnLeft()
            turn = false
        else 
            ensureFuel(1)
            turtle.turnRight()
            turtle.dig()
            goForward()
            if h == 0 then
                createGround()
            end
            turtle.turnRight()
            turn = true
        end
    end
    -- Height change
    ensureFuel(1)
    turtle.digUp()
    turtle.up()

    if turn then
        turtle.turnLeft()
        turtle.turnLeft()
    else 
        turtle.turnRight()
        turtle.turnRight()
    end
end

for x = 0, height-1, 1 do
    ensureFuel(height-1)
    turtle.digDown()
    turtle.down()
end