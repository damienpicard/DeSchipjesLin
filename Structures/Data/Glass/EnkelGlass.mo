within DeSchipjesLin.Structures.Data.Glass;
record EnkelGlass =  IDEAS.Buildings.Data.Interfaces.Glazing (
    nLay=1,
    mats={IDEAS.Buildings.Data.Materials.Glass(d=0.004)},
    SwTrans=[0, 0.521; 10, 0.524; 20, 0.517; 30, 0.508; 40, 0.495; 50, 0.472;
        60, 0.418; 70, 0.312; 80, 0.153; 90, 0.000],
    SwAbs=[0, 0.102; 10, 0.104; 20, 0.112;
        30, 0.117; 40, 0.119; 50, 0.123; 60,
        0.135; 70, 0.142; 80, 0.105; 90,
        0.000],
    SwTransDif=0.418,
    SwAbsDif={0.135},
    U_value=5.8,
    g_value=0.85) "enkel glass";
