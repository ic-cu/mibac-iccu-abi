//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2013.09.04 at 12:16:10 PM CEST 
//


package xml.xsd.v16;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * 
 * 				A parte alcuni elementi dall'ovvio significato, la
 * 				"descrizione" corrisponde ad una descrizione libera del
 * 				fondo speciale, mentre "digitalizzazione" registra in
 * 				forma libera lo stato dell'eventuale digitalizzazione
 * 				del fondo.
 * 			
 * 
 * <p>Java class for fondoSpecialeType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="fondoSpecialeType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="nome" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="descrizione" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="cdd" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="depositato" type="{}siNoType" minOccurs="0"/>
 *         &lt;element name="digitalizzazione" type="{}siNoType" minOccurs="0"/>
 *         &lt;element name="catalogo-inventario" minOccurs="0">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;enumeration value="N"/>
 *               &lt;enumeration value="S"/>
 *               &lt;enumeration value="O"/>
 *               &lt;enumeration value="V"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="catalogo-inventario-url" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "fondoSpecialeType", propOrder = {
    "nome",
    "descrizione",
    "cdd",
    "depositato",
    "digitalizzazione",
    "catalogoInventario",
    "catalogoInventarioUrl"
})
public class FondoSpecialeType {

    @XmlElement(required = true)
    protected String nome;
    protected String descrizione;
    protected String cdd;
    protected SiNoType depositato;
    protected SiNoType digitalizzazione;
    @XmlElement(name = "catalogo-inventario")
    protected String catalogoInventario;
    @XmlElement(name = "catalogo-inventario-url")
    protected String catalogoInventarioUrl;

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
     * Gets the value of the descrizione property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDescrizione() {
        return descrizione;
    }

    /**
     * Sets the value of the descrizione property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDescrizione(String value) {
        this.descrizione = value;
    }

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
     * Gets the value of the depositato property.
     * 
     * @return
     *     possible object is
     *     {@link SiNoType }
     *     
     */
    public SiNoType getDepositato() {
        return depositato;
    }

    /**
     * Sets the value of the depositato property.
     * 
     * @param value
     *     allowed object is
     *     {@link SiNoType }
     *     
     */
    public void setDepositato(SiNoType value) {
        this.depositato = value;
    }

    /**
     * Gets the value of the digitalizzazione property.
     * 
     * @return
     *     possible object is
     *     {@link SiNoType }
     *     
     */
    public SiNoType getDigitalizzazione() {
        return digitalizzazione;
    }

    /**
     * Sets the value of the digitalizzazione property.
     * 
     * @param value
     *     allowed object is
     *     {@link SiNoType }
     *     
     */
    public void setDigitalizzazione(SiNoType value) {
        this.digitalizzazione = value;
    }

    /**
     * Gets the value of the catalogoInventario property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCatalogoInventario() {
        return catalogoInventario;
    }

    /**
     * Sets the value of the catalogoInventario property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCatalogoInventario(String value) {
        this.catalogoInventario = value;
    }

    /**
     * Gets the value of the catalogoInventarioUrl property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCatalogoInventarioUrl() {
        return catalogoInventarioUrl;
    }

    /**
     * Sets the value of the catalogoInventarioUrl property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCatalogoInventarioUrl(String value) {
        this.catalogoInventarioUrl = value;
    }

}
