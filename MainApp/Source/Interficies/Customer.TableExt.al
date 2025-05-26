tableextension 50103 "CLIP Customer" extends Customer
{
    fields
    {
        field(50100; "CLIP Customer Level"; Enum "CLIP Customer Level")
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ICustomerLevel: Interface CLIPICustomerLevel;
            begin
                ICustomerLevel := Rec."CLIP Customer Level";
                Rec."CLIP Discount" := ICustomerLevel.GetDiscount();
            end;
        }
        field(50101; "CLIP Discount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
}