within DeSchipjesLin.Structures.Data.Constructions.Old;
record GemeneMuur "gemeenschappelijke muur"

  extends IDEAS.Buildings.Data.Interfaces.Construction(
    nLay=4,
    final mats={
      Materials.Pleister(d=0.01),
      Materials.Metselwerk(d=0.286),
      insulationType,
      Materials.Pleister(d=0.01)});

end GemeneMuur;
