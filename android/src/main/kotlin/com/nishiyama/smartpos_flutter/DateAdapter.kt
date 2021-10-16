package com.nishiyama.smartpos_flutter

import com.google.gson.*
import java.lang.IllegalArgumentException
import java.lang.reflect.Type
import java.text.ParseException
import java.text.SimpleDateFormat
import java.util.*

class DateAdapter : JsonSerializer<Date?>,
        JsonDeserializer<Date> {
    @Throws(JsonParseException::class)
    override fun deserialize(
            json: JsonElement,
            type: Type,
            jsonDeserializationContext: JsonDeserializationContext
    ): Date {
        if (json !is JsonPrimitive) {
            throw JsonParseException("The date should be a string value")
        }
        val date = deserializeToDate(json)
        return if (type === Date::class.java) {
            date
        } else {
            throw IllegalArgumentException("$javaClass cannot deserialize to $type")
        }
    }

    override fun serialize(
            date: Date?,
            type: Type,
            jsonSerializationContext: JsonSerializationContext
    ): JsonElement {
        return JsonPrimitive(format(date))
    }

    private fun deserializeToDate(json: JsonElement): Date {
        return try {
            parse(json.asString)
        } catch (e: ParseException) {
            throw JsonSyntaxException(json.asString, e)
        }
    }

    private fun parse(input: String?): Date {
        var input = input ?: throw ParseException("Null", 0)

        val df = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
        return df.parse(input)
    }

    private fun format(date: Date?): String? {
        val df = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
        return df.format(date)
    }
}