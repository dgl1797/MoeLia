function example(pop::AbstractArray)::AbstractArray
  mypopulation = Vector{typeof(pop[1, :])}[]
  for i in 1:3
    push!(mypopulation, rand(1,5))
  end 
  return mypopulation
end

example(rand(20,5))