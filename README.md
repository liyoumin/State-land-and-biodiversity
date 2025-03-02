# State-land-and-biodiversity
### Species richness index, down scale, pixcle, biodiversity down scale,  
### Maching layer, overlap, biodiversity index, 10*10m resolution, AI processed data, high index without protection, rastdata, pacel data 
### Landuse – mismatch 
### Ownership- mismatch 

/data/raw/          # Original GIS and land value files  
/scripts/           # Python scripts for clipping, merging, analysis  
/outputs/           # Processed datasets, maps, model results  
/notebooks/         # Jupyter notebooks for visualization and reporting  

LAND_USE_CAT = categorize(!DOR_UC!)

def categorize(PA_UC):
    if PA_UC in ['000','001','002','004','005','006','007','008','009']:
        return "Residential"
    elif PA_UC in ['003','010','011','012','013','014','015','016','017','018','019','020','021','022','023','024','025','026','027','028','029','030','031','032','033','034','035','036','037','038','039']:
        return "Commercial"
    elif PA_UC in ['040','041','042','043','044','045','046','047','048','049']:
        return "Industrial"
    elif PA_UC in ['050','051','052','053','054','055','056','057','058','059','060','061','062','063','064','065','066','067','068','069','097']:
        return "Agricultural"
    elif PA_UC in ['070','071','072','073','074','075','076','077','078','079']:
        return "Institutional"
    elif PA_UC in ['080','081','082','083','084','085','086','087','088','089']:
        return "Governmental"
    else:
        return "Other"
