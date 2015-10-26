within DeSchipjesLin.Structures.Data.Constructions.Old;
record Vloer "Vloer"

  extends IDEAS.Buildings.Data.Interfaces.Construction(
    nLay=5,
    final mats={
      Materials.GewapendBeton(d=0.12),
      Materials.Chape(d=0.04),
      insulationType,
      Materials.Uitvulling(d=0.06),
      Materials.GrestTegels(d=0.03)});

end Vloer;
