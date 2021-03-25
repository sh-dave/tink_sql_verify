package tink.sql.verify.mysql;

class InformationSchema extends Database {
	@:table('INFORMATION_SCHEMA.COLUMNS') final column: Column;
}
