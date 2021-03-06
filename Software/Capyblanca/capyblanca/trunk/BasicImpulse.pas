unit BasicImpulse;

interface

uses BoardViewerUnit, classes, stdctrls;

type
    TUrgency = integer;

    TTemperature = byte; {to be continued...}

    PTimpulse=^Timpulse;

    tParameterSet = class
                         pmemo: tmemo;
                         impulsepointer:Pointer;
                      end;

    PTParameterSet = ^TParameterSet;

    timpulse = class (Tobject)
                    Parameters: tparameterset;
                    urgency: TUrgency;
                    {REFACTOR INCLUDE CREATE HERE AND MAKE IT VIRTUAL DAMMIT!} {Constructor create (P:PTParameterSet; U: TUrgency); virtual;}
                    procedure Fire; virtual; abstract;
                    procedure Feel_Urging_Pressure (P:pointer);
                    {runs & sparks new urges}
                 end;

      TParamImpString = class (TParameterSet)
                              S:string;
                        end;

      timpulsestring= class (Timpulse)
                        Parameters: TParamImpString;
                        Constructor create (P:TParamImpString; U: TUrgency);
                        Procedure Fire; override;
                  end;

      TParamImpNumber = class (TParameterSet)
                              N:real;
                        end;

      timpulsenumber= class (Timpulse)
                        Parameters: TParamImpNumber;
                        Constructor create (P:TParamImpNumber; U: TUrgency);
                        Procedure Fire; override;
                  end;

var urges:tlist;

implementation
{each impulse has two phases:  (i) executing;
and (ii) sparking new impulses (posting new codelets)}

{Constructor TImpulse.create (P:PTParameterSet; U: TUrgency);
begin
     Parameters:=P^;
     Urgency:= U;
     Feel_Urging_Pressure (Parameters.impulsepointer);
end;}


procedure timpulse.Feel_Urging_Pressure(P:pointer);
begin
     urges.add(P);
end;

{impulse NUMBER}
Constructor TImpulseNumber.create (P:TParamImpNumber; U: TUrgency);
begin
     Parameters:=P;
     Urgency:= U;
     Feel_Urging_Pressure (Parameters.impulsepointer);
end;

Procedure TImpulseNumber.Fire;
var s:string;
begin
     with Parameters do
     begin
          str(N:5:2,S);
          Pmemo.lines.add(S);
     end;                                                    
end;

{Impulse STRING}
Constructor TImpulseString.create (P:TParamImpString; U: TUrgency);
begin
     Parameters:=P;
     Urgency:=U;
     Feel_Urging_Pressure (Parameters.impulsepointer);
end;

Procedure TImpulseString.Fire;
begin
     with Parameters do
          Pmemo.lines.add(S);
end;

end.
