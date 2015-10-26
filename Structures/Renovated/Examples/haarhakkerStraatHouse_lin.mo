within DeSchipjesLin.Structures.Renovated.Examples;
model haarhakkerStraatHouse_lin
  extends Modelica.Icons.Example;
  BaseClasses.HaarhakkerStraatHouse_lin building(addAngles=true, linearise=true)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  IDEAS.Buildings.Linearization.BaseClasses.StateSpace ssm(
    fileName="ssm.mat",
    nWin=5,
    x_start=293.15*ones(ssm.states),
    nQConv=6,
    nQRad=6,
    addAngles=dis.addAngles)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Add error[6](k2=-1)
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  IDEAS.Buildings.Components.Interfaces.WinBus winBus1[5](nLay=3) annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,40}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=270,
        origin={-100,-40})));
  Modelica.Blocks.Sources.Sine sine[6](               freqHz=1/(86400*0.5),
      amplitude=100)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  BaseClasses.Disturbances dis
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
initial algorithm
    ssm.y :=building.TSensor;

equation
//   connect(keukenWindowLarge.winBus, singleRoom1.winBus1[1]) annotation (Line(
//       points={{-43.8,46},{-34,46},{-34,48.3},{-10,48.3}},
//       color={255,204,51},
//       thickness=0.5,
//       smooth=Smooth.None));
//   connect(keukenWindowLarge.winBus, singleRoom_SSM1.winBus[1]) annotation (Line(
//       points={{-43.8,46},{-34,46},{-34,0},{-10,0}},
//       color={255,204,51},
//       thickness=0.5,
//       smooth=Smooth.None));
  connect(ssm.y, error.u2) annotation (Line(
      points={{10.4,0},{18,0},{18,24},{38,24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(building.winBus1, winBus1) annotation (Line(
      points={{-10,42},{-24,42},{-24,40},{-40,40}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(ssm.winBus, winBus1) annotation (Line(
      points={{-9.8,6},{-24,6},{-24,40},{-40,40}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(building.TSensor, error.u1) annotation (Line(
      points={{11,50},{18,50},{18,36},{38,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ssm.Q_flowConv, sine.y) annotation (Line(
      points={{-10.8,-2.8},{-19,-2.8},{-19,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(building.Q_flowConv, sine.y) annotation (Line(
      points={{-11,53.6},{-19,53.6},{-19,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(building.Q_flowRad, sine.y) annotation (Line(
      points={{-11,46.2},{-19,46.2},{-19,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ssm.Q_flowRad, sine.y) annotation (Line(
      points={{-10.8,-8.8},{-19,-8.8},{-19,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dis.winBus1, winBus1) annotation (Line(
      points={{-60.2,46},{-52,46},{-52,40},{-40,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(dis.weaBus1, building.weaBus1) annotation (Line(
      points={{-60,56},{-36,56},{-36,58},{-10,58}},
      color={255,204,51},
      thickness=0.5));
  connect(dis.weaBus1, ssm.weaBus) annotation (Line(
      points={{-60,56},{-36,56},{-36,54},{-16,54},{-16,32},{-10,32},{-10,9}},
      color={255,204,51},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           __Dymola_Commands(file="../scripts/haarhakkerStraatHouse_lin_sim_plot.mos"
        "Linearize, simulate, plot"),
    experiment(StopTime=100000),
    __Dymola_experimentSetupOutput(events=false));
end haarhakkerStraatHouse_lin;
