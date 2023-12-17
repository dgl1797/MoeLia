export Runners
module Runners

  using MoeLia

  function basic_runner(algorithm::MoeliaAlgoTypes.MAT)::AbstractArray
    population = algorithm.population_initializer(algorithm.initializer_parameters...)
    current_iteration = 1
    while MoeliaAlgorithm.validate_criteria(population, current_iteration, algorithm.problem)
      population = MoeliaPipeline.run_pipeline(algorithm.algorithm_pipeline, population)
      current_iteration+=1
    end
    return population
  end

  function verbose_runner(algorithm::MoeliaAlgoTypes.MAT, every::Int=1)::AbstractArray
    population = algorithm.population_initializer(algorithm.initializer_parameters...)
    current_iteration = 1
    while MoeliaAlgorithm.validate_criteria(population, current_iteration, algorithm.problem)
      if (current_iteration % every == 0 || current_iteration == 1)
        println("[STEP $current_iteration]:\n-----INPUT-----\n$population\n-----OUTPUT-----\n")
      end
      population = MoeliaPipeline.run_pipeline(algorithm.algorithm_pipeline, population)
      if (current_iteration % every == 0 || current_iteration == 1)
        println(population)
      end
      current_iteration+=1
    end
    return population
  end


end