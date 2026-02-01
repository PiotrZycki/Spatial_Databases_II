SELECT OrderDate, COUNT(SalesOrderNumber) AS OrdersCount
FROM FactInternetSales
GROUP BY OrderDate
HAVING COUNT(SalesOrderNumber) < 100
ORDER BY OrdersCount DESC;

SELECT
    r.OrderDate,
    r.ProductKey,
    r.UnitPrice
FROM (
SELECT
    OrderDate,
    UnitPrice,
    ProductKey,
    ROW_NUMBER() OVER (
        PARTITION BY OrderDate 
        ORDER BY UnitPrice DESC, ProductKey ASC
    ) AS PriceRank
FROM FactInternetSales
) AS r
WHERE r.PriceRank <= 3