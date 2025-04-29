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
}