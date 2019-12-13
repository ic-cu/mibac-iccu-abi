<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<xsl:output method="text" indent="yes" encoding="ISO-8859-1" />
	<!-- Foglio di stile per estrarre i materiali da un xml -->
	<xsl:template match="/">
		<xsl:apply-templates select="//CATEGORIA/DETTAGLIO" />

	</xsl:template>

	<xsl:template match="//CATEGORIA/DETTAGLIO">
		<xsl:value-of select="@descrizione" />
		<xsl:text>
</xsl:text>
	</xsl:template>
</xsl:stylesheet>
