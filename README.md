# <center>MoeLia Suite</center>

**Multi-Objective Evolutionary** Ju**Li*Algorithms*** project emerged with the goal of offering a suite for MOEAs (Multi-Objective Evolutionary Algorithms) where it is possible to utilize not just existing codes and implementations, but develop custom code to integrate it into the MoeLia Suite, following a straightforward and well-documented modular approach.

## Getting Started

Actually the project is available to use only Julia Pkg or through git.

[github repository](https://github.com/dgl1797/MoeLia.git)

### Import as dependency in a project

Once started the Julia shell, activate your project using `Pkg.activate` then use `Pkg.add` followed by the github repository link. <br>
Julia will automatically clone the package with all the necessary dependencies and treat that as a simple package to use in the code. <br>
After the cloning you can use the package thanks to `using MoeLia`

### Local Forking for Suite Development

After forking and cloning locally the repository, the Julia's Pkg manager can be used through `using Pkg` you can run `Pkg.develop(PackageSpec(path="relative/path/to/MoeLia/"))` and only then use the suite's Package thanks to `using MoeLia`.<br>
The advantage is the possibility to change the MoeLia Project code.

## Business Logic

This section give a brief description of the implementation logic of the suite in order to make that readible and comprehensible.
The Suite is composed by three core components:

- Functions componente per le funzionalità
- Implementations vari algoritmi completi compresi di pipeline e pronti all'uso
- APIs exposed by moelia\_\*
- Runners funzionalità per runnare gli algoritmi

### Functions

Core component exposing reusable functions for general purpose pipelines. <br>
Currently composed by:

- Auxiliaries : generated in order to contains functions for specific algorithms like nsga-II
- Crossovers
- Mutators
- Populators

### Implementations

Component exposing the fully implemented MATs (MoeLia Algorithm Types) via a Dictionary implemented in algos.jl . <br>
It actually contains the following modules:

- Algos : implements MATs and expose those through a Dictionary
- Implementations : exposes APIs to access the Dictionary

### APIs

Set of core modules that exposes all the necessary data structures and their relative APIs. <br>
By convention the files exposing the APIs are named with Pascal case.<br>

- MoeLia problem : logical component exposing the MPT (MoeLia Problem Type) that allows to define several parameters related to the problem itself and some mutable parameters about secondary problem attributes.

  - MPTParams (mutable struct)
    - criteria served as Function
    - number of variable
    - number of population
    - ...
  - MPT
    - objective functions served as a vector
    - bounds consisting of a vector
    - params for optional parameters

- MoeLia algorithms : logical component exposing the MAT (MoeLia Algorithm Type) that allows to define several parameters related to itself.

  - population initializer
  - initializer parameters
  - algorithm pipeline
  - problem : **of type MPT**
  - population size

- MoeLia pipeline : logical component containing the structs for the Core MPipe (Moelia Pipeline) Object. <br>

  - MData keeps track of the single instance of a data and its type

    - data

  - Iteration keeps track of the overall steps of the pipeline corresponding to a single run of it

    - inputs
    - outputs

  - MPipe core objects representing the pipeline

    - mpipe : consisting of a Vector of tuples describing the steps
    - iter : representing the history of the pipeline, each iteration keeps track of both input and output data relative to its run

### Runners

Exposes several versions of the running loop for the Multi-Objective evolutionary algorithm, to be specific a basic version and a verbose version allowing to see details about input/output data.

### Development Flow

## How to develop using MoeLia

## How to enhance the suite

## Dependencies
