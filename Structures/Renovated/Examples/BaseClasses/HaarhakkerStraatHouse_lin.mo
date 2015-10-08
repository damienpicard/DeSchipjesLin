within DeSchipjesLin.Structures.Renovated.Examples.BaseClasses;
model HaarhakkerStraatHouse_lin
  // FIXME: all dynamics are now on steady state to simplify the initialization in matlab. This should be changed.
  package Medium = IDEAS.Media.Air;
  parameter Boolean horInc = true
    "Set to true to have only horizontal and vertical surfaces.";
  parameter Integer nZones = 6;
  HaarhakkerStraatHouse buiStr(
    redeclare package Medium = Medium,
    slaapkamerDakLinks(inc=if horInc then 0 else 300/180*Modelica.Constants.pi),
    slaapkamerDakRechts(inc=if horInc then 0 else 120/180*Modelica.Constants.pi),
    badkamerDak(inc=if horInc then 0 else 306/180*Modelica.Constants.pi),
    halDak(inc=if horInc then 0 else 306/180*Modelica.Constants.pi),
    T_start=293.15*ones(nZones),
    woonruimte,
    keuken,
    wc,
    slaapkamer,
    badkamer,
    nachthal,
    addAngles=addAngles,
    linearise=linearise)
    annotation (Placement(transformation(extent={{-16,-10},{14,10}})));

  inner Modelica.Fluid.System system
  annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  inner IDEAS.SimInfoManager sim(linearise=linearise,
    addAngles=addAngles,
    offsetAzi=1.0995574287564)
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));

  Modelica.Blocks.Interfaces.RealInput Q_flowConv[nZones](each start=100) annotation (Placement(
        transformation(extent={{-130,16},{-90,56}}),   iconTransformation(
          extent={{-130,16},{-90,56}})));
  Modelica.Blocks.Interfaces.RealInput Q_flowRad[nZones](each start=100)
    annotation (Placement(transformation(extent={{-130,-58},{-90,-18}})));

  input IDEAS.BoundaryConditions.WeatherData.Bus weaBus1(numSolBus=sim.numAzi +
        1, addAngles=addAngles)
    annotation (Placement(transformation(
        extent={{-16,-16},{16,16}},
        rotation=270,
        origin={100,60}),iconTransformation(
        extent={{-14,14},{14,-14}},
        rotation=270,
        origin={-100,80})));
  input IDEAS.Buildings.Components.Interfaces.WinBus winBus1[5](nLay=3) annotation (
      Placement(transformation(
        extent={{-18,-17},{18,17}},
        rotation=270,
        origin={99,30}),  iconTransformation(
        extent={{-14,12},{14,-12}},
        rotation=270,
        origin={-100,-80})));
  Modelica.Blocks.Interfaces.RealOutput TSensor[6]
    "Sensor temperature of the zones" annotation (Placement(transformation(
          extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{
            120,10}})));
  IDEAS.Utilities.IO.heatPortPrescribedHeatFlow convHeat[nZones]
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  IDEAS.Utilities.IO.heatPortPrescribedHeatFlow radHeat[nZones]
    annotation (Placement(transformation(extent={{-80,-20},{-60,-40}})));
  Modelica.SIunits.Temperature TZoneAir[nZones] = {buiStr.woonruimte.TAir,buiStr.keuken.TAir,buiStr.wc.TAir,buiStr.slaapkamer.TAir,buiStr.badkamer.TAir,buiStr.nachthal.TAir};
  Modelica.Blocks.Sources.RealExpression realExpression[nZones](y=TZoneAir)
    annotation (Placement(transformation(extent={{60,-22},{80,-2}})));
  parameter Boolean addAngles=false;
  parameter Boolean linearise=true;
equation
  connect(buiStr.weaBus, weaBus1) annotation (Line(
      points={{21,10},{50,10},{50,60},{100,60}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(buiStr.winBus, winBus1) annotation (Line(
      points={{21,2},{60,2},{60,30},{99,30}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(convHeat.port1, buiStr.heatPortCon) annotation (Line(
      points={{-60,30},{16,30},{16,2},{14,2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(radHeat.port1, buiStr.heatPortRad) annotation (Line(
      points={{-60,-30},{16,-30},{16,-2},{14,-2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(radHeat.Q_flow, Q_flowRad) annotation (Line(
      points={{-80.8,-37},{-102,-37},{-102,-38},{-110,-38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(convHeat.Q_flow, Q_flowConv) annotation (Line(
      points={{-80.8,37},{-93.4,37},{-93.4,36},{-110,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression.y, TSensor) annotation (Line(
      points={{81,-12},{86,-12},{86,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=10000),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                    graphics));
end HaarhakkerStraatHouse_lin;
