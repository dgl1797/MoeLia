module ResearcherLibrary
  function researcher_objective1(chromosome::Vector{Float64})::Float64
    nvar = length(chromosome)
    return 1-exp(-sum([(x-1/sqrt(nvar))^2 for x in chromosome]))
  end

  function researcher_objective2(chromosome::Vector{Float64})::Float64
    nvar = length(chromosome)
    return 1-exp(-sum([(x+1/sqrt(nvar))^2 for x in chromosome]))
  end

  function my_genetic_algorithm(population::Vector{Float64}, objective::Function)::Array{Float64, 5}
    fitness = objective(population)
    fitness = sort(fitness)
    return fitness[1:5]
  end
end