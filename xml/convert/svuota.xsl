<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

	<!-- Foglio di stile per copiare un file -->

	<!-- il primo foglio importato deve essere l'identity transform -->

	<xsl:import href="identity.xsl" />

	<!-- cancella i servizi -->

	<xsl:template match="//servizi" />

	<!-- cancella i contatti -->

	<xsl:template match="..//contatti" />

</xsl:stylesheet>