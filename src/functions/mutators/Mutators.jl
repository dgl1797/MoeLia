export Mutators
module Mutators
  
  using MoeLia

  function one_position(
    population::AbstractArray, 
    uniques_set::Set{Vector{Float64}},
    mutation_rate::Float64, 
    bounds::Vector{Tuple{<: Real, <: Real}}
  )::AbstractArray
    if isempty(population) return population end
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
      if !(mutated_chromosome in uniques_set)
        push!(uniques_set, mutated_chromosome)
        push!(offspring, mutated_chromosome)
      end
    end

    return convert(Matrix{Float64},hcat(offspring...)')

  end

end