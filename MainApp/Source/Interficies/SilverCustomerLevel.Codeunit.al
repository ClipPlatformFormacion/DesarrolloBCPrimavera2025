codeunit 50104 "CLIPSilver Customer Level" implements CLIPICustomerLevel
{
    procedure GetDiscount(): Decimal
    begin
        exit(10);
    end;

    procedure SendEmail()
    begin

    end;
}