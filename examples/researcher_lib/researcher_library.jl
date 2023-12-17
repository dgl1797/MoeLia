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

  function unpack_mutator(
    (population, uniques_set)::Tuple{AbstractArray,Set{Vector{Float64}}},
    mutation_rate::Float64
  )::AbstractArray
    bounds = [(-4,4), (-4,4), (-4,4)]
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

  function sort_and_filter(population::Matrix{Float64}, pop_size::Int, objectives::Vector{Function})
    Nobj = size(objectives)[1]
    Nvar = size(population)[2]
    fitnesses = Dict{Int, Vector{Float64}}()

    for i in 1:pop_size
      fitnesses[i] = Vector{Float64}(undef, Nvar)
    end

    for i in 1:pop_size
      for j in 1:Nobj
        fitnesses[i][j] = objectives[j](population[i, :])
      end
    end

    sorted_pairs = sort(collect(fitnesses), by = x -> -x[2])
    filtered_sorted_pairs = sorted_pairs[1:pop_size]

    return population[[k[1] for k in filtered_sorted_pairs], :]
  end
  
end