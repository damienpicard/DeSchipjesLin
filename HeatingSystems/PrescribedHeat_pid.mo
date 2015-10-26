within DeSchipjesLin.HeatingSystems;
model PrescribedHeat_pid

  parameter Integer nZones=6;

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b portRad[nZones]
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b portCon[nZones]
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeatFlowCon[
    nZones] annotation (Placement(transformation(extent={{-40,50},{-60,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeatFlowRad[
    nZones] annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
  Modelica.Blocks.Math.Gain gainRad[nZones](k=0.4)
    annotation (Placement(transformation(extent={{-14,-6},{-26,6}})));
  Modelica.Blocks.Math.Gain gainCon[nZones](k=0.6)
    annotation (Placement(transformation(extent={{-16,54},{-28,66}})));
  Modelica.Blocks.Interfaces.RealInput QFlow[nZones] "Heat flow to zones"
    annotation (Placement(transformation(extent={{128,10},{88,50}})));
equation
  connect(gainCon.y, preHeatFlowCon.Q_flow)
    annotation (Line(points={{-28.6,60},{-40,60}},          color={0,0,127}));
  connect(gainRad.y, preHeatFlowRad.Q_flow)
    annotation (Line(points={{-26.6,0},{-40,0}},         color={0,0,127}));
  connect(preHeatFlowRad.port, portRad)
    annotation (Line(points={{-60,0},{-100,0},{-100,0}}, color={191,0,0}));
  connect(preHeatFlowCon.port, portCon)
    annotation (Line(points={{-60,60},{-100,60},{-100,60}}, color={191,0,0}));
  for i in 1:nZones loop
  end for;
  connect(gainCon.u, QFlow) annotation (Line(points={{-14.8,60},{-8,60},{0,60},
          {0,30},{108,30}}, color={0,0,127}));
  connect(QFlow, gainRad.u) annotation (Line(points={{108,30},{54,30},{0,30},{0,
          0},{-12.8,0}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={191,0,0}),
        Line(points={{34,4},{14,24}}, color={0,0,127}),
        Line(
          points={{14,24},{-16,-6}},
          color={0,0,127},
          pattern=LinePattern.Dash),
        Line(
          points={{14,24},{-24,24}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-44,2},{-90,2}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-44,60},{-90,60}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-24,24},{-44,2}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-24,24},{-46,60}},
          color={191,0,0},
          thickness=0.5),
        Polygon(
          points={{-60,40},{-60,80},{-90,60},{-60,40}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,-18},{-60,22},{-90,2},{-60,-18}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{14,94},{14,64}}),
        Line(points={{36.9,56.8},{54.2,81.3}}),
        Line(points={{-8.9,56.8},{-26.2,81.3}}),
        Line(points={{51.6,37.7},{79.8,47.9}}),
        Ellipse(
          lineColor={64,64,64},
          fillColor={215,215,215},
          extent={{2,12},{26,36}},
          fillPattern=FillPattern.Solid),
        Polygon(
          origin={14,24},
          rotation=-17.5,
          fillColor={64,64,64},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-5.0,0.0},{-2.0,60.0},{0.0,65.0},{2.0,60.0},{5.0,0.0}}),
        Ellipse(
          fillColor={64,64,64},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{7,17},{21,31}}),
        Line(
          points={{44,-6},{34,4}},
          color={0,0,127},
          pattern=LinePattern.Dash),
        Line(
          points={{-16,-76},{-16,-6}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash),
        Line(
          points={{44,-76},{44,-6}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash)}));
end PrescribedHeat_pid;
