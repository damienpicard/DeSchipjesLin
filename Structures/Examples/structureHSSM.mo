within DeSchipjesLin.Structures.Examples;
model structureHSSM
  extends Modelica.Icons.Example;
  extends IDEAS.Buildings.Linearisation.Interfaces.StateSpaceModelInterface(
      redeclare StateSpace ssm(
        fileName="ssm_structureH.mat"), sim(offsetAzi=backAng));

  final parameter Modelica.SIunits.Angle leftAng=63/180*Modelica.Constants.pi;
  final parameter Modelica.SIunits.Angle rightAng=243/180*Modelica.Constants.pi;
  final parameter Modelica.SIunits.Angle frontAng=153/180*Modelica.Constants.pi;
  final parameter Modelica.SIunits.Angle backAng=-27/180*Modelica.Constants.pi;

  IDEAS.Buildings.Linearisation.Components.LinWindow slaapkamerRaam(
    A=0.75,
    frac=0.21,
    redeclare final Data.Glass.DubbelGlas glazing,
    redeclare final Data.Frames.LoofHout fraType,
    azi=frontAng,
    indexWindow=5,
    inc=1.5707963267949,
    removeDynamics=true)
    annotation (Placement(transformation(extent={{-90,-72},{-80,-52}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow woonruimteWindow(
    A=5.78,
    frac=0.12,
    redeclare final Data.Glass.DubbelGlas glazing,
    redeclare final Data.Frames.LoofHout fraType,
    azi=frontAng,
    indexWindow=1,
    inc=1.5707963267949,
    removeDynamics=true)
    annotation (Placement(transformation(extent={{-90,48},{-80,68}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow keukenWindowLarge(
    A=4.57,
    frac=0.15,
    redeclare final Data.Glass.DubbelGlas glazing,
    redeclare final Data.Frames.LoofHout fraType,
    azi=frontAng,
    indexWindow=2,
    inc=1.5707963267949,
    removeDynamics=true)
    annotation (Placement(transformation(extent={{-90,20},{-80,40}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow keukenWindowSmall(
    A=1.05,
    frac=0.25,
    redeclare final Data.Glass.DubbelGlas glazing,
    redeclare final Data.Frames.LoofHout fraType,
    azi=frontAng,
    indexWindow=3,
    inc=1.5707963267949,
    removeDynamics=true)
    annotation (Placement(transformation(extent={{-90,-10},{-80,10}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow raamwc(
    A=0.07,
    frac=0.89,
    redeclare final Data.Glass.DubbelGlas glazing,
    redeclare final Data.Frames.LoofHout fraType,
    azi=frontAng,
    indexWindow=4,
    inc=1.5707963267949,
    removeDynamics=true)
    annotation (Placement(transformation(extent={{-90,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Constant const[6](k=0)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Modelica.Blocks.Interfaces.RealOutput TSensor[6]
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(const.y, ssm.Q_flowConv) annotation (Line(points={{21,20},{44,20},{44,
          56},{55,56}}, color={0,0,127}));
  connect(const.y, ssm.Q_flowRad) annotation (Line(points={{21,20},{46,20},{46,
          53},{55,53}}, color={0,0,127}));
  connect(ssm.y, TSensor) annotation (Line(points={{76.4,54},{80,54},{80,0},{
          100,0}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end structureHSSM;
