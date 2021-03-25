package tink.sql.verify;

// typedef PartitionInfo = {
// }

class InformationSchema extends Database {
	@:table('INFORMATION_SCHEMA.COLUMNS') final column: Column;
	// @:table('INFORMATION_SCHEMA.PARTITIONS') final partition: PartitionInfo;
}
