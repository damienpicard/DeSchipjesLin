within DeSchipjesLin.Validation;
model test

  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    offset=zeros(6),
    tableOnFile=true,
    tableName="data",
    fileName=
        "C:/Users/u0085306/Documents/work/modelica/DeSchipjesLin/Inputs/PiDControlledOld.txt",

    columns={2,3,4,5,6,7})
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
end test;
