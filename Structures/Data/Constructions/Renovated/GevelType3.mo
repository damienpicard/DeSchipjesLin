within DeSchipjesLin.Structures.Data.Constructions.Renovated;
record GevelType3 "Renovated - Geveltype 3"

  extends IDEAS.Buildings.Data.Interfaces.Construction(
    nLay=3,
    final mats={
      Materials.Metselwerk(d=0.168),
      Materials.SnelBouwSteen(d=0.1),
      Insulation.AeroGel(d=0.015)});

end GevelType3;
