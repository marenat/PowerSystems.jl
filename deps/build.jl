
import InfoZIP

Pkg.checkout("PowerModels", "master")

const GITHUB_TAG = "v0.1-alpha.2"

const POWERSYSTEMS_GITHUB_URL = "https://github.com/NREL/PowerSystems.jl"

const ZIP_DATA_URL = joinpath(POWERSYSTEMS_GITHUB_URL, "releases/download/" , GITHUB_TAG, "data.zip")

const DATA_FOLDER = Pkg.dir("PowerSystems/data")

function download_data()

    if !isdir(DATA_FOLDER)
        mkpath(DATA_FOLDER)
        temp_folder = tempname()
        mkpath(temp_folder)
        temp_data_zip = joinpath(temp_folder, "data.zip")
        download(ZIP_DATA_URL, temp_data_zip)
        InfoZIP.unzip(temp_data_zip, DATA_FOLDER)
    end

end

download_data()