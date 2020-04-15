@testset "TAMU Parsing " begin
    files = readdir(TAMU_DIR)
    if length(files) == 0
        error("No test files in the folder")
    end

    sys = TAMU_System(TAMU_DIR)
    @info "Successfully parsed $TAMU_DIR to System struct"

    # Test bad input
    @test_throws PowerSystems.DataFormatError TAMU_System("")
end
