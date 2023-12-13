function score1(x1,x2,x3)
  return 3*x1+4*x2-2*x3+5  
end
function score2(x1,x2,x3)
  return 6*x1+2*x2-4*x3-1  
end
function score3(x1,x2,x3)
  return x1+x2-x3
end

population = rand(5,3)

objectives = Function[score1, score2, score3]

# Number of objectives
M = size(objectives)[1]

# Number of individuals
N = size(population)[1]

# Initialization
individual = Dict[Dict([("crowd", population[i, :]), ("distance", 0.0)]) for i in 1:N]

for m in 1:M
  # Sort the population by the m-th objective function
  sort!(individual, by = x -> objectives[m](Tuple(x["crowd"])...))

  # Set the boundary points' crowding distance to infinity
  individual[1]["distance"] = Inf
  individual[N]["distance"] = Inf

  # For each remaining individual
  for i in 2:(N-1)
      # Update the crowding distance
      individual[i]["distance"] += (objectives[m](Tuple(individual[i+1]["crowd"])...) - objectives[m](Tuple(individual[i-1]["crowd"])...))
  end
end

sort!(individual, by = x -> -x["distance"])