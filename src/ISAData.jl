module ISAData
	
	using Unitful
	
	export ISAdata
	
	const g = 9.80665
	const Rs = 287.058
	const RE = 6371009.0
	const kB = 1.3806503e-23
	const m = 4.809651184715603e-26
	const ϵ_kB = 97.0
	const σ = 3.617e-10
	
	"""
	    ISAdata(h::T) where T <: Real
	
	Returns a tuple containing air density, pressure, temperature, and dynamic viscosity at an altitude h,	according to the International Standard Atmosphere model. All quantities are in SI units.
	
	# Example
	
	```julia-repl
	julia> ISAdata(10000)
	(0.4136571526878796, 26510.092578167572, 223.25492665430897, 1.461852633009453e-5)
	```
	
	    ISAdata(h::T) where T <: Quantity
	
	Returns a tuple containing air density, pressure, temperature, and dynamic viscosity at an altitude h. All quantities returned are of Quantity type with the corresponding SI units.
	
	# Example
	```julia-repl
	julia> using Unitful
	
	julia> ISAdata(10u"km")
	(0.4136571526878796 kg m^-3, 26510.092578167572 Pa, 223.25492665430897 K, 1.461852633009453e-5 Pa s)
	```
	"""
	function ISAdata(h::Float64)
		
		a :: Float64 = 0.0
		T0 :: Float64 = 0.0
		P0 :: Float64 = 0.0
		T :: Float64 = 0.0
		P :: Float64 = 0.0
		ρ :: Float64 = 0.0
		μ :: Float64 = 0.0
		
		hgeoP = RE - RE^2/(RE+h)
		
		if hgeoP >= -610
			
			if hgeoP < 11000
				
				a = -0.006503014642549524
				b = 288.18316106804474
				T0 = 292.15
				P0 = 108900.0
				T = a*hgeoP + b
				P = P0*(T/T0)^(-g/(a*Rs))
				
			elseif hgeoP < 20000
				
				a = 0.0
				b = 216.65
				T0 = 216.65
				P0 = 22632.0
				T = T0
				P = P0*exp(-g/(b*Rs) * (hgeoP-11000))
				
			elseif hgeoP < 32000
				
				a = 0.001
				b = 196.65
				T0 = 216.65
				P0 = 5474.9
				T = a*hgeoP + b
				P = P0*(T/T0)^(-g/(a*Rs))
				
			elseif hgeoP < 47000
				
				a = 0.0028
				b = 139.05
				T0 = 228.65
				P0 = 868.02
				T = a*hgeoP + b
				P = P0*(T/T0)^(-g/(a*Rs))
				
			elseif hgeoP < 51000
				
				a = 0.0
				b = 270.65
				T0 = 270.65
				P0 = 110.91
				T = T0
				P = P0*exp(-g/(b*Rs) * (hgeoP-47000))
				
			elseif hgeoP < 71000
				
				a = -0.0028
				b = 413.45
				T0 = 270.65
				P0 = 66.939
				T = a*hgeoP + b
				P = P0*(T/T0)^(-g/(a*Rs))
				
			elseif hgeoP <= 84852
				
				a = -0.002005486572336125
				b = 357.0395466358649
				T0 = 214.65
				P0 = 3.9564
				T = a*hgeoP + b
				P = P0*(T/T0)^(-g/(a*Rs))
				
			end
		end
		
		ρ = P/(Rs*T)
		μ = 5.0/(16*sqrt(π)) * sqrt(m*kB*T) / (σ^2 * Ω(T/ϵ_kB))
		
		return (ρ, P, T, μ)
		
	end
	
	function ISAdata(h::T) where T <: Real
		return ISAdata(float(h))
	end
	
	function ISAdata(h::T) where T <: Quantity
		hi = uconvert(u"m", h)
		ρi, Pi, Ti, μi = ISAdata(ustrip(hi))
		return (ρi*u"kg/m^3", Pi*u"Pa", Ti*u"K", μi*u"Pa*s")
	end
	
	function Ω(Ts::Float64)
		return 1.16145*Ts^(-0.14874) + 0.52487*exp(-0.7732*Ts) + 2.16178*exp(-2.43787*Ts)
	end
	
end
