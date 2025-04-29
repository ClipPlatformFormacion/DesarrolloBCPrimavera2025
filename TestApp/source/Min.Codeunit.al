codeunit 50141 CLIPMin
{
    procedure GetMin(v1: Decimal; v2: Decimal): Decimal
    begin
        if v2 < v1 then
            exit(v2)
        else
            exit(v1);
    end;
}