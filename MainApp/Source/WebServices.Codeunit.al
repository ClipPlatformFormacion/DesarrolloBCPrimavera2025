codeunit 50107 CLIPWebServices
{
    procedure UnMetodoSinParametroNiValorDeRetorno()
    begin

    end;

    procedure UnMetodoConParametroDeTexto(TextoRecibido: Text): Text
    begin
        exit(StrSubstNo('Hola desde Business Central! Estás en la empresa %1, tu texto era %2', CompanyName(), TextoRecibido));
    end;

    procedure CrearCliente(): Text
    var
        Customer: Record Customer;
    begin
        Customer.Init();
        Customer.Validate(Name, 'Cliente creado desde WebService');
        Customer.Insert(true);

        exit(Customer."No.");
    end;

    procedure CrearClienteConParametros(Name: Text[100]; Address: Text[100]; PhoneNo: Text[30]; CreditLimit: Decimal): Text
    var
        Customer: Record Customer;
    begin
        if GuiAllowed() then
            if not Confirm('¿Estás seguro que quieres crear un nuevo cliente?', false) then
                Error('Operación cancelada por el usuario.');

        Customer.Init();
        Customer.Validate(Name, Name);
        Customer.Validate(Address, Address);
        Customer.Validate("Phone No.", PhoneNo);
        Customer.Validate("Credit Limit (LCY)", CreditLimit);
        Customer.Insert(true);
        Message('Cliente creado con éxito: %1', Customer."No.");

        exit(Customer."No.");
    end;

    procedure CrearCurso(XMLPortAImportar: XMLPort "CLIPImport Course")
    begin
        XMLPortAImportar.Import();
    end;
}