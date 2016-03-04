<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xalan="http://xml.apache.org/xslt" version="1.0">

	<!--
		Foglio di stile per correggere piccoli difetti di un file 1.6 derivato
		da un export dell'Emilia-Romagna. Importa il generico convert.xsl con
		l'aggiunta di template per qualche elemento da trattare in modo diverso
		rispetto a quanto avviene in convert.xsl
	-->

	<xsl:import href="../xml/convert/convert.xsl" />
	<xsl:import href="mappa.xsl" />
	<xsl:output method="xml" indent="yes" encoding="UTF-8" xalan:indent-amount="2"/>

<!-- 
	Questo è l'identity transform che garantisce che tutto ciò per cui non
	è definito un template viene semplicemente copiato in output
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
-->

<!--
		Il tipo di un catalogo generale è diventato una voce d'autorità.
		Almeno per le voci trasmesse compatibili con quelle in ABI si creano
		altrettanti cataloghi generali. Ad esempio, se il tipo di un cg è "per
		Autori / Soggetti", si creano due cg, uno per "Autore" e uno per
		"Soggetto", per il resto del tutto identici.
-->
		
	<xsl:template match="//catalogo-generale">
		<xsl:if test="contains(@tipo,'Autor')">
			<xsl:element name="catalogo-generale">
				<xsl:attribute name="tipo">Autore</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:if>

		<xsl:if test="contains(@tipo,'Soggett')">
			<xsl:element name="catalogo-generale">
				<xsl:attribute name="tipo">Soggetto</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:if>

		<xsl:if test="contains(@tipo,'Titol')">
			<xsl:element name="catalogo-generale">
				<xsl:attribute name="tipo">Titolo</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
