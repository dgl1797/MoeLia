export Populators
module Populators

  using MoeLia

  include("../../moelia_problems/mptypes.jl")

  function random_initializer(problem::MoeliaProblemTypes.MPT)::AbstractArray
    return rand
  end
  
end