within DeSchipjesLin.Occupancy;
model Occupant

  parameter Integer timNight = 22;
  parameter Integer timMorning = 7;
  parameter Real corTBouLowNight = 0;
  parameter Real corTBouLowDay = 0;

protected
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
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Logical.LessThreshold greaterThreshold1(each threshold=8)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,50})));
  Modelica.Blocks.Logical.Or  or1
    annotation (Placement(transformation(extent={{-2,58},{18,78}})));
public
  Modelica.Blocks.Interfaces.RealOutput TZoneSetUp(unit="K", displayUnit="degC")
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));

  Modelica.Blocks.Interfaces.RealOutput TZoneSetLow(unit="K", displayUnit=
        "degC") "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput TRefControl(unit="K", displayUnit="degC")
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
protected
  Modelica.Blocks.Logical.Switch switchBouLow1
                                              annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={50,-60})));
  Modelica.Blocks.Logical.LessThreshold greaterThreshold2(each threshold=
        timMorning)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-66,-84})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold3(each threshold=
        timNight)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-66,-60})));
  Modelica.Blocks.Logical.Or  or2
    annotation (Placement(transformation(extent={{-40,-78},{-28,-66}})));
  Modelica.Blocks.Sources.Constant const(k=corTBouLowDay)
    annotation (Placement(transformation(extent={{4,-58},{14,-48}})));
  Modelica.Blocks.Sources.Constant const1(k=corTBouLowNight)
    annotation (Placement(transformation(extent={{4,-94},{14,-84}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{20,-50},{30,-40}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{22,-88},{32,-78}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{26,62},{38,74}})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{-20,-78},{-8,-66}})));
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
  connect(hourDayMonthSeason.hour, greaterThreshold.u) annotation (Line(points={{-79,96},
          {-50,96},{-50,80},{-42,80}},          color={0,0,127}));
  connect(hourDayMonthSeason.hour, greaterThreshold1.u) annotation (Line(points={{-79,96},
          {-50,96},{-50,50},{-42,50}},          color={0,0,127}));
  connect(greaterThreshold.y, or1.u1) annotation (Line(points={{-19,80},{-10,80},
          {-10,68},{-4,68}}, color={255,0,255}));
  connect(greaterThreshold1.y, or1.u2) annotation (Line(points={{-19,50},{-8,50},
          {-8,60},{-4,60}}, color={255,0,255}));
  connect(switchBouLow.u2, switchBouUp.u2) annotation (Line(points={{-41.6,-20},
          {-52,-20},{-52,20},{-39.6,20}}, color={255,0,255}));
  connect(switchBouUp.y, TZoneSetUp)
    annotation (Line(points={{-21.2,20},{110,20}}, color={0,0,127}));
  connect(switchBouLow.y, TZoneSetLow)
    annotation (Line(points={{-23.2,-20},{110,-20}}, color={0,0,127}));
  connect(greaterThreshold3.y, or2.u1) annotation (Line(points={{-55,-60},{-41.2,
          -60},{-41.2,-72}}, color={255,0,255}));
  connect(greaterThreshold2.y, or2.u2) annotation (Line(points={{-55,-84},{-42,-84},
          {-42,-76.8},{-41.2,-76.8}}, color={255,0,255}));
  connect(const.y, add.u2)
    annotation (Line(points={{14.5,-53},{19,-53},{19,-48}}, color={0,0,127}));
  connect(const1.y, add1.u2)
    annotation (Line(points={{14.5,-89},{21,-89},{21,-86}}, color={0,0,127}));
  connect(comfortBoundaryISO7730_classB.TBouLow, add.u1) annotation (Line(
        points={{-59,-5},{10,-5},{10,-42},{19,-42}}, color={0,0,127}));
  connect(TBouLow.y, add1.u1) annotation (Line(points={{-59,-30},{-30,-30},{0,-30},
          {0,-80},{21,-80}}, color={0,0,127}));
  connect(add1.y, switchBouLow1.u3) annotation (Line(points={{32.5,-83},{40.4,-83},
          {40.4,-66.4}}, color={0,0,127}));
  connect(add.y, switchBouLow1.u1) annotation (Line(points={{30.5,-45},{40.4,-45},
          {40.4,-53.6}}, color={0,0,127}));
  connect(hourDayMonthSeason.hour, greaterThreshold3.u) annotation (Line(points=
         {{-79,96},{-66,96},{-66,60},{-100,60},{-100,-60},{-78,-60}}, color={0,0,
          127}));
  connect(greaterThreshold2.u, greaterThreshold3.u) annotation (Line(points={{-78,
          -84},{-100,-84},{-100,-60},{-78,-60}}, color={0,0,127}));
  connect(switchBouLow1.y, TRefControl) annotation (Line(points={{58.8,-60},{110,
          -60},{110,-60}}, color={0,0,127}));
  connect(or1.y, not1.u)
    annotation (Line(points={{19,68},{24.8,68}}, color={255,0,255}));
  connect(not1.y, switchBouUp.u2) annotation (Line(points={{38.6,68},{46,68},{
          46,34},{-52,34},{-52,20},{-39.6,20}}, color={255,0,255}));
  connect(or2.y, not2.u)
    annotation (Line(points={{-27.4,-72},{-21.2,-72}}, color={255,0,255}));
  connect(not2.y, switchBouLow1.u2) annotation (Line(points={{-7.4,-72},{20,-72},
          {20,-60},{40.4,-60}}, color={255,0,255}));
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
