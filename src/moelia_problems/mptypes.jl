module MoeliaProblemTypes
  
  mutable struct MPTParams
    nvar::Int64
    max_iteration::Int64
  end

  struct MPT
    objective_functions::Vector{Function} 
    bounds::Vector{Tuple{<: Real, <: Real}}
    params::MPTParams
  end

end