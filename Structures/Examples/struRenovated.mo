within DeSchipjesLin.Structures.Examples;
model struRenovated
  extends Modelica.Icons.Example;

  replaceable StruRenovated
                stru(linearise=false)
    annotation (Placement(transformation(extent={{-14,36},{10,60}})));
  Modelica.Blocks.Interfaces.RealOutput TSensor1[6]
    "Sensor temperature of the zones"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(stru.TSensor, TSensor1) annotation (Line(points={{10.72,40.8},{60,
          40.8},{60,0},{100,0}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=10000),
    __Dymola_experimentSetupOutput);
end struRenovated;
