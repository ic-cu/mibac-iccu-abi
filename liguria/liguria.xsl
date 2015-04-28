<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="recapiti.xsl" />
	<xsl:import href="patrimonio.xsl" />
	<xsl:import href="servizi.xsl" />
	<xsl:output method="xml" indent="yes" />
	<!--
		c'è una perfetta corrispondenza fra "listof_scheda_BIBLIO" sorgente
		e biblioteche nell'output, quindi si può partire da questo template
		che crea "biblioteche" e poi applicare il template per le singole
		"scheda_BIBLIO" del sorgente
	-->
	<xsl:template match="/listof_scheda_BIBLIO">
		<xsl:element name="biblioteche">
			<xsl:attribute name="xsi:noNamespaceSchemaLocation">http://anagrafe.iccu.sbn.it/opencms/opencms/informazioni/formato-di-scambio/biblioteca-1.6.xsd</xsl:attribute>
			<!-- dataExport va poi cambiato a mano -->
			<data-export>2013-11-04T00:00:00</data-export>
			<xsl:apply-templates select="scheda_BIBLIO[not(normalize-space(CONSISTENZA/TOTCONS)) = '']" />
		</xsl:element>
	</xsl:template>

	<!--
		questo template lavora su tutti gli elementi "scheda_BIBLIO"; non
		serve indicarne in modo esatto il path, perché non risulta ci siano
		altri elementi con questo nome con percorsi diversi; l'elemento input
		corrisponde esattamente a "biblioteca" in output;
		il template per adesso è in grado di creare "anagrafica" con nome,
		indirizzo e contatti, poi crea anche patrimonio e servizi
	-->

	<xsl:template match="scheda_BIBLIO[not(normalize-space(CONSISTENZA/TOTCONS)) = '']">
		<xsl:element name="biblioteca">
			<xsl:element name="anagrafica">
				<xsl:apply-templates select="RELAZIONE" />
				<fonte>
					<descrizione>Regione Liguria</descrizione>
					<url>http://www.culturainliguria.it/cultura/it/Temi/Luoghivisita/biblioteche.do</url>
				</fonte>
				<xsl:element name="nomi">
					<xsl:element name="attuale">
						<xsl:value-of select="NOMEBIB" />
					</xsl:element>
				</xsl:element>
				<xsl:element name="codici">
					<xsl:element name="isil">
						<xsl:value-of select="CODISIL" />
					</xsl:element>
					<!-- solo se c'è IDPOLO si deve selezionare il codice SBN -->
					<xsl:if test="string-length(IDPOLO)=3">
						<xsl:element name="sbn">
							<xsl:value-of select="concat(IDPOLO,CODBIB)" />
						</xsl:element>
					</xsl:if>
				</xsl:element>
				<xsl:apply-templates select="RECAPITI" />
				<xsl:apply-templates select="ANNO" />
			</xsl:element>
			<xsl:call-template name="patrimonio" />
			<xsl:call-template name="servizi" />
			<xsl:call-template name="amministrativa" />
		</xsl:element>
		<!--</xsl:template>

			<xsl:template match="//scheda_BIBLIO/RECAPITI/COMUNE">
			<xsl:element name="comune">
			<xsl:value-of select="."/>
			</xsl:element>
		-->
	</xsl:template>

	<xsl:template match="//scheda_BIBLIO/RELAZIONE">
		<xsl:element name="data-censimento">
			<xsl:value-of select="@ANNO" />
		</xsl:element>
		<xsl:element name="data-aggiornamento">
			<xsl:value-of
				select="concat(substring(@DATAULTAGG, 7, 4), 
			  '-', substring(@DATAULTAGG, 4, 2),
				'-', substring(@DATAULTAGG, 1, 2), 'T00:00:00')" />
		</xsl:element>
	</xsl:template>
	<xsl:template match="scheda_BIBLIO/ANNO">
		<xsl:element name="istituzione">
			<xsl:element name="data-istituzione">
				<xsl:value-of select="." />
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template name="amministrativa">
		<amministrativa>
			<xsl:if test="not(normalize-space(CF) = '')">
				<codice-fiscale>
					<xsl:value-of select="CF" />
				</codice-fiscale>
			</xsl:if>
			<xsl:if test="not(normalize-space(PIVA) = '')">
				<partita-IVA>
					<xsl:value-of select="PIVA" />
				</partita-IVA>
			</xsl:if>
		</amministrativa>
	</xsl:template>
</xsl:stylesheet>