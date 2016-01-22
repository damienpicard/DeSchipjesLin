within DeSchipjesLin.Validation;
model validation
  extends Modelica.Icons.Example;

  Structures.Examples.comparison reno
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Structures.Examples.comparison old(structureH1(redeclare Structures.StruOld
        stru), structureHSSM1(
      ssm(fileName="ssmStruOld.mat"),
      woonruimteWindow(
        frac=0.12,
        redeclare Structures.Data.Glass.VoorzetRaam glazing,
        redeclare Structures.Data.Frames.LoofHout fraType,
        redeclare IDEAS.Buildings.Components.Shading.None shaType),
      keukenWindowLarge(
        frac=0.15,
        redeclare Structures.Data.Frames.LoofHout fraType,
        redeclare IDEAS.Buildings.Components.Shading.None shaType,
        redeclare Structures.Data.Glass.DubbelGlas glazing),
      keukenWindowSmall(
        frac=0.25,
        redeclare Structures.Data.Glass.DubbelGlas glazing,
        redeclare Structures.Data.Frames.LoofHout fraType),
      raamwc(
        frac=0.89,
        redeclare Structures.Data.Glass.DubbelGlas glazing,
        redeclare Structures.Data.Frames.LoofHout fraType),
      slaapkamerRaam(
        frac=0.21,
        redeclare Structures.Data.Glass.VoorzetRaam glazing,
        redeclare Structures.Data.Frames.LoofHout fraType)))
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Structures.Examples.comparison renoLight(structureH1(redeclare
        Structures.StruRenovatedLight stru), structureHSSM1(ssm(fileName="ssmStruRenovatedLight.mat")))
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    offset=zeros(6),
    tableOnFile=true,
    tableName="data",
    fileName=
        "C:/Users/u0085306/Documents/work/modelica/DeSchipjesLin/Inputs/PiDControlledOld.txt",
    columns={2,3,4,5,6,7})
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));

  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(
    offset=zeros(6),
    tableOnFile=true,
    tableName="data",
    columns={2,3,4,5,6,7},
    fileName=
        "C:/Users/u0085306/Documents/work/modelica/DeSchipjesLin/Inputs/PiDControlledReno.txt")
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable2(
    offset=zeros(6),
    tableOnFile=true,
    tableName="data",
    columns={2,3,4,5,6,7},
    fileName=
        "C:/Users/u0085306/Documents/work/modelica/DeSchipjesLin/Inputs/PiDControlledRenoLight.txt")
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Math.Gain gain[6](each k=1)
    annotation (Placement(transformation(extent={{-46,64},{-34,76}})));
  Modelica.Blocks.Math.Gain gain1[6](each k=1)
    annotation (Placement(transformation(extent={{-46,-6},{-34,6}})));
  Modelica.Blocks.Math.Gain gain2[6](each k=1)
    annotation (Placement(transformation(extent={{-44,-76},{-32,-64}})));
equation
  connect(combiTimeTable.y, gain.u)
    annotation (Line(points={{-59,70},{-47.2,70}}, color={0,0,127}));
  connect(gain.y, old.QFlow)
    annotation (Line(points={{-33.4,70},{-26,70},{-20,70}}, color={0,0,127}));
  connect(combiTimeTable1.y, gain1.u)
    annotation (Line(points={{-59,0},{-47.2,0}}, color={0,0,127}));
  connect(gain1.y, reno.QFlow)
    annotation (Line(points={{-33.4,0},{-28,0},{-20,0}}, color={0,0,127}));
  connect(combiTimeTable2.y, gain2.u)
    annotation (Line(points={{-59,-70},{-45.2,-70}}, color={0,0,127}));
  connect(gain2.y, renoLight.QFlow) annotation (Line(points={{-31.4,-70},{-25.7,
          -70},{-20,-70}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end validation;
