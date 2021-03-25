# tink_sql_verify

Check whether the database matches all of our types.

```haxe
typedef MyDBSchema = {
	...
}

final schemaName = '...';
final driver = new tink.sql.drivers.MySql({});
final myDB = new MyDBSchema(dbname, driver);
final schemaOk = @:await tink.sql.verify.SchemaVerification.run(myDB, schemaName, driver);

if (!schemaOk) {
	throw new Error('schema `$schemaName` does not match');
} else {
	trace('schema `$schemaName` verified');
}

```
