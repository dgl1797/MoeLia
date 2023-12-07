module MoeliaCriteriaTypes

  struct MCT{NObj <: Int64, NVar <: Int64}
    objective_functions::Vector{Function} = Vector{Function}(undef, NObj)
    objective_variables::Vector{<: Number} = Vector{<: Number}(undef, NVar)
  end

end