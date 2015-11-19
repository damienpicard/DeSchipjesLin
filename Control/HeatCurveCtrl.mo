within DeSchipjesLin.Control;
model HeatCurveCtrl
  extends Interface;

  parameter Integer nZones=6;
  parameter Integer i_thermostat(
    min=1,
    max=nZones) = 2 "Index of zone in which the thermostat is";
  parameter Modelica.SIunits.ThermalConductance G[nZones]=heaSysPar.powerZones/40
    "Thermal conductance of radiators";
  parameter Modelica.SIunits.TemperatureDifference deltaT_nom=4
    "Nominal temperature difference between zone set point temperature and actual temperature";
  parameter Real corr[nZones]=ones(6)
    "Correction coefficient for the proportional controller of each zone";

  IDEAS.Controls.Discrete.HysteresisRelease onOff(revert=true, enableRelease=false)
    annotation (Placement(transformation(extent={{30,68},{10,88}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{66,72},{48,54}})));
  Modelica.Blocks.Sources.Constant const(k=3)
    annotation (Placement(transformation(extent={{94,62},{82,74}})));
  Modelica.Blocks.Interfaces.RealInput TZones[nZones] "Zone temperature"
    annotation (Placement(transformation(extent={{128,60},{88,100}})));
  IDEAS.Controls.ControlHeating.HeatingCurves.HeatingCurve heatingCurve(
    use_TRoo_in=true,
    TSup_nominal=343.15,
    TSupMin=308.15,
    TRet_nominal=323.15,
    TOut_nominal=263.15)
    annotation (Placement(transformation(extent={{18,18},{-2,-2}})));
  Modelica.Blocks.Math.Add add1(k1=0.5, k2=0.5)
    annotation (Placement(transformation(extent={{50,6},{34,22}})));
  Occupancy.BaseClasses.RunningMeanTemperature6h TRm6h
    annotation (Placement(transformation(extent={{50,-22},{30,-2}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te)
    annotation (Placement(transformation(extent={{30,-44},{50,-24}})));
  Modelica.Blocks.Math.Gain gainCor[nZones](k=corr)
    "Tuning parameter for proportional gain"
    annotation (Placement(transformation(extent={{-52,-46},{-64,-34}})));
  Modelica.Blocks.Math.Add powerMax[nZones](      k2=G, k1=-G)
    annotation (Placement(transformation(extent={{-30,4},{-50,24}})));
  Modelica.Blocks.Math.Product powerMaxOnOff[nZones]
    annotation (Placement(transformation(extent={{-56,32},{-76,52}})));
  Modelica.Blocks.Math.Product QFlowVal[nZones]
    annotation (Placement(transformation(extent={{-70,-10},{-90,10}})));
  Modelica.Blocks.Math.Add proGain[nZones](k1=1/const1.k, k2=-1/const1.k)
    "ProportionalGain"
    annotation (Placement(transformation(extent={{-26,-30},{-46,-50}})));
  IDEAS.Utilities.Math.SmoothLimit smoothLimit[nZones](
    deltaX=0.01,
    upper=1,
    lower=0)
    annotation (Placement(transformation(extent={{-70,-44},{-78,-36}})));
  Modelica.Blocks.Interfaces.RealOutput QFlow[nZones]
    "Heat flow from radiators to zone"
    annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));

  Modelica.Blocks.Interfaces.RealInput TSetLow "Zone set point temperature"
    annotation (Placement(transformation(extent={{126,10},{86,50}})));
  Modelica.Blocks.Interfaces.RealInput TSetUp "Zone set point temperature"
    annotation (Placement(transformation(extent={{128,-40},{88,0}})));
  outer IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{70,-92},{90,-72}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=nZones)
    annotation (Placement(transformation(extent={{-12,-50},{-20,-42}})));
  Modelica.Blocks.Sources.Constant const1(k=0.5)
    annotation (Placement(transformation(extent={{32,42},{20,54}})));
  Modelica.Blocks.Math.Add add2(k1=-1)
    annotation (Placement(transformation(extent={{12,66},{0,54}})));
equation
  connect(const.y, add.u2) annotation (Line(points={{81.4,68},{67.8,68},{67.8,68.4}},
        color={0,0,127}));
  connect(add.y, onOff.uHigh) annotation (Line(points={{47.1,63},{42,63},{42,74},
          {32,74}}, color={0,0,127}));
  connect(add1.y, heatingCurve.TRoo_in) annotation (Line(points={{33.2,14},{19.9,
          14}},                 color={0,0,127}));
  connect(realExpression.y, TRm6h.TIn)
    annotation (Line(points={{51,-34},{51,-12},{50.6,-12}}, color={0,0,127}));
  connect(TRm6h.TRm, heatingCurve.TOut) annotation (Line(points={{29.4,-12},{24,
          -12},{24,2},{20,2}}, color={0,0,127}));

  for i in 1:nZones loop
    connect(heatingCurve.TSup, powerMax[i].u2) annotation (Line(points={{-3,2},{
            -16,2},{-16,8},{-28,8}},  color={0,0,127}));
    connect(onOff.y, powerMaxOnOff[i].u1) annotation (Line(points={{9,78},{-18,78},
            {-52,78},{-52,48},{-54,48}}, color={0,0,127}));
    if not i == i_thermostat then
      connect(QFlowVal[i].y, QFlow[i])
        annotation (Line(points={{-91,0},{-110,0}}, color={0,0,127}));
    end if;

  end for;

  connect(powerMax.y, powerMaxOnOff.u2)
    annotation (Line(points={{-51,14},{-54,14},{-54,36}}, color={0,0,127}));

  connect(proGain.y, gainCor.u)
    annotation (Line(points={{-47,-40},{-50.8,-40}}, color={0,0,127}));
  connect(smoothLimit.u, gainCor.y)
    annotation (Line(points={{-69.2,-40},{-64.6,-40}}, color={0,0,127}));
  connect(smoothLimit.y, QFlowVal.u2) annotation (Line(points={{-78.4,-40},{-84,
          -40},{-84,-38},{-84,-20},{-62,-20},{-62,-6},{-68,-6}}, color={0,0,127}));
  connect(powerMaxOnOff.y, QFlowVal.u1) annotation (Line(points={{-77,42},{-80,42},
          {-80,20},{-62,20},{-62,6},{-68,6}}, color={0,0,127}));

  connect(powerMaxOnOff[i_thermostat].y, QFlow[i_thermostat]) annotation (Line(
        points={{-77,42},{-98,42},{-98,0},{-110,0}}, color={0,0,127}));
  connect(TZones[i_thermostat], onOff.u) annotation (Line(points={{108,80},{108,
          64},{108,78},{32,78}},                   color={0,0,127}));
  connect(TZones, powerMax.u1) annotation (Line(points={{108,80},{50,80},{50,100},
          {-20,100},{-20,20},{-28,20}}, color={0,0,127}));
  connect(proGain.u2, TZones) annotation (Line(points={{-24,-34},{-20,-34},{-20,
          100},{50,100},{50,80},{108,80}}, color={0,0,127}));
  connect(TSetUp, add1.u2) annotation (Line(points={{108,-20},{80,-20},{80,9.2},
          {51.6,9.2}},
                    color={0,0,127}));
  connect(TSetLow, add1.u1) annotation (Line(points={{106,30},{86,30},{86,30},{68,
          30},{68,18.8},{51.6,18.8}},
                                   color={0,0,127}));
  connect(TSetLow, add.u1) annotation (Line(points={{106,30},{88,30},{68,30},{68,
          44},{67.8,44},{67.8,57.6}},
                                 color={0,0,127}));
  connect(TSetLow, onOff.uLow) annotation (Line(points={{106,30},{88,30},{36,30},
          {36,70},{32,70}},         color={0,0,127}));
  connect(replicator.y, proGain.u1)
    annotation (Line(points={{-20.4,-46},{-24,-46}}, color={0,0,127}));
  connect(add.y, add2.u2) annotation (Line(points={{47.1,63},{30.15,63},{30.15,63.6},
          {13.2,63.6}}, color={0,0,127}));
  connect(const1.y, add2.u1) annotation (Line(points={{19.4,48},{13.2,48},{13.2,
          56.4}}, color={0,0,127}));
  connect(add2.y, replicator.u) annotation (Line(points={{-0.6,60},{-8,60},{-8,-46},
          {-11.2,-46}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end HeatCurveCtrl;
