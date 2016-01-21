within DeSchipjesLin.Structures;
model StruRenovatedLight
  extends partial_structure(
    woonruimte(n50=6.74),
    keuken(n50=2.87),
    slaapkamer(n50=3.25),
    wc(n50=3.36),
    badkamer(n50=3.33),
    nachthal(n50=5.14),
    woonruimteVloer(
        redeclare final Data.Constructions.Renovated.Vloer1
        constructionType, final insulationThickness=0),
    woonruimteAchtergevel(
      redeclare final Data.Constructions.LichtStructure.WallWoodStructure
        constructionType, final insulationThickness=0),
    woonruimteVoorgevel(redeclare final
        Data.Constructions.LichtStructure.WallWoodStructure
        constructionType, final insulationThickness=0),
    woonruimteKoer(redeclare final
        Data.Constructions.LichtStructure.WallWoodStructure
        constructionType, final insulationThickness=0),
    keukenAchtergevel(redeclare final
        Data.Constructions.LichtStructure.WallWoodStructure
        constructionType, final insulationThickness=0),
    woonruimteWindow(redeclare final Data.Glass.DubbelGlas    glazing,
        redeclare final Data.Frames.LoofHout                                 fraType),
    keukenWindowLarge(redeclare final Data.Glass.DubbelGlas   glazing,
        redeclare final Data.Frames.LoofHout                                 fraType),
    keukenWindowSmall(redeclare final Data.Glass.DubbelGlas   glazing,
        redeclare final Data.Frames.LoofHout                                 fraType),
    raamwc(redeclare final Data.Glass.DubbelGlas
        glazing, redeclare final Data.Frames.LoofHout
        fraType),
    slaapkamerRaam(redeclare final Data.Glass.DubbelGlas      glazing,
        redeclare final Data.Frames.LoofHout                                 fraType),
    keukenVloer(redeclare final Data.Constructions.Renovated.Vloer1
        constructionType, final insulationThickness=0),
    WCKoer(redeclare final Data.Constructions.LichtStructure.WallWoodStructure
        constructionType, final insulationThickness=0),
    WCVoorgevel(redeclare final
        Data.Constructions.LichtStructure.WallWoodStructure
        constructionType, final insulationThickness=0),
    WCVloer(final insulationThickness=0, redeclare final
        Data.Constructions.Renovated.Vloer1
        constructionType),
    slaapkamerZijgevel(redeclare final
        Data.Constructions.LichtStructure.WallWoodStructure
        constructionType, final insulationThickness=0),
    slaapkamerVoorgevel(redeclare final
        Data.Constructions.LichtStructure.WallWoodStructure
        constructionType, final insulationThickness=0),
    badkamerAchtergevel(redeclare final
        Data.Constructions.LichtStructure.WallWoodStructure
        constructionType, final insulationThickness=0),
    badkamerZijgevel(redeclare final
        Data.Constructions.LichtStructure.WallWoodStructure
        constructionType, final insulationThickness=0),
    halAchtergevel(redeclare final
        Data.Constructions.LichtStructure.WallWoodStructure
        constructionType, final insulationThickness=0),
    keukenDak(insulationThickness=0, redeclare
        Data.Constructions.LichtStructure.RoofWood constructionType),
    WCDak(insulationThickness=0, redeclare
        Data.Constructions.LichtStructure.RoofWood constructionType),
    slaapkamerDakLinks(insulationThickness=0, redeclare
        Data.Constructions.LichtStructure.RoofWood constructionType),
    slaapkamerDakRechts(insulationThickness=0, redeclare
        Data.Constructions.LichtStructure.RoofWood constructionType),
    badkamerDak(insulationThickness=0, redeclare
        Data.Constructions.LichtStructure.RoofWood constructionType),
    halDak(insulationThickness=0, redeclare
        Data.Constructions.LichtStructure.RoofWood constructionType));
        annotation (   Documentation(info="<html>
<p>
This model allows comparing the simulation accuracy of the 
\"true\" linearised state space model with two reduced order models (ROMs).
</p>
<p>
Before running this model, 
you may need to run the following script in order to create the state space model:
</p>
<code>
OutputCPUtime:=false;<br/>
re=Modelica_LinearSystems2.ModelAnalysis.Linearize(\"DeSchipjesLin.Structures.StruRenovatedLight\");<br/>
writeMatrix(fileName=\"ssmStruRenovatedLight.mat\",matrixName=\"A\",matrix=re.A);<br/>
writeMatrix(fileName=\"ssmStruRenovatedLight.mat\",matrixName=\"B\",matrix=re.B, append=true);<br/>
writeMatrix(fileName=\"ssmStruRenovatedLight.mat\",matrixName=\"C\",matrix=re.C, append=true);<br/>
writeMatrix(fileName=\"ssmStruRenovatedLight.mat\",matrixName=\"D\",matrix=re.D, append=true);<br/>
OutputCPUtime:=true;</code>
</html>", revisions="<html>
<ul>
<li>
August, 2015 by Damien Picard:<br/>
First implementation
</li>
</ul>
</html>"));
end StruRenovatedLight;
