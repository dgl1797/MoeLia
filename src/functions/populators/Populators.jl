export Populators
module Populators

  using MoeLia
  
  function random_initializer(problem::MoeLia.MoeliaProblemTypes.MPT, pop_size::Int64)::AbstractArray
    lower_bounds = [b[1] for b in problem.bounds]
    upper_bounds = [b[2] for b in problem.bounds]
    pop = [lower_bounds .+ rand(Float64, problem.params.nvar) .* (upper_bounds .- lower_bounds) for _ in 1:pop_size]
    return vcat(pop'...)
end

  
end