package tink.sql.verify.mysql;

using tink.CoreApi;

enum VerificationResult {
	MissingColumn( schema: String, table: String, column: String, expected: tink.sql.Info.DataType );
	UnmatchedColumn( schema: String, table: String, column: String, expected: tink.sql.Info.DataType );
}

class SchemaVerification {
	// TODO (DK) return detailed errors (per column) instead of a single bool
	public static function run( db: Database, schema: String, driver: tink.sql.drivers.MySql ) : Promise<Array<VerificationResult>> {
		final infoSchema = new InformationSchema(schema, driver);

		return infoSchema.column.all().next(function( queriedRows ) {
			// var ok = true;
			final r: Array<VerificationResult> = [];

			final table_names = db.tableNames();

			for (tn in table_names) {
				for (c in db.tableInfo(tn).getColumns()) {
					var found = false;

					for (qr in queriedRows) {
						switch ColumnVerification.match(db.name, tn, c, qr) {
							case Match:
								found = true;
								trace('[ok] column: ${db.name}.${tn}.${c.name}');
								break;

							case NoMatch, NotImplemented:
								r.push(UnmatchedColumn(schema, tn, c.name, c.type));
								found = true;
								trace('[fail] column: ${db.name}.${tn}.${c.name} - type does not match');
								break;

							case DifferentSchema, DifferentTable, DifferentColumn:
						}
					}

					if (!found) {
						trace('[fail] column: ${db.name}.${tn}.${c.name} - column is missing');
						r.push(MissingColumn(schema, tn, c.name, c.type));
					}
				}
			}

			// TODO (DK) check whether the db contains more columns per table than our schema,
			// as they would need to provide a default value, otherwise inserts will fail?

			return r;
		});
	}
}
