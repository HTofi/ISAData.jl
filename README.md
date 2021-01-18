# ISAData

| [![Build Status](https://travis-ci.com/HTofi/ISAData.jl.svg?branch=master)](https://travis-ci.com/HTofi/ISAData.jl) | [![codecov.io](http://codecov.io/github/HTofi/ISAData.jl/coverage.svg?branch=master)](http://codecov.io/github/HTofi/ISAData.jl?branch=master) |

ISAData is a Julia package that can be used to calculate thermodynamic properties of the atmosphere (air density, pressure, temperature, and viscosity) using the **I**nternational **S**tandard **A**tmosphere (ISA) model.

## Installation

ISAData can be installed from Julia's REPL with the following command:
```
]add ISAData
```

## Usage

The package contains only one exported function called `ISAdata`. The function is called with the altitude as the input parameter, and it returns a tuple containing the values for density, pressure, temperature, and dynamic viscosity. For example:
```
julia> using ISAData

julia> ρ, P, T, μ = ISAdata(10000)
(0.4136571526878796, 26510.092578167572, 223.25492665430897, 1.461852633009453e-5)
```
where all quantities are in SI units.

`ISAdata` also supports the `Quantity` type provided by the [Unitful](https://github.com/PainterQubits/Unitful.jl) package. For example:
```
julia> using Unitful

julia> ρ, P, T, μ = ISAdata(10u"km")
(0.4136571526878796 kg m^-3, 26510.092578167572 Pa, 223.25492665430897 K, 1.461852633009453e-5 Pa s)
```
Here, output values are also of the type `Quantity`, and this provides the flexibility to convert quantities into different units:
```
julia> P |> u"lbf/ft^2"
553.6747950560401 lbf ft^-2
```
