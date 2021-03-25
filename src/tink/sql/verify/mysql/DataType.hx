package tink.sql.verify.mysql;

enum abstract DataType(tink.sql.Types.LongText) {
	final DTBigInt = 'bigint';
	// final Bool = 'bool';
	final DTTinyInt = 'tinyint';
	final DTInt = 'int';
	final DTLongText = 'longtext';
	final DTMediumText = 'mediumtext';
	final DTSmallInt = 'smallint';
	final DTVarChar = 'varchar';
}
