within DeSchipjesLin.MatlabUtilities;
model PreComputed

    // Orientations
  final parameter Modelica.SIunits.Angle leftAng=63/180*Modelica.Constants.pi;
  final parameter Modelica.SIunits.Angle rightAng=243/180*Modelica.Constants.pi;
  final parameter Modelica.SIunits.Angle frontAng=153/180*Modelica.Constants.pi;
  final parameter Modelica.SIunits.Angle backAng=-27/180*Modelica.Constants.pi;
  inner IDEAS.SimInfoManager
                       sim(
    nWindow=5,
    final linearise=false,
    final createOutputs=true,
    final nLayWin=3)
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));

  inner IDEAS.Buildings.Linearisation.Interfaces.WindowBus[sim.nWindow] winBusOut(each nLay=
       3) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-20,62})));
protected
  inner input IDEAS.Buildings.Linearisation.Interfaces.WindowBus[sim.nWindow]
    winBusIn(each nLay=sim.nLayWin) if sim.linearise;

public
  inner output IDEAS.Buildings.Components.Interfaces.WeaBus weaBus(final
      outputAngles=not sim.linearise, final numSolBus=sim.numAzi + 1) if
                                      sim.createOutputs annotation (Placement(
        transformation(
        extent={{-19,-19},{19,19}},
        rotation=270,
        origin={55,91})));

  IDEAS.Buildings.Linearisation.Components.LinWindow slaapkamerRaam(
    A=0.75,
    frac=0.21,
    redeclare final Structures.Data.Glass.DubbelGlas
                                          glazing,
    redeclare final Structures.Data.Frames.LoofHout
                                         fraType,
    azi=frontAng,
    indexWindow=5,
    inc=1.5707963267949,
    removeDynamics=true)
    annotation (Placement(transformation(extent={{-80,-82},{-70,-62}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow woonruimteWindow(
    A=5.78,
    frac=0.12,
    redeclare final Structures.Data.Glass.DubbelGlas
                                          glazing,
    redeclare final Structures.Data.Frames.LoofHout
                                         fraType,
    azi=frontAng,
    indexWindow=1,
    inc=1.5707963267949,
    removeDynamics=true)
    annotation (Placement(transformation(extent={{-80,38},{-70,58}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow keukenWindowLarge(
    A=4.57,
    frac=0.15,
    redeclare final Structures.Data.Glass.DubbelGlas
                                          glazing,
    redeclare final Structures.Data.Frames.LoofHout
                                         fraType,
    azi=frontAng,
    indexWindow=2,
    inc=1.5707963267949,
    removeDynamics=true)
    annotation (Placement(transformation(extent={{-80,10},{-70,30}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow keukenWindowSmall(
    A=1.05,
    frac=0.25,
    redeclare final Structures.Data.Glass.DubbelGlas
                                          glazing,
    redeclare final Structures.Data.Frames.LoofHout
                                         fraType,
    azi=frontAng,
    indexWindow=3,
    inc=1.5707963267949,
    removeDynamics=true)
    annotation (Placement(transformation(extent={{-80,-20},{-70,0}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow raamwc(
    A=0.07,
    frac=0.89,
    redeclare final Structures.Data.Glass.DubbelGlas
                                          glazing,
    redeclare final Structures.Data.Frames.LoofHout
                                         fraType,
    azi=frontAng,
    indexWindow=4,
    inc=1.5707963267949,
    removeDynamics=true)
    annotation (Placement(transformation(extent={{-80,-50},{-70,-30}})));

  Occupancy.Occupant occupant
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  IDEAS.Controls.ControlHeating.HeatingCurves.HeatingCurve heatingCurve(
    use_TRoo_in=true,
    TSup_nominal=343.15,
    TSupMin=308.15,
    TRet_nominal=323.15,
    TOut_nominal=263.15)
    annotation (Placement(transformation(extent={{36,-48},{56,-68}})));
  Occupancy.BaseClasses.RunningMeanTemperature6h TRm6h
    annotation (Placement(transformation(extent={{2,-74},{22,-54}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te)
    annotation (Placement(transformation(extent={{22,-96},{2,-76}})));
  Modelica.Blocks.Math.Add add1(k1=0.5, k2=0.5)
    annotation (Placement(transformation(extent={{2,-46},{22,-26}})));
  Modelica.Blocks.Interfaces.RealOutput TZoneSetUp
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput TZoneSetLow
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
  Modelica.Blocks.Interfaces.RealOutput TSup "Setpoint for supply temperature"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
equation
  connect(realExpression.y,TRm6h. TIn)
    annotation (Line(points={{1,-86},{1,-64},{1.4,-64}},    color={0,0,127}));
  connect(TRm6h.TRm, heatingCurve.TOut) annotation (Line(points={{22.6,-64},{
          28.3,-64},{34,-64}}, color={0,0,127}));
  connect(occupant.TZoneSetUpLow, add1.u2) annotation (Line(points={{-19,-32},{
          -10,-32},{-10,-42},{0,-42}}, color={0,0,127}));
  connect(occupant.TZoneSetUp, add1.u1) annotation (Line(points={{-19,-28},{-6,
          -28},{-6,-30},{0,-30}}, color={0,0,127}));
  connect(occupant.TZoneSetUp, TZoneSetUp) annotation (Line(points={{-19,-28},{
          -6,-28},{-6,0},{100,0}}, color={0,0,127}));
  connect(occupant.TZoneSetUpLow, TZoneSetLow) annotation (Line(points={{-19,-32},
          {-10,-32},{-10,20},{100,20}}, color={0,0,127}));
  connect(heatingCurve.TSup, TSup) annotation (Line(points={{57,-64},{80,-64},{
          80,-20},{100,-20}}, color={0,0,127}));
  connect(add1.y, heatingCurve.TRoo_in) annotation (Line(points={{23,-36},{28,
          -36},{28,-52},{34.1,-52}}, color={0,0,127}));
  connect(sim.weaBus, weaBus) annotation (Line(
      points={{-78.6,87.2},{-78.6,91},{55,91}},
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
end PreComputed;
