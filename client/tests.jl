function init_problem(NOBJ::Int64, NVAR::Int64)
  return (
    Vector{Function}(undef, NOBJ),
    Vector{Tuple{Number, Number}}(undef, NVAR),
    -1
  )
end

init_problem(3, 6)