export Mutators
module Mutators
  
  using MoeLia

  function one_position(population::AbstractArray, mutation_rate::Float64, bounds::Vector{Tuple{<: Real, <: Real}})::AbstractArray
    if mutation_rate < 0 || mutation_rate > 1 throw("invalid mutation rate, it has to be a probability in [0,1]") end
    (pop_size, nvar) = size(population)
    if pop_size <= 0 || nvar <= 0 throw("invalid population") end
    offspring = Vector{Float64}[]
    for i in 1:pop_size
      if rand()>mutation_rate continue end
      mutated_index = rand(1:nvar)
      lb, hb = bounds[mutated_index] 
      mutated_value = lb + rand(Float64) * (hb - lb)
      mutated_chromosome = population[i, :]
      mutated_chromosome[mutated_index] = mutated_value
      push!(offspring, mutated_chromosome)
    end

    return offspring

  end

end