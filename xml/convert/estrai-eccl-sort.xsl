<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<xsl:output method="text" indent="yes" encoding="ISO-8859-1" />
	<!--
	Foglio di stile per estrarre le biblioteche di ente ecclesiastico solo delle biblioteche che non 
	risultano di fonte AICE
	-->
	<!--
	Il primo template serve solo ad escludere dall'output qualunque cosa
	che non sia governato dal secondo
	-->
	<xsl:template match="/">
		<xsl:apply-templates select="//biblioteca">
<xsl:sort select="anagrafica/codici/isil"/>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="//biblioteca">
    
<xsl:value-of select="anagrafica/codici/isil"/>
<xsl:text>
</xsl:text>
	</xsl:if>

	<xsl:if test="not(contains(anagrafica/fonte/descrizione,'AICE'))
and(contains(amministrativa/ente/tipologia-amministrativa, 'Enti
ecclesiastici'))">

	</xsl:template>
</xsl:stylesheet>