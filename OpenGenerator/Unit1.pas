// By Stalker1917  LGPL 3.0

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Vcl.ExtCtrls,Translator;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
TDices = Array[0..6] of Byte;

var
  Form1: TForm1;
  GameStage:Integer = 0;
  CurrentBlock : Integer = 0;
  Buttons : Array [0..4] of TButton;
  Cheat : Integer = 0;
  iddqdMode : Boolean = False;  //Все битвы автоматически выигрываются.
  FileLog:Text;

implementation

{$R *.dfm}



procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseFile(FileLog);
end;

procedure TForm1.FormCreate(Sender: TObject);
var i,j,k,a,b,c,NumBlock:Integer;
s:WideString;
Opr :Array[1..3,1..150] of String;
begin
  AssignFile(FileLog,'Log.txt');
  Rewrite(FileLog);
  FileToText('operators.txt',Operators);
  FileToText('devicemgmt.pas',Story);
  a := FindStrWithOperator(Story,0); //Device
  if a<0 then exit; //Ошибка - не найден оператор Device
  i := a+1;
  j := 20;
  while FindOperator(Story[i],7)=-1 do
    begin
      a := FindOperator(Story[i],1);
      if a>-1 then
        begin
          b := FindOperator(Story[i],3);
          s := CopyText(Story[i],a+8,b-1); //Копирование текста без пробелов
          Opr[1,j] := s;
          Write(FileLog,s+' ');
          a := FindOperator(Story[i],5);
          b := FindOperator(Story[i],4);
          s := CopyText(Story[i],a+1,b-1);
          Write(FileLog,s+' ');
          Opr[2,j] := s;
          a := FindOperator(Story[i],5,b);
          b := FindOperator(Story[i],6);
          s := CopyText(Story[i],a+1,b-1);
          Writeln(FileLog,s);
          Opr[3,j] := s;
          inc(j);
        end;
      inc(i);
    end;
  Writeln(FileLog,'=============');
  for k := 20 to j-1 do Writeln(FileLog,Opr[2,k]+'Data : '+Opr[3,k]+';');
  Writeln(FileLog,'=============');
  for k := 20 to j-1 do Writeln(FileLog,'    ' + IntToStr(k) + ': Result := '+#39+ Opr[1,k]+#39+';');
  Writeln(FileLog,'=============');
  for k := 20 to j-1 do Writeln(FileLog,'    ' + IntToStr(k) + ': ' + Opr[2,k]+'Data  := Service.'+ Opr[1,k]+'('+Opr[1,k]+'.Create'+');');
  Writeln(FileLog,'=============');
  for k := 20 to j-1 do Writeln(FileLog,'  ' + IntToStr(k) + ': if ' + Opr[2,k]+'Data = nil then exit;');
  Writeln(FileLog,'=============');
  for k := 20 to j-1 do Writeln(FileLog,'  ' + IntToStr(k) + ': Result := 0; //'+Opr[2,k]+'Data');

end;





end.
