enum 50101 "CLIP Customer Level" implements CLIPICustomerLevel
{
    Extensible = true;

    value(0; " ")
    {
        Implementation = CLIPICustomerLevel = "CLIPBlank Customer Level";
    }
    value(1; "Bronze")
    {
        Implementation = CLIPICustomerLevel = "CLIPBronze Customer Level";
    }
    value(2; "Silver")
    {
        Implementation = CLIPICustomerLevel = "CLIPSilver Customer Level";
    }
    value(3; "Gold")
    {
        Implementation = CLIPICustomerLevel = "CLIPGold Customer Level";
    }
}