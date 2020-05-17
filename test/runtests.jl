using ISAData
using Unitful
using Test

@testset "With Float input" begin
    @test ISAdata(2000.0) == (1.0067463824164535, 79525.88552601013, 275.18121338059757, 1.7263247952751583e-5)
end

@testset "With Int input" begin
	@test ISAdata(2000) == (1.0067463824164535, 79525.88552601013, 275.18121338059757, 1.7263247952751583e-5)
end

@testset "With Quantity input" begin
	@test ISAdata(2u"km") == (1.0067463824164535u"kg/m^3", 79525.88552601013u"Pa", 275.18121338059757u"K", 1.7263247952751583e-5u"Pa*s")
end
