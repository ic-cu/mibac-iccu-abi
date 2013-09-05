//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2013.09.04 at 12:16:10 PM CEST 
//


package xml.xsd.v16;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.bind.annotation.XmlType;


/**
 * 
 * 				La forma di un catalogo ha di solito un solo attributo, 
 * 				la percentuale di copertura, riferita al patrimonio
 * 				inventariato o supposto, relativo alla forma
 * 				particolare. Un'eccezione è la forma "digitale", che
 * 				aggiunge un elemento (o attributo che sia) relativo al
 * 				tipo di catalogo digitale (CD-ROM, web o altro).
 * 			
 * 
 * <p>Java class for formaType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="formaType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;attribute name="percentuale" type="{http://www.w3.org/2001/XMLSchema}string" />
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "formaType")
@XmlSeeAlso({
    DigitaleType.class,
    VolumeType.class
})
public class FormaType {

    @XmlAttribute
    protected String percentuale;

    /**
     * Gets the value of the percentuale property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPercentuale() {
        return percentuale;
    }

    /**
     * Sets the value of the percentuale property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPercentuale(String value) {
        this.percentuale = value;
    }

}
