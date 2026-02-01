USE AdventureWorksDW2019;
GO

CREATE PROCEDURE dbo.GetCurrencyRatesFromYearsAgo
    @YearsAgo INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        f.CurrencyKey,
        f.Date,
        f.AverageRate,
        f.EndOfDayRate,
        d.CurrencyAlternateKey
    FROM dbo.FactCurrencyRate AS f
    INNER JOIN dbo.DimCurrency AS d ON f.CurrencyKey = d.CurrencyKey
    WHERE d.CurrencyAlternateKey IN ('GBP', 'EUR')
      AND f.Date >= DATEADD(YEAR, -@YearsAgo, CAST(GETDATE() AS DATE));
END;
GO