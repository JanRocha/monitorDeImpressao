unit UFuncoes;

interface

uses
  StrUtils,
  forms,
  SysUtils,
  iniFiles,
  rtti,
  classes,
  StdCtrls,
  Windows,
  Registry,
  MaskUtils;

type

  TFuncoes = class
  private

  public
    function preparaString(value: string; aLimExt: boolean; aEspaco: Boolean = false): string;
    function RemoveTagHTML(Value:string):string;
    procedure GravarLog(msg: string);
    procedure GravarArquivo(Nome, valor: string);
    function EscreverRegistro(Chave, valor, Conteudo: String): String;
    function LerRegistro(Chave, valor: String): String;
    function ListarArquivos(Diretorio: string; Sub: boolean): TStringList;
    function ColocaTextoDireita(Texto: string; Qtd: integer; Ch: Char): string;
    function ColocaTextoEsquerda(Texto: string; Qtd: integer; Ch: Char): string;
    Function SerialNum(FDrive: String): String;
    function mascaratel(valor: string): string;
    function SerializarINI(Arquivo, chave: string; obj: TObject): TObject;
    function GravarINI(Arquivo, chave: string; obj: TObject): TObject;
    destructor Destroy; override;
  end;

implementation

{ TFuncoes }

function TFuncoes.ColocaTextoDireita(Texto: string; Qtd: integer;
  Ch: Char): string;
var
  x: integer;
  str: string;
begin
  if Ch = '' then
    Ch := Chr(32); { Espaço }

  if Length(Texto) > Qtd then
    Result := Copy(Texto, (Length(Texto) - Qtd) + 1, Length(Texto))
  else
  begin
    str := '';
    for x := Length(Texto) to Qtd - 1 do
    begin
      str := str + Ch;
    end;
    Result := str + Texto;
  end
end;

function TFuncoes.ColocaTextoEsquerda(Texto: string; Qtd: integer;
  Ch: Char): string;
var
  x: integer;
begin
  if Ch = '' then
    Ch := Chr(32) { Espaço }
    { endif };

  if Length(Texto) > Qtd then
    Result := Copy(Texto, 0, Qtd)
  else
  begin
    x := Length(Texto);
    for Qtd := x to Qtd - 1 do
    begin
      Texto := Texto + Ch;
    end;
    Result := Texto;
  end

end;

destructor TFuncoes.Destroy;
begin
  inherited;
end;

function TFuncoes.EscreverRegistro(Chave, valor, Conteudo: String): String;
var
  Registro: TRegistry;
begin
  Registro := TRegistry.Create;
  Registro.RootKey := HKEY_CURRENT_USER;

  if (Registro.OpenKey(Chave, True)) then
  begin
    Registro.WriteString(valor, Conteudo);
  end;

  Registro.CloseKey;
  Registro.Free;
end;

procedure TFuncoes.GravarLog(msg: string);
var
  arq: TextFile;
  s, Nome: string;
begin
  s := GetCurrentDir + '\LOGS\';
  if not DirectoryExists(s) then
    ForceDirectories(s);
  Nome := FormatDateTime('yyyy-mm-dd', now);
  try
    s := s + '\' + Nome + '.LOG';
    AssignFile(arq, s);
    if FileExists(s) then
    begin
      Append(arq);
    end
    else
    begin
      Rewrite(arq);
    end;
    Writeln(arq, FormatDateTime('yyyy-dd-mm hh:mm:ss', now) + ' - ' + msg);
    CloseFile(arq);
  finally

  end;
end;

function TFuncoes.LerRegistro(Chave, valor: string): String;
var
  Registro: TRegistry;
begin
  Registro := TRegistry.Create;

  Registro.RootKey := HKEY_CURRENT_USER;

  Result := '';
  if (Registro.OpenKey(Chave, True)) then
  begin
    Result := Registro.ReadString(valor);
  end;
  Registro.CloseKey;
  Registro.Free;
end;

function TFuncoes.ListarArquivos(Diretorio: string; Sub: boolean): TStringList;
var
  F: TSearchRec;
  Ret: integer;
  TempNome: string;
  function TemAtributo(Attr, Val: integer): boolean;
  begin
    Result := Attr and Val = Val;
  end;

begin
  Result := TStringList.Create;
  Ret := FindFirst(Diretorio + '\*.*', faAnyFile, F);
  try
    while Ret = 0 do
    begin
      if TemAtributo(F.Attr, faDirectory) then
      begin
        if (F.Name <> '.') And (F.Name <> '..') then
        begin
          if Sub = True then
          begin
            TempNome := Diretorio + '\' + F.Name;
            ListarArquivos(TempNome, True);
          end;
        end;
      end
      else
      begin
        Result.Add(F.Name);
      end;
      Ret := FindNext(F);
    end;
  finally
    SysUtils.FindClose(F);
  end;

end;

function TFuncoes.mascaratel(valor: string): string;
var
  Mascara: string;
begin
  valor := StringReplace(valor, '(', '', [rfReplaceAll]);
  valor := StringReplace(valor, ')', '', [rfReplaceAll]);
  valor := StringReplace(valor, '-', '', [rfReplaceAll]);
  valor := trim(valor);
  case Length(trim(valor)) of
    10:
      Mascara := '\(00\)0000-00009;0;_';
    11:
      Mascara := '\(00\)00000-0000;0;_';
  else
    Mascara := '\(00\)000000009;0;_';
  end;
  Result := trim(FormatMaskText(Mascara, valor));
end;

function TFuncoes.preparaString(value: string; aLimExt: boolean; aEspaco: Boolean): string;
const
  // Lista de caracteres especiais
  xCarEsp: array [1 .. 38] of String = ('á', 'à', 'ã', 'â', 'ä', 'Á', 'À', 'Ã',
    'Â', 'Ä', 'é', 'è', 'É', 'È', 'í', 'ì', 'Í', 'Ì', 'ó', 'ò', 'ö', 'õ', 'ô',
    'Ó', 'Ò', 'Ö', 'Õ', 'Ô', 'ú', 'ù', 'ü', 'Ú', 'Ù', 'Ü', 'ç', 'Ç', 'ñ', 'Ñ');
  // Lista de caracteres para troca
  xCarTro: array [1 .. 38] of String = ('a', 'a', 'a', 'a', 'a', 'A', 'A', 'A',
    'A', 'A', 'e', 'e', 'E', 'E', 'i', 'i', 'I', 'I', 'o', 'o', 'o', 'o', 'o',
    'O', 'O', 'O', 'O', 'O', 'u', 'u', 'u', 'u', 'u', 'u', 'c', 'C', 'n', 'N');
  // Lista de Caracteres Extras
  xCarExt: array [1 .. 51] of string = ('<', '>', '!', '@', '#', '$', '%', '¨',
    '&', '*', '(', ')', '_', '+', '=', '{', '}', '[', ']', '?', ';', ':', ',',
    '|', '*', '"', '~', '^', '´', '`', '¨', 'æ', 'Æ', 'ø', '£', 'Ø', 'ƒ', 'ª',
    'º', '¿', '®', '½', '¼', 'ß', 'µ', 'þ', 'ý', 'Ý', '/', '.', '-');
var
  xTexto: string;
  i: integer;
begin
  xTexto := value;
  for i := 1 to 38 do
    xTexto := StringReplace(xTexto, xCarEsp[i], xCarTro[i], [rfReplaceAll]);
  // De acordo com o parâmetro aLimExt, elimina caracteres extras.
  if (aLimExt) then
    for i := 1 to 51 do
      xTexto := StringReplace(xTexto, xCarExt[i], '', [rfReplaceAll]);
    if aEspaco then
       xTexto := StringReplace(xTexto, ' ', '', [rfreplaceall]);
  Result := xTexto;
end;

function TFuncoes.RemoveTagHTML(Value: string): string;
function RemoveTags(S: string): string;
var
  TagInicio, TagFim, TagLength: integer;
begin
  TagInicio := Pos( '<', S); // posição de busca de primeira <

  while (TagInicio > 0) do begin  // enquanto há uma < em S
    TagFim := Pos('>', S);       // encontra a correspondente >
    TagLength := TagFim - TagInicio + 1;
    Delete(S, TagInicio, TagLength); // exclui a tag
    TagInicio:= Pos( '<', S);       // pesquisa a proxima <
  end;
  Result := S; // da o resultado
end;
begin
   Result:=  Value;
   Result:= StringReplace(Result,'<p>'      , '\n\n',[rfReplaceAll]);
   Result:= StringReplace(Result,'<br>'     , '\n',[rfReplaceAll]);
   Result:= StringReplace(Result,'<br />'     , '\n',[rfReplaceAll]);
   Result:= RemoveTags(Result);

   Result:= StringReplace(Result,'"', ' ',[rfReplaceAll]);
   Result:= StringReplace(Result,'\u00ED', 'í',[rfReplaceAll]);
   Result:= StringReplace(Result,'\u00E0', 'à',[rfReplaceAll]);
   Result:= StringReplace(Result,'\u00F3', 'ó',[rfReplaceAll]);
   Result:= StringReplace(Result,'\u00E2', 'ê',[rfReplaceAll]);
   Result:= StringReplace(Result,'\u00E2', 'â',[rfReplaceAll]);
   Result:= StringReplace(Result,'\u00F5', 'õ',[rfReplaceAll]);
   Result:= StringReplace(Result,'\u00E7', 'ç',[rfReplaceAll]);
   Result:= StringReplace(Result,'\u00E3', 'ã',[rfReplaceAll]);

   Result:= StringReplace(Result,'&nbsp;',' ',[rfReplaceAll]);
   //Result:= StringReplace(Result,'~','a',[rfReplaceAll]);
   Result:= StringReplace(Result,#$1E,' ',[rfReplaceAll]);
   Result:= StringReplace(Result,#$200B,' ',[rfReplaceAll]);
   Result:= StringReplace(Result,#$00AD,' ',[rfReplaceAll]);
   Result:= StringReplace(Result,#$D#$A,' ',[rfReplaceAll]);
   Result:= StringReplace(Result,'&gt;',' ',[rfReplaceAll]);
   Result:= StringReplace(Result,'&amp;',' ',[rfReplaceAll]);
  // Result:= StringReplace(Result,'≤','menor',[rfReplaceAll]);
   Result:= StringReplace(Result,'Ω',' kiloohm',[rfReplaceAll]);
   Result:= StringReplace(Result,'&lt;',' ', [rfReplaceAll]);
end;

function TFuncoes.SerializarINI(Arquivo, chave: string; obj: TObject): TObject;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Fini:TIniFile;
begin
  Result := obj;
  if not(FileExists(Arquivo)) then
    exit;
  Fini := TIniFile.Create(Arquivo);
  Tipo := Contexto.GetType(obj.ClassInfo);
  for Propriedade in Tipo.GetProperties do
  begin
    case Propriedade.PropertyType.TypeKind of
      tkInteger:
        Propriedade.SetValue(obj, Fini.ReadInteger(chave, Propriedade.Name, 0));
      tkUString, tkLString, tkString, tkWString:
        Propriedade.SetValue(obj, Fini.ReadString(chave, Propriedade.Name, ''));
      tkEnumeration:
        Propriedade.SetValue(obj, Fini.ReadBool(chave, Propriedade.Name, False));
      tkFloat:
        Propriedade.SetValue(obj, Fini.ReadFloat(chave, Propriedade.Name, 0));
    end;
  end;
end;

function TFuncoes.SerialNum(FDrive: String): String;
var
  Serial: DWord;
  DirLen, Flags: DWord;
  DLabel: Array [0 .. 11] of Char;
begin
  Try
    GetVolumeInformation(PChar(FDrive + ':\'), DLabel, 12, @Serial, DirLen,
      Flags, nil, 0);
    Result := IntToHex(Serial, 8);
  Except
    Result := '';

  End;
end;

procedure TFuncoes.GravarArquivo(Nome, valor: string);
var
  arq: TextFile;
  s: string;
begin
  s := GetCurrentDir + '\Pedidos\' + FormatDateTime('dd-mm-yyy', now);
  if not DirectoryExists(s) then
    ForceDirectories(s);
  s := s + '\' + Nome + '.txt';

  AssignFile(arq, s);
  Rewrite(arq);
  Writeln(arq, valor);
  CloseFile(arq);
end;

function TFuncoes.GravarINI(Arquivo, chave: string; obj: TObject): TObject;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
   Propriedades: TRttiProperty;
   Fini : TIniFile;
begin
  Fini := TIniFile.Create(Arquivo);
  Tipo := Contexto.GetType(obj.ClassInfo);

  for Propriedades in Tipo.GetProperties do
  begin
    case Propriedades.PropertyType.TypeKind of
      tkInteger:
        Fini.WriteInteger(chave, Propriedades.Name, Propriedades.GetValue(obj).AsInteger);
      tkUString, tkLString, tkString, tkWString:
        Fini.WriteString(chave, Propriedades.Name, Propriedades.GetValue(obj).AsString);
      tkEnumeration:
        Fini.WriteBool(chave, Propriedades.Name, Propriedades.GetValue(obj).AsBoolean);
      tkFloat:
        Fini.WriteFloat(chave, Propriedades.Name, Propriedades.GetValue(obj).AsExtended);
    end;
  end;
  Result := obj;
end;

end.

