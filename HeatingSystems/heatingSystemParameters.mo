within DeSchipjesLin.HeatingSystems;
record heatingSystemParameters
    extends Modelica.Icons.Record;

  parameter Integer nZones=6;
  parameter Modelica.SIunits.Power powerZones[nZones] = 40.*{70,17.13,3.86,25,8,7.24} .*{0.6,1,1,1,1,0.8};
end heatingSystemParameters;
