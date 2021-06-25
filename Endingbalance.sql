# MySQL
# please check the comment with 4 steps that I used to solve the case
# step 0: 
# union all 12 months of a year
CREATE OR REPLACE view months
AS
  SELECT 1 month
  UNION ALL
  SELECT 2
  UNION ALL
  SELECT 3
  UNION ALL
  SELECT 4
  UNION ALL
  SELECT 5
  UNION ALL
  SELECT 6
  UNION ALL
  SELECT 7
  UNION ALL
  SELECT 8
  UNION ALL
  SELECT 9
  UNION ALL
  SELECT 10
  UNION ALL
  SELECT 11
  UNION ALL
  SELECT 12;

# step 3:
# calculate `month_total` as account ending balance
SELECT Sum(month_total) AS ending_balance_of_the_year
FROM   (SELECT DISTINCT month,
                        Ifnull(total + activity_fee, -2) AS month_total
        # step 2:
        # left join months and 'transactions_id', to get 'transaction_by_month'
        # if one month has null transaction, activity_fee -2
        # else, calculate activity_fee based on given rules below
        # left join to get `month_total` of all transactions + fees combined
        FROM   months
               LEFT JOIN (SELECT month,
                                 Count(transaction_id) AS transation_count,
                                 Sum(amount)           AS total,
                                 ( CASE
                                     WHEN Sum(payment_count) >= 3
                                          # Only if both payment count >= 3 and payment amount <= -100
                                          # 2 dollar activity fee will be waived
                                          # fail to meet either of the above criterias will charge -2
                                          AND Sum(payment_amount) <= -100 THEN 0
                                     ELSE -2
                                   end )               AS activity_fee
                          # step 1:
                          # get month as a digit of each transaction
                          # get count of payment transactions and total payment amount in that month by `group_by`
                          # alias the table as 'transactions_with_id'
                          FROM   (SELECT Date_format(transactions.date, '%c') AS
                                         month,
                                         @rownum := @rownum + 1               AS
                                         transaction_id
                                         ,
                                         amount,
                                         ( CASE
                                             WHEN amount >= 0 THEN 0
                                             ELSE amount
                                           end )                              AS
                                         payment_amount
                                         ,
                                         ( CASE
                                             WHEN amount >= 0 THEN 0
                                             ELSE 1
                                           end )                              AS
                                         payment_count
                                  FROM   transactions,
                                         # use a variable as an unique ID for each row
                                         (SELECT @rownum := 0) r
                                  WHERE  date BETWEEN '2020-01-01' AND
                                                      '2020-12-31')
                                 transactions_with_id
                          GROUP  BY month) transaction_by_month USING (month))
       month_total
