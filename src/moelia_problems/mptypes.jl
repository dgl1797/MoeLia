export MoeliaProblemTypes
module MoeliaProblemTypes
  
  mutable struct MPTParams
    nvar::Int64
    criteria::Function
    cparams::Any
    crequires_pop::Bool
    crequires_it::Bool
  end

  struct MPT
    objective_functions::Vector{Function} 
    bounds::Vector{Tuple{<: Real, <: Real}}
    params::MPTParams
  end

end