use [srdb_sr2_dev]
GO
GRANT ALTER ON SCHEMA::[operation_dars] TO [DARSOps]
GO
use [srdb_sr2_dev]
GO
GRANT CONTROL ON SCHEMA::[operation_dars] TO [DARSOps]
GO
use [srdb_sr2_dev]
GO
GRANT DELETE ON SCHEMA::[operation_dars] TO [DARSOps]
GO
use [srdb_sr2_dev]
GO
GRANT EXECUTE ON SCHEMA::[operation_dars] TO [DARSOps]
GO
use [srdb_sr2_dev]
GO
GRANT INSERT ON SCHEMA::[operation_dars] TO [DARSOps]
GO
use [srdb_sr2_dev]
GO
GRANT REFERENCES ON SCHEMA::[operation_dars] TO [DARSOps]
GO
use [srdb_sr2_dev]
GO
GRANT SELECT ON SCHEMA::[operation_dars] TO [DARSOps]
GO
use [srdb_sr2_dev]
GO
GRANT UPDATE ON SCHEMA::[operation_dars] TO [DARSOps]
GO
use [srdb_sr2_dev]
GO
GRANT VIEW DEFINITION ON SCHEMA::[operation_dars] TO [DARSOps]
GO

--- Add Role
USE [srdb_sr2_int]
GO
ALTER ROLE [DARSOps] ADD MEMBER [UCLANET\rhosseiny]
GO
USE [srdb_sr2_int]
GO
ALTER ROLE [DARSOps] ADD MEMBER [UCLANET\dchugh]
GO
USE [srdb_sr2_int]
GO
ALTER ROLE [DARSOps] ADD MEMBER [UCLANET\kchun]
GO
USE [srdb_sr2_int]
GO
ALTER ROLE [DARSOps] ADD MEMBER [UCLANET\rcarrera]
GO
USE [srdb_sr2_int]
GO
ALTER ROLE [DARSOps] ADD MEMBER [UCLANET\dmorada]
GO
