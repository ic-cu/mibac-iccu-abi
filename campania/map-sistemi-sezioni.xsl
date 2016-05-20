<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

<!--
	Foglio di stile per correggere o mappare alcune voci di autorità relative a
	sistemi e reti di biblioteche e a sezioni speciali
-->

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

<!-- c'è un sistema di biblioteche errato solo a causa di un apostrofo -->

	<xsl:template match="//sistemi/sistema">
		<xsl:choose>
		<xsl:when test="contains(.,'Ateneo. Università degli Studi di Salerno')">
		<xsl:element name="sistema">Sistema bibliotecario di Ateneo. Università degli Studi di Salerno</xsl:element>
		</xsl:when>
				
		<xsl:otherwise>
		<xsl:copy-of select="." />
        </xsl:otherwise>
		
		
		</xsl:choose>
	</xsl:template>

<!-- sezioni speciali -->

	<xsl:template match="//sezioni-speciali/sezione">
		<xsl:choose>
		<xsl:when test="contains(.,'Sezione Raccolta storica di testi legislativi')">
		<xsl:element name="sezione">legislazione italiana</xsl:element>
		</xsl:when>
		<xsl:when test="contains(.,'dialettologia')">
		<xsl:element name="sezione">dialetto</xsl:element>
		</xsl:when>
		<xsl:when test="contains(.,'libro parlato')">
		<xsl:element name="sezione">audiolibri</xsl:element>
		</xsl:when>
		<xsl:when test="contains(.,'Fotodiapoteca')">
		<sezione>fotografia</sezione>
		<sezione>diapositive</sezione>
		</xsl:when>
		<xsl:when test="contains(.,'Soggettività femminile')">
		<sezione>donna</sezione>
		</xsl:when>
		<xsl:when test="contains(.,'Internet per ragazzi')">
    	<sezione>IGNORARE</sezione>
    	</xsl:when>
		<xsl:when test="contains(.,'sezione educatori')"> 
	    <sezione>IGNORARE</sezione>
	  </xsl:when>
		   
	    <xsl:when test="contains(.,'Sezione Capri')">
		<sezione>Capri</sezione>
		</xsl:when>
		<xsl:otherwise>
	<xsl:copy-of select="." />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
