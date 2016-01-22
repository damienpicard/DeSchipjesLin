within DeSchipjesLin.Structures;
package Examples_test
extends Modelica.Icons.ExamplesPackage;
  model struRenovated
    extends Modelica.Icons.Example;
    parameter Integer nZones = 1;
    replaceable partial_structure
                  stru(linearise=false)
      annotation (Placement(transformation(extent={{-14,36},{10,60}})));
    Modelica.Blocks.Interfaces.RealOutput TSensor1[nZones]
      "Sensor temperature of the zones"
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    HeatingSystems.PrescribedHeat_pid prescribedHeat_pid(nZones=nZones)
      annotation (Placement(transformation(extent={{-60,40},{-80,60}})));
    Modelica.Blocks.Interfaces.RealInput QFlow[nZones] "Heat flow to zones"
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  equation
    connect(stru.TSensor[1], TSensor1[1]) annotation (Line(points={{10.72,39.8},
            {60,39.8},{60,0},{100,0}},
                                   color={0,0,127}));
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

  model struRenovatedSSM
    extends Modelica.Icons.Example;
    extends IDEAS.Buildings.Linearisation.Interfaces.StateSpaceModelInterface(
        redeclare StateSpace ssm(
        fileName="ssmStruOld.mat",
        nQConv=1,
        nQRad=1,
        nWin=2),                          sim(offsetAzi=frontAng));

    final parameter Modelica.SIunits.Angle leftAng=63/180*Modelica.Constants.pi;
    final parameter Modelica.SIunits.Angle rightAng=243/180*Modelica.Constants.pi;
    final parameter Modelica.SIunits.Angle frontAng=153/180*Modelica.Constants.pi;
    final parameter Modelica.SIunits.Angle backAng=-27/180*Modelica.Constants.pi;
    final parameter Integer nZones = 1;

    Modelica.Blocks.Interfaces.RealOutput TSensor[nZones]
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  protected
    Modelica.Blocks.Math.Gain gainRad[nZones](k=0.4)
      annotation (Placement(transformation(extent={{-20,-6},{-8,6}})));
    Modelica.Blocks.Math.Gain gainCon[nZones](k=0.6)
      annotation (Placement(transformation(extent={{-20,14},{-8,26}})));
  public
    Modelica.Blocks.Interfaces.RealInput QFlow[nZones] "Input signal connector"
      annotation (Placement(transformation(extent={{-130,-20},{-90,20}})));
  protected
    IDEAS.Buildings.Linearisation.Components.LinWindow keukenWindowLarge1(
      A=4.57,
      frac=0.15,
      redeclare Data.Glass.DubbelGlas  glazing,
      redeclare Data.Frames.LoofHout  fraType,
      azi=frontAng,
      indexWindow=1,
      inc=1.5707963267949,
      createOutputsOnly=true)
      annotation (Placement(transformation(extent={{-86,20},{-76,40}})));
    IDEAS.Buildings.Linearisation.Components.LinWindow keukenWindowSmall1(
      A=1.05,
      frac=0.25,
      redeclare Data.Glass.DubbelGlas  glazing,
      redeclare Data.Frames.LoofHout  fraType,
      azi=frontAng,
      indexWindow=2,
      inc=1.5707963267949,
      createOutputsOnly=true)
      annotation (Placement(transformation(extent={{-86,-40},{-76,-20}})));
  equation
    connect(ssm.y, TSensor) annotation (Line(points={{76.4,54},{80,54},{80,0},{
            100,0}}, color={0,0,127}));
    connect(gainCon.y, ssm.Q_flowConv) annotation (Line(points={{-7.4,20},{40,20},
            {40,56},{55,56}}, color={0,0,127}));
    connect(gainRad.y, ssm.Q_flowRad) annotation (Line(points={{-7.4,0},{20,0},{46,
            0},{46,53},{55,53}}, color={0,0,127}));
    connect(gainRad.u, QFlow)
      annotation (Line(points={{-21.2,0},{-110,0}}, color={0,0,127}));
    connect(gainCon.u, QFlow) annotation (Line(points={{-21.2,20},{-40,20},{-40,0},
            {-110,0}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})));
  end struRenovatedSSM;

  model comparison
    extends Modelica.Icons.Example;
    parameter Integer nZones = 1;
    struRenovated structureH1
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    struRenovatedSSM structureHSSM1
      annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
    Modelica.Blocks.Math.Add add[nZones](k2=-1)
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    Modelica.Blocks.Interfaces.RealOutput error[nZones]
      "Connector of Real output signal"
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Interfaces.RealInput QFlow[nZones] "Input signal connector"
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  equation
    connect(structureH1.TSensor1, add.u1)
      annotation (Line(points={{-20,50},{0,50},{0,6},{18,6}}, color={0,0,127}));
    connect(structureHSSM1.TSensor, add.u2) annotation (Line(points={{-20,-50},{0,
            -50},{0,-6},{18,-6}}, color={0,0,127}));
    connect(add.y, error)
      annotation (Line(points={{41,0},{72,0},{100,0}}, color={0,0,127}));
    connect(structureHSSM1.QFlow, QFlow) annotation (Line(points={{-41,-50},{-60,
            -50},{-60,0},{-100,0}}, color={0,0,127}));
    connect(structureH1.QFlow, QFlow) annotation (Line(points={{-40,50},{-60,50},
            {-60,0},{-100,0}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      experiment(
        StartTime=2.6e+006,
        StopTime=3.1e+006,
        __Dymola_fixedstepsize=30,
        __Dymola_Algorithm="Euler"),
      __Dymola_experimentSetupOutput);
  end comparison;

  package BaseClasses
  extends Modelica.Icons.BasesPackage;
  end BaseClasses;

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
end Examples_test;
