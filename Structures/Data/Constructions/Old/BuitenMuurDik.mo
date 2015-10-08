within DeSchipjesLin.Structures.Data.Constructions.Old;
record BuitenMuurDik "Dikke buiten muur"

  extends IDEAS.Buildings.Data.Interfaces.Construction(
    nLay=3,
    final mats={
      Materials.Metselwerk(d=0.268),
      insulationType,
      Materials.Pleister(d=0.01)});

end BuitenMuurDik;
