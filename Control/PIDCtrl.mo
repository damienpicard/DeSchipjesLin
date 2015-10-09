within DeSchipjesLin.Control;
model PIDCtrl
  extends Interface;

  parameter Integer nZones = 6;

  IDEAS.Controls.Continuous.LimPID conPID[nZones](each Ti=600, each Td=600)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
  Modelica.Blocks.Interfaces.RealInput TZones[nZones](unit="K", displayUnit="degC")
    annotation (Placement(transformation(extent={{128,-80},{88,-40}})));
  Modelica.Blocks.Interfaces.RealInput TSet[nZones](unit="K", displayUnit="degC")
    annotation (Placement(transformation(extent={{128,40},{88,80}})));
  Modelica.Blocks.Interfaces.RealOutput QFlow[nZones]
    "Connector of actuator output signal"
    annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
  HeatingSystems.heatingSystemParameters
                          heaSysPar
    annotation (Placement(transformation(extent={{-90,74},{-70,94}})));
  Modelica.Blocks.Math.Gain gain[nZones](k=heaSysPar.powerZones)
    annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
equation
  connect(conPID.u_m,TZones)
    annotation (Line(points={{0,-12},{0,-60},{108,-60}},   color={0,0,127}));
  connect(TSet, conPID.u_s) annotation (Line(points={{108,60},{20,60},{20,0},{12,
          0}}, color={0,0,127}));
  connect(conPID.y, gain.u)
    annotation (Line(points={{-11,0},{-24.5,0},{-38,0}}, color={0,0,127}));
  connect(gain.y, QFlow)
    annotation (Line(points={{-61,0},{-110,0},{-110,0}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end PIDCtrl;
