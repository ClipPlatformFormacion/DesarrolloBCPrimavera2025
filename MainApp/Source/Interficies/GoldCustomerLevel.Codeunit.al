codeunit 50105 "CLIPGold Customer Level" implements CLIPICustomerLevel
{
    procedure GetDiscount(): Decimal
    begin
        exit(15);
    end;

    procedure SendEmail()
    begin

    end;
}