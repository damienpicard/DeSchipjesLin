within DeSchipjesLin.Structures.Data.Constructions.Renovated;
record GevelType1 "Renovated - Geveltype 1"

  extends IDEAS.Buildings.Data.Interfaces.Construction(
    nLay=2,
    final mats={
      Materials.Metselwerk(d=0.2),
      Insulation.AeroGel(d=0.015)});

end GevelType1;
