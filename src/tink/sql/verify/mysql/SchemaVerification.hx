package tink.sql.verify.mysql;

using tink.CoreApi;

class SchemaVerification {
	public static function run( db: Database, schema: String, driver: tink.sql.drivers.MySql ) : Promise<Bool> {
		final infoSchema = new InformationSchema(schema, driver);

		return infoSchema.column.all().next(function( queriedRows ) {
			var ok = true;

			// final refs: Array<ExpectedColumnInfo> = [
			for (tn in db.tableNames()) {
				for (c in db.tableInfo(tn).getColumns()) {
					var found = false;

					for (qr in queriedRows) {
						if (ColumnVerification.match(db.name, tn, c, qr)) {
							found = true;
							break;
						}
					}

					if (!found) {
						trace('unmatched column: ${c}');
						ok = false;
					}
				}
			}

			return ok;
		});
	}
}
