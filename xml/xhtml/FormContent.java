//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2013.10.04 at 04:29:19 PM CEST 
//


package xml.xhtml;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElements;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.bind.annotation.XmlType;


/**
 * 
 *       form uses "Block" excluding form
 *       
 * 
 * <p>Java class for form.content complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="form.content">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;choice maxOccurs="unbounded" minOccurs="0">
 *         &lt;group ref="{http://www.w3.org/1999/xhtml}block"/>
 *         &lt;group ref="{http://www.w3.org/1999/xhtml}misc"/>
 *       &lt;/choice>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "form.content", propOrder = {
    "pOrH1OrH2"
})
@XmlSeeAlso({
    Form.class
})
public class FormContent {

    @XmlElements({
        @XmlElement(name = "p", type = P.class),
        @XmlElement(name = "del", type = Del.class),
        @XmlElement(name = "div", type = Div.class),
        @XmlElement(name = "table", type = Table.class),
        @XmlElement(name = "script", type = Script.class),
        @XmlElement(name = "h6", type = H6 .class),
        @XmlElement(name = "dl", type = Dl.class),
        @XmlElement(name = "pre", type = Pre.class),
        @XmlElement(name = "fieldset", type = Fieldset.class),
        @XmlElement(name = "h2", type = H2 .class),
        @XmlElement(name = "h1", type = H1 .class),
        @XmlElement(name = "blockquote", type = Blockquote.class),
        @XmlElement(name = "address", type = Address.class),
        @XmlElement(name = "noscript", type = Noscript.class),
        @XmlElement(name = "h4", type = H4 .class),
        @XmlElement(name = "ins", type = Ins.class),
        @XmlElement(name = "hr", type = Hr.class),
        @XmlElement(name = "ol", type = Ol.class),
        @XmlElement(name = "h3", type = H3 .class),
        @XmlElement(name = "ul", type = Ul.class),
        @XmlElement(name = "h5", type = H5 .class)
    })
    protected List<java.lang.Object> pOrH1OrH2;

    /**
     * Gets the value of the pOrH1OrH2 property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the pOrH1OrH2 property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPOrH1OrH2().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link P }
     * {@link Del }
     * {@link Div }
     * {@link Table }
     * {@link Script }
     * {@link H6 }
     * {@link Dl }
     * {@link Pre }
     * {@link Fieldset }
     * {@link H2 }
     * {@link H1 }
     * {@link Blockquote }
     * {@link Address }
     * {@link Noscript }
     * {@link H4 }
     * {@link Ins }
     * {@link Hr }
     * {@link Ol }
     * {@link H3 }
     * {@link Ul }
     * {@link H5 }
     * 
     * 
     */
    public List<java.lang.Object> getPOrH1OrH2() {
        if (pOrH1OrH2 == null) {
            pOrH1OrH2 = new ArrayList<java.lang.Object>();
        }
        return this.pOrH1OrH2;
    }

}
