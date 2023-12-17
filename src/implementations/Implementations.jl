export Implementations
module Implementations
  
  using MoeLia

  function get_algorithm(name::String, problem::MoeliaProblemTypes.MPT, pop_size::Int64)::MoeliaAlgoTypes.MAT
    required_implementation = get(Algos.MoeliaImplementations, name, undef)
    return required_implementation == undef ? throw("Algorithm $name not found") : required_implementation(problem, pop_size)
  end

end