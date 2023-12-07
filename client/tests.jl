function myfunction(x1, x2)
  return x1+x2
end

function example(argument::Function)
  return argument()
end

function another_function()::Array{Float64, 2}
  return ones(4,5)
end

function incompatible_function()::Int64
  return 5
end

println(example(another_function))
println(example(incompatible_function))