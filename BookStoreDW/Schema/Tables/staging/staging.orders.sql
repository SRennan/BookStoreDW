CREATE TABLE [staging].[orders]
(
	
	order_id			INT NOT NULL,

    AddressSK           INT NULL, 
	BookSK              INT NULL,
	CustomerSK          INT NULL,
	MethodSK            INT NULL,      
	StatusSK			INT NULL,
		
	Order_dateKey		INT NOT NULL,
	Status_dateKey		INT NOT NULL,

	order_date			datetime NULL,
	status_date			datetime NULL,

	
	quantity            INT NOT NULL DEFAULT(1),
	price               DECIMAL(5,2) NOT NULL
)
