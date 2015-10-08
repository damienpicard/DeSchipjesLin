within DeSchipjesLin;
package Occupancy

  package BaseClasses

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

    model HourDayMonthSeason
      "Give the hour, the day, the month and the season during the year."
    //  parameter Integer hourList[:] "List of hours at which an event should be triggered";

      parameter Integer unixTime=1388530800
        "Unix time for the 1/1/2014 0:00AM for GMT + 1 (http://www.epochconverter.com/)";

      parameter Integer unixTimeEndMonth[12] = {1391209200, 1393628400, 1396303200, 1398895200, 1401573600, 1404165600, 1406844000, 1409522400, 1412114400, 1414796400, 1417388400, 1420066800} + ones(12)*3600
        "unixTime at end of each month from 1/02/2014 0:00AM GMT+1 until 1/01/2015 0:00AM GMT+1";

      parameter Integer unixTimeSeason[2] = {1395356400,  1411250400}
        "Unix time for March 21 2014 and September 21 2014 at 0:00AM GMT+1";
      Modelica.Blocks.Sources.RealExpression dayOfWeek_val(y=floor(mod((unixTime +
            time)/3600/24, 7)) + 1) "simulation time"
        annotation (Placement(transformation(extent={{-20,10},{40,30}})));
      Modelica.Blocks.Sources.RealExpression hourOfDay_val(y=floor(mod((unixTime +
            time)/3600, 24)) + 1) "Hour of the day"
        annotation (Placement(transformation(extent={{-20,50},{40,70}})));

      Modelica.Blocks.Sources.RealExpression monthOfYear_val(y=sum(integer((time +
            unixTime - floor(time/3600/24/365)*31536000)*ones(12) ./
            unixTimeEndMonth)) + 1)
        annotation (Placement(transformation(extent={{-20,-30},{40,-10}})));

      Modelica.Blocks.Interfaces.RealOutput hour "Value of Real output" annotation (
         Placement(transformation(extent={{100,50},{120,70}}), iconTransformation(
              extent={{100,50},{120,70}})));
      Modelica.Blocks.Interfaces.RealOutput day "Value of Real output" annotation (
          Placement(transformation(extent={{100,10},{120,30}}),  iconTransformation(
              extent={{100,10},{120,30}})));
      Modelica.Blocks.Interfaces.RealOutput month "Value of Real output"
        annotation (Placement(transformation(extent={{100,-30},{120,-10}}),
            iconTransformation(extent={{100,-30},{120,-10}})));
      Modelica.Blocks.Sources.RealExpression seasonOfYear_val(
                                                             y=integer((time +
            unixTime - floor(time/3600/24/365)*31536000) ./
            unixTimeSeason)*{1,-1})
        annotation (Placement(transformation(extent={{-20,-70},{40,-50}})));
      Modelica.Blocks.Interfaces.BooleanOutput season
        "Season: 0 = winter, 1 = summer"
        annotation (Placement(transformation(extent={{100,-70},{120,-50}}),
            iconTransformation(extent={{100,-80},{120,-60}})));
      Modelica.Blocks.Math.RealToBoolean realToBoolean
        annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
    equation
      connect(hourOfDay_val.y, hour) annotation (Line(
          points={{43,60},{110,60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(dayOfWeek_val.y, day) annotation (Line(
          points={{43,20},{110,20}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(monthOfYear_val.y, month) annotation (Line(
          points={{43,-20},{110,-20}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(seasonOfYear_val.y, realToBoolean.u) annotation (Line(
          points={{43,-60},{58,-60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(realToBoolean.y, season) annotation (Line(
          points={{81,-60},{110,-60}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{40,92}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{38,76},{-2,-2},{34,-32}},
              color={0,0,0},
              smooth=Smooth.None,
              thickness=1),
            Text(
              extent={{-100,-100},{100,-120}},
              lineColor={0,0,255},
              textString="%name")}));
    end HourDayMonthSeason;
  end BaseClasses;

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
            points={{-2,-52},{-30,-88},{-26,-90},{0,-56},{2,-56},{22,-90},{26,
                -88},{4,-52},{-2,-52}},
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
end Occupancy;
