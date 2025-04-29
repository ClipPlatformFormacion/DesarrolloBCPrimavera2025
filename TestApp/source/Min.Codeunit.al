codeunit 50141 CLIPMin
{
    procedure GetMin(v1: Decimal; v2: Decimal): Decimal
    begin
        if v1 < v2 then
            exit(v1)
        else
            exit(v2);
    end;
}