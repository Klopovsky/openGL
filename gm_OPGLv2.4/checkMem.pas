unit checkMem;
interface  
implementation  
    
uses sysUtils, dialogs;   
var HPs : THeapStatus;   
var HPe : THeapStatus;   
var lost: integer;
initialization
   HPs := getHeapStatus;
finalization
   HPe := getHeapStatus;
   Lost:= HPe.TotalAllocated - HPs.TotalAllocated;
//   if lost >  0 then begin
      beep;
      ShowMessage( format('lostMem: %d',[ lost ]) );

//   end;
end. 
 