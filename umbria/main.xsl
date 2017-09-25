<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xslt"
	version="1.0"
>

	<!--
		Foglio di stile per la trasformazione dei file XML provenienti dalla Regione
		Umbria
	-->

	<xsl:import href="comune.xsl"/>
	<xsl:import href="anagrafica.xsl"/>
	<xsl:import href="servizi.xsl"/>

	<xsl:output
		method="xml"
		indent="yes"
		encoding="UTF-8"
		xalan:indent-amount="2"/>

	<xsl:template match="CARDSET">
		<biblioteche>
			<xsl:attribute name="xsi:noNamespaceSchemaLocation">http://anagrafe.iccu.sbn.it/opencms/opencms/informazioni/formato-di-scambio/biblioteca-1.6.xsd</xsl:attribute>
			<data-export>2016-01-01T00:00:00</data-export>
			<xsl:apply-templates select="CARD"/>
		</biblioteche>
	</xsl:template>

	<xsl:template match="CARD">
		<biblioteca>
			<xsl:call-template name="anagrafica"/>
			<xsl:call-template name="servizi"/>
		</biblioteca>
	</xsl:template>

</xsl:stylesheet>
