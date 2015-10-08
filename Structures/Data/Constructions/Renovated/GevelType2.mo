within DeSchipjesLin.Structures.Data.Constructions.Renovated;
record GevelType2 "Renovated - Geveltype 2"

  extends IDEAS.Buildings.Data.Interfaces.Construction(
    nLay=4,
    final mats={
      Materials.HoutVezel(d=0.018),
      Insulation.RotsWolSpanten(d=0.1),
      Materials.OSB(d=0.012),
      Materials.GipsKartonPlaat(d=0.095)});

end GevelType2;
