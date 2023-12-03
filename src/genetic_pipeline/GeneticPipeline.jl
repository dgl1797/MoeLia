export GeneticPipeline
module GeneticPipeline
  #= TODO
    Module containing all the necessary structures to:
    initialize, configure and run a pipeline specific for genetic MOEA algorithms
  =#
  using MoeLia

  export MutationFunctionalities

  include("mutation_functionalities.jl")
  include("gpipeline.jl")

  """ EXAMPLE OF DOCSTRINGS\n
    function launching the configured pipeline, it has to take a valid pipeline reference and a valid stop criteria\n
    \t@arg pipeline::Pipeline -> the pipeline's reference to be launched
    \t@arg stopCriteria::Function{Boolean} -> function that returns a boolean testing if the population meets the stop criteria
    \t@returns ::BestIndividuals -> an array of values representing the final population generated to optimize the configured problem
    \t
  """
  function run_pipeline(pipeline::GPipeline.GPipe, startingInputs::Any)
    pipeline.mutation_algorithm(startingInputs, pipeline.mutator_args...)
    pipeline.optimizer(pipeline.optimizer_args...)
  end

  function init_pipeline()::GPipeline.GPipe
    return GPipeline.GPipe(
      MutationFunctionalities.default_mutator,
      (),
      C_NULL,
      ()
    )
  end

  function set_mutator!(pipeline::GPipeline.GPipe, mutator::Function, mutatorArgs...)
    pipeline.mutation_algorithm = mutator
    pipeline.mutator_args = mutatorArgs
  end

  function set_optimizer!(pipeline::GPipeline.GPipe, optimizer::Function, optimizerArgs...)
    pipeline.optimizer = optimizer
    pipeline.optimizer_args = optimizerArgs
  end
end