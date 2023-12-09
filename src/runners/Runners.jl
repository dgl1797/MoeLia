export Runners
module Runners

  using MoeLia

  include("../moelia_algorithms/matypes.jl")
  include("../moelia_pipeline/MoeliaPipeline.jl")
  include("../moelia_problems/MoeliaProblem.jl")

  function basic_runner(algorithm::MoeliaAlgoTypes.MAT)::Union{Vector{<: Real}, Vector{<: AbstractArray}}
    population = algorithm.population_initializer(algorithm.initializer_parameters)::Union{Vector{<: Real}, Vector{<: AbstractArray}}
    while MoeliaProblem.validate_critera(algorithm.problem)
      population = MoeliaPipeline.run_pipeline(algorithm.algorithm_pipeline, population)::Union{Vector{<: Real}, Vector{<: AbstractArray}}
    end
    return population
  end


end