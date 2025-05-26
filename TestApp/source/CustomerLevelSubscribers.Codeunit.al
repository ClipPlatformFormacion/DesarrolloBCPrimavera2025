codeunit 50143 "CLIPCustomer Level Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, OnValidateCustomerLevelOnBeforeUnknownCustomerLevel, '', false, false)]
    local procedure Customer_OnValidateCustomerLevelOnBeforeUnknownCustomerLevel(var Customer: Record Customer; var Handled: Boolean)
    begin
        if Customer."CLIP Customer Level" <> Enum::"CLIP Customer Level"::Platinium then
            exit;

        Customer."CLIP Discount" := 20; // Set discount for Platinium level
        Handled := true; // Indicate that the event has been handled
    end;
}