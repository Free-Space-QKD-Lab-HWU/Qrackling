# QKD_Sat_Link

Initial Commit 16/6/22

Commit 12/7/22
-Provide example scripts for simulating orbits
-Change detector construction behaviour to avoid factory pattern
-Change protocol compatibility so that detector are not specific to a protocol
-Replace DPS model with corrected version

Commit
-correct QBER determination in DPS and COW models
-vectorise COW model
-plot function correctly labels secret key rate (in place of sifted key rate, previously used)
-implement Dark count rate as an abstract detector property and include the SetDarkCountRate method
-include Xinglong ground station object and .mat file of Beijing as a background light source
-inputParsers added for ground station, Telescope, Jamming_Laser, Background_Source and pass simulation classes
-move Mean_Photon_Number, g2, State_Probabilities and State_Prep_Error properties from source concrete classes to source superclass as they are common. subclasses now act to implement default values necessary for each protocol
-change COW_Source to use State_Probabilities property instead of Decoy_Probability. Decoy probability is the second of a 2-element State_Probabilities probability vector