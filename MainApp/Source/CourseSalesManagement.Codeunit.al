codeunit 50100 "CLIPCourse - Sales Management"
{
    [EventSubscriber(ObjectType::Table, Database::"Option Lookup Buffer", OnBeforeIncludeOption, '', false, false)]
    local procedure "Option Lookup Buffer_OnBeforeIncludeOption"(LookupType: Option; Option: Integer; var Handled: Boolean; var Result: Boolean)
    begin
        if LookupType <> Enum::"Option Lookup Type"::Sales.AsInteger() then
            exit;

        if Option <> "Sales Line Type"::"CLIP Course".AsInteger() then
            exit;

        Result := true;
        Handled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterAssignFieldsForNo, '', false, false)]
    local procedure OnAfterAssignFieldsForNo(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
        if SalesLine.Type <> Enum::"Sales Line Type"::"CLIP Course" then
            exit;

        CopyFromCourse(SalesLine, SalesHeader);
    end;

    local procedure CopyFromCourse(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        Course: Record "CLIP Course";
    begin
        Course.Get(SalesLine."No.");
        Course.TestField("Gen. Prod. Posting Group");
        SalesLine.Description := Course.Name;
        SalesLine."Gen. Prod. Posting Group" := Course."Gen. Prod. Posting Group";
        SalesLine."VAT Prod. Posting Group" := Course."VAT Prod. Posting Group";
        SalesLine."Allow Item Charge Assignment" := false;
        SalesLine."Unit Price" := Course.Price;
        OnAfterAssignCourseValues(SalesLine, Course, SalesHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAssignCourseValues(var SalesLine: Record "Sales Line"; Course: Record "CLIP Course"; SalesHeader: Record "Sales Header")
    begin
    end;
}