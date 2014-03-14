<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- 
Foglio di stile per l'aggiunta della "fonte AICE"
Presuppone che il file sorgente sia già in formato 1.6.
Non rimuove la fonte dalla url nei contatti, perché è molto più facile
farlo con un grep.
-->

  <xsl:output method="xml" indent="yes" encoding="ISO-8859-1"/>

<!--
Template per l'elemento root che si limita a richiamare quello per ogni
singola biblioteca.
-->

  <xsl:template match="/biblioteche">
    <xsl:element name="biblioteche">
			<xsl:copy-of select="data-export"/>
      <xsl:apply-templates select="//biblioteca"/>
    </xsl:element>
  </xsl:template>

<!-- 
Richiama i template per i raggruppamenti principali, mentre per le
specializzazioni introduce un apposito contenitore e copia in esso ogni
specializzazione trovata
-->

  <xsl:template match="//biblioteca">
	  <xsl:element name="biblioteca">
			<xsl:apply-templates select="anagrafica"/>
			<xsl:copy-of select="cataloghi"/>
			<xsl:copy-of select="patrimonio"/>
			<xsl:copy-of select="specializzazioni"/>
			<xsl:copy-of select="servizi"/>
			<xsl:copy-of select="amministrativa"/>
	  </xsl:element>
  </xsl:template>

<!--
Anagrafica: oltre a invocare diversi template, corregge i nomi di alcune
date, eventualmente valorizzando la data-aggiornamento se assente, e
copiando gli indirizzi che non richiedono trattamenti
-->

  <xsl:template match="//anagrafica">
	  <xsl:element name="anagrafica">
			<xsl:copy-of select="data-censimento"/>
			<xsl:copy-of select="data-aggiornamento"/>
			<xsl:element name="fonte">
				<xsl:element name="descrizione">Anagrafe degli Istituti Culturali Ecclesiastici (AICE)</xsl:element>
				<xsl:element name="url">http://www.anagrafebbcc.chiesacattolica.it/anagraficaCEIBib/</xsl:element>
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
