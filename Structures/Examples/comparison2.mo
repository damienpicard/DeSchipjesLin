within DeSchipjesLin.Structures.Examples;
model comparison2
  parameter Real a = 0;

  comparison comparison1(structureHSSM1(gainRad(k=a)), structureH1(
        prescribedHeat_pid(gainRad(k=a))))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Pulse const[6](amplitude=500, period=166500)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(const.y, comparison1.QFlow)
    annotation (Line(points={{-59,0},{-10,0}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end comparison2;
