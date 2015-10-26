within DeSchipjesLin.Structures.Renovated;
model PartialRenovated "Standaard woning de schipjes"
  extends StructureH(
    woonruimte(n50=6.74),
    keuken(n50=2.87),
    slaapkamer(n50=3.25),
    wc(n50=3.36),
    badkamer(n50=3.33),
    nachthal(n50=5.14),
    woonruimteVloer(
        redeclare final Data.Constructions.Renovated.Vloer1
        constructionType, final insulationThickness=0),
    woonruimteAchtergevel(
      redeclare final Data.Constructions.Renovated.GevelType1
        constructionType, final insulationThickness=0),
    woonruimteVoorgevel(redeclare final Data.Constructions.Renovated.GevelType1
        constructionType, final insulationThickness=0),
    woonruimteKoer(redeclare final Data.Constructions.Renovated.GevelType2
        constructionType, final insulationThickness=0),
    keukenAchtergevel(redeclare final Data.Constructions.Renovated.GevelType1
        constructionType, final insulationThickness=0),
    woonruimteWindow(redeclare final Data.Glass.DubbelGlas    glazing,
        redeclare final Data.Frames.LoofHout                                 fraType),
    keukenWindowLarge(redeclare final Data.Glass.DubbelGlas   glazing,
        redeclare final Data.Frames.LoofHout                                 fraType),
    keukenWindowSmall(redeclare final Data.Glass.DubbelGlas   glazing,
        redeclare final Data.Frames.LoofHout                                 fraType),
    raamwc(redeclare final Data.Glass.DubbelGlas
        glazing, redeclare final Data.Frames.LoofHout
        fraType),
    slaapkamerRaam(redeclare final Data.Glass.DubbelGlas      glazing,
        redeclare final Data.Frames.LoofHout                                 fraType),
    keukenVloer(redeclare final Data.Constructions.Renovated.Vloer1
        constructionType, final insulationThickness=0),
    WCKoer(redeclare final Data.Constructions.Renovated.GevelType2
        constructionType, final insulationThickness=0),
    WCVoorgevel(redeclare final Data.Constructions.Renovated.GevelType3
        constructionType, final insulationThickness=0),
    WCVloer(final insulationThickness=0, redeclare final
        Data.Constructions.Renovated.Vloer1
        constructionType),
    slaapkamerZijgevel(redeclare final Data.Constructions.Renovated.GevelType1
        constructionType, final insulationThickness=0),
    slaapkamerVoorgevel(redeclare final Data.Constructions.Renovated.GevelType1
        constructionType, final insulationThickness=0),
    badkamerAchtergevel(redeclare final Data.Constructions.Renovated.GevelType1
        constructionType, final insulationThickness=0),
    badkamerZijgevel(redeclare final Data.Constructions.Renovated.GevelType1
        constructionType, final insulationThickness=0),
    halAchtergevel(redeclare final Data.Constructions.Renovated.GevelType1
        constructionType, final insulationThickness=0),
    woonruimteKeuken,
    woonruimteGemeenschappelijk,
    keukenGemeenschappelijk,
    keukenWC,
    WCGemeenschappelijk,
    slaapkamerGemeenschappelijk,
    slaapkamerBadStaand,
    slaapkamerBadLiggend,
    slaapkamerDakLinks,
    slaapkamerDakRechts);

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-150,
            -100},{220,200}}), graphics));
end PartialRenovated;
