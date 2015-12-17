within DeSchipjesLin.Structures.Data.Materials;
record EquivalentWoodWithIns =   IDEAS.Buildings.Data.Interfaces.Material (
     k=0.11*0.2+0.04*0.8,
     c=1880*0.2 + 840*0.8,
     rho=550*0.2 + 80*0.8,
     epsLw=0.86,
     epsSw=0.44) "Wooden structure with insulation";
