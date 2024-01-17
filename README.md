# Qrackling 📡 📨 🛰️
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

- MATLAB R2021a (or later)
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


## Publications

## License
We have not decided on a license for this repo, as it is currently private. If Heriot-Watt University didn't give you access, don't use it, and give us our stuff back.
