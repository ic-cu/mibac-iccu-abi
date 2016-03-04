<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

<!--
	Foglio di stile per correggere o mappare alcune voci di autorità relative a
	tipologie amministrative e funzionali
-->

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

<!-- correzioni alle tipologie amministrative -->

	<xsl:template match="//tipologia-amministrativa">
		<xsl:choose>

		<xsl:when test=". = 'Accademie, Associazioni, Fondazioni, Istituti, Società (privati)'">
		<tipologia-amministrativa>Accademie, associazioni, fondazioni, istituti, societa' (privati)</tipologia-amministrativa>
		</xsl:when>

		<xsl:when test=". = 'Consorzio e/o associazioni di regioni, provincie, comuni e comunità montane'">
		<tipologia-amministrativa>Consorzio e/o associazioni di regioni, provincie, comuni e comunita' montane</tipologia-amministrativa>
		</xsl:when>

		<xsl:otherwise>
				<xsl:copy-of select="." />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- correzioni alle modalità di accesso -->

	<xsl:template match="//modalita-accesso/modo">
		<xsl:choose>

		<xsl:when test=". = 'Documento identità'">
		<modo>Documento identita'</modo>
		</xsl:when>

		<xsl:otherwise>
				<xsl:copy-of select="." />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
