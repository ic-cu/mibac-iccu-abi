<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	
	<xsl:output method="text" indent="yes" encoding="ISO-8859-1" />
	<!--
	Foglio di stile per estrarre gli isil di aderenti all'ILL-SBN
	-->
	
<xsl:template match="/">
		<xsl:apply-templates select="//bib">

<xsl:sort select="idb"/>
		</xsl:apply-templates>
		
	</xsl:template>
	
	<xsl:template match="//bib">
    
<xsl:value-of select="idb"/>

<xsl:text>
</xsl:text>
</xsl:template>

</xsl:stylesheet>