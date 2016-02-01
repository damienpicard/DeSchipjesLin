within DeSchipjesLin.MatlabUtilities;
model preComputedReno
  extends partial_preComputed(
    woonruimteWindow(redeclare final Structures.Data.Glass.DubbelGlas    glazing,
        redeclare final Structures.Data.Frames.LoofHout                                 fraType),
    keukenWindowLarge(redeclare final Structures.Data.Glass.DubbelGlas   glazing,
        redeclare final Structures.Data.Frames.LoofHout                                 fraType),
    keukenWindowSmall(redeclare final Structures.Data.Glass.DubbelGlas   glazing,
        redeclare final Structures.Data.Frames.LoofHout                                 fraType),
    raamwc(redeclare final Structures.Data.Glass.DubbelGlas
        glazing, redeclare final Structures.Data.Frames.LoofHout
        fraType),
    slaapkamerRaam(redeclare final Structures.Data.Glass.DubbelGlas      glazing,
        redeclare final Structures.Data.Frames.LoofHout                                 fraType));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=3.17e+007,
      Interval=900,
      __Dymola_fixedstepsize=15,
      __Dymola_Algorithm="Euler"),
    __Dymola_experimentSetupOutput(events=false));
end preComputedReno;
