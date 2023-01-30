# QKD_Sat_Link

## Description
QKD_Sat_Link is a MATLAB simulator for satellite QKD written at Heriot-Watt University. It incorporates real-world data and simulations to produce results which are maximally verifiable. The MATLAB object-oriented paragdym allows traceability of results back to the expressions used to evaluate them. As the project expands, we endeavour to integrate and use more and more external sources, to increase the flexibility and realism extracted from a small development commitment.

## Requirements
### Mandatory
MATLAB R2021a or newer, with:
- Satellite Communications Toolbox
- Navigation Toolbox
- Mapping Toolbox

### Optional
| System | Description |
| ----------- | ----------- |
| SMARTS (Simple Model of the Atmospheric Radiative Transfer of Sunshine) available [here](https://www.nrel.gov/grid/solar-resource/smarts.html) | Allows the simulation of sunlight in the atmosphere to support daylight QKD background count modelling |
| GMAT (General Mission Analysis tool) available [here](https://opensource.gsfc.nasa.gov/projects/GMAT/index.php#:~:text=The%20General%20Mission%20Analysis%20Tool%20%28GMAT%29%20is%20a,and%20is%20a%20testbed%20for%20future%20technology%20development.) | allows editting of orbit paths and the creation of new standardised orbit datasets external to MATLAB's satellite simulator |

## Installation
1. First ensure that your MATLAB installation is up to date, you have a valid MATLAB licence and have all of the mandatory toolboxes installed and enabled.
2. Clone the `main` branch of this repository to your machine (for a guide to this, see [here](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)), or download and unzip the zip-file copy from GitHub.
3. Ensure that the whole repository is on your MATLAB path by opening the file `QKD modelling.prj`. This can be done by double-clicking, or, if the file is on your MATLAB path, by using the command `open('QKD modelling.prj')`.
4. You're good to go! Consider running one or more of the scripts in the *Example scripts* folder to familiarise yourself with the syntax needed to write and run a simulation.

## Licensing
We have not decided on a license for this repo, as it is currently private. If Heriot-Watt University didn't give you access, don't use it, and give us our stuff back.

## Further reading
For a guide on the object-oriented paragdym and how this is implemented in MATLAB, see [here](https://uk.mathworks.com/products/matlab/object-oriented-programming.html?s_tid=srchtitle_object%20oriented%20programming_1). The Wiki for this repo contains specifics on how various components of this model function.
