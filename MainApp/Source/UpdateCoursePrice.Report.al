report 50100 "CLIP Update Course Price"
{
    Caption = 'Update Course Price', Comment = 'ESP="Actualizar precio cursos"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Course; "CLIP Course")
        {
            RequestFilterFields = "No.", Price, "Type (Enum)";
            trigger OnPreDataItem()
            begin
                // código que se ejecuta antes que empiece el bucle
                // Message('OnPreDataItem');
            end;

            trigger OnAfterGetRecord()
            begin
                //código que se ejecuta en cada una de las iteraciones del bucle
                // Message('OnAfterGetRecord ' + Course."No.");
                Course.Validate(Price, Course.Price * (1 + Percentaje / 100));
                Course.Modify(true);
            end;

            trigger OnPostDataItem()
            begin
                // código que se ejecuta después de que termina el bucle
                // Message('OnPostDataItem');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options', comment = 'ESP="Opciones"';
                    field(PercentajeControl; Percentaje)
                    {
                        ApplicationArea = All;
                        Caption = 'Percentaje', comment = 'ESP="Porcentaje"';
                        ToolTip = 'Enter the percentaje to increase the price of the courses.';
                        BlankZero = true;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            Percentaje := 10;
        end;
    }

    trigger OnPreReport()
    begin
        if Percentaje = 0 then
            Error('The percentaje must be greater than 0.');
    end;

    trigger OnPostReport()
    begin
        Message('The price of the courses has been updated.');
    end;

    var
        Percentaje: Decimal;
}