
![qrackling-logo](https://github.com/RDonaldson5/QKD_Sat_Link/assets/24245170/4391532c-85e1-47e0-80f5-308610079d9c)



# Qrackling
> A toolbox for modelling quantum key distribution between satellites and ground stations.

## About
Qrackling is a flexible object-oriented toolbox for simulating qkd between satellites and ground stations. It is easlily extended allowing users to replicate satellite qkd scenarios presented in the literature and explore the features present within them.

## Examples

<details>
<summary><b>Satellite to Ground Decoy BB84</b></summary>
   
![sample_overpass_qkd](https://github.com/RDonaldson5/QKD_Sat_Link/assets/24245170/b497c680-65f4-4c5d-9ab5-66cc644786be)

</details>

<details>
<summary><b>Beacon Performance</b></summary>
   
![sample_overpass_beacon](https://github.com/RDonaldson5/QKD_Sat_Link/assets/24245170/61ca5094-656a-440c-99ab-7d3404c2a174)

</details>


## Features
- Multiple qkd protocols:
    * BB84
    * Decoy state BB84
    * Coherent One-Way
    * Differential phase shift
    * BBM92
- Data for a range of detectors (APD, SNSPD)
    * Collected or extrapolated for various of the shelf devices
- Loss models:
    * Geometric
    * Optical
    * Point and Track
    * Atmospheric
    * Turbulence
- Simulations
    - Sifted and Secure key rates with QBER
    - Beacon performance

## Installation

Installation of the toolbox is as simple as ensuring it's on the MATLAB path. First ensure that the requirements are met. Then follow either the simple (recommended) or advanced installation sections.

### Requirements

- MATLAB R2022b (or later)
- [Satellite Communications Toolbox](https://uk.mathworks.com/products/satellite-communications.html)
- [Navigation Toolbox](https://www.mathworks.com/products/navigation.html)
- [Mapping Toolbox](https://www.mathworks.com/products/mapping.html)

<details>
<summary><b>Optional</b></summary>

- [LibRadtran](http://www.libradtran.org/doku.php)

</details>

## Easy Installation (Recommended)
For best stability we recommend using a tagged release, the following steps show how to install using that.

1. Open the location of your MATLAB user path. This can be found by running the following in the MATLAB command window:
    ``` matlab
    userpath
    ```
    By default this should be something like `C:\Documents\MATLAB` on Windows and `~/Documents/MATLAB/` for Linux.
2. Head over to [releases](https://github.com/RDonaldson5/QKD_Sat_Link/releases) and get the latest version.
3. Extract the contents of the downloaded .zip archive into your user path. Qrackling will now be available for use in MATLAB to make use of the included examples follow the next step otherwise have fun!
4. (Optional) To use the included examples you will need to add the folder you just placed into folder at your user path manually. To do this you will need to open the path tool by either going to the `HOME` tab and clicking `Set Path` or by running `pathtool` in the MATLAB command window. From there click `Add with Subfolders` and navigate to where you extracted the model to. Click save when you are done.

## Advanced Installation

For those wanting to develop new features (or just use the most up to date version) you can install the toolbox by cloning the repository. It is up to you where you wish to install it, the most convenient is as follows:

1. Change directory to the MATLAB user path
    * Windows: `cd C:\Documents\MATLAB`
    * Linux: `cd ~/Documents/MATLAB`

2. Clone the repository
    ```shell
    git clone https://github.com/RDonaldson5/QKD_Sat_Link
    ```
3. (Optional) Add the examples to the MATLAB path with the pathtool (see step 4 of [Easy Installation](#easy-installation-recommended))

## LibRadtran
libRadtran - library for radiative transfer - is a collection of C and Fortran functions and programs for calculation of solar and thermal radiation in the Earth's atmosphere. See the [libRadtran website](https://libradtran.org/doku.php) for technical details, licensing and operational instructions.

Qrackling has the optional ability to incorporate libRadtran to calculate background light and atmospheric transmission for conditions different to those already provided. This requires the installation of libRadtran to the machine running Qrackling. The following instructions detail how to do this on *NIX and windows machines. On windows, the process is marginally more complicated, as both installation and then running of libRadtran have been designed to depend on [windows subsystem for linux](https://learn.microsoft.com/en-us/windows/wsl/) (WSL). Steps which are only for windows users are **_in bold italics_**. *NIX (e.g. linux or macOS) should ignore these steps.

### Dependencies
Building and running libRadtran depends on the following:
- make
- g++
- gcc
- gfortran
- NetCDF (libraries and headers, e.g. on ubuntu (including in WSL) libnetcdff-dev)
- gsl (libraries and headers, e.g. on ubuntu (including in WSL) libgsl-dev)
- **_WSL (windows subsystem for linux, required for windows only)_**

### Installation
1. Download and unzip libRadtran from [its website](https://libradtran.org/doku.php?id=download) to an easily accessible folder
   - **_Ensure on windows that this path does not contain spaces, as these cannot be parsed by libRadtran_**.
   - Make a note of this path, we will need it later.
2. **_Install and prepare WSL_**
   - **_[WSL](https://learn.microsoft.com/en-us/windows/wsl/install) can be installed by opening the command prompt and calling `WSL --install`._**
   - **_Once installed, launch WSL by calling `wsl` in the command prompt._**
   - **_You will be prompted to create a username and password pair._**
   - **_To test your network connection, call `sudo apt update`. If this succeeds and updates your packages, continue to the next step._**
      - **_In some cases, especially on managed PCs, WSL will not have network permissions. Contact your IT service if this is an issue and they will be able to allow WSL through the firewall_**
3. Install required *NIX packages
   - Use your favourite flavour of package manager to install the packages listed in the dependencies above. The versions you require will depend on the hardware architecture you are using.
   - **_For instance, the standard installation of WSL will install them with the command `sudo apt install g++ gcc gfortran make libnetcdff-dev libgsl-dev`_**
      - This step will require permissions (hence `sudo` above).
4. Navigate to the top of your unzipped libRadtran folder.
   - **_In WSL, this path can be formed by taking the windows path to the libRadtran folder, replacing all `\` with `/`, and replacing `C:\` with `/mnt/c/` (or equivalent)._**
   - This folder should contain further folders named bin, data, doc, examples (as well as many more and several files).
5. Build libRadtran
   - Call `./configure` to configure the make files to build libRadtran. This will fail if you are missing any crucial packages.
   - Call `make` to prepare to build.
   - Call `make check` to ensure preparation went smoothly.
   - Call `sudo make install` to build libRadtran.
      - This step requires permissions (hence `sudo` above).
6. Download aerosol files (optional)
   - For MYSTIC polarisation calculations, some extra aerosol data are required.
   - This is a very specific calculation and won't be required for most users.
   - If required, download the OPAC data from the [libRadtran website downloads page](https://libradtran.org/doku.php?id=download).
   - Unzip this information (there is quite a lot) and the contents into the libRadtran data folder.

## Publications
[Dawn and dusk satellite quantum key distribution using time and phase based encoding and polarization filtering (preprint)](https://preprints.opticaopen.org/s/1bb0c741db45094e4890), C. Simmons, P. Barrow, R. Donaldson.

## License
Qrackling and its tutorials/examples are [MIT licensed](https://github.com/RDonaldson5/QKD_Sat_Link/blob/main/LICENSE)
