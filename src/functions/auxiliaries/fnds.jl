export fnds 
module fnds

  function fast_non_dominated_sort(population)
    # Initialize domination count and dominated solutions for each solution
    S = [Set() for _ in 1:size(population)[1]] #ordered set containing for each i-th cell the individuals dominated by the i-th one 
    n = zeros(Int, size(population)[1]) #domination count, number of individuals that dominate the i-th one 
    rank = zeros(Int, size(population)[1]) #array in which each i-th cell corresponds to the rank/frontier of i-th ind.

    # Initialize the first front, a front contains all the individuals with the same number of dominant individuals
    F = Vector{Int}[]
    push!(F, Int[])

    # Calculate domination for pairs of solutions
    for p in 1:size(population)[1] #p is the index examinated element 
        for q in 1:size(population)[1] #q is the index of the other compared element 
            if p != q
                # Check if solution p dominates solution q (case true)
                if all(population[p,:] .<= population[q,:]) && any(population[p,:] .< population[q,:])
                    push!(S[p], q)
                elseif all(population[q,:] .<= population[p,:]) && any(population[q,:] .< population[p,:])
                    n[p] += 1
                end
            end
        end
        # If solution p is not dominated, counter == 0, it belongs to the first front
        if n[p] == 0
            rank[p] = 1
            push!(F[1], p)
        end
    end

    # Generate subsequent fronts
    i = 1
    while size(F[i])[1] != 0
        Q = Int[]
        for p in F[i]
            for q in S[p]
                n[q] -= 1
                if n[q] == 0
                    rank[q] = i + 1
                    push!(Q, q)
                end
            end
        end
        i += 1
        if isempty(Q) break end
        push!(F, Q)
    end
    return F
  end
  
  function frontier_filter(frontiers::Vector{Vector{Int}},population::AbstractArray,pop_size::Int)
    next_batch = Vector{Float64}[]
    k = 1
    while k <= size(frontiers)[1]
      if size(next_batch)[1] + size(frontiers[k])[1] > pop_size break end
      [push!(next_batch, population[cs, :]) for cs in frontiers[k]]
      k += 1
    end
    return (
      convert(Matrix{Float64}, hcat(next_batch...)'),
      k <= size(frontiers)[1] ? population[frontiers[k], :] : []
    )
  end


  
  function crowding_distance(population::AbstractArray, objectives::Vector{Function} )
    # Number of objectives
    M = length(population[1].objectives)

    # Number of individuals
    N = length(population)

    # Initialize crowding distance
    for individual in population
        individual.crowding_distance = 0.0
    end

    # For each objective function
    for m in 1:M
        # Sort the population by the m-th objective function
        sort!(population, by = x -> x.objectives[m])

        # Set the boundary points' crowding distance to infinity
        population[1].crowding_distance = Inf
        population[N].crowding_distance = Inf

        # For each remaining individual
        for i in 2:(N-1)
            # Update the crowding distance
            population[i].crowding_distance += (population[i+1].objectives[m] - population[i-1].objectives[m])
        end
    end
  end

end