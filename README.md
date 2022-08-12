# QKD_Sat_Link

Initial Commit 16/6/22

Commit 12/7/22
-Provide example scripts for simulating orbits
-Change detector construction behaviour to avoid factory pattern
-Change protocol compatibility so that detector are not specific to a protocol
-Replace DPS model with corrected version

Commit 29/7/22
-correct QBER determination in DPS and COW models
-vectorise COW model
-plot function correctly labels secret key rate (in place of sifted key rate, previously used)
-implement Dark count rate as an abstract detector property and include the SetDarkCountRate method
-include Xinglong ground station object and .mat file of Beijing as a background light source
-inputParsers added for ground station, Telescope, Jamming_Laser, Background_Source and pass simulation classes
-move Mean_Photon_Number, g2, State_Probabilities and State_Prep_Error properties from source concrete classes to source superclass as they are common. subclasses now act to implement default values necessary for each protocol
-change COW_Source to use State_Probabilities property instead of Decoy_Probability. Decoy probability is the second of a 2-element State_Probabilities probability vector

Commit 8/8/22
-change examples and internal behaviour to be consistent with Constellation (12/7/22) merge
-change 100km and 500km LLAT files to pass over Errol
-fixed failure to construct a located object from a 3-element LLA vector
-fixed misrepresentation of GetXYZ output in IsEarthShadowed (method of Located_Object)
-change inputparser behaviour in Satellite to make function hints clearer to user
-include an example for using the DPS protocol

Commit
-new class SatQKDScenario which mirrors the satellite toolbox scenario to provide full general simulation of orbitting satellites
-new class SunSynchronousConstellation which allows the creation of a constellation of sun-synchronous orbitting satellites
-change of constellation and satellite class structures. Now a single satelliteScenario object is owned by the SatQKDScenario object
-provide ExampleSatQKDScenario script to explain new class structure