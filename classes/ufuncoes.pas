
unit uFuncoes;
interface

uses StdCtrls, DBCtrls;

function cpf(num: string): boolean;
function cnpj(num: string): boolean;
function IntegerTrue(const num: string): Boolean;
function FloatTrue(num:string; Comprimento:integer):boolean;
procedure AceitaInteiro(var Edit:TEdit);
procedure DBAceitaInteiro(var Edit:TDBEdit);
procedure DBAceitaDecimal(var Edit:TDBEdit);
implementation
uses SysUtils, Dialogs;

function cpf(num: string): boolean;
var temp,
n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11:integer;
d1,d2:integer;
digitado, calculado:string;
begin
try
if (length(Num) < 11) then
begin
   cpf:=false;
   Exit;
end;
temp:=strToInt(num);
except
      cpf:=false;
      Exit;
end;
n1:= StrToInt(num[1]);
n2:= StrToInt(num[2]);
n3:= StrToInt(num[3]);
n4:= StrToInt(num[4]);
n5:= StrToInt(num[5]);
n6:= StrToInt(num[6]);
n7:= StrToInt(num[7]);
n8:= StrToInt(num[8]);
n9:= StrToInt(num[9]);
n10:=StrToInt(num[10]);
n11:=StrToInt(num[11]);

d1:= n1*1+n2*2+n3*3+n4*4+n5*5+n6*6+n7*7+n8*8+n9*9;
d1:= (d1 mod 11);
if d1>=10 then d1:=0;
d2:= n1*0+n2*1+n3*2+n4*3+n5*4+n6*5+n7*6+n8*7+n9*8+d1*9;
d2:= (d2 mod 11);
if d2>=10 then d2:=0;
calculado:= inttostr(d1)+inttostr(d2);
digitado:= num[10]+num[11];
if calculado = digitado then
cpf:=true
else
cpf:=false;
end;

function cnpj(num: string): boolean;
var
temp,
n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14:integer;
d1,d2:integer;
 digitado, calculado:string;
begin
try
if (length(Num) < 14) then
begin
   cnpj:=false;
   Exit;
end;
 temp:=strToInt(num);
except
      cnpj:=false ;
      Exit;
end;
n1:= strtoint(num[1]);
n2:= strtoint(num[2]);
n3:= strtoint(num[3]);
n4:= strtoint(num[4]);
n5:= strtoint(num[5]);
n6:= strtoint(num[6]);
n7:= strtoint(num[7]);
n8:= strtoint(num[8]);
n9:= strtoint(num[9]);
n10:= strtoint(num[10]);
n11:= strtoint(num[11]);
n12:= strtoint(num[12]);
n13:= strtoint(num[13]);
n14:= strtoint(num[14]);
d1:= n1*6+n2*7+n3*8+n4*9+n5*2+n6*3+n7*4+n8*5+
n9*6+n10*7+n11*8+n12*9;
d1:= (d1 mod 11);
if d1>=10 then d1:=0;
d2:= n1*5+n2*6+n3*7+n4*8+n5*9+n6*2+n7*3+
n8*4+n9*5+n10*6+n11*7+n12*8+d1*9;
d2:= (d2 mod 11);
if d2>=10 then d2:=0;
calculado:= intTostr(d1) + inttostr(d2);
digitado:=num[13]+num[14];
if calculado = digitado then
cnpj:=true
else
cnpj:=false;
end;

function IntegerTrue(const num: string): Boolean;
var temp, i:integer;
begin
  try
  for i:= 1 to length(num) do
  begin
       if not((Copy(num,i,1) >= '0') and (Copy(num,i,1) <= '9')) then
       begin
            IntegerTrue:=false;
            Exit;
       end;
  end;
  temp := StrToInt(num);
  IntegerTrue := True;
  except
  on EConvertError do
  IntegerTrue := False;
  end;
end;

function FloatTrue(num:string; Comprimento:integer):boolean;
 var temp:double;
     i:integer;
     len:integer;
begin
    try
    for i:= 1 to length(num) do
    begin
         if not(((Copy(num,i,1) >= '0') and (Copy(num,i,1) <= '9')) or
            (Copy(num,i,1) = ',')) then
         begin
              FloatTrue:=false;
              Exit;
         end;
         if Copy(num,i,1)=',' then
         begin
             len:=length(num)-i;
             if ((len - Comprimento)> 0) then
             begin
                  FloatTrue:=false;
                  Exit;
             end;
         end;
    end;
    temp:=strToFloat(num);
    FloatTrue:=True;
    except
    FloatTrue:=False ;
    end;
end;

procedure AceitaInteiro(var Edit:TEdit);
var
  S, Filtrada: string;
  i: Integer;
  C: String;
begin
  S := Edit.Text;
  Filtrada := '';
  i := 1;

  while i <= Length(S) do
  begin
    // Captura o caractere UTF-8 completo (pode ter mais de 1 byte)
    C := s[i];

    // Se for um número, permite
    if C[1] in ['0'..'9'] then
    begin
      Filtrada := Filtrada + C;
    end;
    inc(i);
  end;

  // Atualiza o campo apenas se houve mudança para evitar loop infinito
  if Edit.Text <> Filtrada then
  begin
    Edit.Text := Filtrada;
    Edit.SelStart := Length(Filtrada); // Mantém o cursor no fim
  end;
end;

procedure DBAceitaInteiro(var Edit:TDBEdit);
var
  S, Filtrada: string;
  i: Integer;
  C: String;
begin
  S := Edit.Text;
  Filtrada := '';
  i := 1;

  while i <= Length(S) do
  begin
    // Captura o caractere UTF-8 completo (pode ter mais de 1 byte)
    C := s[i];

    // Se for um número, permite
    if C[1] in ['0'..'9'] then
    begin
      Filtrada := Filtrada + C;
    end

     // Se for sinal de menos, permite apenas um no inicio da string
    else if (C[1] = '-') and (Pos('-', Filtrada) = 0) then
    begin
      Filtrada := C + Filtrada;
    end;

    inc(i);
  end;

  // Atualiza o campo apenas se houve mudança para evitar loop infinito
  if Edit.Text <> Filtrada then
  begin
    Edit.Text := Filtrada;
    Edit.SelStart := Length(Filtrada); // Mantém o cursor no fim
  end;
end;

procedure DBAceitaDecimal(var Edit:TDBEdit);
var
  S, Filtrada: string;
  i: Integer;
  C: String;
begin
  S := Edit.Text;
  Filtrada := '';
  i := 1;

  while i <= Length(S) do
  begin
    // Captura o caractere UTF-8 completo (pode ter mais de 1 byte)
    C := s[i];

    // Se for um número, permite
    if C[1] in ['0'..'9'] then
    begin
      Filtrada := Filtrada + C;
    end

     // Se for sinal de menos, permite apenas um no inicio da string
    else if (C[1] = '-') and (Pos('-', Filtrada) = 0) then
    begin
      Filtrada := C + Filtrada;
    end
     // Se for virgula, permite apenas um no inicio da string
    else if (C[1] = ',') and (Pos(',', Filtrada) = 0) then
    begin
      Filtrada := Filtrada + C;
    end;
    inc(i);
  end;

  // Atualiza o campo apenas se houve mudança para evitar loop infinito
  if Edit.Text <> Filtrada then
  begin
    Edit.Text := Filtrada;
    Edit.SelStart := Length(Filtrada); // Mantém o cursor no fim
  end;
end;

end.
