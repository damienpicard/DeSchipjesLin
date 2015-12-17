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
            -100},{100,100}})));
end preComputedReno;
