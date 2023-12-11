export MoeliaAlgoTypes
module MoeliaAlgoTypes

    using MoeLia

    #inizializzazione: population
    #terminazione: max iteration, fitness treshold 
    #pipeline: algoritmo a step 

    mutable struct MAT
      population_initializer::Function
      initializer_parameters::Any
      algorithm_pipeline::MoeliaTypes.MPipe
      problem::MoeliaProblemTypes.MPT
      pop_size::Int64
    end
end