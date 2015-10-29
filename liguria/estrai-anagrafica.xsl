<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" indent="yes"/>

	<xsl:template match="//scheda_BIBLIO">
<xsl:value-of select="CODISIL"/>;<xsl:value-of select="NOMEBIB"/>;<xsl:value-of select="RECAPITI/COMUNE"/>;<xsl:value-of select="RECAPITI/INDIRIZZO"/>
   </xsl:template>
</xsl:stylesheet>
