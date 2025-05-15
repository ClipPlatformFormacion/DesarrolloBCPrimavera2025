codeunit 50142 "CLIP Library - Course"
{
    procedure CreateCourse() Course: Record "CLIP Course"
    var
        GeneralPostingSetup: Record "General Posting Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        LibraryRandom: Codeunit "Library - Random";
        LibraryERM: Codeunit "Library - ERM";
    begin
        CoursesNoSeriesSetup();
        LibraryRandom.Init();

        LibraryERM.FindGeneralPostingSetupInvtFull(GeneralPostingSetup);
        LibraryERM.FindVATPostingSetupInvt(VATPostingSetup);

        Course.Insert(true);
        Course.Validate(Name, Course."No.");
        Course.Validate(Price, LibraryRandom.RandDecInRange(500, 1000, 2));
        Course.Validate("Gen. Prod. Posting Group", GeneralPostingSetup."Gen. Prod. Posting Group");
        Course.Validate("VAT Prod. Posting Group", VATPostingSetup."VAT Prod. Posting Group");
        Course.Modify(true);
    end;

    internal procedure CreateEdition(Course: Record "CLIP Course") CourseEdition: Record "CLIP Course Edition"
    var
        LibraryRandom: Codeunit "Library - Random";
    begin
        LibraryRandom.Init();
        CourseEdition.Init();
        CourseEdition.Validate("Course No.", Course."No.");
        CourseEdition.Validate(Edition, LibraryRandom.RandText(MaxStrLen(CourseEdition.Edition)));
        CourseEdition.Validate("Max. Students", LibraryRandom.RandIntInRange(10, 20));
        CourseEdition.Validate("Start Date", LibraryRandom.RandDateFrom(Today(), 30));
        CourseEdition.Insert(true);
    end;

    local procedure CoursesNoSeriesSetup()
    var
        CoursesSetup: Record "CLIP Courses Setup";
        LibraryUtility: Codeunit "Library - Utility";
        NoSeriesCode: Code[20];
    begin
        if not CoursesSetup.Get() then
            CoursesSetup.Insert();
        NoSeriesCode := LibraryUtility.GetGlobalNoSeriesCode();
        if NoSeriesCode <> CoursesSetup."Course Nos." then begin
            CoursesSetup.Validate("Course Nos.", LibraryUtility.GetGlobalNoSeriesCode());
            CoursesSetup.Modify(true);
        end;
    end;
}