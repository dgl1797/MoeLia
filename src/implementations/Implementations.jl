export Implementations
module Implementations
  
  using MoeLia
  
  include("../moelia_pipeline/MoeliaPipeline.jl")
  include("../moelia_algorithms/matypes.jl")
  include("../moelia_problems/mptypes.jl")
  include("../moelia_pipeline/mtypes.jl")
  include("algos.jl")

  function get_algorithm(name::String, problem::MoeliaProblemTypes.MPT, pop_size::Int64)::MoeliaAlgoTypes.MAT
    required_implementation = get(Algos.MoeliaImplementations, name, undef)
    return required_implementation == undef ? throw("Algorithm $name not found") : required_implementation(problem, pop_size)
  end

  function set_populator_params!(algo::MoeliaAlgoTypes.MAT, params::Any)
    algo.initializer_parameters = params
  end


end