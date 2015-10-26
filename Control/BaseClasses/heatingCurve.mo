within DeSchipjesLin.Control.BaseClasses;
model heatingCurve
  extends Modelica.Icons.Example;
  IDEAS.Controls.ControlHeating.HeatingCurves.HeatingCurve heatingCurve(
    use_TRoo_in=true,
    TSup_nominal=343.15,
    TSupMin=308.15,
    TRet_nominal=323.15,
    TOut_nominal=263.15)
    annotation (Placement(transformation(extent={{-18,-12},{14,28}})));
  inner IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Occupancy.BaseClasses.ComfortBoundaryISO7730_classB
    comfortBoundaryISO7730_classB
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
  Modelica.Blocks.Math.Add add(k1=0.5, k2=0.5)
    annotation (Placement(transformation(extent={{-56,-20},{-36,0}})));
  Occupancy.BaseClasses.RunningMeanTemperature6h runningMeanTemperature6h
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te)
    annotation (Placement(transformation(extent={{-94,20},{-74,40}})));
equation
  connect(add.u2, comfortBoundaryISO7730_classB.TBouLow)
    annotation (Line(points={{-58,-16},{-69,-16},{-69,-15}}, color={0,0,127}));
  connect(add.u1, comfortBoundaryISO7730_classB.TBouUp) annotation (Line(points=
         {{-58,-4},{-68,-4},{-68,-5},{-69,-5}}, color={0,0,127}));
  connect(add.y, heatingCurve.TRoo_in) annotation (Line(points={{-35,-10},{-30,
          -10},{-30,-4},{-21.04,-4}}, color={0,0,127}));
  connect(runningMeanTemperature6h.TRm, heatingCurve.TOut) annotation (Line(
        points={{-39.4,30},{-36,30},{-32,30},{-32,20},{-21.2,20}}, color={0,0,
          127}));
  connect(realExpression.y, runningMeanTemperature6h.TIn) annotation (Line(
        points={{-73,30},{-60.6,30},{-60.6,30}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end heatingCurve;
