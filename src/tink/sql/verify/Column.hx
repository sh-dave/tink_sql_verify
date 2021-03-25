package tink.sql.verify;

import tink.sql.Types.LongText;

typedef Column = {
	final CHARACTER_MAXIMUM_LENGTH: Int;
	// final CHARACTER_OCTET_LENGTH: Int;
	final CHARACTER_SET_NAME: LongText;
	// final COLLATION_NAME: LongText;
	// final COLUMN_COMMENT: LongText;
	// final COLUMN_DEFAULT
	// final COLUMN_KEY: LongText;
	final COLUMN_NAME: LongText;
	// final COLUMN_TYPE: Dynamic;
	final DATA_TYPE: DataType;
	// final DATETIME_PRECISION
	// final EXTRA
	// final GENERATION_EXPRESSION
	// final IS_GENERATED
	final IS_NULLABLE: LongText;
	// final NUMERIC_PRECISION
	// final NUMERIC_SCALE
	// final ORDINAL_POSITION
	// final PRIVILEDGES
	// TABLE_CATALOG
	final TABLE_NAME: LongText;
	final TABLE_SCHEMA: LongText;
}
