module ResearcherLibrary
  function researcher_objective1(chromosome::Vector{Float64})::Float64
    nvar = length(chromosome)
    return 1-exp(-sum([(x-1/sqrt(nvar))^2 for x in chromosome]))
  end

  function researcher_objective2(chromosome::Vector{Float64})::Float64
    nvar = length(chromosome)
    return 1-exp(-sum([(x+1/sqrt(nvar))^2 for x in chromosome]))
  end

  function stop_criteria(current_iteration, max_iteration)::Bool
    return current_iteration <= max_iteration
  end
end