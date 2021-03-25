# tink_sql_verify

Check whether the database matches our schema.

```haxe
typedef MyDBSchema = {
	...
}

final schemaName = '...';
final driver = new tink.sql.drivers.MySql(...);
final myDB = new MyDBSchema(schemaName, driver);
final schemaOk = @:await SchemaVerification.run(myDB, schemaName, driver);

if (!schemaOk) {
	throw new Error('schema `$schemaName` does not match');
} else {
	trace('schema `$schemaName` verified');
}

```
