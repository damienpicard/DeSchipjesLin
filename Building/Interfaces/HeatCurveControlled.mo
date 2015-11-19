within DeSchipjesLin.Building.Interfaces;
model HeatCurveControlled
  extends Interfaces.partial_building;

  Control.HeatCurveCtrl ctrl
    annotation (Placement(transformation(extent={{40,-20},{80,20}})));
equation
  connect(occ.TZoneSetUp, ctrl.TSetUp) annotation (Line(points={{22,-48},{96,
          -48},{96,-4},{81.6,-4}},    color={0,0,127}));
  connect(stru.TSensor, ctrl.TZones) annotation (Line(points={{-38.8,-12},
          {-30,-12},{-30,-26},{-86,-26},{-86,26},{96,26},{96,16},{81.6,16}},
        color={0,0,127}));
  connect(ctrl.QFlow, prescribedHeat_pid.QFlow)
    annotation (Line(points={{38,0},{30,0},{30,6},{21.6,6}}, color={0,0,127}));
  connect(occ.TRefControl, ctrl.TSetLow) annotation (Line(points={{22,-64},{34,-64},
          {34,-64},{100,-64},{100,6},{81.2,6}},          color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(
      StopTime=846000,
      __Dymola_NumberOfIntervals=50000,
      __Dymola_fixedstepsize=20,
      __Dymola_Algorithm="Euler"),
    __Dymola_experimentSetupOutput);
end HeatCurveControlled;
