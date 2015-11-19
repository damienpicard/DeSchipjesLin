within DeSchipjesLin.Building.Interfaces;
model partial_NonHeated
  extends Interfaces.partial_building;
  Modelica.Blocks.Sources.Constant const[stru.nZones](each k=0)
    annotation (Placement(transformation(extent={{60,0},{40,20}})));
equation
  connect(const.y, prescribedHeat_pid.QFlow) annotation (Line(points={{39,10},{34,
          10},{34,6},{21.6,6}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(
      StopTime=3.15e+006,
      __Dymola_fixedstepsize=30,
      __Dymola_Algorithm="Euler"),
    __Dymola_experimentSetupOutput);
end partial_NonHeated;
