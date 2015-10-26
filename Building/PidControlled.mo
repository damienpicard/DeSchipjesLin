within DeSchipjesLin.Building;
model PidControlled
  extends partial_building;

  Control.PIDCtrl ctrl
    annotation (Placement(transformation(extent={{40,-20},{80,20}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=nZones)
    annotation (Placement(transformation(extent={{34,-72},{46,-56}})));
equation
  connect(replicator.y, ctrl.TSet) annotation (Line(points={{46.6,-64},{98,-64},
          {98,12},{81.6,12}}, color={0,0,127}));
  connect(occupant.TZoneSetUpLow, replicator.u)
    annotation (Line(points={{22,-64},{32.8,-64}}, color={0,0,127}));
  connect(ctrl.QFlow, prescribedHeat_pid.QFlow)
    annotation (Line(points={{38,0},{30,0},{30,6},{21.6,6}}, color={0,0,127}));
  connect(structureH.TSensor, ctrl.TZones) annotation (Line(points={{-38.8,-12},
          {-30,-12},{-30,-28},{88,-28},{88,-12},{81.6,-12}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=3.15e+007,
      __Dymola_NumberOfIntervals=50000,
      __Dymola_fixedstepsize=40,
      __Dymola_Algorithm="Euler"),
    __Dymola_experimentSetupOutput);
end PidControlled;
