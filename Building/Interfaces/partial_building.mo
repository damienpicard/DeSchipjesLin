within DeSchipjesLin.Building.Interfaces;
partial model partial_building
  final parameter Integer nZones = stru.nZones;
  replaceable Structures.partial_structure stru(linearise=false)
    annotation (Placement(transformation(extent={{-80,-20},{-40,20}})));
  HeatingSystems.PrescribedHeat_pid prescribedHeat_pid
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Occupancy.Occupant occ
    annotation (Placement(transformation(extent={{-20,-72},{20,-32}})));
  inner IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Modelica.Blocks.Continuous.Integrator discomfortAve_int
    annotation (Placement(transformation(extent={{86,68},{98,80}})));
  Modelica.Blocks.Sources.RealExpression realExp[nZones](y=stru.TSensor - occ.TZoneSetUp
        *ones(nZones))
    annotation (Placement(transformation(extent={{-56,68},{-26,96}})));
  Modelica.Blocks.Sources.RealExpression realExp2[nZones](y=occ.TZoneSetLow*
        ones(nZones) - stru.TSensor)
    annotation (Placement(transformation(extent={{-54,34},{-24,62}})));
  Modelica.Blocks.Math.Max discomfortUp_val[6]
    annotation (Placement(transformation(extent={{-10,70},{4,84}})));
  Modelica.Blocks.Math.Max discomfortLow_val[6]
    annotation (Placement(transformation(extent={{-10,46},{4,60}})));
  Modelica.Blocks.Sources.Constant const[nZones](each k=0)
    annotation (Placement(transformation(extent={{-44,62},{-34,72}})));
  Modelica.Blocks.Sources.RealExpression discomfortAve(y=(sum(discomfortUp_val.y)
         + sum(discomfortLow_val.y))/nZones)
    annotation (Placement(transformation(extent={{46,60},{76,88}})));
  Modelica.Blocks.Math.MinMax discomfortMax(nu=12)
    annotation (Placement(transformation(extent={{16,56},{36,76}})));
equation
  connect(prescribedHeat_pid.portCon, stru.heatPortCon) annotation (Line(points=
         {{-20,12},{-30,12},{-30,4},{-40,4}}, color={191,0,0}));
  connect(prescribedHeat_pid.portRad, stru.heatPortRad) annotation (Line(points=
         {{-20,0},{-30,0},{-30,-2},{-40,-2},{-40,-4}}, color={191,0,0}));
  connect(realExp.y, discomfortUp_val.u1) annotation (Line(points={{-24.5,82},{
          -11.4,82},{-11.4,81.2}}, color={0,0,127}));
  connect(realExp2.y, discomfortLow_val.u2) annotation (Line(points={{-22.5,48},
          {-17.25,48},{-17.25,48.8},{-11.4,48.8}}, color={0,0,127}));
  connect(const.y, discomfortUp_val.u2) annotation (Line(points={{-33.5,67},{
          -18,67},{-18,72.8},{-11.4,72.8}}, color={0,0,127}));
  connect(const.y, discomfortLow_val.u1) annotation (Line(points={{-33.5,67},{
          -18,67},{-18,57.2},{-11.4,57.2}}, color={0,0,127}));
  connect(discomfortAve.y, discomfortAve_int.u)
    annotation (Line(points={{77.5,74},{84.8,74}}, color={0,0,127}));
  connect(discomfortUp_val.y, discomfortMax.u[1:6]) annotation (Line(points={{
          4.7,77},{10,77},{10,66.5833},{16,66.5833}}, color={0,0,127}));
  connect(discomfortLow_val.y, discomfortMax.u[7:12]) annotation (Line(points={
          {4.7,53},{8,53},{8,54},{10,54},{10,60},{16,60},{16,59.5833}}, color={
          0,0,127}));
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
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end partial_building;
