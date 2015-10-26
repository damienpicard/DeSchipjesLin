within DeSchipjesLin.Structures.Data.Materials;
record SnelBouwSteen = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.125,
    c=840,
    rho=450,
    epsLw=0.8,
    epsSw=0.8) "Isolerende snelbouwsteen";
