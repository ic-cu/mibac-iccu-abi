<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0"
>
	<xsl:output
		method="xml"
		indent="yes"
		encoding="ISO-8859-1"/>
	<!--
		Foglio di stile per estrarre le biblioteche dai file scheda_luogo inviati
		dalla Regione Umbria
	-->
	<!--
		Il primo template serve solo ad escludere dall'output qualunque cosa
		che non sia governato dal secondo
	-->
	<xsl:template match="/">
		<CARDSET>
			<xsl:copy-of select="//CARD[(OG/OGT/OGTD)='Biblioteca']"/>
		</CARDSET>
	</xsl:template>

<!-- 	<xsl:template match="//CARD"> -->
<!-- 		<xsl:if test="(contains(anagrafica/fonte/descrizione,'AICE'))"> -->
<!-- 			<xsl:copy-of select="."/> -->
<!-- 		</xsl:if> -->
<!-- 	</xsl:template> -->
</xsl:stylesheet>