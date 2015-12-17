within DeSchipjesLin.Structures.Examples;
model comparison
  extends Modelica.Icons.Example;

  struRenovated structureH1
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  struRenovatedSSM structureHSSM1
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Math.Add add[6](k2=-1)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(structureH1.TSensor1, add.u1)
    annotation (Line(points={{-20,50},{0,50},{0,6},{18,6}}, color={0,0,127}));
  connect(structureHSSM1.TSensor, add.u2) annotation (Line(points={{-20,-50},{0,
          -50},{0,-6},{18,-6}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(StopTime=3.15e+007),
    __Dymola_experimentSetupOutput);
end comparison;
