using MoeLia.MoeliaPipeline
using MoeLia.PopulationHandlers
using MoeLia.Mutators

include("./algos/researcher_library.jl")

population = PopulationHandlers.random_initializer(Int8(5))

mypipeline = MoeliaPipeline.init_pipeline()

MoeliaPipeline.add_step!(mypipeline, "mutate", Mutators.classic_mutator)
MoeliaPipeline.add_step!(mypipeline, "unite", x -> vcat(mypipeline.inputs[1].data, x))
MoeliaPipeline.add_step!(mypipeline, "core", ResearcherLibrary.my_genetic_algorithm, ResearcherLibrary.myobjective)
MoeliaPipeline.add_step!(mypipeline, "adjustments", (x,param) -> x .+ (1*param), 12)

result = MoeliaPipeline.inspect(mypipeline, Vector{Float64})
println(result)

MoeliaPipeline.substitute!(mypipeline,"adjustments","try_again_mutator",Mutators.classic_mutator)

result = MoeliaPipeline.inspect(mypipeline, Vector{Float64})
println(result)

MoeliaPipeline.substitute!(mypipeline,4,"new_step",(x,param,param2) -> x .+ (1*param-param2),12,0.5)

result = MoeliaPipeline.inspect(mypipeline, Vector{Float64})
println(result)