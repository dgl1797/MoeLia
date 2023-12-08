module MoeliaAlgoTypes

    #inizializzazione: population
    #terminazione: max iteration, fitness treshold 
    #pipeline: algoritmo a step 

    include("../moelia_pipeline/mtypes.jl")
    include("../moelia_problems/mptypes.jl")

    struct MAT
      population_initializer::Function
      initializer_parameters::Any

      algorithm_pipeline::MoeliaTypes.MPipe
      problem::MoeliaProblemTypes.MPT
    end
end