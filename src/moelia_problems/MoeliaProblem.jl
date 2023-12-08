export MoeliaProblem
module MoeliaProblem
  using MoeLia

  include("./mptypes.jl")

  function make_problem(NOBJ::Int64, NVAR::Int64)::MoeliaProblemTypes.MPT
    return MoeliaProblemTypes.MPT(
      Vector{Function}(undef, NOBJ),
      Vector{Tuple{Number,Number}}(undef, NVAR),
      -1
    )
  end

  function validate_critera(criteria::MoeliaProblemTypes.MPT)::Bool
    return true
  end
end