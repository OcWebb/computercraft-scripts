function inventory_full()
    for i = 1, 16 do
        if turtle.getItemCount(i) == 0 then
            return false
        end
    end
    return true
end
 
function empty_inventory()
    for i = 1, 16 do
        turtle.select(i)
        turtle.drop()
    end
end
 
local i = 0
while true do
    turtle.attack()
    if i > 10 and inventory_full() then
        turtle.turnRight()
        turtle.turnRight()
        empty_inventory()
        turtle.turnRight()
        turtle.turnRight()
        i = 0
    end
    i = i + 1
end