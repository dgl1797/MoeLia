using MoeLia

include("algos/researcher_library.jl")

myPipe = MoeLia.GeneticPipeline.init_pipeline()
MoeLia.GeneticPipeline.set_optimizer!(myPipe, ResearcherLibrary.my_algorithm, "Hello", 13.61723)