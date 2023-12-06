export MoeliaPipeline
module MoeliaPipeline
  #= TODO
    Module containing all the necessary structures to:
    initialize, configure and run a pipeline specific for genetic MOEA algorithms
  =#
  using MoeLia
  
  include("mtypes.jl")

  function init_pipeline()::MoeliaTypes.MPipe
    return MoeliaTypes.MPipe(Vector{Tuple{String, Function, Any}}[], Vector{MoeliaTypes.MData}[], Vector{MoeliaTypes.MData}[])
  end

  """
    pushes a new action to be performed in the pipeline. Actions are executed in the same order they are inserted
    and their output type needs to be coherent with the next step's input type\n
    \t@arg pipe::MoeliaTypes.MPipe -> the pipeline where to push the new action
    \t@arg name::String -> the name that identifies the action (?allow name-based sorting?)
    \t@arg action::Function -> the action to be taken
    \t@arg action_args::Tuple{Any...} -> configuration parameters for the action\n
      EXAMPLE OF USAGE:
    \t mypipe = MoeliaPipeline.init_pipeline()
    \t MoeliaPipeline.add_step!(mypipe, "step1", first_action, config_param1, config_param2, ...)\n
    notice that first_action is any functionality that takes a single input + some configuration parameters and returns a
    single output which is the elaborated input.\n
    \t@throws error if previous action's output is incompatible with new action's input
    \t
  """
  function add_step!(pipe::MoeliaTypes.MPipe, name::String, action::Function, action_args...)
    push!(pipe.mpipe, (name, action, action_args))
  end

  """
  Views the entire pipeline of actions, giving the ordering and the naming, so that new elements can be accessed/substituted
  signularly using either the index or the name of the step. It also inspects the types to each action, if it is not specified
  in the action's declaration it will assume the action will not modify the type of the input\n
  \t@arg pipe::MoeliaTypes.MPipe -> the pipeline to inspect
  \t@arg InputType::DataType -> expected input shape to the pipeline
  \t@returns a string representation of the pipeline in the format: [index -> name]: action(arguments type)\n
    EXAMPLE OF USAGE:\n
  \t mypipe = MoeliaPipeline.init_pipeline()
  \t MoeliaPipeline.add_step!(mypipeline, "mutate", Mutators.classic_mutator)
  \t MoeliaPipeline.add_step!(mypipeline, "unite", x -> vcat(mypipeline.inputs[1].data, x))
  \t MoeliaPipeline.add_step!(mypipeline, "core", ResearcherLibrary.my_genetic_algorithm, ResearcherLibrary.myobjective)
  \t MoeliaPipeline.add_step!(mypipeline, "adjustments", (x,param) -> x .+ (1*param), 12)
  \t MoeliaPipeline.inspect(mypipeline)\n
    PRODUCES:\n
  \t [1 -> mutate]: classic_mutator(::Vector{Float64} + [])::Vector{Float64}
  \t [2 -> unite]: Anonymous Function(::Vector{Float64} + [])::Vector{Float64}
  \t [3 -> core]: my_genetic_algorithm(::Vector{Float64} + [Function])::Array{Float64, 5}
  \t [4 -> adjustments]: Anonymous Function(::Array{Float64, 5} + [Int64])::Array{Float64, 5}\n
  The first argument type in each action represents the streamed input type of the pipeline assuming the inital type is 
  InputType\n
  \t
  """
  function inspect(pipe::MoeliaTypes.MPipe, InputType::DataType)::String
    finalString::String = ""
    PreviousType = [InputType]
    for (index, (name, action, args)) in enumerate(pipe.mpipe)
      action_name = occursin("#", string(action)) ? "Anonymous Function" : string(action)
      arg_types = "$(join(map(x -> isa(x, Function) ? "Function" : typeof(x), args), ", "))"
      ftype = Base.return_types(action)
      fstring = ftype[1] == Any ? PreviousType[1] : ftype[1]
      finalString *= "[$index -> $name]: $action_name(\u001b[32m$(PreviousType[1])\u001b[0m + [$arg_types])::$fstring\n"
      push!(PreviousType, fstring)
      popfirst!(PreviousType)
    end
    return finalString
  end

  """
    runs a configured pipeline\n
    \t@arg pipeline::MoeliaTypes.MPipe -> the configured pipeline to run
    \t@arg startingInputs::MoeliaTypes.MInputs -> inputs that will be forwarded through the pipeline
    \t@returns the most fitting solutions until stop criteria are met
    \t@throws errors when steps output are incompatible with next inputs
    \t
  """
  function run_pipeline(pipe::MoeliaTypes.MPipe, x::Any)::Any
    for (_, action, args) in pipe.mpipe
      push!(pipe.inputs, MoeliaTypes.MData{typeof(x)}(x))
      x = action(x, args...)
      push!(pipe.outputs, MoeliaTypes.MData{typeof(x)}(x))
    end
    return x
  end
end