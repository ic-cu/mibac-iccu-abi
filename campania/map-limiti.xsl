<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

<!--
	Foglio di stile per correggere o mappare alcune voci di autorità relative a
	limiti di età
-->

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

<!-- correzioni ai limiti di età -->

	<xsl:template match="//modalita-accesso/modo">
		<xsl:choose>

		<xsl:when test="contains(.,' > = 8')">
		<xsl:element name="modo">Limite di eta': >= 8</xsl:element>
		</xsl:when>

		<xsl:when test="contains(.,'Registrazione dati anagrafici')">
		<xsl:element name="modo">Registrazione</xsl:element>
		</xsl:when>
		
		<xsl:when test="contains(.,'Prenotazione')">
		<xsl:element name="modo">Appuntamento</xsl:element>
		</xsl:when>

		<xsl:when test="contains(.,'Libretto universitario')">
		<modo>Numero di matricola</modo>
		</xsl:when>
		
        <xsl:when test="contains(.,'Tessera sanitaria')">
        <xsl:element name="modo">Tessera sanitaria nazionale</xsl:element>
		</xsl:when>
		
		<xsl:when test="contains(.,'Accesso libero')">
	     <xsl:element name="modo">IGNORARE:<xsl:value-of select="."/></xsl:element>
		</xsl:when>
		
		<xsl:when test="contains(.,'Permesso di soggiorno')">
	     <xsl:element name="modo">IGNORARE:<xsl:value-of select="."/></xsl:element>
		</xsl:when>
				
		<xsl:when test="contains(.,'Libretto o badge universitario')">
		<modo>Numero di matricola</modo>
		</xsl:when>
	
		<xsl:otherwise>
				<xsl:copy-of select="." />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
