within DeSchipjesLin.Structures.Data.Constructions.Old;
record DakHoofdGebouw "Dak in het hoofdgebouw"

  extends IDEAS.Buildings.Data.Interfaces.Construction(
    nLay=3,
    final mats={
      Materials.VezelCement(d=0.18),
      insulationType,
      Materials.GipsKartonPlaat(d=0.0095)});

end DakHoofdGebouw;
