<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

<!--
	Foglio di stile per inserire la fonte Regione Campania ove mancante,
	scartando però tutte le biblioteche con fonte AICE. 
	È sostanzialmente un "copy with recursion" con un solo template per
  per aggiungere la fonte.
-->

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

<!-- 
	Questo è l'identity transform che garantisce che tutto ciò per cui non
	è definito un template viene semplicemente copiato in output
-->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="/biblioteche">
		<xsl:element name="biblioteche">
			<xsl:copy-of select="data-export" />
			<xsl:apply-templates select="//biblioteca"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="//biblioteca">
		<xsl:if test="not(contains(anagrafica/fonte/descrizione,'AICE'))">
			<biblioteca>
				<xsl:apply-templates select="*" />
			</biblioteca>
		</xsl:if>
	</xsl:template>

<!-- nell'anagrafica si inserisce il nuovo elemento fonte e si copia tutto il resto -->

	<xsl:template match="//biblioteca/anagrafica">
		<xsl:element name="anagrafica">
			<xsl:copy-of select="data-censimento"/>
			<xsl:copy-of select="data-aggiornamento"/>
			<xsl:element name="fonte">
				<xsl:element name="descrizione">Regione Campania</xsl:element>
				<xsl:element name="url"/>
			</xsl:element>
			<xsl:copy-of select="nomi"/>
			<xsl:copy-of select="codici"/>
			<xsl:copy-of select="indirizzo"/>
			<xsl:copy-of select="contatti"/>
			<xsl:copy-of select="edificio"/>
			<xsl:copy-of select="istituzione"/>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>
