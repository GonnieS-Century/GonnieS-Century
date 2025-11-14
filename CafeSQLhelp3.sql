create table transaction_type (
PaymentID int identity(1,1),
Payment_Method varchar(250),
);

select * from [transaction_type]

delete from [transaction_type] where PaymentID = '10031';
delete from [transaction_type] where PaymentID = '10032';

UPDATE [transaction_type]
SET [Payment_Method]= 'UNKNOWN'
WHERE [Payment_Method] IS NULL
