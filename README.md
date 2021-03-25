# tink_sql_verify

Check whether the database matches all of our types.

```haxe
typedef MySchema = {
	...
}

final driver = new tink.sql.drivers.MySql({
	host: dbhost, port: dbport,
	user: dbuser, password: dbpw,
});

final my = new MySchema(dbname, driver);
final info = new tink.sql.verify.InformationSchema(dbname, driver);
final queriedRows = @:await info.column.all();
var ok = true;

for (tn in my.tableNames()) {
	for (c in my.tableInfo(tn).getColumns()) {
		var found = false;

		for (qr in queriedRows) {
			if (tink.sql.verify.ColumnMatcher.match(my.name, tn, c, qr)) {
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

if (!ok) {
	throw new Error('found unmatched columns');
}
```
