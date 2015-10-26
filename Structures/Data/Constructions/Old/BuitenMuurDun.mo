within DeSchipjesLin.Structures.Data.Constructions.Old;
record BuitenMuurDun "Dunne buiten muur"

  extends IDEAS.Buildings.Data.Interfaces.Construction(
    nLay=4,
    final mats={
      Materials.Metselwerk(d=0.168),
      Materials.SnelBouwSteen(d=0.1),
      insulationType,
      Materials.Pleister(d=0.01)});

end BuitenMuurDun;
