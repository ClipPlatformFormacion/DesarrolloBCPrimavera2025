// Un comentario
table 50100 "CLIP Course"
{
    Caption = 'Course', Comment = 'ESP="Curso"';
    DataClassification = CustomerContent;
    LookupPageId = "CLIP Course List";
    // ObsoleteState = Pending;
    // ObsoleteReason = 'Empezando en BC26, este campo va a ser eliminado en algun momento. Por favor, utiliza el campo "Name"';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'ESP="Nº"';
            ToolTip = 'Course identifier', Comment = 'ESP="Identificador del curso"';

            trigger OnValidate()
            var
                ResSetup: Record "CLIP Courses Setup";
                NoSeries: Codeunit "No. Series";
                IsHandled: Boolean;
            begin
                IsHandled := false;
                OnBeforeValidateNo(Rec, xRec, IsHandled);
                if IsHandled then
                    exit;

                if "No." <> xRec."No." then begin
                    ResSetup.Get();
                    NoSeries.TestManual(ResSetup."Course Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
        }
        field(3; "Content Description"; Text[2048])
        {
            Caption = 'Content Description', Comment = 'ESP="Temario"';
            ObsoleteState = Pending;
            ObsoleteReason = 'Empezando en BC26, este campo va a ser eliminado en algun momento. Por favor, utiliza el campo "Name"';
        }
        field(4; "Duration (hours)"; Integer)
        {
            Caption = 'Duration (hours)', Comment = 'ESP="Duración (horas)"';
            BlankZero = true;
        }
        field(5; Price; Decimal)
        {
            Caption = 'Price', Comment = 'ESP="Precio"';
            BlankZero = true;

            trigger OnValidate()
            begin
                if Rec."No." = 'GL00000005' then
                    Error('El nuevo precio %1 es incorrecto', Rec.Price);

                Commit();
            end;
        }
        field(6; "Language Code"; Code[10])
        {
            Caption = 'Language Code', Comment = 'ESP="Cód. idioma"';
            TableRelation = Language;
        }
        field(7; "Type (Option)"; Option)
        {
            Caption = 'Type (Option)', Comment = 'ESP="Tipo (Option)"';
            OptionMembers = " ","Instructor-Lead","Video Tutorial";
            OptionCaption = ' ,Instructor-Lead,Video Tutorial', Comment = 'ESP=" ,Guiado por profesor,Vídeo tutorial"';
        }
        field(8; "Type (Enum)"; Enum "CLIP Course Type")
        {
            Caption = 'Type (Enum)', Comment = 'ESP="Tipo (Enum)"';
        }
        field(56; "No. Series"; Code[20])
        {
            Caption = 'No. Series', Comment = 'ESP="Nº Serie"';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(51; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group', Comment = 'ESP="Grupo contable prod. gen."';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            var
                GenProdPostingGrp: Record "Gen. Product Posting Group";
            begin
                if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
                    if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group", GenProdPostingGrp."Def. VAT Prod. Posting Group");
            end;
        }
        field(58; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group', Comment = 'ESP="Grupo contable IVA prod."';
            TableRelation = "VAT Product Posting Group";
        }
        field(60; Updated; Integer)
        { }
        field(70; "Error Message"; Text[2048]) { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, "Duration (hours)", "Type (Enum)", "Language Code") { }
        fieldgroup(Brick; "No.", Name, Price) { }
    }

    trigger OnInsert()
    var
        CoursesSetup: Record "CLIP Courses Setup";
        Course: Record "CLIP Course";
        NoSeries: Codeunit "No. Series";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsert(Rec, IsHandled, xRec);
        if IsHandled then
            exit;

        if "No." = '' then begin
            CoursesSetup.Get();
            CoursesSetup.TestField("Course Nos.");
            "No. Series" := CoursesSetup."Course Nos.";
            if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeries.GetNextNo("No. Series");
            Course.ReadIsolation(IsolationLevel::ReadUncommitted);
            Course.SetLoadFields("No.");
            while Course.Get("No.") do
                "No." := NoSeries.GetNextNo("No. Series");
        end;
    end;

    [Obsolete('Empezando en BC26, este campo va a ser eliminado en algun momento. Por favor, utiliza el campo "Name"')]
    procedure AssistEdit(OldCourse: Record "CLIP Course") Result: Boolean
    var
        Course: Record "CLIP Course";
        CoursesSetup: Record "CLIP Courses Setup";
        NoSeries: Codeunit "No. Series";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeAssistEdit(Rec, OldCourse, IsHandled, Result);
        if IsHandled then
            exit(Result);

        Course := Rec;
        CoursesSetup.Get();
        CoursesSetup.TestField("Course Nos.");
        if NoSeries.LookupRelatedNoSeries(CoursesSetup."Course Nos.", OldCourse."No. Series", Course."No. Series") then begin
            Course."No." := NoSeries.GetNextNo(Course."No. Series");
            Rec := Course;
            exit(true);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeAssistEdit(var Course: Record "CLIP Course"; xOldCourse: Record "CLIP Course"; var IsHandled: Boolean; var Result: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateNo(var Course: Record "CLIP Course"; xCourse: Record "CLIP Course"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var Course: Record "CLIP Course"; var IsHandled: Boolean; var xCourse: Record "CLIP Course")
    begin
    end;
}