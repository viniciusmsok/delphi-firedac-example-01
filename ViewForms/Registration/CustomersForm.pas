unit CustomersForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.NumberBox, Vcl.Mask,
  AncestralForm, RegistrationForm, _Library, _Language, _CustomerDAO, _App;

type
  TFCustomers = class(TFRegistration)
    nID: TNumberBox;
    lbID: TLabel;
    eMainName: TEdit;
    lbOficialName: TLabel;
    lbFederalID: TLabel;
    lbPersonType: TLabel;
    cbPersonType: TComboBox;
    eFederalID: TMaskEdit;
    eSocialName: TEdit;
    lbSocialName: TLabel;
    eEmail: TEdit;
    lbEmail: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure nIDKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbPersonTypeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure eMainNameExit(Sender: TObject);
  private
    isPtBR: Boolean;
    captionPersonTypeNatural: string;
    captionPersonTypeLegal: string;

    captionNaturalPersonOficialName: string;
    captionNaturalPersonSocialName: string;
    captionNaturalPersonFederalId: string;

    captionLegalPersonOficialName: string;
    captionLegalPersonSocialName: string;
    captionLegalPersonFederalId: string;

    procedure InvalidFederalIDMessage;
  protected
    procedure ConfigLanguage; override;
    procedure ValidateData; override;
    procedure Save; override;
    procedure Mode(edition: boolean; isNewRecord: boolean); override;
  public
    class procedure Open;
  end;

implementation

{$R *.dfm}

class procedure TFCustomers.Open;
var
  f: TFCustomers;
begin
  f := TFCustomers.Create(Application);
  f.Show;
end;

procedure TFCustomers.Save;
var
  dao: CustomerDAO;
  data: Customer;
begin
  inherited;
  dao := CustomerDAO.Create(App.conn);
  try
    data.customer_id := 0;
    data.person_type := cbPersonType.Text;
    data.main_name := eMainName.Text;
    data.social_name := eSocialName.Text;
    data.federal_id := eFederalID.Text;
    data.email := eEmail.Text;

    dao.Insert(data);    
  finally
    dao.Free;
  end;
end;

procedure TFCustomers.FormCreate(Sender: TObject);
begin
  inherited;
  cbPersonType.Items.Clear;
  cbPersonType.Items.Add(captionPersonTypeNatural);
  cbPersonType.Items.Add(captionPersonTypeLegal);
  cbPersonType.ItemIndex := 0;
  cbPersonTypeChange(Self);
end;

procedure TFCustomers.InvalidFederalIDMessage;
begin
  Lib.Exclaim(
    '"' + lbFederalID.Caption + '" inválido.',
    'Invalid "' + lbFederalID.Caption + '".'
  );
end;

procedure TFCustomers.ConfigLanguage;
const
  C_PERSON_TYPE_NATURAL = 'C_PERSON_TYPE_NATURAL';
  C_PERSON_TYPE_LEGAL = 'C_PERSON_TYPE_LEGAL';

  C_NATURAL_PERSON_OFICIAL_NAME = 'C_NATURAL_PERSON_OFICIAL_NAME';
  C_NATURAL_PERSON_SOCIAL_NAME = 'C_NATURAL_PERSON_SOCIAL_NAME';
  C_NATURAL_PERSON_FEDERAL_ID = 'C_NATURAL_PERSON_FEDERAL_ID';

  C_LEGAL_PERSON_OFICIAL_NAME = 'C_LEGAL_PERSON_OFICIAL_NAME';
  C_LEGAL_PERSON_SOCIAL_NAME = 'C_LEGAL_PERSON_SOCIAL_NAME';
  C_LEGAL_PERSON_FEDERAL_ID = 'C_LEGAL_PERSON_FEDERAL_ID';
begin
  inherited;
  isPtBR := language.GetConfiguration = TLanguageItem.PT_BR;

  AddCaption(Self.Name, 'Clientes', 'Customers');
  AddCaption(lbPersonType.Name, 'Tipo de pessoa', 'Person type');
  AddCaption(lbOficialName.Name, 'Nome', 'Name');
  AddCaption(lbSocialName.Name, 'Nome social', 'Social name');

  AddCaption(C_PERSON_TYPE_NATURAL, 'Física', 'Natural');
  AddCaption(C_PERSON_TYPE_LEGAL, 'Jurídica', 'Legal');

  AddCaption(C_NATURAL_PERSON_OFICIAL_NAME, 'Nome (registro oficial)', 'Name');
  AddCaption(C_NATURAL_PERSON_SOCIAL_NAME, 'Nome social', 'Social name');
  AddCaption(C_NATURAL_PERSON_FEDERAL_ID, 'CPF', 'Social security');

  AddCaption(C_LEGAL_PERSON_OFICIAL_NAME, 'Razão social', 'Company name');
  AddCaption(C_LEGAL_PERSON_SOCIAL_NAME, 'Nome fantasia', 'Trading name');
  AddCaption(C_LEGAL_PERSON_FEDERAL_ID, 'CNPJ', 'EIN');

  captionPersonTypeNatural := GetCaption(C_PERSON_TYPE_NATURAL);
  captionPersonTypeLegal := GetCaption(C_PERSON_TYPE_LEGAL);

  captionNaturalPersonOficialName := GetCaption(C_NATURAL_PERSON_OFICIAL_NAME);
  captionNaturalPersonSocialName := GetCaption(C_NATURAL_PERSON_SOCIAL_NAME);
  captionNaturalPersonFederalId := GetCaption(C_NATURAL_PERSON_FEDERAL_ID);

  captionLegalPersonOficialName := GetCaption(C_LEGAL_PERSON_OFICIAL_NAME);
  captionLegalPersonSocialName := GetCaption(C_LEGAL_PERSON_SOCIAL_NAME);
  captionLegalPersonFederalId := GetCaption(C_LEGAL_PERSON_FEDERAL_ID);
end;

procedure TFCustomers.Mode(edition: boolean; isNewRecord: boolean);
begin
  inherited;
  nID.Enabled := not edition;

  cbPersonType.Enabled := edition;
  eMainName.Enabled := edition;
  eSocialName.Enabled := edition;
  eFederalID.Enabled := edition;
  eEmail.Enabled := edition;

  if isNewRecord then
    nID.Clear;

  eMainName.Clear;
  eSocialName.Clear;
  eEmail.Clear;

  cbPersonType.itemIndex := cbPersonType.Items.IndexOf(captionPersonTypeNatural);
  cbPersonTypeChange(Self);

  if isNewRecord then begin
    
  end;
end;

procedure TFCustomers.nIDKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  isNewRecord: boolean;
begin
  inherited;
  if Key = VK_RETURN then begin
    isNewRecord := nID.ValueInt = 0;
    Mode(True, isNewRecord);
    Lib.Focus(cbPersonType);
  end;
end;

procedure TFCustomers.cbPersonTypeChange(Sender: TObject);
begin
  inherited;
  eFederalID.Clear;

  if cbPersonType.Text = captionPersonTypeNatural then begin
    lbOficialName.Caption := captionNaturalPersonOficialName;
    lbSocialName.Caption := captionNaturalPersonSocialName;
    lbFederalID.Caption := captionNaturalPersonFederalId;

    eFederalID.EditMask := '';
    if language.GetConfiguration = TLanguageItem.PT_BR then
      eFederalID.EditMask := '999.999.999-99';
  end
  else begin
    lbOficialName.Caption := captionLegalPersonOficialName;
    lbSocialName.Caption := captionLegalPersonSocialName;
    lbFederalID.Caption := captionLegalPersonFederalId;

    eFederalID.EditMask := '';
    if language.GetConfiguration = TLanguageItem.PT_BR then
       eFederalID.EditMask := '99.999.999/9999-99';
  end;
end;

procedure TFCustomers.ValidateData;
begin
  inherited;
  eMainName.Text := Trim(eMainName.Text);
  Lib.Required(
    lbOficialName.Caption,
    Length(eMainName.Text) < 3,
    eMainName
  );

  eSocialName.Text := Trim(eSocialName.Text);
  Lib.Required(
    lbSocialName,
    Length(eSocialName.Text) < 3,
    eSocialName
  );

  Lib.Required(
    lbFederalID,
    Lib.Numbers(eFederalID.Text) = '',
    eFederalID
  );

  if isPtBR then begin
    if
      ((cbPersonType.Text = captionPersonTypeNatural) and (not Lib.ValidateCPF(eFederalID.Text)))
      or
      ((cbPersonType.Text = captionPersonTypeLegal) and (not Lib.ValidateCNPJ(eFederalID.Text)))

    then begin
      Self.InvalidFederalIDMessage;
      Lib.Focus(eFederalID);
      Abort;
    end;
  end;
end;

procedure TFCustomers.eMainNameExit(Sender: TObject);
begin
  inherited;
  eMainName.Text := Trim(eMainName.Text);

  if eSocialName.Text = '' then
    eSocialName.Text := eMainName.Text;

  eSocialName.Text := Trim(eSocialName.Text);
end;

procedure TFCustomers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := TCloseAction.caFree;
end;

end.
