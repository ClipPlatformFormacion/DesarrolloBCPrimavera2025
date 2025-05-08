codeunit 50101 "CLIP Course Journal-Post Line"
{
    Permissions = TableData "CLIP Course Ledger Entry" = rimd;
    TableNo = "CLIP Course Journal Line";

    trigger OnRun()
    begin
        GetGLSetup();
        RunWithCheck(Rec);
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        CourseJournalLineGlobal: Record "CLIP Course Journal Line";
        CourseLedgerEntry: Record "CLIP Course Ledger Entry";
        Course: Record "CLIP Course";
        NextEntryNo: Integer;
        GLSetupRead: Boolean;

    procedure RunWithCheck(var CourseJournalLine: Record "CLIP Course Journal Line")
    begin
        CourseJournalLineGlobal.Copy(CourseJournalLine);
        Code();
        CourseJournalLine := CourseJournalLineGlobal;
    end;

    local procedure "Code"()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforePostCourseJnlLine(CourseJournalLineGlobal, IsHandled);
        if not IsHandled then begin
            if CourseJournalLineGlobal.EmptyLine() then
                exit;

            if NextEntryNo = 0 then begin
                CourseLedgerEntry.LockTable();
                NextEntryNo := CourseLedgerEntry.GetLastEntryNo() + 1;
            end;

            if CourseJournalLineGlobal."Document Date" = 0D then
                CourseJournalLineGlobal."Document Date" := CourseJournalLineGlobal."Posting Date";

            Course.Get(CourseJournalLineGlobal."Course No.");

            CourseLedgerEntry.Init();
            CourseLedgerEntry.CopyFromCourseJournalLine(CourseJournalLineGlobal);

            GetGLSetup();
            CourseLedgerEntry."Total Price" := Round(CourseLedgerEntry."Total Price");
            CourseLedgerEntry."Entry No." := NextEntryNo;

            OnBeforeCourseLedgerEntryInsert(CourseLedgerEntry, CourseJournalLineGlobal);

            CourseLedgerEntry.Insert(true);

            NextEntryNo := NextEntryNo + 1;
        end;

        OnAfterPostCourseJournalLine(CourseJournalLineGlobal, CourseLedgerEntry);
    end;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then
            GeneralLedgerSetup.Get();
        GLSetupRead := true;
    end;


    [IntegrationEvent(false, false)]
    local procedure OnAfterPostCourseJournalLine(var CourseJournalLine: Record "CLIP Course Journal Line"; var CourseLedgerEntry: Record "CLIP Course Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostCourseJnlLine(var CourseJournalLine: Record "CLIP Course Journal Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCourseLedgerEntryInsert(var CourseLedgerEntry: Record "CLIP Course Ledger Entry"; CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;
}

