//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2013.09.05 at 09:58:07 AM CEST 
//


package xml.xsd.v15;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * 
 * 				La specializzazione di una biblioteca è semplicemente
 * 				una CDD più una descrizione libera opzionale.
 * 			
 * 
 * <p>Java class for specializzazioneType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="specializzazioneType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;all>
 *         &lt;element name="cdd" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="descrizione-libera" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/all>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "specializzazioneType", propOrder = {

})
public class SpecializzazioneType {

    @XmlElement(required = true)
    protected String cdd;
    @XmlElement(name = "descrizione-libera")
    protected String descrizioneLibera;

    /**
     * Gets the value of the cdd property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCdd() {
        return cdd;
    }

    /**
     * Sets the value of the cdd property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCdd(String value) {
        this.cdd = value;
    }

    /**
     * Gets the value of the descrizioneLibera property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDescrizioneLibera() {
        return descrizioneLibera;
    }

    /**
     * Sets the value of the descrizioneLibera property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDescrizioneLibera(String value) {
        this.descrizioneLibera = value;
    }

}
