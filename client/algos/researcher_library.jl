module ResearcherLibrary
  function myobjective(population::Vector{Float64})
    return population .- 1
  end

  function my_genetic_algorithm(population::Vector{Float64}, objective::Function)::Array{Float64, 5}
    fitness = objective(population)
    fitness = sort(fitness)
    return fitness[1:5]
  end
end