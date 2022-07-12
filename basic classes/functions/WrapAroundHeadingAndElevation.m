function [Heading,Elevation]=WrapAroundHeadingAndElevation(r,Previous_Heading)
%%WRAPAROUNDHEADINGANDELEVATION compute the heading and elevation of a 3D vector r and choose the heading angle which minimises distance to the previous heading angle to improve plotting

[Heading,Elevation]=HeadingAndElevation(r);
   %wrap heading around to visualise easier
   if abs(Heading-360-Previous_Heading)<abs(Heading-Previous_Heading)
      Heading=Heading-360;
   elseif abs(Heading+360-Previous_Heading)<abs(Heading-Previous_Heading)
      Heading=Heading+360;
   end