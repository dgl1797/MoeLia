module MoeliaProblemTypes

  struct Boundary
    lower::Real
    upper::Real
  end

  struct MPT
    objective_functions::Vector{Function} 
    bounds::Vector{Vector{Boundary}}
    max_iteration::Int64
  end

end