# PSSE Files
files = readdir(abspath(joinpath(dirname(Base.find_package("PowerSystems")), "../data/psse_raw")))
file_ext = r".*?\.(\w+)"

if length(files) == 0
    @error "No test files in the folder"
end

for f in files
    @test_skip @time try
        ext = match(file_ext, f)
        @info "Parsing $f ..."
        pm_dict = PowerSystems.parse_file(abspath(joinpath(dirname(Base.find_package("PowerSystems")), "../data/psse_raw",f)))
        @info "Successfully parsed $f to PowerModels dict"
        PowerSystems.make_mixed_units(pm_dict)
        @info "Successfully converted $f to mixed_units"
        ps_dict = PowerSystems.pm2ps_dict(pm_dict)
        @info "Successfully parsed $f to PowerSystems dict"
        Buses, Generators, Storage, Branches, Loads, LoadZones ,Shunts = PowerSystems.ps_dict2ps_struct(ps_dict)
        @info "Successfully parsed $f to PowerSystems devices"
        sys_test = PowerSystem(Buses, Generators,Loads,Branches,Storage,float(ps_dict["baseMVA"])) # TODO: Add DClines, Shunts
        @info "Successfully parsed $f to PowerSystem struct"
        true
    catch
        @warn "error while parsing $f"
        false
    end
end

true