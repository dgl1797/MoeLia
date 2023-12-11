export Runners
module Runners

  using MoeLia

  function basic_runner(algorithm::MoeliaAlgoTypes.MAT)::AbstractArray
    population = algorithm.population_initializer(algorithm.initializer_parameters)::AbstractArray
    #@TODO
    while MoeliaProblem.validate_critera(algorithm.problem)
      population = MoeliaPipeline.run_pipeline(algorithm.algorithm_pipeline, population)::AbstractArray
    end
    return population
  end


end