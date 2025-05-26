codeunit 50103 "CLIPBronze Customer Level" implements CLIPICustomerLevel
{
    procedure GetDiscount(): Decimal
    begin
        exit(5);
    end;

    procedure SendEmail()
    begin

    end;
}