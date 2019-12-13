<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xalan="http://xml.apache.org/xslt"
	exclude-result-prefixes="xalan" version="1.0">

	<!-- conversione da versione 1.4 e 1.5 a versione 1.6 -->

	<xsl:import href="identity.xsl" />
	<xsl:import href="anagrafica.xsl" />
	<xsl:import href="cataloghi.xsl" />
	<xsl:import href="patrimonio.xsl" />
	<xsl:import href="servizi.xsl" />
	<xsl:output method="xml" indent="yes" encoding="UTF-8"
		xalan:indent-amount="2" />
	<xsl:template match="//funzione-obiettivo" />
	<xsl:template match="//part-time[normalize-space()='']" />

	<!-- Per gestire le specializzazioni, che in 1.4 sono sparse dopo il patrimonio, 
		ma senza contenitore, l'unica soluzione è richiamare un template per la singola 
		biblioteca, poi tutti i sotto-template e trattare a parte le specs -->

	<xsl:template match="//biblioteca">
		<biblioteca>
			<xsl:apply-templates select="anagrafica" />
			<xsl:apply-templates select="cataloghi" />
			<xsl:apply-templates select="patrimonio" />
			<xsl:if test="specializzazione">
				<xsl:element name="specializzazioni">
					<xsl:for-each select="specializzazione">
						<xsl:copy-of select="." />
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
			<xsl:apply-templates select="servizi" />
			<xsl:apply-templates select="amministrativa" />
		</biblioteca>
	</xsl:template>


</xsl:stylesheet>
