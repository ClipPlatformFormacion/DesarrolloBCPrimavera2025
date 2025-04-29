codeunit 50140 "CLIP Courses Test"
{
    Subtype = Test;

    // [Test]
    // procedure Test001()
    // begin
    // end;

    // [Test]
    // procedure Test002()
    // begin
    //     Error('Un error del test');
    // end;

    [Test]
    procedure Test003()
    var
        CLIPMin: Codeunit CLIPMin;
        Value1: Decimal;
        Value2: Decimal;
        Result: Decimal;
    begin
        // [Scenario] Una función llamada GetMin devuelve el menor de 2 valores numéricos

        // [Given] 2 valores numéricos
        Value1 := 1;
        Value2 := 2;

        // [When] se realice la llamada a la función GetMin
        Result := CLIPMin.GetMin(Value1, Value2);

        // [Then] El resultado tiene que ser el más pequeño de los valores numéricos
        if Result <> Value1 then
            Error('El resultado no es correcto');
    end;

    [Test]
    procedure Test004()
    var
        CLIPMin: Codeunit CLIPMin;
        Value1: Decimal;
        Value2: Decimal;
        Result: Decimal;
    begin
        // [Scenario] Una función llamada GetMin devuelve el menor de 2 valores numéricos

        // [Given] 2 valores numéricos
        Value1 := 20;
        Value2 := 10;

        // [When] se realice la llamada a la función GetMin
        Result := CLIPMin.GetMin(Value1, Value2);

        // [Then] El resultado tiene que ser el más pequeño de los valores numéricos
        if Result <> Value2 then
            Error('El resultado no es correcto');
    end;

    [Test]
    procedure SelectingACourseOnASalesLine()
    var
        Course: Record "CLIP Course";
        SalesHeader: Record "Sales Header";
    begin
        // [Scenario] al seleccionar un curso en una línea de venta, el sistema rellena la información relacionada

        // [Given] Un curso con descripción, precio y grupos contables
        //         Un documento de venta
        Course.Init();
        Course."No." := 'TEST';
        Course.Name := 'Un curso de test';
        Course.Price := 999.99;
        // Course."Gen. Prod. Posting Group" := 
        // Course."VAT Prod. Posting Group" :=
        Course.Insert();

        SalesHeader.Init();
        SalesHeader."Sell-to Customer No."


        // [When] seleccionamos el curso en el documento de venta


        // [Then] la línea de venta tiene la Descripción, Precio y Grupos contables especificados en el curso
    end;
}