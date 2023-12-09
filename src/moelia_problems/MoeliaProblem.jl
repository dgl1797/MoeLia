export MoeliaProblem
module MoeliaProblem
  using MoeLia

  include("./mptypes.jl")

  function init_problem(NOBJ::Int64, NVAR::Int64)::MoeliaProblemTypes.MPT
    return MoeliaProblemTypes.MPT(
      Vector{Function}(undef, NOBJ),
      Vector{Tuple{<: Real,<: Real}}(undef, NVAR),
      NVAR,
      -1
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
    problem.nvar = length(problem.bounds)
  end

  function set_niterations!(problem::MoeliaProblemTypes.MPT, n::Int64)
    problem.max_iteration = n > 0 ? n : throw("invalid number of iterations")
  end
end