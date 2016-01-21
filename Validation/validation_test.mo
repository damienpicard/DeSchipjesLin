within DeSchipjesLin.Validation;
model validation_test
  extends Modelica.Icons.Example;

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
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    offset=zeros(6),
    tableOnFile=true,
    tableName="data",
    fileName=
        "C:/Users/u0085306/Documents/work/modelica/DeSchipjesLin/Inputs/PiDControlledOld.txt",

    columns={2,3,4,5,6,7})
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Math.Gain gain[6](k={0,1,0,0,0,0})
    annotation (Placement(transformation(extent={{-46,64},{-34,76}})));
equation
  connect(combiTimeTable.y, gain.u)
    annotation (Line(points={{-59,70},{-47.2,70}}, color={0,0,127}));
  connect(gain.y, old.QFlow)
    annotation (Line(points={{-33.4,70},{-26,70},{-20,70}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end validation_test;
