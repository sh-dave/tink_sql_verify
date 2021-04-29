package tink.sql.verify.mysql;

using tink.CoreApi;

class SchemaVerification {
	// TODO (DK) return detailed errors (per column) instead of a single bool
	public static function run( db: Database, schema: String, driver: tink.sql.drivers.MySql ) : Promise<Bool> {
		final infoSchema = new InformationSchema(schema, driver);

		return infoSchema.column.all().next(function( queriedRows ) {
			var ok = true;

			for (tn in db.tableNames()) {
				for (c in db.tableInfo(tn).getColumns()) {
					var found = false;

					for (qr in queriedRows) {
						if (ColumnVerification.match(db.name, tn, c, qr)) {
							found = true;
							trace('verified column: ${db.name}.${tn}.${c.name}');
							break;
						}
					}

					if (!found) {
						trace('unverified column: ${db.name}.${tn}.${c.name}');
						ok = false;
					}
				}
			}

			// TODO (DK) check whether the db contains more columns per table than our schema,
			// as they would need to provide a default value, otherwise inserts will fail?

			return ok;
		});
	}
}
