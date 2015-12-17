within DeSchipjesLin.Structures.Data.Constructions;
package LichtStructure

  record WallWoodStructure "Renovated - Geveltype 1"

    extends IDEAS.Buildings.Data.Interfaces.Construction(
      nLay=1,
      final mats={
        DeSchipjesLin.Structures.Data.Materials.EquivalentWoodWithIns(d=0.15)});

  end WallWoodStructure;

  record RoofWood
      extends IDEAS.Buildings.Data.Interfaces.Construction(
      nLay=2,
      final mats={
        Materials.EquivalentWoodWithIns(d=0.2),
        Materials.GipsKartonPlaat(d=0.0095)});
  end RoofWood;
end LichtStructure;
