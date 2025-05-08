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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnPostSalesLineOnBeforePostSalesLine, '', false, false)]
    local procedure "Sales-Post_OnPostSalesLineOnBeforePostSalesLine"(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; SrcCode: Code[10]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean; SalesLineACY: Record "Sales Line")
    begin
        if SalesLine.Type <> "Sales Line Type"::"CLIP Course" then
            exit;

        PostCourseJournalLine(SalesHeader, SalesLine, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode);
    end;


    local procedure PostCourseJournalLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; SrcCode: Code[10])
    var
        CourseJournalLine: Record "CLIP Course Journal Line";
        CourseJournalPostLine: Codeunit "CLIP Course Journal-Post Line";
        IsHandled: Boolean;
        ShouldExit: Boolean;
    begin
        IsHandled := false;
        OnBeforePostCourseJournalLine(SalesHeader, SalesLine, IsHandled, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode);
        if IsHandled then
            exit;

        ShouldExit := SalesLine."Qty. to Invoice" = 0;
        OnPostCourseJournalLineOnShouldExit(SalesLine, ShouldExit);
        if ShouldExit then
            exit;

        CourseJournalLine.Init();
        CourseJournalLine.CopyFromSalesHeader(SalesHeader);
        CourseJournalLine.CopyDocumentFields(GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, SalesHeader."Posting No. Series");
        CourseJournalLine.CopyFromSalesLine(SalesLine);
        OnPostCourseJournalLineOnAfterInit(CourseJournalLine, SalesLine);

        CourseJournalPostLine.RunWithCheck(CourseJournalLine);

        OnAfterPostCourseJournalLine(SalesHeader, SalesLine, CourseJournalLine);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostCourseJournalLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var IsHandled: Boolean; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; SrcCode: Code[10])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostCourseJournalLineOnShouldExit(var SalesLine: Record "Sales Line"; ShouldExit: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostCourseJournalLineOnAfterInit(ResJnlLine: Record "Res. Journal Line"; var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPostCourseJournalLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ResJnlLine: Record "Res. Journal Line")
    begin
    end;
}