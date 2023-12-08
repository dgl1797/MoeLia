module MoeliaProblemTypes

  struct MPT
    objective_functions::Vector{Function} 
    objective_variables::Vector{Number}
    max_iteration::Int64
  end

end