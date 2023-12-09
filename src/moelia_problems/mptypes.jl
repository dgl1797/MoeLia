module MoeliaProblemTypes

  struct MPT
    objective_functions::Vector{Function} 
    bounds::Vector{Tuple{Number, Number}}
    nvar::Int64
    max_iteration::Int64
  end

end