function example(pop::AbstractArray)::AbstractArray
  offspring = Vector{Float64}[]

  for i in 1:size(pop)[1]
    if rand() > 0.5
      mutated_index = rand(1:5)
      mutated_value = -4 + rand(Float64) * (4 - (-4))
      chromosome = pop[i, :]
      chromosome[mutated_index] = mutated_value
      push!(offspring, chromosome)
    end
  end

  return offspring

end



println(example(ones(4,5)))