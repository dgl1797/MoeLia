export MoeliaProblem
module MoeliaProblem
  using MoeLia

  function init_problem(NOBJ::Int64, NVAR::Int64)::MoeliaProblemTypes.MPT
    return MoeliaProblemTypes.MPT(
      Vector{Function}(undef, NOBJ),
      Vector{Tuple{<: Real,<: Real}}(undef, NVAR),
      MoeliaProblemTypes.MPTParams(NVAR, ()->false, (), false, false)
    )
  end

  function set_objectives!(problem::MoeliaProblemTypes.MPT, objective_functions::Function...)
    for (i, f) in enumerate(objective_functions)
      problem.objective_functions[i] = f
    end
  end

  function set_boundaries!(problem::MoeliaProblemTypes.MPT, boundaries::Tuple{<: Real,<: Real}...)
    for (i, b) in enumerate(boundaries)
      problem.bounds[i] = b
    end
    problem.params.nvar = length(problem.bounds)
  end

  function set_criteria!(
    problem::MoeliaProblemTypes.MPT, 
    new_validator::Function, 
    with_population::Bool=false,
    with_iterations::Bool=true,
    new_params...
  )
    
    if Base.return_types(new_validator)[1] != Bool
      throw("Criteria validator must be a function returning a boolean and a boolean only")
    end

    problem.params.criteria = new_validator
    problem.params.crequires_pop = with_population
    problem.params.crequires_it = with_iterations
    problem.params.cparams = new_params
  end
end