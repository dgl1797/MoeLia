export Implementations
module Implementations
  
  using MoeLia
  
  include("../moelia_pipeline/MoeliaPipeline.jl")
  include("../moelia_algorithms/matypes.jl")
  include("../moelia_problems/mptypes.jl")

  function init_nsga2(problem::MoeliaProblemTypes.MPT)::MoeliaAlgoTypes.MAT
    #TODO create related function in functions folder 
    MoeliaAlgoTypes.MAT(
      population_initializer,
      initializer_parameters,
      algorithm_pipeline,
      problem
    )
  end

end