within DeSchipjesLin.Structures.Data.Constructions.Old;
record Plafond "Tussenverdiep plafonds"

  extends IDEAS.Buildings.Data.Interfaces.Construction(
    nLay=3,
    final mats={
      Materials.GewapendBeton(d=0.2),
      insulationType,
      Materials.GrestTegels(d=0.015)});

end Plafond;
