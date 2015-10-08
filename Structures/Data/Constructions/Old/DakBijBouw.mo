within DeSchipjesLin.Structures.Data.Constructions.Old;
record DakBijBouw "Dak in de bijbouw"

  extends IDEAS.Buildings.Data.Interfaces.Construction(
    nLay=3,
    final mats={
      Materials.Kepers(d=0.14),
      insulationType,
      Materials.GipsKartonPlaat(d=0.0095)});

end DakBijBouw;
