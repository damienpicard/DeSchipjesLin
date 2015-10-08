within DeSchipjesLin.Structures.Data.Constructions.Renovated;
record Vloer1 "Renovated - Vloer type 1"

  extends IDEAS.Buildings.Data.Interfaces.Construction(
    nLay=4,
    final mats={
      Materials.GewapendBeton(d=0.12),
      Insulation.VIP(d=0.02),
      Materials.Dekvloer(d=0.06),
      Materials.GrestTegels(d=0.03)});

end Vloer1;
