package tink.sql.verify.mysql;

enum MatchResult {
	Match;
	NoMatch;
	NotImplemented;

	DifferentSchema;
	DifferentTable;
	DifferentColumn;
}

class ColumnVerification {
	public static function match( dbn: String, tn: String, spec: tink.sql.Info.Column, parsed: Column ) : MatchResult {
		if (parsed.TABLE_SCHEMA != dbn) {
			return DifferentSchema;
		}

		if (parsed.TABLE_NAME != tn) {
			return DifferentTable;
		}

		if (parsed.COLUMN_NAME != spec.name) {
			return DifferentColumn;
		}

		return matchType(spec.type, parsed);
	}

	public static function matchType( type: tink.sql.Info.DataType, parsed: Column ) : MatchResult {
		return switch type {
			case DBool(byDefault):
				NotImplemented;

			case DInt(Tiny, signed, autoIncrement, byDefault):
				parsed.DATA_TYPE == DTTinyInt ? Match : NoMatch;

			case DInt(Small, signed, autoIncrement, byDefault):
				parsed.DATA_TYPE == DTSmallInt ? Match : NoMatch;

			case DInt(Medium, signed, autoIncrement, byDefault):
				NotImplemented;

			case DInt(Default, signed, autoIncrement, byDefault):
				parsed.DATA_TYPE == DTInt ? Match : NoMatch;

			case DDouble(byDefault):
				NotImplemented;

			case DString(maxLength, byDefault):
					parsed.DATA_TYPE == DTVarChar
				&&	maxLength == parsed.CHARACTER_MAXIMUM_LENGTH
				?	Match : NoMatch;

			case DText(Tiny, byDefault):
				NotImplemented;

			case DText(Default, byDefault):
				parsed.DATA_TYPE == DTText ? Match : NoMatch;

			case DText(Medium, byDefault):
				parsed.DATA_TYPE == DTMediumText ? Match : NoMatch;

			case DText(Long, byDefault):
				parsed.DATA_TYPE == DTLongText ? Match : NoMatch;

			case DBlob(maxLength):
				NotImplemented;

			case DDate(byDefault):
				NotImplemented;

			case DDateTime(byDefault):
				NotImplemented;

			case DTimestamp(byDefault):
				NotImplemented;

			case DPoint:
				NotImplemented;

			case DLineString:
				NotImplemented;

			case DPolygon:
				NotImplemented;

			case DMultiPoint:
				NotImplemented;

			case DMultiLineString:
				NotImplemented;

			case DMultiPolygon:
				NotImplemented;

			case DUnknown(type, byDefault):
				NotImplemented;
		}
	}
}