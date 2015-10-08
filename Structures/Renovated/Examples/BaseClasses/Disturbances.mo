within DeSchipjesLin.Structures.Renovated.Examples.BaseClasses;
model Disturbances

  IDEAS.Buildings.Components.LinearizableWindow slaapkamerRaam(
    A=0.75,
    frac=0.21,
    redeclare Data.Frames.LoofHout fraType,
    use_ctrl=false,
    linearise=true,
    linOut=true,
    inc=1.5707963267949,
    azi=3.9444441095072)
    annotation (Placement(transformation(extent={{-66,-80},{-56,-60}})));
  IDEAS.Buildings.Components.LinearizableWindow raamwc(
    A=0.07,
    frac=0.89,
    redeclare Data.Frames.LoofHout fraType,
    use_ctrl=false,
    linearise=true,
    linOut=true,
    inc=1.5707963267949,
    azi=3.9444441095072)
    annotation (Placement(transformation(extent={{-66,-52},{-56,-32}})));
  IDEAS.Buildings.Components.LinearizableWindow keukenWindowSmall(
    A=1.05,
    frac=0.25,
    redeclare Data.Frames.LoofHout fraType,
    use_ctrl=false,
    linearise=true,
    linOut=true,
    inc=1.5707963267949,
    azi=2.3736477827123)
    annotation (Placement(transformation(extent={{-66,-26},{-56,-6}})));
  IDEAS.Buildings.Components.LinearizableWindow keukenWindowLarge(
    A=4.57,
    frac=0.15,
    redeclare Data.Frames.LoofHout fraType,
    use_ctrl=false,
    linearise=true,
    linOut=true,
    inc=1.5707963267949,
    azi=3.9444441095072)
    annotation (Placement(transformation(extent={{-66,0},{-56,20}})));
  IDEAS.Buildings.Components.LinearizableWindow woonruimteWindow(
    A=5.78,
    frac=0.12,
    redeclare Data.Frames.LoofHout fraType,
    use_ctrl=false,
    linearise=true,
    linOut=true,
    inc=3.9444441095072,
    azi=3.9444441095072)
    annotation (Placement(transformation(extent={{-66,26},{-56,46}})));
public
  inner IDEAS.SimInfoManager sim(
    linearise=linearise,
    addAngles=addAngles,
    offsetAzi=1.0995574287564)
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-78,56},{-58,76}})));
  output IDEAS.Buildings.Components.Interfaces.WinBus winBus1[5](nLay=3) annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-26,28}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=90,
        origin={98,-40})));
  output IDEAS.BoundaryConditions.WeatherData.Bus weaBus1(numSolBus=sim.numAzi + 1,
      addAngles=true)                                                               annotation (Placement(transformation(extent={{0,50},
            {20,70}}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,60})));
  parameter Boolean addAngles=true;
  parameter Boolean linearise=false;
equation
  connect(slaapkamerRaam.weaBus, sim.weaBus) annotation (Line(
      points={{-69,-60},{-80,-60},{-80,80},{-66.6,80},{-66.6,73.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(sim.weaBus, woonruimteWindow.weaBus) annotation (Line(
      points={{-66.6,73.2},{-66.6,80},{-80,80},{-80,46},{-69,46}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(keukenWindowLarge.weaBus, sim.weaBus) annotation (Line(
      points={{-69,20},{-80,20},{-80,80},{-66.6,80},{-66.6,73.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(keukenWindowSmall.weaBus, sim.weaBus) annotation (Line(
      points={{-69,-6},{-80,-6},{-80,80},{-66.6,80},{-66.6,73.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(raamwc.weaBus, sim.weaBus) annotation (Line(
      points={{-69,-32},{-80,-32},{-80,80},{-66.6,80},{-66.6,73.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(woonruimteWindow.winBus,winBus1 [1]) annotation (Line(
      points={{-54.6,30},{-44,30},{-44,44},{-26,44}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(keukenWindowLarge.winBus,winBus1 [2]) annotation (Line(
      points={{-54.6,4},{-42,4},{-42,36},{-26,36}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(keukenWindowSmall.winBus,winBus1 [3]) annotation (Line(
      points={{-54.6,-22},{-40,-22},{-40,28},{-26,28}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(raamwc.winBus,winBus1 [4]) annotation (Line(
      points={{-54.6,-48},{-38,-48},{-38,20},{-26,20}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(slaapkamerRaam.winBus,winBus1 [5]) annotation (Line(
      points={{-54.6,-76},{-32,-76},{-32,12},{-26,12}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sim.weaBus, weaBus1) annotation (Line(
      points={{-66.6,73.2},{-66.6,80},{10,80},{10,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-102}},
          pattern=LinePattern.None,
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-64,72},{20,-12}},
          lineColor={255,220,220},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,0}),
        Polygon(
          points={{-76,-22},{-72,-34},{-68,-36},{-42,-48},{-40,-48},{-20,-46},{-6,
              -50},{-2,-52},{6,-54},{12,-56},{26,-56},{30,-56},{42,-54},{44,-52},
              {54,-44},{62,-38},{64,-38},{68,-36},{78,-30},{80,-28},{82,-18},{82,
              -16},{78,-8},{74,2},{74,8},{72,16},{72,20},{62,28},{60,28},{46,26},
              {32,20},{20,16},{12,14},{-2,16},{-10,16},{-26,16},{-30,10},{-34,-2},
              {-36,-8},{-44,-12},{-48,-12},{-62,-12},{-64,-12},{-76,-22}},
          smooth=Smooth.Bezier,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    experiment(StopTime=3.1536e+007, Interval=900),
    __Dymola_experimentSetupOutput(events=false));
end Disturbances;
