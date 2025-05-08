table 50104 "CLIP Course Journal Line"
{
    Caption = 'Course Journal Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            // TableRelation = "Course Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        // field(3; "Entry Type"; Enum "Course Journal Line Entry Type")
        // {
        //     Caption = 'Entry Type';
        // }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                TestField("Posting Date");
                Validate("Document Date", "Posting Date");
            end;
        }
        field(6; "Course No."; Code[20])
        {
            Caption = 'Course No.';
            TableRelation = "CLIP Course";

            trigger OnValidate()
            begin
                // if "Course No." = '' then begin
                //     CreateDimFromDefaultDim(Rec.FieldNo("Course No."));
                //     exit;
                // end;

                Course.Get("Course No.");

                Description := Course.Name;
                "Unit Price" := Course.Price;
                "Gen. Prod. Posting Group" := Course."Gen. Prod. Posting Group";

                // CreateDimFromDefaultDim(Rec.FieldNo("Course No."));
            end;
        }
        field(7; "Course Edition"; Code[20])
        {
            Caption = 'Course Edition';
            TableRelation = "CLIP Course Edition".Edition where("Course No." = field("Course No."));
        }
        field(8; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Validate("Unit Price");
            end;
        }
        field(16; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;

            trigger OnValidate()
            begin
                "Total Price" := Quantity * "Unit Price";
            end;
        }
        field(17; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price';

            trigger OnValidate()
            begin
                TestField(Quantity);
                GetGLSetup();
                "Unit Price" := Round("Total Price" / Quantity, GeneralLedgerSetup."Unit-Amount Rounding Precision");
            end;
        }
        // field(18; "Shortcut Dimension 1 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,1';
        //     Caption = 'Shortcut Dimension 1 Code';
        //     TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
        //                                                   Blocked = const(false));

        //     trigger OnValidate()
        //     begin
        //         Rec.ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
        //     end;
        // }
        // field(19; "Shortcut Dimension 2 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,2';
        //     Caption = 'Shortcut Dimension 2 Code';
        //     TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
        //                                                   Blocked = const(false));

        //     trigger OnValidate()
        //     begin
        //         Rec.ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
        //     end;
        // }
        field(21; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
        }
        field(23; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            // TableRelation = "Course Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(24; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        // field(25; "Recurring Method"; Option)
        // {
        //     BlankZero = true;
        //     Caption = 'Recurring Method';
        //     OptionCaption = ',Fixed,Variable';
        //     OptionMembers = ,"Fixed",Variable;
        // }
        // field(26; "Expiration Date"; Date)
        // {
        //     Caption = 'Expiration Date';
        // }
        // field(27; "Recurring Frequency"; DateFormula)
        // {
        //     Caption = 'Recurring Frequency';
        // }
        field(28; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(29; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(30; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(31; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(34; "Customer No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = Customer."No.";
        }
        // field(480; "Dimension Set ID"; Integer)
        // {
        //     Caption = 'Dimension Set ID';
        //     Editable = false;
        //     TableRelation = "Dimension Set Entry";

        //     trigger OnLookup()
        //     begin
        //         Rec.ShowDimensions();
        //     end;

        //     trigger OnValidate()
        //     begin
        //         DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        //     end;
        // }
        field(959; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "Course No.", Description, Quantity, "Document No.", "Document Date")
        { }
    }

    trigger OnInsert()
    begin
        LockTable();
        // ResJnlTemplate.Get("Journal Template Name");
        // ResJnlBatch.Get("Journal Template Name", "Journal Batch Name");

        // Rec.ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
        // Rec.ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
    end;

    var
        // ResJnlTemplate: Record "Course Journal Template";
        // ResJnlBatch: Record "Course Journal Batch";
        Course: Record "CLIP Course";
        GeneralLedgerSetup: Record "General Ledger Setup";
        // DimMgt: Codeunit DimensionManagement;
        GLSetupRead: Boolean;

    procedure EmptyLine(): Boolean
    begin
        exit(("Course No." = '') and (Quantity = 0));
    end;

    // procedure SetUpNewLine(LastResJnlLine: Record "CLIP Course Journal Line")
    // var
    //     NoSeries: Codeunit "No. Series";
    // begin
    //     ResJnlTemplate.Get("Journal Template Name");
    //     ResJnlBatch.Get("Journal Template Name", "Journal Batch Name");
    //     CourseJournalLine.SetRange("Journal Template Name", "Journal Template Name");
    //     CourseJournalLine.SetRange("Journal Batch Name", "Journal Batch Name");
    //     if CourseJournalLine.FindFirst() then begin
    //         "Posting Date" := LastResJnlLine."Posting Date";
    //         "Document Date" := LastResJnlLine."Posting Date";
    //         "Document No." := LastResJnlLine."Document No.";
    //     end else begin
    //         "Posting Date" := WorkDate();
    //         "Document Date" := WorkDate();
    //         if ResJnlBatch."No. Series" <> '' then
    //             "Document No." := NoSeries.PeekNextNo(ResJnlBatch."No. Series", "Posting Date");
    //     end;
    //     "Recurring Method" := LastResJnlLine."Recurring Method";
    //     "Source Code" := ResJnlTemplate."Source Code";
    //     "Reason Code" := ResJnlBatch."Reason Code";
    //     "Posting No. Series" := ResJnlBatch."Posting No. Series";

    //     OnAfterSetUpNewLine(Rec, LastResJnlLine);
    // end;

    // procedure CreateDim(DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    // var
    //     OldDimSetID: Integer;
    // begin
    //     "Shortcut Dimension 1 Code" := '';
    //     "Shortcut Dimension 2 Code" := '';
    //     OldDimSetID := "Dimension Set ID";
    //     "Dimension Set ID" :=
    //       DimMgt.GetRecDefaultDimID(
    //         Rec, CurrFieldNo, DefaultDimSource, "Source Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);

    //     OnAfterCreateDimProcedure(Rec, CurrFieldNo, DefaultDimSource, xRec, OldDimSetID);
    // end;

    // procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    // begin
    //     OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);

    //     DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

    //     OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
    // end;

    // procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    // begin
    //     DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
    //     DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    // end;

    // procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    // begin
    //     DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDimCode);
    // end;

    procedure CopyDocumentFields(DocNo: Code[20]; ExtDocNo: Text[35]; SourceCode: Code[10]; NoSeriesCode: Code[20])
    begin
        "Document No." := DocNo;
        "External Document No." := ExtDocNo;
        "Source Code" := SourceCode;
    end;

    procedure CopyFromSalesHeader(SalesHeader: Record "Sales Header")
    begin
        "Posting Date" := SalesHeader."Posting Date";
        "Document Date" := SalesHeader."Document Date";
        "Reason Code" := SalesHeader."Reason Code";

        OnAfterCopyCourseJournalLineFromSalesHeader(SalesHeader, Rec);
    end;

    procedure CopyFromSalesLine(SalesLine: Record "Sales Line")
    begin
        "Course No." := SalesLine."No.";
        "Course Edition" := SalesLine."CLIP Course Edition";
        Description := SalesLine.Description;
        "Customer No." := SalesLine."Sell-to Customer No.";
        // "Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
        // "Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
        // "Dimension Set ID" := SalesLine."Dimension Set ID";
        "Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := SalesLine."Gen. Prod. Posting Group";
        // "Entry Type" := "Entry Type"::Sale;      
        Quantity := -SalesLine."Qty. to Invoice";
        "Unit Price" := SalesLine."Unit Price";
        "Total Price" := -SalesLine.Amount;

        OnAfterCopyCourseJournalLineFromSalesLine(SalesLine, Rec);
    end;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then
            GeneralLedgerSetup.Get();
        GLSetupRead := true;
    end;

    // procedure ShowDimensions()
    // begin
    //     "Dimension Set ID" :=
    //       DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', "Journal Template Name", "Journal Batch Name", "Line No."));
    //     DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

    //     OnAfterShowDimensions(Rec);
    // end;

    // procedure IsOpenedFromBatch(): Boolean
    // var
    //     ResJournalBatch: Record "Course Journal Batch";
    //     TemplateFilter: Text;
    //     BatchFilter: Text;
    // begin
    //     BatchFilter := GetFilter("Journal Batch Name");
    //     if BatchFilter <> '' then begin
    //         TemplateFilter := GetFilter("Journal Template Name");
    //         if TemplateFilter <> '' then
    //             ResJournalBatch.SetFilter("Journal Template Name", TemplateFilter);
    //         ResJournalBatch.SetFilter(Name, BatchFilter);
    //         ResJournalBatch.FindFirst();
    //     end;

    //     exit((("Journal Batch Name" <> '') and ("Journal Template Name" = '')) or (BatchFilter <> ''));
    // end;

    // procedure CreateDimFromDefaultDim(FieldNo: Integer)
    // var
    //     DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];
    // begin
    //     InitDefaultDimensionSources(DefaultDimSource, FieldNo);
    //     CreateDim(DefaultDimSource);
    // end;

    // local procedure InitDefaultDimensionSources(var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    // begin
    //     DimMgt.AddDimSource(DefaultDimSource, Database::Course, Rec."Course No.", FieldNo = Rec.FieldNo("Course No."));
    //     DimMgt.AddDimSource(DefaultDimSource, Database::"Course Group", Rec."Course Group No.", FieldNo = Rec.FieldNo("Course Group No."));
    //     DimMgt.AddDimSource(DefaultDimSource, Database::Job, Rec."Job No.", FieldNo = Rec.FieldNo("Job No."));

    //     OnAfterInitDefaultDimensionSources(Rec, DefaultDimSource, FieldNo);
    // end;

    // [IntegrationEvent(false, false)]
    // local procedure OnAfterInitDefaultDimensionSources(var ResJournalLine: Record "Course Journal Line"; var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // local procedure OnAfterCreateDimProcedure(var ResJournalLine: Record "Course Journal Line"; CurrFieldNo: Integer; var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; xResJournalLine: Record "Course Journal Line"; OldDimSetID: Integer)
    // begin
    // end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyCourseJournalLineFromSalesHeader(var SalesHeader: Record "Sales Header"; var CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyCourseJournalLineFromSalesLine(var SalesLine: Record "Sales Line"; var CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;

    // [IntegrationEvent(false, false)]
    // local procedure OnAfterSetUpNewLine(var ResJournalLine: Record "Course Journal Line"; LastResJournalLine: Record "Course Journal Line")
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // local procedure OnAfterShowDimensions(var ResJnlLine: Record "Course Journal Line")
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // local procedure OnAfterValidateShortcutDimCode(var ResJournalLine: Record "Course Journal Line"; xResJournalLine: Record "Course Journal Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // local procedure OnBeforeValidateShortcutDimCode(var ResJournalLine: Record "Course Journal Line"; xResJournalLine: Record "Course Journal Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    // begin
    // end;
}

