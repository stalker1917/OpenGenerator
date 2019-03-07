// By Stalker1917  LGPL 3.0

unit Translator;

interface

type
   TText = Array of String;
   SNumber = Record
     S : WideString;
     N : Word;
   End;

var
//  Blocks    : Array of TBlock;
  Operators : TText;//array [0..30] of string; //Список опреаторов
  Story     : TText;
  f         : System.text;

Procedure FileToText(S:String; var Dump:TText);
function FindStrWithOperator(var Dump : TText; Number : Integer) : Integer;
function FindOperator(S:String; Number:Integer; pos:Integer=1) :Integer;
function CopyText(S:String; a,b:Integer) :String;
implementation
function FindOperator;
var i,High:Integer;
begin
  High := Length(s)-Length(Operators[Number])+1;
  for I := pos to High do
    if (s[i]=Operators[Number,1]) and (Copy(S,i,Length(Operators[Number]))=Operators[Number]) then
      begin
        Result := i;
        Break;
      end;
  if i>High then  Result := -1;
end;
function FindStrWithOperator;
var i,a:Integer;
begin
  result := -1;
  for i := 0 to High(Dump) do
    begin
      a:=FindOperator(Dump[i],Number);
      if a>-1 then
        begin
          result := i;
          exit;
        end;
    end;
end;

function CopyText;
var i,j : Integer;
begin
  result:='';
  if b>=a then
    begin
       i:=a;
       while (s[i]=' ') and (i<=b) do inc(i);
       while (s[i]<>' ') and (i<=b) do
         begin
           result:=result+s[i];
           inc(i);
         end;
    end;
end;


Procedure FileToText(S:String;var Dump:TText);
var s1:Ansistring;
begin
  Assignfile(f,s); //Список операторов
  Reset(f);
  while not eof(f) do
    begin
      readln(f,s1);
      SetLength(Dump,Length(Dump)+1);
      Dump[Length(Dump)-1] := UTF8ToWideString(s1);
    end;
 closeFile(f);
end;


end.
