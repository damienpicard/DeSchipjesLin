within DeSchipjesLin.Structures.Renovated.Examples;
model haarhakkerStraatHouse
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Experimental.Media.AirPTDecoupled;

  HaarhakkerStraatHouse haarhakkerStraatHouse(redeclare package Medium = Medium,slaapkamerDakLinks(inc= 0),
    slaapkamerDakRechts(inc= 0),
    badkamerDak(inc= 0),
    halDak(inc= 0))
    annotation (Placement(transformation(extent={{-16,-10},{14,10}})));
  Modelica.Fluid.Sources.FixedBoundary boundary(nPorts=6, redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{32,30},{12,50}})));
  inner IDEAS.SimInfoManager sim(linearize=false, offsetAzi=2.5307274153918)
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-50,-100},{-30,-80}})));
  inner Modelica.Fluid.System system
  annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
equation
  connect(boundary.ports[1:6], haarhakkerStraatHouse.flowPort_In) annotation (
      Line(
      points={{12,36.6667},{1,36.6667},{1,10}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=10000),
    __Dymola_experimentSetupOutput);
end haarhakkerStraatHouse;
