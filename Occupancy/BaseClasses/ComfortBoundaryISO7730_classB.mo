within DeSchipjesLin.Occupancy.BaseClasses;
model ComfortBoundaryISO7730_classB
  parameter Boolean use_filter = true;
  IDEAS.Controls.SetPoints.Table UpBou(table=[-15 + 273.13,24 + 273.13; 10
         + 273.13,24 + 273.13; 15 + 273.13,26 + 273.13; 35 + 273.13,26 +
        273.13], constantExtrapolation=false) "upper temperature bound"
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  IDEAS.Controls.SetPoints.Table LowBou(table=[-15 + 273.13,20 + 273.13; 10
         + 273.13,20 + 273.13; 15 + 273.13,23 + 273.13; 35 + 273.13,23 +
        273.13], constantExtrapolation=false) "Lower temperature bound"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  IDEAS.Controls.ControlHeating.RunningMeanTemperatureEN15251
    runningMeanTemperatureEN15251_continuous
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealOutput TBouUp(unit="K", displayUnit="degC")
    "Upper temperature bound"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput TBouLow(unit="K", displayUnit="degC")
    "Lower temperature bound"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Continuous.Filter filter(
    final analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
    final filterType=Modelica.Blocks.Types.FilterType.LowPass,
    final order=2,
    final f_cut=5/(2*Modelica.Constants.pi*86400),
    final gain=1.0) if use_filter annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Blocks.Continuous.Filter filter1(
    final analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
    final filterType=Modelica.Blocks.Types.FilterType.LowPass,
    final order=2,
    final f_cut=5/(2*Modelica.Constants.pi*86400),
    final gain=1.0) if use_filter annotation (Placement(transformation(extent={{40,-60},{60,
            -40}})));
equation
  connect(runningMeanTemperatureEN15251_continuous.TRm, UpBou.u) annotation (
      Line(
      points={{-39.4,0},{-20,0},{-20,50},{-2,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(runningMeanTemperatureEN15251_continuous.TRm, LowBou.u) annotation (
      Line(
      points={{-39.4,0},{-20,0},{-20,-50},{-2,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  if use_filter then
    connect(UpBou.y, filter.u) annotation (Line(
      points={{21,50},{38,50}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(filter.y, TBouUp) annotation (Line(
      points={{61,50},{110,50}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(LowBou.y, filter1.u) annotation (Line(
      points={{21,-50},{38,-50}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(filter1.y, TBouLow) annotation (Line(
      points={{61,-50},{110,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  else
    connect(UpBou.y, TBouUp) annotation (Line(
      points={{21,50},{26,50},{26,68},{80,68},{80,50},{110,50}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(LowBou.y, TBouLow) annotation (Line(
      points={{21,-50},{28,-50},{28,-20},{80,-20},{80,-50},{110,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  end if;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-76},{-80,80}},
          color={0,0,0},
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-92,-60},{68,-60}},
          color={0,0,0},
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-72,-40},{-40,-40},{-20,-40},{0,-20},{40,-20}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-72,0},{-20,0},{0,10},{40,10}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-60,100},{60,80}},
          lineColor={0,0,0},
          textString="%name")}));
end ComfortBoundaryISO7730_classB;
