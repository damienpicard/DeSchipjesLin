within DeSchipjesLin.Occupancy.BaseClasses;
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
