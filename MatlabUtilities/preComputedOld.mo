within DeSchipjesLin.MatlabUtilities;
model preComputedOld
  extends partial_preComputed(
    woonruimteWindow(
      frac=0.12,
      redeclare Structures.Data.Glass.VoorzetRaam                                 glazing,
      redeclare Structures.Data.Frames.LoofHout                                 fraType,
      redeclare IDEAS.Buildings.Components.Shading.None shaType),
    keukenWindowLarge(
      frac=0.15,
      redeclare Structures.Data.Frames.LoofHout                                 fraType,
      redeclare IDEAS.Buildings.Components.Shading.None shaType,
      redeclare Structures.Data.Glass.DubbelGlas                                 glazing),
    keukenWindowSmall(
      frac=0.25,
      redeclare Structures.Data.Glass.DubbelGlas                                 glazing,
      redeclare Structures.Data.Frames.LoofHout                                 fraType),
    raamwc(
      frac=0.89,
      redeclare Structures.Data.Glass.DubbelGlas                                 glazing,
      redeclare Structures.Data.Frames.LoofHout                                 fraType),
    slaapkamerRaam(
      frac=0.21,
      redeclare Structures.Data.Glass.VoorzetRaam                                 glazing,
      redeclare Structures.Data.Frames.LoofHout                                 fraType));
  annotation (
    experiment(
      StopTime=3.17e+007,
      Interval=900,
      __Dymola_fixedstepsize=15,
      __Dymola_Algorithm="Euler"),
    __Dymola_experimentSetupOutput(events=false),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})));
end preComputedOld;
