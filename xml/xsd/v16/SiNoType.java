//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2013.09.04 at 12:16:10 PM CEST 
//


package xml.xsd.v16;

import javax.xml.bind.annotation.XmlEnum;
import javax.xml.bind.annotation.XmlEnumValue;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for siNoType.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p>
 * <pre>
 * &lt;simpleType name="siNoType">
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *     &lt;enumeration value="s"/>
 *     &lt;enumeration value="n"/>
 *   &lt;/restriction>
 * &lt;/simpleType>
 * </pre>
 * 
 */
@XmlType(name = "siNoType")
@XmlEnum
public enum SiNoType {

    @XmlEnumValue("s")
    S("s"),
    @XmlEnumValue("n")
    N("n");
    private final String value;

    SiNoType(String v) {
        value = v;
    }

    public String value() {
        return value;
    }

    public static SiNoType fromValue(String v) {
        for (SiNoType c: SiNoType.values()) {
            if (c.value.equals(v)) {
                return c;
            }
        }
        throw new IllegalArgumentException(v);
    }

}
