within DeSchipjesLin.Structures.Renovated.Examples;
model singleRoom_lin
  extends Modelica.Icons.Example;
  BaseClasses.SingleRoom_lin singleRoom1
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  IDEAS.Buildings.Linearization.BaseClasses.StateSpace
                             singleRoom_SSM1(    fileName="ssm.mat",
    nWin=1,
    x_start=293.15*ones(singleRoom_SSM1.states))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Add error(k2=-1)
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  IDEAS.Buildings.Components.LinearizableWindow
                                    keukenWindowLarge(
     A=4.57,
    frac=0.15,
    redeclare Data.Frames.LoofHout fraType,
    redeclare IDEAS.Buildings.Components.Shading.None shaType,
    linOut=true,
    linearize=true,
    inc=1.5707963267949,
    azi=3.9444441095072)
    annotation (Placement(transformation(extent={{-54,42},{-44,62}})));
public
  inner IDEAS.SimInfoManager sim(offsetAzi=0.95993108859688)
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-92,68},{-72,88}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
initial algorithm
    singleRoom_SSM1.y[1] :=singleRoom1.TSensor;

equation
  connect(singleRoom1.TSensor, error.u1) annotation (Line(
      points={{11,50},{22,50},{22,36},{38,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(singleRoom_SSM1.y[1], error.u2) annotation (Line(
      points={{10.4,0},{22,0},{22,24},{38,24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sim.weaBus, keukenWindowLarge.weaBus) annotation (Line(
      points={{-80.6,85.2},{-80.6,92},{-57,92},{-57,62}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(sim.weaBus, singleRoom1.weaBus1) annotation (Line(
      points={{-80.6,85.2},{-80.6,92},{-26,92},{-26,56.4},{-10,56.4}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(const.y, keukenWindowLarge.Ctrl) annotation (Line(
      points={{-59,30},{-52,30},{-52,42}},
      color={0,0,127},
      smooth=Smooth.None));
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
  connect(keukenWindowLarge.winBus, singleRoom1.winBus1[1]) annotation (Line(
      points={{-43.8,46},{-26,46},{-26,48.3},{-10,48.3}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(keukenWindowLarge.winBus, singleRoom_SSM1.winBus[1]) annotation (Line(
      points={{-43.8,46},{-26,46},{-26,0},{-10,0}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), __Dymola_Commands(file="../scripts/singleRoom_lin_sim_plot.mos"
        "Linearize, simulate, plot"));
end singleRoom_lin;
