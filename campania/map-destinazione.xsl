<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

	<!-- Foglio di stile per correggere o mappare alcune voci di autorità relative 
		alle destinazioni-sociali destinazione valore -->

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />
	<!-- correzioni ai valori di destinazione sociale inutili -->

	<xsl:template match="//destinazioni-sociali/destinazione/valore">
		<xsl:choose>

			<xsl:when test="contains(.,'Categoria professionale specifica')">
				<valore></valore>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>