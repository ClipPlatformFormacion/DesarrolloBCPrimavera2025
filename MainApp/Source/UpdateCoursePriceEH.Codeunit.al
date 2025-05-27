codeunit 50106 "CLIPUpdate Course Price - EH"
{
    var
        Course: Record "CLIP Course";
        Percentaje: Decimal;


    trigger OnRun()
    begin
        UpdateCoursePrice(Course, Percentaje);
    end;

    procedure SetParameters(NEwCourse: record "CLIP Course"; NewPercentaje: Decimal)
    begin
        Course := NewCourse;
        Percentaje := NewPercentaje;
    end;

    [CommitBehavior(CommitBehavior::Ignore)]
    local procedure UpdateCoursePrice(LocalCourse: Record "CLIP Course"; LocalPercentaje: Decimal): Boolean
    var
        NewPrice: Decimal;
    begin
        NewPrice := LocalCourse.Price * (1 + LocalPercentaje / 100);
        LocalCourse.Validate(Price, NewPrice);
        LocalCourse.Modify(true);

        if LocalCourse."No." = 'GL00000006' then
            Error('The course %1 cannot be updated.', LocalCourse."No.");

        // LlamarAWebService();    
    end;
}