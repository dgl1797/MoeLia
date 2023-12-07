module MoeliaAlgoTypes

    #inizializzazione: population
    #terminazione: max iteration, fitness treshold 
    #pipeline: algoritmo a step 

    include("../moelia_pipeline/mtypes.jl")
    include("../moelia_criteria/mctypes.jl")

    struct MAT
      population_initializer::Function
      initializer_parameters::Any

      algorithm_pipeline::MoeliaTypes.MPipe
      criteria::MoeliaCriteriaTypes.MCT
    end
end