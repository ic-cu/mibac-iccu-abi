<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

<!--
	Foglio di stile per correggere piccoli difetti nei file 1.6 inviati
	dalla Regione Campania. È sostanzialmente un "copy with recursion" con
	l'aggiunta di template per i vari elementi da correggere.
	Inoltre esclude le biblioteche di fonte AICE.
-->

<!-- il primo foglio importato deve essere l'identity transform -->

	<xsl:import href="../xml/convert/identity.xsl" />

<!-- vari template per mappare voci di autorità -->

	<xsl:import href="map-tipologie.xsl" />
	<xsl:import href="map-destinazione.xsl"/>
	<xsl:import href="map-limiti.xsl" />
	<xsl:import href="map-sistemi-sezioni.xsl" />
	<xsl:import href="map-cataloghi-patrimonio.xsl" />
	<xsl:import href="map-prestito.xsl" />
	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

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

<!-- rimozione delle eventuali biblioteche con elemento fonte=AICE -->

	<xsl:template match="//biblioteca">
		<xsl:if test="not(contains(anagrafica/fonte/descrizione,'AICE'))">
<!-- questa versione esclude anche le ecclesiastiche, oltre alle AICE -->
<!-- 
		<xsl:if test="not(contains(anagrafica/fonte/descrizione,'AICE')) 
		and not(contains(amministrativa/ente/tipologia-amministrativa, 'Enti ecclesiastici'))">
 -->		
			<xsl:element name="biblioteca">
				<xsl:apply-templates select="*" />
			</xsl:element>
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
			<xsl:apply-templates select="edificio"/>
			<xsl:copy-of select="istituzione"/>
		</xsl:element>
	</xsl:template>

<!-- 
forse per un bug o per una configurazione incompleta, la url delle immagini 
richiede l'inserimento di un ramo mancante; prima però serve un template per 
copiare gli altri dati dell'edificio
-->

	<xsl:template match="edificio">
	  <edificio>
			<xsl:copy-of select="denominazione"/>
			<xsl:copy-of select="monumentale"/>
			<xsl:copy-of select="appositamente-costruito"/>
			<xsl:copy-of select="data-costruzione"/>
			<xsl:apply-templates select="immagini"/>
		</edificio>
	</xsl:template>
	
	<xsl:template match="immagini">
		<immagini>
	  <xsl:for-each select="immagine">
	  <immagine>
			<xsl:choose>
				<xsl:when test="starts-with(url, 'http://anagrafebiblioteche.regione.campania.it/photo')">
					<url><xsl:value-of select="concat('http://anagrafebiblioteche.regione.campania.it/abicampania/photo', 
					substring-after(url, 'http://anagrafebiblioteche.regione.campania.it/photo'))"/></url>
				</xsl:when>
				<xsl:otherwise><xsl:copy-of select="url"/></xsl:otherwise>
			</xsl:choose>
			<xsl:copy-of select="didascalia"/>
			</immagine>
		</xsl:for-each>
		</immagini>
	</xsl:template>

<!-- gli utenti del prestito locale andranno scambiati a causa di un bug ancora
non risolto nell'applicativo regionale; in una prima fase si estrae solo 
"ultimo-anno", esportandolo però come "iscritti-prestito" -->

	<xsl:template match="//utenti">
	  <utenti>
		  <xsl:if test="ultimo-anno">
		  	<iscritti-prestito><xsl:value-of select="ultimo-anno"/></iscritti-prestito>
		  </xsl:if>
			<xsl:copy-of select="minori-quattordici-anni" />
		</utenti>
	</xsl:template>
	<xsl:template match="//patrimonio/materiali/materiale[contains(@nome, 'altri documenti di biblioteca')]"/>
			
</xsl:stylesheet>
