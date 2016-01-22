within DeSchipjesLin.MatlabUtilities;
model partial_preComputed

    // Orientations
   parameter Modelica.SIunits.Angle leftAng=63/180*Modelica.Constants.pi;
   parameter Modelica.SIunits.Angle rightAng=243/180*Modelica.Constants.pi;
   parameter Modelica.SIunits.Angle frontAng=153/180*Modelica.Constants.pi;
   parameter Modelica.SIunits.Angle backAng=-27/180*Modelica.Constants.pi;

   // extends IDEAS.Buildings.Linearisation.Interfaces.LinearisationInterface
   //     (sim(createOutputs=true, linearise=false, nWindow=5));

   inner IDEAS.SimInfoManager
                        sim(
     nWindow=5,
      linearise=false,
      createOutputs=true,
      nLayWin=3,
    offsetAzi=frontAng)
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
   inner output IDEAS.Buildings.Components.Interfaces.WeaBus weaBus(
       outputAngles=not sim.linearise,  numSolBus=sim.numAzi + 1) if
                                       sim.createOutputs annotation (Placement(
         transformation(
         extent={{-19,-19},{19,19}},
         rotation=270,
         origin={55,91})));

  IDEAS.Buildings.Linearisation.Components.LinWindow slaapkamerRaam(
    A=0.75,
    frac=0.21,
    redeclare Structures.Data.Glass.DubbelGlas
                                          glazing,
    redeclare Structures.Data.Frames.LoofHout
                                         fraType,
    azi=frontAng,
    indexWindow=5,
    inc=1.5707963267949,
    createOutputsOnly=true)
    annotation (Placement(transformation(extent={{-80,-82},{-70,-62}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow woonruimteWindow(
    A=5.78,
    frac=0.12,
    redeclare Structures.Data.Glass.DubbelGlas
                                          glazing,
    redeclare Structures.Data.Frames.LoofHout
                                         fraType,
    azi=frontAng,
    indexWindow=1,
    inc=1.5707963267949,
    createOutputsOnly=true)
    annotation (Placement(transformation(extent={{-80,38},{-70,58}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow keukenWindowLarge(
    A=4.57,
    frac=0.15,
    redeclare Structures.Data.Glass.DubbelGlas
                                          glazing,
    redeclare Structures.Data.Frames.LoofHout
                                         fraType,
    azi=frontAng,
    indexWindow=2,
    inc=1.5707963267949,
    createOutputsOnly=true)
    annotation (Placement(transformation(extent={{-80,10},{-70,30}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow keukenWindowSmall(
    A=1.05,
    frac=0.25,
    redeclare Structures.Data.Glass.DubbelGlas
                                          glazing,
    redeclare Structures.Data.Frames.LoofHout
                                         fraType,
    azi=frontAng,
    indexWindow=3,
    inc=1.5707963267949,
    createOutputsOnly=true)
    annotation (Placement(transformation(extent={{-80,-20},{-70,0}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow raamwc(
    A=0.07,
    frac=0.89,
    redeclare Structures.Data.Glass.DubbelGlas
                                          glazing,
    redeclare Structures.Data.Frames.LoofHout
                                         fraType,
    azi=frontAng,
    indexWindow=4,
    inc=1.5707963267949,
    createOutputsOnly=true)
    annotation (Placement(transformation(extent={{-80,-50},{-70,-30}})));

  Occupancy.Occupant occupant
    annotation (Placement(transformation(extent={{-40,-26},{-20,-6}})));
  IDEAS.Controls.ControlHeating.HeatingCurves.HeatingCurve heatingCurve(
    use_TRoo_in=true,
    TSup_nominal=343.15,
    TSupMin=308.15,
    TRet_nominal=323.15,
    TOut_nominal=263.15)
    annotation (Placement(transformation(extent={{36,-56},{56,-76}})));
  Occupancy.BaseClasses.RunningMeanTemperature6h TRm6h
    annotation (Placement(transformation(extent={{2,-82},{22,-62}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te)
    annotation (Placement(transformation(extent={{22,-102},{2,-82}})));
  Modelica.Blocks.Math.Add add1(k1=0.5, k2=0.5)
    annotation (Placement(transformation(extent={{2,-58},{22,-38}})));
  Modelica.Blocks.Interfaces.RealOutput TZoneSetUp
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput TZoneSetLow
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
  Modelica.Blocks.Interfaces.RealOutput TSup "Setpoint for supply temperature"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Blocks.Interfaces.RealOutput TRefControl
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{90,-26},{110,-6}})));
equation
  connect(realExpression.y,TRm6h. TIn)
    annotation (Line(points={{1,-92},{1,-72},{1.4,-72}},    color={0,0,127}));
  connect(TRm6h.TRm, heatingCurve.TOut) annotation (Line(points={{22.6,-72},{22.6,
          -72},{34,-72}},      color={0,0,127}));
  connect(occupant.TZoneSetUp, add1.u1) annotation (Line(points={{-19,-14},{-6,-14},
          {-6,-42},{0,-42}},      color={0,0,127}));
  connect(occupant.TZoneSetUp, TZoneSetUp) annotation (Line(points={{-19,-14},{-6,
          -14},{-6,0},{100,0}},    color={0,0,127}));
  connect(heatingCurve.TSup, TSup) annotation (Line(points={{57,-72},{80,-72},{80,
          -40},{100,-40}},    color={0,0,127}));
  connect(add1.y, heatingCurve.TRoo_in) annotation (Line(points={{23,-48},{28,-48},
          {28,-60},{34.1,-60}},      color={0,0,127}));
  connect(sim.weaBus, weaBus) annotation (Line(
      points={{-78.6,87.2},{-78.6,91},{55,91}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(occupant.TZoneSetLow, TZoneSetLow) annotation (Line(points={{-19,-18},
          {-10,-18},{-10,20},{100,20}}, color={0,0,127}));
  connect(occupant.TRefControl, add1.u2) annotation (Line(points={{-19,-22},{-10,
          -22},{-10,-54},{0,-54}}, color={0,0,127}));
  connect(occupant.TRefControl, TRefControl) annotation (Line(points={{-19,-22},
          {0,-22},{0,-16},{100,-16}}, color={0,0,127}));
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
end partial_preComputed;
