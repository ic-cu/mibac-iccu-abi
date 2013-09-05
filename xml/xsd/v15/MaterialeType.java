//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2013.09.05 at 09:58:07 AM CEST 
//


package xml.xsd.v15;

import java.math.BigInteger;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;


/**
 * 
 * 				Un tipo di materiale è descritto semplicemente da un
 * 				nome e da un posseduto (opzionale). Quest'ultimo
 * 				dev'essere un intero non negativo.
 * 			
 * 
 * <p>Java class for materialeType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="materialeType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;attribute name="nome" use="required" type="{http://www.w3.org/2001/XMLSchema}string" />
 *       &lt;attribute name="posseduto" type="{http://www.w3.org/2001/XMLSchema}nonNegativeInteger" />
 *       &lt;attribute name="acquisti-ultimo-anno" type="{http://www.w3.org/2001/XMLSchema}nonNegativeInteger" />
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "materialeType")
public class MaterialeType {

    @XmlAttribute(required = true)
    protected String nome;
    @XmlAttribute
    @XmlSchemaType(name = "nonNegativeInteger")
    protected BigInteger posseduto;
    @XmlAttribute(name = "acquisti-ultimo-anno")
    @XmlSchemaType(name = "nonNegativeInteger")
    protected BigInteger acquistiUltimoAnno;

    /**
     * Gets the value of the nome property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNome() {
        return nome;
    }

    /**
     * Sets the value of the nome property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNome(String value) {
        this.nome = value;
    }

    /**
     * Gets the value of the posseduto property.
     * 
     * @return
     *     possible object is
     *     {@link BigInteger }
     *     
     */
    public BigInteger getPosseduto() {
        return posseduto;
    }

    /**
     * Sets the value of the posseduto property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigInteger }
     *     
     */
    public void setPosseduto(BigInteger value) {
        this.posseduto = value;
    }

    /**
     * Gets the value of the acquistiUltimoAnno property.
     * 
     * @return
     *     possible object is
     *     {@link BigInteger }
     *     
     */
    public BigInteger getAcquistiUltimoAnno() {
        return acquistiUltimoAnno;
    }

    /**
     * Sets the value of the acquistiUltimoAnno property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigInteger }
     *     
     */
    public void setAcquistiUltimoAnno(BigInteger value) {
        this.acquistiUltimoAnno = value;
    }

}
