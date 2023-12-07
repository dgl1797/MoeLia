export MoeliaCriteria
module MoeliaCriteria
  using MoeLia

  include("./mctypes.jl")

  function make_criteria(NOBJ::Int64, NVAR::Int64)::MoeliaCriteriaTypes.MCT
    return MoeliaCriteriaTypes.MCT{NOBJ, NVAR}()
  end

  function validate_critera(criteria::MoeliaCriteriaTypes.MCT)::Bool
    return true
  end
end