package site.ani4h.shared.common;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

import java.io.IOException;

public class UidDeserializer extends JsonDeserializer<Uid> {
    @Override
    public Uid deserialize(JsonParser p, DeserializationContext ctxt) throws IOException {
        return new Uid(p.getValueAsString());
    }
}