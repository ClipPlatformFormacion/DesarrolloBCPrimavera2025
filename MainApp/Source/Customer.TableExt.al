tableextension 50103 "CLIP Customer" extends Customer
{
    fields
    {
        field(50100; "CLIP Customer Level"; Enum "CLIP Customer Level")
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Handled: Boolean;
            begin
                case Rec."CLIP Customer Level" of
                    Enum::"CLIP Customer Level"::" ":
                        Rec."CLIP Discount" := 0;
                    Enum::"CLIP Customer Level"::Bronze:
                        Rec."CLIP Discount" := 5;
                    Enum::"CLIP Customer Level"::Silver:
                        Rec."CLIP Discount" := 10;
                    Enum::"CLIP Customer Level"::Gold:
                        Rec."CLIP Discount" := 15;
                    else begin
                        OnValidateCustomerLevelOnBeforeUnknownCustomerLevel(Rec, Handled);
                        if not Handled then
                            Error('Unknown Customer Level: %1', Rec."CLIP Customer Level");
                    end;
                end;
            end;
        }
        field(50101; "CLIP Discount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    [IntegrationEvent(false, false)]
    local procedure OnValidateCustomerLevelOnBeforeUnknownCustomerLevel(var Customer: Record Customer; var Handled: boolean)
    begin
    end;
}