myvec = [(-4,4),(-4,4),(-4,4)]

mypop = rand(Float64, 10,3)

lower_bounds = [b[1] for b in myvec]
upper_bounds = [b[2] for b in myvec]

println("before:")
mypop

println("after:")
map(chromosome -> lower_bounds .+ chromosome .* (upper_bounds .- lower_bounds), mypop)