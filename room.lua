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

local forward_amt, side_amt = ...
forward_amt = tonumber(forward_amt)
side_amt = tonumber(side_amt)
mid_pt = math.floor(side_amt/2)
print(mid_pt)
