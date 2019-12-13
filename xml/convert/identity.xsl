<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xalan="http://xml.apache.org/xslt"
	version="1.0">

	<xsl:output method="xml" indent="yes" encoding="UTF-8"
		xalan:indent-amount="2" />

	<!-- Questo è l'identity transform che garantisce che tutto ciò per cui 
		non è definito un template viene semplicemente copiato in output -->
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*" />
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
