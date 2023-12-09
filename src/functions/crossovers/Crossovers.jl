export Crossovers
module Crossovers

  using MoeLia

  function single_point(population::AbstractArray, crossover_rate::Float64, pop_size::Int64, nvar::Int64)::AbstractArray
    if crossover_rate < 0. && crossover_rate > 1. throw("invalid crossover rate, it must be a probability in [0,1]") end
    if length(population) != pop_size throw("declared population size is $pop_size but got $(length(population))") end
    offspring = ones(pop_size, nvar)
    for i in 1:2:pop_size
      if rand() > crossover_rate continue end
      parent1, parent2 = (population[i], (i+1 < pop_size ? population[i+1] : population[rand(1:pop_size)]))
      crossover_point = rand(1:nvar)
      child1, child2 = (
        vcat(parent1[1:crossover_point], parent2[crossover_point:nvar]),
        vcat(parent2[1:crossover_point], parent1[crossover_point:nvar])
      )
      offspring[i, :] = child1
      offspring[i+1, :] = child2
    end
    return offspring
  end
  
end