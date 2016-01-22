within DeSchipjesLin.Structures.Examples;
model struRenovated
  extends Modelica.Icons.Example;

  replaceable StruRenovated
                stru(linearise=false)
    annotation (Placement(transformation(extent={{-14,36},{10,60}})));
  Modelica.Blocks.Interfaces.RealOutput TSensor1[6]
    "Sensor temperature of the zones"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  HeatingSystems.PrescribedHeat_pid prescribedHeat_pid
    annotation (Placement(transformation(extent={{-60,40},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput QFlow[6] "Heat flow to zones"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
equation
  connect(stru.TSensor, TSensor1) annotation (Line(points={{15.04,38.64},{60,
          38.64},{60,0},{100,0}},color={0,0,127}));
  connect(prescribedHeat_pid.portCon, stru.heatPortCon) annotation (Line(points=
         {{-60,56},{-42,56},{-42,72},{18,72},{18,50.4},{10,50.4}}, color={191,0,
          0}));
  connect(prescribedHeat_pid.portRad, stru.heatPortRad) annotation (Line(points=
         {{-60,50},{-42,50},{-42,26},{18,26},{18,45.6},{10,45.6}}, color={191,0,
          0}));
  connect(prescribedHeat_pid.QFlow, QFlow) annotation (Line(points={{-80.8,53},
          {-88,53},{-88,0},{-100,0}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=10000),
    __Dymola_experimentSetupOutput);
end struRenovated;
