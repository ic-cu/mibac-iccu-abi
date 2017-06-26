<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

<!--
	Foglio di stile per correggere o mappare alcune voci di autorità relative a
	prestito locale e materiali esclusi
-->

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

<!-- un paio di template relativi al prestito locale (utenti ammessi e materiale escluso) -->

	<xsl:template match="//prestito/locale/utenti-ammessi">
		<xsl:choose>
			<xsl:when test="contains(.,'Isola')">
				<utenti-ammessi>Residenti nella regione</utenti-ammessi>
			</xsl:when>
			<xsl:when test="contains(.,'Utenti associati')">
				<utenti-ammessi>Utenti di sistema o di enti convenzionati</utenti-ammessi>
			</xsl:when>
			<xsl:otherwise>
				
				<xsl:copy-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="//prestito/locale/materiali-esclusi/materiale-escluso">
		<xsl:choose>
			<xsl:when test="contains(.,'Testi universitari')">
				<materiale-escluso>Libri scolastici</materiale-escluso>
			</xsl:when>
			<xsl:when test="contains(.,'Materiali didattici')">
				<materiale-escluso>Ignorare: Materiali didattici </materiale-escluso>
			</xsl:when>			
	        <xsl:when test="contains(.,'Libri fuori commercio')">
		    <materiale-escluso>Opere fuori commercio</materiale-escluso>
	    	</xsl:when>
			
			<xsl:when test="contains(.,'Opere dei fondi speciali')"/>
			
			<xsl:otherwise>
				<xsl:copy-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>