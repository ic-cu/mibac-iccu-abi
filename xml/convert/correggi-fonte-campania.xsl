<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

<!--
	Foglio di stile per correggere piccoli difetti nei file 1.6 inviati
	dalla Regione Campania. È sostanzialmente un "copy with recursion" con
	l'aggiunta di template per i vari elementi da correggere.
	Inoltre esclude le biblioteche di fonte AICE.
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

<!-- Per escludere le biblioteche di fonte CEI, senza però rischiare di compromettere la copia
completa di tutte le altre, serve un primo template solo per escludere dall'output qualunque
cosa che non sia governato dal secondo, che copia una biblioteca non AICE per intero; vengongo
escluse anche le biblioteche di ente ecclesiastico, che saranno gestite caso per caso -->

	<xsl:template match="/biblioteche">
		<xsl:element name="biblioteche">
			<xsl:copy-of select="data-export" />
			<xsl:apply-templates select="//biblioteca"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="//biblioteca">
		<xsl:if test="contains(anagrafica/fonte/descrizione,'Regione Campania')">

<!-- questa versione lavora solo le biblioteche lavorate da Campania -->
		
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
