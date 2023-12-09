export Populators
module Populators

  using MoeLia

  include("../../moelia_problems/mptypes.jl")

  function random_initializer(problem::MoeliaProblemTypes.MPT, pop_size::Int64)::AbstractArray
    lower_bounds = [b[1] for b in problem.bounds]
    upper_bounds = [b[2] for b in problem.bounds]
    return map(
      chromosome -> lower_bounds .+ chromosome .* (upper_bounds .- lower_bounds),
      rand(Float64, (pop_size, problem.nvar))
    )
  end
  
end