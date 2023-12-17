export MoeliaAlgorithm
module MoeliaAlgorithm

  using MoeLia 

  function validate_criteria(population::AbstractArray, iteration::Int, problem::MoeliaProblemTypes.MPT)::Bool
    if problem.params.crequires_it
      return (
        problem.params.crequires_pop 
          ? problem.params.criteria(population, iteration, problem.params.cparams...)
          : problem.params.criteria(iteration, problem.params.cparams...)
      )
    else
      return (
        problem.params.crequires_pop
          ? problem.params.criteria(population, problem.params.cparams...)
          : problem.params.criteria(problem.params.cparams...)
      )
    end
  end

  function set_populator!(algo::MoeliaAlgoTypes.MAT, populator_function::Function, populator_parameters...)
    algo.population_initializer = populator_function
    algo.initializer_parameters = populator_parameters
  end

  function set_population_size!(algo::MoeliaAlgoTypes.MAT, new_size::Int)
    if new_size < 2 throw("invalid population size, must contain at least 2 elements") end
    algo.pop_size = new_size
  end

  function set_algorithm_pipeline!(algo::MoeliaAlgoTypes.MAT, pipe::MoeliaTypes.MPipe)
    if isempty(pipe.mpipe) println("\033[0;33mWarning: the pipeline you set is empty") end
    algo.algorithm_pipeline = pipe
  end

  function create_algorithm(problem::MoeliaProblemTypes.MPT, pop_size::Int)
    return MoeliaAlgoTypes.MAT(
      () -> undef,
      (),
      MoeliaTypes.MPipe(Tuple{String, Function, Any}[], MoeliaTypes.Iteration[]),
      problem,
      pop_size
    )
  end
   
end