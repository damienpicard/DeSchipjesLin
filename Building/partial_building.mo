within DeSchipjesLin.Building;
partial model partial_building
  parameter Integer nZones = 6;
  Structures.StructureH structureH(linearise=false)
    annotation (Placement(transformation(extent={{-80,-20},{-40,20}})));
  HeatingSystems.PrescribedHeat_pid prescribedHeat_pid
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Occupancy.Occupant occupant
    annotation (Placement(transformation(extent={{-20,-80},{20,-40}})));
  inner IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
equation
  connect(prescribedHeat_pid.portCon,structureH. heatPortCon)
    annotation (Line(points={{-20,12},{-30,12},{-30,4},{-40,4}},
                                                             color={191,0,0}));
  connect(prescribedHeat_pid.portRad,structureH. heatPortRad)
    annotation (Line(points={{-20,0},{-30,0},{-30,-2},{-40,-2},{-40,-4}},
                                                        color={191,0,0}));
  annotation (Icon(graphics={
        Line(
          points={{56,36},{-4,88},{-64,38},{-64,-32},{56,-32}},
          color={127,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{56,36},{52,32},{-4,78},{-58,34},{-58,-26},{56,-26},{56,-32},
              {-64,-32},{-64,38},{-4,88},{56,36}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,20},{-50,8},{-48,6},{-28,18},{-28,30},{-30,32},{-50,20}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,-4},{-50,-16},{-48,-18},{-28,-6},{-28,6},{-30,8},{-50,-4}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-48,10},{-54,6},{-54,-18},{-50,-22},{24,-22},{38,-12}},
          color={127,0,0},
          smooth=Smooth.None),
        Line(
          points={{-54,-18},{-48,-14}},
          color={127,0,0},
          smooth=Smooth.None),
        Line(
          points={{-28,28},{-24,30},{-24,-4},{-20,-8},{-20,-8},{36,-8}},
          color={127,0,0},
          smooth=Smooth.None),
        Line(
          points={{-28,4},{-24,6}},
          color={127,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{36,2},{36,-18},{46,-24},{54,-18},{54,-2},{50,4},{44,8},{36,2}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-104,-46},{96,-86}},
          lineColor={127,0,0},
          textString="%name")}));
end partial_building;
