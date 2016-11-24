<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0"
>
	<xsl:output
		method="text"
		indent="yes"
		encoding="UTF-8"/>
	<!--
		Foglio di stile per estrarre le biblioteche dai file scheda_luogo inviati
		dalla Regione Umbria
	-->
	<!--
		Il primo template serve solo ad escludere dall'output qualunque cosa
		che non sia governato dal secondo
	-->
	<xsl:template match="/CARDSET">
		<xsl:for-each select="//CARD[(OG/OGT/OGTD)='Biblioteca']">
			<xsl:value-of select="IN/INO/INOO"/>
			<xsl:text>
</xsl:text>
		</xsl:for-each>
		<xsl:for-each select="//CARD[(OG/OGT/OGTD)='Biblioteca']">
			<xsl:value-of select="IN/INO/INOD"/> - <xsl:value-of select="IN/INO/INOA"/>
			
			<xsl:text>
</xsl:text>
		</xsl:for-each>
		<xsl:for-each select="//CARD[(OG/OGT/OGTD)='Biblioteca']">
			<xsl:value-of select="IN/INO/INOG"/>
			<xsl:text>
</xsl:text>
		</xsl:for-each>
	</xsl:template>

	<!-- <xsl:template match="//CARD"> -->
	<!-- <xsl:if test="(contains(anagrafica/fonte/descrizione,'AICE'))"> -->
	<!-- <xsl:copy-of select="."/> -->
	<!-- </xsl:if> -->
	<!-- </xsl:template> -->
</xsl:stylesheet>