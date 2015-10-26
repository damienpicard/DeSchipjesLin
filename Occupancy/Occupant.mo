within DeSchipjesLin.Occupancy;
model Occupant

  BaseClasses.ComfortBoundaryISO7730_classB comfortBoundaryISO7730_classB
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(each threshold=22)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,80})));
  Modelica.Blocks.Logical.Switch switchBouLow annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-32,-20})));
  Modelica.Blocks.Sources.Constant TBouLow(k=273.15 + 17)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Sources.Constant TBouUp(k=273.15 + 30)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Logical.Switch switchBouUp annotation (Placement(
        transformation(
        extent={{-8,8},{8,-8}},
        rotation=0,
        origin={-30,20})));
  BaseClasses.HourDayMonthSeason hourDayMonthSeason
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Logical.LessThreshold greaterThreshold1(each threshold=8)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,50})));
  Modelica.Blocks.Logical.Or  or1
    annotation (Placement(transformation(extent={{-2,58},{18,78}})));
  Modelica.Blocks.Interfaces.RealOutput TZoneSetUp(unit="K", displayUnit="degC")
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput TZoneSetUpLow(unit="K", displayUnit="degC")
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
equation
  connect(comfortBoundaryISO7730_classB.TBouUp, switchBouUp.u1) annotation (
      Line(points={{-59,5},{-50,5},{-50,14},{-39.6,14},{-39.6,13.6}}, color={0,0,
          127}));
  connect(TBouUp.y, switchBouUp.u3) annotation (Line(points={{-59,30},{-50,30},{
          -50,26.4},{-39.6,26.4}}, color={0,0,127}));
  connect(TBouLow.y, switchBouLow.u3) annotation (Line(points={{-59,-30},{-48,-30},
          {-48,-26.4},{-41.6,-26.4}}, color={0,0,127}));
  connect(comfortBoundaryISO7730_classB.TBouLow, switchBouLow.u1) annotation (
      Line(points={{-59,-5},{-50,-5},{-50,-13.6},{-41.6,-13.6}}, color={0,0,127}));
  connect(hourDayMonthSeason.hour, greaterThreshold.u) annotation (Line(points={
          {-59,76},{-50,76},{-50,80},{-42,80}}, color={0,0,127}));
  connect(hourDayMonthSeason.hour, greaterThreshold1.u) annotation (Line(points=
         {{-59,76},{-50,76},{-50,50},{-42,50}}, color={0,0,127}));
  connect(greaterThreshold.y, or1.u1) annotation (Line(points={{-19,80},{-10,80},
          {-10,68},{-4,68}}, color={255,0,255}));
  connect(greaterThreshold1.y, or1.u2) annotation (Line(points={{-19,50},{-8,50},
          {-8,60},{-4,60}}, color={255,0,255}));
  connect(or1.y, switchBouUp.u2) annotation (Line(points={{19,68},{46,68},{46,34},
          {-52,34},{-52,20},{-39.6,20}}, color={255,0,255}));
  connect(switchBouLow.u2, switchBouUp.u2) annotation (Line(points={{-41.6,-20},
          {-52,-20},{-52,20},{-39.6,20}}, color={255,0,255}));
  connect(switchBouUp.y, TZoneSetUp)
    annotation (Line(points={{-21.2,20},{110,20}}, color={0,0,127}));
  connect(switchBouLow.y, TZoneSetUpLow)
    annotation (Line(points={{-23.2,-20},{110,-20}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-12,46},{14,20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-2,20},{4,-52}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{4,-4},{30,16},{32,12},{4,-10},{-2,-8},{4,-4}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,-10},{-30,12},{-26,16},{-2,-4},{-2,-10}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,-52},{-30,-88},{-26,-90},{0,-56},{2,-56},{22,-90},{26,-88},
              {4,-52},{-2,-52}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,100},{100,60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end Occupant;
