# AFM-parser
##This is an antlr4 implementation of the old fama plain-text format built from scratch, developed for retrocompatibility purposes.

%Relationships
Home : ControlSystemLighting [AntiTheftAlarm] [MoviePlayer] [Internet] [Contents] [ADA] ;  
ControlSystem:[1,2]CellPhone ControlPanel;  
MoviePlayer:[1,3]{HDTV42in HDTV32in PCPlayer} ;  
Internet:[1,4]{EthernetWiFi_n WiFi_bg Mobile3G } ;  
Contents:[1,2]{VideoOnDemand DMS } ;  
VideoOnDemand : [Cache] Providers ;  
Providers : [1,2]ProviderA ProviderB ;  
%Constraints  
VideoOnDemand REQUIRES Internet ;  
VideoOnDemand REQUIRES ADA ;  
Cache REQUIRES DMS ;  
PCPlayer REQUIRES CellPhone ;  
AntiTheftAlarm REQUIRES ControlPanel ;  
Model 1: Feature Model Example  

Load Model 1 in FAMA console using the load command. In case you need help about the available
commands, use help command or read the reference manual. The following table shows the results of
executing the difeerent operations.

Operation Result
-------------------
Valid Yes  
#Products 4928  
Commonality(CellPhone) 3696  
Errors No error  

If you want to see how FAMA behaves when an error is found, introduce at the end of Model 1 the constraint ControlPanel REQUIRES CellPhone;. The result is a model where CellPhone is a false-mandatory
feature. It means that it is mandatory for any product despite of being modelled as optional. When we calculate Its commonality (the number of products where a feature appears in), it is equal to the total number
of products. It is the sign of mandatory features:

Operation Result
-------------------
Valid Yes  
#Products 3696  
Commonality(CellPhone) 3696  
Errors False-mandatory: CellPhone  
Explanations [CTC-6],[to-CellPhone-ControlPanel-rel]  

%Relationships
Home : ControlSystemLighting [AntiTheftAlarm] [MoviePlayer] [Internet] [Contents] [ADA] ;  
ControlSystem:[1,2]CellPhone ControlPanel;  
MoviePlayer:[1,3]{HDTV42in HDTV32in PCPlayer} ;  
Internet:[1,4]{EthernetWiFi_n WiFi_bg Mobile3G } ;  
Contents:[1,2]{VideoOnDemand DMS } ;  
VideoOnDemand : [Cache] Providers ;  
Providers : [1,2]ProviderA ProviderB ;  
%Attributes  
HDTV42in.ppp : [720,1080],0,0 ;  
%Constraints  
VideoOnDemand REQUIRES Internet ;  
VideoOnDemand REQUIRES ADA ;  
Cache REQUIRES DMS ;  
PCPlayer REQUIRES CellPhone ;  
AntiTheftAlarm REQUIRES ControlPanel ;  
HDTV42in.ppp == 1080 IMPLIES Ethernet ;  
Model 2: Model 1 extended with quality attributes  

All credits to the original design corresponds to Jesús García Galán. 
