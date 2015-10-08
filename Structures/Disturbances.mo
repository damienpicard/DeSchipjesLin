within DeSchipjesLin.Structures;
model Disturbances

  parameter Boolean addAngles=true;
  parameter Boolean linearise=false;
  inner IDEAS.SimInfoManager
                       sim(
    nWindow=ssm.nWin,
    final linearise=false,
    final createOutputs=true,
    final nLayWin=max(ssm.winNLay))
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow slaapkamerRaam(
    A=0.75,
    frac=0.21,
    redeclare final Data.Glass.DubbelGlas glazing,
    redeclare final Data.Frames.LoofHout fraType,
    azi=frontAng,
    indexWindow=5,
    inc=1.5707963267949,
    removeDynamics=true)
    annotation (Placement(transformation(extent={{-80,-82},{-70,-62}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow woonruimteWindow(
    A=5.78,
    frac=0.12,
    redeclare final Data.Glass.DubbelGlas glazing,
    redeclare final Data.Frames.LoofHout fraType,
    azi=frontAng,
    indexWindow=1,
    inc=1.5707963267949,
    removeDynamics=true)
    annotation (Placement(transformation(extent={{-80,38},{-70,58}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow keukenWindowLarge(
    A=4.57,
    frac=0.15,
    redeclare final Data.Glass.DubbelGlas glazing,
    redeclare final Data.Frames.LoofHout fraType,
    azi=frontAng,
    indexWindow=2,
    inc=1.5707963267949,
    removeDynamics=true)
    annotation (Placement(transformation(extent={{-80,10},{-70,30}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow keukenWindowSmall(
    A=1.05,
    frac=0.25,
    redeclare final Data.Glass.DubbelGlas glazing,
    redeclare final Data.Frames.LoofHout fraType,
    azi=frontAng,
    indexWindow=3,
    inc=1.5707963267949,
    removeDynamics=true)
    annotation (Placement(transformation(extent={{-80,-20},{-70,0}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow raamwc(
    A=0.07,
    frac=0.89,
    redeclare final Data.Glass.DubbelGlas glazing,
    redeclare final Data.Frames.LoofHout fraType,
    azi=frontAng,
    indexWindow=4,
    inc=1.5707963267949,
    removeDynamics=true)
    annotation (Placement(transformation(extent={{-80,-50},{-70,-30}})));
  inner IDEAS.Buildings.Linearisation.Interfaces.WindowBus[sim.nWindow]
    winBusOut(each nLay=sim.nLayWin) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-10,52})));
protected
  output IDEAS.Buildings.Linearisation.Interfaces.WindowBus[sim.nWindow] winBus(each nLay
      =sim.nLayWin) "Dummy for getting outputs" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={28,52})));
public
  IDEAS.Buildings.Components.Interfaces.WeaBus weaBus1
    annotation (Placement(transformation(extent={{18,82},{38,102}})));
equation
  connect(winBusOut, winBus) annotation (Line(
      points={{-10,52},{28,52}},
      color={255,204,51},
      thickness=0.5));
  connect(sim.weaBus, weaBus1) annotation (Line(
      points={{-78.6,87.2},{-78.6,92},{28,92}},
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
