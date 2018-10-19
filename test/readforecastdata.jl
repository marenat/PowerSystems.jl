using Dates

@testset "Read PowerSystems data" begin


@test data = PowerSystems.parsestandardfiles(abspath(joinpath(dirname(Base.find_package("PowerSystems")), "../data/matpower/RTS_GMLC.m")))

@test ps_dict = PowerSystems.pm2ps_dict(data)

@test time_series = PowerSystems.read_data_files(abspath(joinpath(dirname(Base.find_package("PowerSystems")), "../data/forecasts/RTS_GMLC_forecasts")))
@test ps_dict = PowerSystems.add_realtime_ts(ps_dict,time_series)

@test Buses, Generators, Storage, Branches, Loads, LoadZones ,Shunts  = PowerSystems.ps_dict2ps_struct(ps_dict)
@test sys_RTS = PowerSystems.PowerSystem(Buses, Generators,Loads,Branches,Storage,ps_dict["baseMVA"])
@test forecast_gen = PowerSystems.make_forecast_dict(time_series,Dates.Day(1),24,Generators)
@test forecast_load = PowerSystems.make_forecast_dict(time_series,Dates.Day(1),24,Loads, LoadZones)

@test Forecast_Struct = PowerSystems.make_forecast_array(forecast_gen)

true

end


