Margin %         = SUM([profit]) / NULLIFZERO(SUM([sales]))
Month            = DATETRUNC('month', [order_date])
MoM %            = (SUM([sales]) - LOOKUP(SUM([sales]), -1)) / LOOKUP(SUM([sales]), -1)
Discount Band    = IF [discount] < 0.05 THEN '0-5%' ELSEIF [discount] < 0.10 THEN '5-10%'
                   ELSEIF [discount] < 0.20 THEN '10-20%' ELSE '20%+' END
Delivered ≤3 Day = IF [delivery_days] <= 3 THEN 1 ELSE 0 END
