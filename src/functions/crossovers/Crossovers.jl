export Crossovers
module Crossovers
  using MoeLia
  using Random, Dates
  
  function single_point(population::AbstractArray, crossover_rate::Float64)::Tuple{Matrix{Float64}, Set{Vector{Float64}}}
    if isempty(population) return [] end
    Random.seed!(convert(Int64,Dates.datetime2unix(Dates.now())*1000))
    dims = size(population)
    if crossover_rate < 0. && crossover_rate > 1. throw("invalid crossover rate, it must be a probability in [0,1]") end
    if length(dims) != 2 throw("population must be a 2D array, not well generated") end
    (pop_size, nvar) = dims
    if pop_size <= 0 || nvar <= 0 throw("invalid population") end
    uniques = Set{Vector{Float64}}([population[i, :] for i in 1:size(population)[1]])
    offspring = Vector{Float64}[]
    for i in 1:2:pop_size
      if rand() > crossover_rate continue end
      parent1, parent2 = (population[i,:], (i+1 <= pop_size ? population[i+1,:] : population[rand(1:pop_size),:]))
      crossover_point = rand(1:nvar)
      child1, child2 = (
        vcat(parent1[1:crossover_point-1], parent2[crossover_point:nvar]),
        vcat(parent2[1:crossover_point-1], parent1[crossover_point:nvar])
      )
      if !(child1 in uniques)
        push!(uniques, child1)
        push!(offspring, child1)
      end
      if !(child2 in uniques)
        push!(uniques, child2)
        push!(offspring, child2)
      end
    end
    offspring = isempty(offspring) ? Matrix{Float64}(undef, 1, 0) : convert(Matrix{Float64}, vcat(offspring'...))
    return offspring, uniques
  end
  
end