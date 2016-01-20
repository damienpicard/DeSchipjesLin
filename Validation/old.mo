within DeSchipjesLin.Validation;
model old

  Structures.Examples.comparison reno
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
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
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
end old;
