<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<xsl:output method="xml" indent="yes" encoding="ISO-8859-1" />
	<!-- Foglio di stile per estrarre le biblioteche di ente ecclesiastico solo 
		delle biblioteche che non risultano di fonte AICE -->
	<!-- Il primo template serve solo ad escludere dall'output qualunque cosa 
		che non sia governato dal secondo -->
	<xsl:template match="/">
		<biblioteche>
			<xsl:apply-templates select="//biblioteca" />
		</biblioteche>
	</xsl:template>

	<xsl:template match="//biblioteca">
		<xsl:if test="(contains(anagrafica/fonte/descrizione,'AICE'))">
			<!-- solo se serve con la tipologia amministrativa <xsl:if test="(contains(anagrafica/fonte/descrizione,'AICE')) 
				and(contains(amministrativa/ente/tipologia-amministrativa, 'Enti ecclesiastici'))"> -->
			<xsl:copy-of select="." />
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>