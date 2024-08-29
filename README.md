
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

- [LibRadtran](http://www.libradtran.org/doku.php) 2.0.4 or later

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
libRadtran - library for radiative transfer - is a collection of C and Fortran functions and programs for calculation of solar and thermal radiation in the Earth's atmosphere. See the [libRadtran website](https://libradtran.org/doku.php) for technical details, licensing and operational instructions. Qrackling has been tested with libRadtran 2.0.4 and 2.0.5.

Qrackling has the optional ability to incorporate libRadtran to calculate background light and atmospheric transmission for conditions different to those already provided.
This requires building and installing libRadtran from source, details for [Linux users](#Linux) and [Windows users](#Windows) have been outlined below.

### Dependencies
Building and running libRadtran depends on the following:
- make
- gcc, g++, gfortran
- NetCDF (libraries and headers, e.g. on ubuntu (including in WSL) libnetcdff-dev)
- Gnu Scientific Library, gsl (libraries and headers, e.g. on ubuntu (including in WSL) libgsl-dev)
- WSL (Windows Subsystem for Linux, required for Windows only)


### Installation

Download and unzip libRadtran from [its website](https://libradtran.org/doku.php?id=download) to an easily accessible folder, **if** you are building this on Windows then you should be careful not to extract libRadtran into a directory with spaces in the name.

#### Linux

**Note:** Although untested these steps likely work on MacOS too if anyone using this attemps this and gets it to work please file a PR with updates to the readme.

Install the requirements: 
1. make
2. gcc
3. g++
4. gfortran
5. NetCDF
6. Gnu Scientific Library

On Ubuntu with `apt` this will be as follows
``` shell
apt install make gcc g++ gfortran libnetcdff-dev libgsl-dev
```
Navigate to the directory you have extraced libRadtran into and run the following commands.
The will first configure the build system, resulting in errors if any dependencies are missing. Then prepare, verify and finally install to the users system.
```shell
./configure
make
make check
sudo make install
```

#### Windows
Installation on Windows is slightly more involved as it requires the use of 
Windows Subsystem for Linux, WSL, to properly build libRadtran.
By default WSL will install Ubuntu Linux as a virtual machine, this will be plenty for this guide.
From Windows 10 onwards this can be installed by openning PowerShell or Command Prompt and running the following command, this will prompt you for your username and password.
```shell
WSL --install
```
Once complete you can enter WSL by running `WSL` in either PowerShell or Command Prompt.

Now that Ubuntu is installed it should be updated, the first command will update the list of available packages, the second will update any packages that need it: 
```shell
sudo apt update
sudo apt upgrade
```

**NOTE:** If you are attempting to install WSL on a managed computer you may need to contact your I.T. department to allow WSL to connect to the internet.

Next we will need to install the required dependencies, this can be done as shown
``` shell
sudo apt install make gcc g++ gfortran libnetcdff-dev libgsl-dev
```

Now that the dependencies are installed we can begin building libRadtran.
From inside WSL navigate to the directory containing libRadtran, since we are in Linux now the path convention has changed for example if libRadtran was extracted to `C:\users\USERNAME\Downloads\libRadtran` this would now become `/mnt/c/users/USERNAME/Downloads/libRadtran`.
Drives become lower case and are found in `/mnt` and all path delimeters change from `\` to `/`.

The following commands are then used to build libRadtran.
The will first configure the build system, resulting in errors if any dependencies are missing. Then prepare, verify and finally install to the users system.
```shell
./configure
make
make check
sudo make install
```

## Publications
[Dawn and dusk satellite quantum key distribution using time and phase based encoding and polarization filtering (preprint)](https://preprints.opticaopen.org/s/1bb0c741db45094e4890), C. Simmons, P. Barrow, R. Donaldson.

## License
Qrackling and its tutorials/examples are [MIT licensed](https://github.com/RDonaldson5/QKD_Sat_Link/blob/main/LICENSE)
