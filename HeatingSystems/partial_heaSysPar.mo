within DeSchipjesLin.HeatingSystems;
record partial_heaSysPar
    extends Modelica.Icons.Record;

  parameter Integer nZones=6;
  parameter Modelica.SIunits.Power powerZones[nZones];
end partial_heaSysPar;
