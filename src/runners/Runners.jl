export Runners
module Runners

  using MoeLia

  include("../moelia_algorithms/matypes.jl")
  include("../moelia_pipeline/MoeliaPipeline.jl")
  include("../moelia_criteria/MoeliaCriteria.jl")

  function basic_runner(algorithm::MoeliaAlgoTypes.MAT)<:AbstractArray
    population <: AbstractArray = algorithm.population_initializer(algorithm.initializer_parameters)<:AbstractArray
    while MoeliaCriteria.validate_critera(algorithm.criteria)
      population <: AbstractArray = MoeliaPipeline.run_pipeline(algorithm.algorithm_pipeline, population)<:AbstractArray
    end
    return population
  end


end